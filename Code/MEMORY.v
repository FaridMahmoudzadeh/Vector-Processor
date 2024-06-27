module MEMORY(
        input clk, reset,
        input [511:0] data_in,
        input [8:0] mem_addr,
        input w_enable,
        output [511:0] data_out
    );

    reg [31:0] mem [0:511];
    reg [511:0] memory_out;
    
    assign data_out = memory_out;
    
    integer i, j;
 
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            if (mem_addr + i < 512)
                memory_out[32*i +: 32] = mem[mem_addr + i];
        end
    end

    always @(negedge clk) begin
        if(reset) begin
            for (j = 0; j < 12; j = j + 1) begin
                mem[j] <= j;
                mem[j + 16] <= 2000 + j;
            end
            mem[12] <= 32'hFFFFFFFF;
            mem[28] <= 32'hFFFFFFFF;
            
            mem[13] <= 32'hFF0000FF;
            mem[29] <= 32'h00FFFF00;
            
            mem[14] <= 32'hFF000000;
            mem[30] <= 32'h10000000;

            mem[15] <= 32'h1FFFFFFF;
            mem[31] <= 32'hEFFFFFFF;
        end
        else begin
            if (w_enable) begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (mem_addr + j < 512)
                        mem[mem_addr + j] <= data_in[32*j +: 32];
                end
            end
        end
    end
endmodule
