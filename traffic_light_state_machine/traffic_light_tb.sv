`timescale 1ns/1ps // This is a testbench for the traffic light module

module traffic_light_tb;

    logic clk = 0;
    logic rst = 1;
    logic red, yellow, green;

    traffic_light dut(
        .clk(clk),    // the chip's clk is connected to the testbench clk
        .rst(rst),    // the chip's rst is connected to the testbench rst
        .red(red),    // the chip's red is connected to the testbench red
        .yellow(yellow), // the chip's yellow is connected to the testbench yellow
        .green(green)  // the chip's green is connected to the testbench green
    );

    always #5 clk = ~clk; // Toggle clock every 5 time units

    initial begin
        $dumpfile("traffic_light_tb.vcd"); //the name of the dump file in the simulation
        $dumpvars(0, traffic_light_tb);    //dump all (0) the variables in the testbench
        #20 rst = 0; // release reset after 20 time units
        #300 $finish; // finish simulation after 300 time units (30 clock cycles)
    end
endmodule
