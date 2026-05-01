module simple;
    reg clk = 0;
    always #5 clk = ~clk;

    initial begin 
        $dumpfile("wave.vcd");
        $dumpvars(0, simple);
        
        $display("Hello Verilog");
        #50;
        $finish;
    end
endmodule
