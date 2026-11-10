sim:
	iverilog -g2012 -o counter_sim counter.sv counter_tb.sv
	vvp counter_sim

test:
	iverilog -g2012 -o counter_sim counter.sv counter_tb.sv
	vvp counter_sim | tee sim.log
	grep -q "PASS" sim.log
