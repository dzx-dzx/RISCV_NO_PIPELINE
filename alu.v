module ALU #(
        parameter AND = 4'b0000,
        parameter OR = 4'b0001,
        parameter ADD = 4'b0010,
        parameter SUBTRACT = 4'b0110,
        parameter XOR = 4'b0011,
        parameter SLL = 4'b0100,
        parameter SRL = 4'b0101,
        parameter LESS_THAN = 4'b0111,
        parameter ZERO=4'b0,
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32
    )(
        input      [ 3:0] operation,
        input      [WORD_BITWIDTH-1:0] addend1  ,
        input      [WORD_BITWIDTH-1:0] addend2  ,
        output            zero     ,
        output reg [WORD_BITWIDTH-1:0] result
    );
    always@*
    begin
        case(operation)
            AND :
                result = addend1&addend2;
            OR :
                result = addend1|addend2;
            ADD :
                result = addend1+addend2;
            SUBTRACT :
                result = addend1-addend2;
            XOR:
                result = addend1^addend2;
            SLL:
                result = addend1<<addend2;
            SRL:
                result = addend1>>addend2;
            LESS_THAN:
                result = addend1<addend2? 1'b0 : 1'b1;
            ZERO:
                result = {WORD_BITWIDTH{1'b0}};
            default :
                result = {WORD_BITWIDTH{1'b0}};
        endcase
    end
    assign zero = result == {WORD_BITWIDTH{1'b0}};
endmodule
