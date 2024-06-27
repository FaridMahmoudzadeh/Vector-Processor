module ALU (
        input [511:0] data_in_1, data_in_2,
        input operator,
        output [1023:0] data_out
    );

    reg [1023:0] S;
    assign data_out = S;
    integer i;

    always @(*) begin
        if (operator) begin
            for (i = 0; i < 16; i = i + 1) begin
                S[64*i +: 64] <= data_in_1[32*i +: 32] + data_in_2[32*i +: 32];
            end
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                S[64*i +: 64] <= data_in_1[32*i +: 32] * data_in_2[32*i +: 32];
            end
        end
    end
endmodule
