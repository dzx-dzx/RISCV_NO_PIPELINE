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
    reg [WORD_BITWIDTH-1:0] next_pc;

    wire control;
    assign control=branch_pc&zero;

    always @(control or pc or imm)
    begin
        next_pc=(control)?(pc+(imm)):(pc+4);
    end
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            pc <= 32'hFFFFFFFC;
        else
            pc <= next_pc;
    end
endmodule
