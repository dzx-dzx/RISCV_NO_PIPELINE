`include "alu.v"
module EX #(
        parameter AND = 4'b0000,
        parameter OR = 4'b0001,
        parameter ADD = 4'b0010,
        parameter SUBTRACT = 4'b0110,
        parameter XOR = 4'b0011,
        parameter SLL = 4'b0100,
        parameter SRL = 4'b0101,
        parameter LESS_THAN = 4'b0111,
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32

    )(
        input [WORD_BITWIDTH-1:0] regReadData1,
        input [WORD_BITWIDTH-1:0] regReadData2,
        input [WORD_BITWIDTH-1:0] imm,
        input ALUSrc,
        input [1:0] ALUOp,
        input [3:0] inst_ALU,//(part of)funct7+funct3
        output zero,
        output [WORD_BITWIDTH-1:0] ALUresult
    );
    wire [WORD_BITWIDTH-1:0] addend1,addend2;
    assign addend1=regReadData1;
    assign addend2=ALUSrc?imm:regReadData2;

    reg [3:0] operation;

    always @(*)
    begin
        case (ALUOp)
            2'b00:
                operation=ADD;
            2'b01:
                operation=SUBTRACT;
            2'b10,2'b11:
            begin
                case(inst_ALU[2:0])
                    3'b111:
                        operation=AND;
                    3'b110:
                        operation=OR;
                    3'b000:
                        operation=inst_ALU[3]?SUBTRACT:ADD;
                    3'b100:
                        operation=XOR;
                    3'b001:
                        operation=SLL;
                    3'b101:
                        operation=SRL;
                    default:
                        operation=operation;
                endcase
            end
            default:
                operation=operation;
        endcase
    end

    ALU  #(
             .AND(AND),
             .OR(OR),
             .ADD(ADD),
             .SUBTRACT(SUBTRACT),
             .XOR(XOR),
             .SLL(SLL),
             .SRL(SRL),
             .LESS_THAN(LESS_THAN)
         )alu(
             .operation(operation),
             .addend1(addend1),
             .addend2(addend2),
             .zero(zero),
             .result(ALUresult)
         );
endmodule
