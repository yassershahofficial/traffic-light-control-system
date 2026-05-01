module tb;
    reg clk, rst;

    wire b_NS_G, b_NS_Y, b_NS_R, b_EW_G, b_EW_Y, b_EW_R;
    wire d_NS_G, d_NS_Y, d_NS_R, d_EW_G, d_EW_Y, d_EW_R;
    wire s_NS_G, s_NS_Y, s_NS_R, s_EW_G, s_EW_Y, s_EW_R;

    behavioral uut_b (
        .clk(clk), .rst(rst), 
        .NS_G(b_NS_G), .NS_Y(b_NS_Y), .NS_R(b_NS_R), 
        .EW_G(b_EW_G), .EW_Y(b_EW_Y), .EW_R(b_EW_R)
    );

    dataflow uut_d (
        .clk(clk), .rst(rst), 
        .NS_G(d_NS_G), .NS_Y(d_NS_Y), .NS_R(d_NS_R), 
        .EW_G(d_EW_G), .EW_Y(d_EW_Y), .EW_R(d_EW_R)
    );

    structural uut_s (
        .clk(clk), .rst(rst), 
        .NS_G(s_NS_G), .NS_Y(s_NS_Y), .NS_R(s_NS_R), 
        .EW_G(s_EW_G), .EW_Y(s_EW_Y), .EW_R(s_EW_R)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("all_models_waveform.vcd"); 
        $dumpvars(0, tb);
        $display("Starting Traffic Light Simulation...");
        rst = 1; #15; 
        rst = 0;      
        #500;         
        $display("Simulation Complete.");
        $finish;
    end
endmodule