module dataflow (
    input clk, rst,
    output NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R
);
    reg [1:0] state;
    reg [2:0] count;
    wire tc; // Terminal Count

    assign tc = (state[1] == 0 && count == (state[0] ? 1 : 4)) || 
                (state[1] == 1 && count == (state[0] ? 1 : 4));

    always @(posedge clk or posedge rst) begin
        if (rst) begin state <= 0; count <= 0; end
        else begin
            state <= tc ? state + 1 : state;
            count <= tc ? 0 : count + 1;
        end
    end

    assign NS_G = (state == 2'b00);
    assign NS_Y = (state == 2'b01);
    assign NS_R = state[1];
    assign EW_G = (state == 2'b10);
    assign EW_Y = (state == 2'b11);
    assign EW_R = !state[1];
endmodule