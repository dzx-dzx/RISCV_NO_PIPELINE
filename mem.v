module MEM #(
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32
    )(
        input [WORD_BITWIDTH-1:0] ALUresult,
        input [WORD_BITWIDTH-1:0] regReadData2,
        input [WORD_BITWIDTH-1:0] memReadData,
        input memWrite,
        input memRead,
        input memToReg,
        output reg [WORD_BITWIDTH-1:0] regWriteData,
        output reg [WORD_BITWIDTH-1:0] address,
        output reg [WORD_BITWIDTH-1:0] memWriteData
    );
    always @(*)
    begin
        memWriteData=regReadData2;
        address=ALUresult;
        regWriteData=memToReg?memReadData:ALUresult;
    end
endmodule
