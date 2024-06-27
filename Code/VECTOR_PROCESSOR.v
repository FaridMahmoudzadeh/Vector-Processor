module VECTOR_PROCESSOR (
        input clk, reset,
        input [12:0] instruct,
        output [511:0] A1, A2, A3, A4
    );

    reg [511:0] rf_in_1, rf_in_2;
    reg [1:0] r_reg;
    reg [1:0] w_reg_1, w_reg_2;
    reg rf_w_enable_1, rf_w_enable_2;
    wire [511:0] rf_out;
    wire [511:0] A1_out, A2_out, A3_out, A4_out;

    reg [511:0] ALU_in_1, ALU_in_2;
    reg operation;
    wire [1023:0] ALU_out;

    reg [511:0] data_in;
    reg [8:0] mem_address;
    reg data_w_enable;
    wire [511:0] data_out;
    
    integer i;

    REGISTER_FILE register_file (clk, reset,
                                    rf_in_1, rf_in_2, 
                                    r_reg, 
                                    w_reg_1, w_reg_2, 
                                    rf_w_enable_1, rf_w_enable_2,
                                    rf_out, 
                                    A1_out, A2_out, A3_out, A4_out
        );
    ALU alu (ALU_in_1, ALU_in_2, 
                operation,
                ALU_out
        );
    MEMORY mem (clk, reset, 
                    data_in, 
                    mem_address, 
                    data_w_enable, 
                    data_out
        );

    assign A1 = A1_out;
    assign A2 = A2_out;
    assign A3 = A3_out;
    assign A4 = A4_out;

    always @(posedge clk) begin
        #5;
        if (~instruct[12]) begin
            rf_w_enable_1 <= ~instruct[11];
            rf_w_enable_2 <= 0;
            mem_address <= instruct[8:0];
            data_w_enable <= instruct[11];
            if(instruct[11]) begin
                r_reg <= instruct[10:9];
                #1
                data_in <= rf_out;
            end
            else begin
                w_reg_1 <= instruct[10:9];
                #5
                rf_in_1 <= data_out;
            end
        end
        else begin
            operation = instruct[11];
            data_w_enable <= 0;
            rf_w_enable_1 <= 1;
            rf_w_enable_2 <= 1;
            w_reg_1 <= 2'b10;
            w_reg_2 <= 2'b11;
            ALU_in_1 <= A1_out;
            ALU_in_2 <= A2_out;
            #5
            for(i = 0; i < 16; i = i + 1) begin
                rf_in_1[32*i +: 32] <= ALU_out[64*i +: 32];
                rf_in_2[32*i +: 32] <= ALU_out[64*i+32 +: 32];
            end
        end
    end
endmodule