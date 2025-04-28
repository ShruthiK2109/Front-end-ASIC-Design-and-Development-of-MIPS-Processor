// top level design for testing
module mips_test #(parameter WIDTH = 8, REGBITS = 3) ();
    reg clk = 0;
    reg reset = 1;

    // instantiate device under test
    mips_mem dut(clk, reset);

    // initialize the test, then quit after some time
    initial 
    begin
        // set up waveform dump
        $dumpfile("mips_test.vcd");   // specify the name of the dump file
        $dumpvars(0, mips_test);      // dump all variables from this module

        reset <= 1;
        #220 reset <= 0;
        #30000 $finish;
    end

    // generate clock
    always #50 clk <= ~clk;

    // check the data on the memory interface
    always @(negedge clk)
    begin
        if (dut.memwrite) begin
            if (dut.adr == 8'hFF && dut.writedata == 8'h0D) begin
                $display("Fibonacci Simulation was successful!!!");
            end else begin
                $display("Fibonacci Simulation has failed...");
                $display("Data at address FF should be 0D");
            end
        end
    end
endmodule