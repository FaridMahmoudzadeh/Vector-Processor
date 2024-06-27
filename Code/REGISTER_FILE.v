module REGISTER_FILE (
        input clk, reset,
        input [511:0] data_in_1, data_in_2,
        input [1:0] r_reg,
        input [1:0] w_reg_1, w_reg_2,
        input w_enable_1, w_enable_2,
        output [511:0] data_out,
        output [511:0] A1, A2, A3, A4
    );

    reg [511:0] regs [0:3];
    assign A1 = regs[0];
    assign A2 = regs[1];
    assign A3 = regs[2];
    assign A4 = regs[3];
    assign data_out = regs[r_reg];

    always @(negedge clk) begin
        if(reset) begin
            regs[0] <= 0;
            regs[1] <= 0;
            regs[2] <= 0;
            regs[3] <= 0;
        end 
        else begin
            if (w_enable_1)
                regs[w_reg_1] <= data_in_1;
            if (w_enable_2)
                regs[w_reg_2] <= data_in_2;
        end
    end
endmodule
