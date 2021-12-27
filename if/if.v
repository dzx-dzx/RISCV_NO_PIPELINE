// `include "mux/mux.v"
module IF #(
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32
    )(
        input clk,
        input rst,
        input branch_pc,
        input zero,
        input [WORD_BITWIDTH-1:0]imm,
        output reg [WORD_BITWIDTH-1:0] pc
    );
    wire[WORD_BITWIDTH-1:0] next_pc;

    MUX mux(
            .control(branch_pc&zero),
            .in0(pc+4),
            .in1(pc+imm<<1),
            .out(next_pc)
        );
    always @(posedge clk or negedge rst)
    begin
        if(rst)
            pc <= 0;
        else
            pc <= next_pc;
    end
endmodule
