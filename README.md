# ARM_one_multi_cycle

## ARM one cycle architecture
Aim The purpose of this project is to design the mircoarchitecture of a simplified one-cycle ARM processor into FPGA technology, using the Vivado IDE.
How we approach:
1. Take of the subset of instructions we have to support. These are ADD(S), SUB(S), CMP, AND(S), XOR(S), MOV, MVN-S, LSL, ASR-S, LDR, STR, B, BL.
2. Choose which components we need for every step of execution, on behalf of Datapath, and design it.
3. Choose which components we need for every step of execution, on behalf of Control Unit, and design it.
4. Design the top level, consisted of Datapath, Control Unit, and other components and test the behavior of our system.

![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/a13ceb5d-3568-4a17-9ab1-a257f64c6a5a)

![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/e922ab0c-8399-49ee-a320-33881357c486)

### Design Datapath

![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/e7166ffa-0fb2-486a-a47a-b31bb82adf58)

Implement and test, in VHDL all the components of Datapath (above image).

### Design Control Unit

![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/7ce80044-2e4f-4f8d-87ed-ce0e99372cad)

Implement and test, in VHDL all the components of Control Unit, that are needed to support the appropriate instructions subset.

### FPGA implementation and analysis

![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/400a1ade-9b7e-4ce6-974b-9ca1a5c6960f)


![image](https://github.com/panostom/ARM_one_multi_cycle/assets/158047350/4104507b-e394-445b-909b-d263fd9687f3)
