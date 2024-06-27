module TESTBENCH;

    reg clk, reset;
    reg [12:0] instruct;
    wire [511:0] A1, A2, A3, A4;

    VECTOR_PROCESSOR processor (clk, reset, instruct, A1, A2, A3, A4);

    always
        #25 clk = ~clk;

    initial begin
        $monitor($time, ":\nA1: %h\nA2: %h\nA3: %h\nA4: %h", A1, A2, A3, A4);
        clk = 0;
        reset <= 1;
        #50
        reset <= 0;
        instruct <= {2'b00, 2'b00, 9'b0}; // A1 <- M[0]
        #50
        instruct <= {2'b00, 2'b01, 9'b10000}; // A2 <- M[16]
        #50
        instruct <= {2'b00, 2'b10, 9'b110000}; // A3 <- M[48]
        #50
        instruct <= {2'b00, 2'b11, 9'b10000}; // A4 <- M[16]
        #50
        instruct <= {2'b10, 2'b00, 9'b0}; // {A4 A3} <- A1 * A2 (vector mult)
        #50
        instruct <= {2'b11, 2'b00, 9'b0}; // {A4 A3} <- A1 + A2 (vector add)
        #50
        instruct <= {2'b01, 2'b10, 9'b100000}; // M[32] <- A3
        #50
        instruct <= {2'b01, 2'b11, 9'b110000}; // M[48] <- A4
        #50 
        instruct <= {2'b00, 2'b00, 9'b100000}; // A1 <- M[32]
        #50
        instruct <= {2'b00, 2'b01, 9'b110000}; // A2 <- M[48]
        #50
        instruct <= {2'b10, 2'b11, 9'b101010101}; // {A4 A3} <- A1 * A2 (vector mult)
        #50
        instruct <= {2'b11, 2'b01, 9'b111100000}; // {A4 A3} <- A1 + A2 (vector add)
        #50
        $stop;
    end


endmodule
