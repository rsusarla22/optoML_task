# optoML_task
This repository implements a parameterized pipeline register in SystemVerilog, using a valid-ready handshake protocol. The control signals "in_valid" indicated the input data is valid and "in_ready" indicates that the register is ready to accept data. Hence, data is transferred only when both in_valid and in_ready are HIGH.

When both signals are asserted to HIGH, the input data is latched into the pipeline register and the module asserts "out_valid" for one clock cycle.

The testbench considered the following cases.

| Test No. | in_valid | in_ready | Expected Behavior    |
| ---- | -------- | -------- | -------------------- |
| 1    | 1        | 1        | Data transfer occurs |
| 2    | 1        | 0        | No transfer          |
| 3    | 0        | 1        | No transfer          |
| 4    | 1        | 1        | Data transfer resumes     |
