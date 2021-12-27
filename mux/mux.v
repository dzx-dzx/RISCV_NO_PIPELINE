module MUX #(
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32
    )(
        input control,
        input [WORD_BITWIDTH-1:0] in0,
        input [WORD_BITWIDTH-1:0] in1,
        output reg [WORD_BITWIDTH-1:0] out
    );
    always @(control)
    begin
        out = control?in0:in1;
    end
endmodule
