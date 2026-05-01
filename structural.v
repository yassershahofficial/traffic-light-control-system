module structural (
    input clk, rst,
    output NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R
);

    reg [1:0] state;
    reg [2:0] count;
    wire s1, s0, ns1, ns0;

    always @(posedge clk or posedge rst) begin
        if (rst) {state, count} <= 0;
        else if ((count == 4 && !state[0]) || (count == 1 && state[0])) begin
            state <= state + 1;
            count <= 0;
        end else count <= count + 1;
    end

    assign {s1, s0} = state;
    not n1(ns1, s1);
    not n0(ns0, s0);

    and g1(NS_G, ns1, ns0); 
    and g2(NS_Y, ns1, s0);  
    buf g3(NS_R, s1);       
    
    and g4(EW_G, s1, ns0);  
    and g5(EW_Y, s1, s0);   
    buf g6(EW_R, ns1);      
endmodule