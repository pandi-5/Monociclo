# Procesador Monociclo RISC-V (RV32I) en SystemVerilog

Este proyecto implementa un **procesador monociclo** basado en la arquitectura **RISC-V RV32I**, completamente escrito en **SystemVerilog**.  
Incluye todos los módulos necesarios para ejecutar instrucciones básicas del conjunto RISC-V, junto con un **testbench de cada módulo** y un **top-level funcional**.

El objetivo del proyecto es comprender la arquitectura interna de un procesador, el flujo de datos y el diseño de hardware mediante HDL.

---

## Características principales

### Arquitectura implementada
- **RISC-V RV32I monociclo**
- No pipelining
- 32 registros de propósito general
- Memoria de instrucciones y datos separadas

### Módulos implementados
- `ProgramCounter` – Registro del PC (sincrónico)
- `Adder4` – Calcula PC + 4
- `InstructionMemory` – Decodifica la instrucción
- `ControlUnit` – Genera todas las señales de control
- `RegisterUnit` – Banco de registros (x0–x31)
- `ImmGen` – Generador de inmediatos (tipos I, S, B, U, J)
- `ALU` – Unidad aritmético-lógica
- `ALU_block` – MUX de entrada + ALU
- `BranchUnit` – Unidad de comparación para saltos condicionales
- `DataMemory` – Memoria de datos (lectura combinacional, escritura sincrónica)
- `PC_Mux` – Selección entre `PC+4` y dirección de salto
- `RU_Mux` – Selección de la fuente de escritura del registro destino
- `Top_level` – Conexión completa del procesador


---

## Requisitos

Para compilar y simular el proyecto necesitas:

- **Icarus Verilog** (`iverilog`, `vvp`)
- **WaveTracer** para visualizar señales
- Cualquier editor con soporte para SystemVerilog (VSCode, Vim, etc.)

---

## Cómo ejecutar las simulaciones

### 1. Compilar cualquier testbench
Ejemplo: ALU

```sh
1. Copiar esto con el modulo a probar y su test-bench

iverilog -g2012 -o sim/ALU_tb.vvp src/ALU.sv tb/ALU_tb.sv

2. Ejecutar

vvp sim/ALU_tb.vvp

3. Ver señales en WaveTracer en el archivo .vcd del nombre que especificaste.

```

## Testbench del procesador completo

El proyecto incluye un testbench Top_level_tb.sv donde puedes cargar instrucciones en memoria (especificamente en el modulo Instruction_memory.sv) y verificar el funcionamiento global del procesador.

## Licencia

Este proyecto es para fines educativos y de aprendizaje.
Puedes modificarlo libremente.
