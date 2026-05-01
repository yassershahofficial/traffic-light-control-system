module behavioral (
    input clk,
    input rst,
    output reg NS_G, NS_Y, NS_R,
    output reg EW_G, EW_Y, EW_R
);
    // State Encoding
    parameter S0 = 2'b00, // NS Green, EW Red
              S1 = 2'b01, // NS Yellow, EW Red
              S2 = 2'b10, // NS Red, EW Green
              S3 = 2'b11; // NS Red, EW Yellow

    reg [1:0] state;
    reg [2:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            count <= 3'd0;
        end else begin
            case (state)
                S0: begin
                    if (count == 3'd4) begin 
                        state <= S1;
                        count <= 3'd0;
                    end else count <= count + 1;
                end
                S1: begin
                    if (count == 3'd1) begin 
                        state <= S2;
                        count <= 3'd0;
                    end else count <= count + 1;
                end
                S2: begin
                    if (count == 3'd4) begin 
                        state <= S3;
                        count <= 3'd0;
                    end else count <= count + 1;
                end
                S3: begin
                    if (count == 3'd1) begin 
                        state <= S0;
                        count <= 3'd0;
                    end else count <= count + 1;
                end
            endcase
        end
    end

    // Output Logic
    always @(*) begin
        {NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R} = 6'b000_000;
        case (state)
            S0: {NS_G, NS_R, EW_R} = 3'b101;
            S1: {NS_Y, NS_R, EW_R} = 3'b101;
            S2: {NS_R, EW_G, EW_R} = 3'b110; // NS Red, EW Green (Red is implicit)
            S3: {NS_R, EW_Y, EW_R} = 3'b110; // NS Red, EW Yellow
        endcase
        // Corrected mapping based on problem sequence:
        case (state)
            S0: {NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R} = 6'b100_001;
            S1: {NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R} = 6'b010_001;
            S2: {NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R} = 6'b001_100;
            S3: {NS_G, NS_Y, NS_R, EW_G, EW_Y, EW_R} = 6'b001_010;
        endcase
    end
endmodule