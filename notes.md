```markdown
# Notas de Desarrollo – Procesador RISC-V Monociclo

Este documento contiene decisiones de diseño, problemas encontrados y aclaraciones técnicas durante la implementación del procesador.

---

## Decisiones de arquitectura

### Estilo monociclo
Se eligió un procesador **monociclo**, donde todas las operaciones se realizan en un solo ciclo de reloj. Esto facilita el diseño y la simulación, aunque no es eficiente en hardware real.

### RISC-V RV32I
El conjunto de instrucciones implementado es RV32I:
- Operaciones aritméticas y lógicas
- Cargas y almacenamientos
- Saltos y branches
- Inmediatos de todos los tipos

No se implementaron multiplicaciones, CSR, ni excepciones.

---

## Notas sobre módulos importantes

### ProgramCounter (PC)
- Registro sincrónico al flanco positivo.
- Se reinicia a 0.
- Su entrada `PcNext` proviene del MUX de salto.

### InstructionMemory
- Memoria combinacional.
- Dirección indexada como `Address[9:2]` porque cada instrucción ocupa 4 bytes.
- Entradas se dividen directamente a `Opcode`, `Funct3`, `Funct7`, etc.

### RegisterUnit
- Banco de 32 registros de 32 bits.
- Escritura sincronizada.
- Registro x0 es constante en 0 (se evita escribir si `rd==0`).
- Se inicializó el stack pointer x2 a `0x3FC`.

### BranchUnit
- Implementa comparaciones con y sin signo.
- Produce una señal booleana `NextPCSrc` para decidir salto o no.

### ALU
- Soporta todas las operaciones requeridas por RV32I.
- Maneja SLT, SLTU, corrimientos, sumas, restas y operaciones lógicas.

### DataMemory
- Lectura combinacional.
- Escritura sincronizada.
- Soporta SB, SH, SW, LB, LH, LW, LBU y LHU.

### Immediate Generator
- Inmediatos correctamente reordenados para formatos:
  - I, S, B, U, J

### Control Unit
- Control completamente combinacional.
- Decodifica:
  - Tipo R
  - Tipo I (ALU)
  - Loads
  - Stores
  - Branches
  - JAL / JALR
  - LUI / AUIPC

---

## Problemas encontrados y soluciones

### Slicing dinámico en Icarus Verilog
El uso de `(Address[1:0] * 8) +: 8` generaba un error.  
Solución: uso de bloques `case` estáticos o reorganización.

### Errores con always_comb
Icarus no soporta completamente `always_comb`.  
Se cambió a `always @(*)`.

### Necesidad de módulos MUX separados
Para claridad y reutilización se implementaron:
- `PC_Mux`
- `RU_Mux`
- `ALU_block` (MUX + ALU integrada)

### Orden correcto de instanciación en Top_level
Primero se declaran las señales internas, luego se instancian los módulos en el orden del datapath.

---

## Flujo del procesador

1. PC lee dirección.
2. InstructionMemory entrega la instrucción.
3. ControlUnit genera las señales según el Opcode.
4. RegisterUnit lee operandos.
5. ImmGen extiende el inmediato.
6. ALU_block elige operandos y ejecuta operación.
7. BranchUnit decide salto.
8. PC_Mux decide entre PC+4 o destino.
9. DataMemory maneja loads/stores.
10. RU_Mux selecciona qué valor escribir en rd.

---

## Consideraciones finales

- El diseño es 100% funcional para todos los tipos de instrucción RV32I.
- Los testbench cubren cada módulo individualmente.
- El datapath respeta el diseño típico enseñado en cursos de arquitectura.
