`timescale 1ns/1ps // This is a testbench for the counter module

module counter_tb;

    logic clk = 0;
    logic rst = 1;
    logic [3:0] count;
    logic [3:0] expected;
    int error_count = 0;

    counter dut(
        .clk(clk),    // the chip's clk is connected to the testbench clk
        .rst(rst),    // the chip's rst is connected to the testbench rst
        .count(count) // the chip's count is connected to the testbench count
    );

    always #5 clk = ~clk; // Toggle clock every 5 time units
    always_ff @(posedge clk) begin
        if (rst) begin
            expected <= 4'b0000; // Reset expected count to 0
        end else begin
            expected <= expected + 1; // Increment expected count on each clock cycle
        end
    end
    always @(negedge clk) begin
        if (count !== expected) begin // Check if the count from the DUT matches the expected value
            error_count++;
            $display("Error at time %0t, count = %0d, expected = %0d", $time, count, expected);
        end
    end

    initial begin
        $dumpfile("counter_tb.vcd"); //the name of the dump file in the simulation
        $dumpvars(0, counter_tb);    //dump all (0) the variables in the testbench
        #20 rst = 0; // release reset after 20 time units
        #202; //waits another 202 so 222 including the line before
        if (error_count == 0)
            $display("PASS with no errors.");
        else
            $display("Test failed with %0d errors.", error_count);
        $finish; // finish simulation after all checks are done
    end
endmodule
