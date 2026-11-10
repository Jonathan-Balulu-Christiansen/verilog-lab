# verilog-lab

Learning SystemVerilog design verification, simulated with Icarus Verilog.

## counter
A 4-bit counter with synchronous reset, plus a self-checking testbench:
- A reference model predicts the expected count every cycle
- A checker compares DUT vs. model on the falling clock edge (avoids races)
- Mismatches are counted and reported, with a PASS/FAIL summary
- Verified that the checker catches bugs by injecting a fault into the model

Run it: `cd counter && make test` (exits with an error on failure)

## traffic_light_state_machine
A 3-state traffic light FSM. The testbench currently only generates waveforms (not self-checking yet).
