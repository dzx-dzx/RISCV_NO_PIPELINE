module CONTROL #(
    parameter INST_R     = 7'b0110011,
    parameter INST_I_LD  = 7'b0000011,
    parameter INST_I_IMM = 7'b0010011,
    parameter INST_S     = 7'b0100011,
    parameter INST_B     = 7'b1100011,
    parameter INST_J     = 7'b1101111,
    parameter INST_U     = 7'b0010011
) (
    input      [6:0] opcode  ,
    output reg       branch  ,
    output reg       memRead ,
    output reg       memToReg,
    output reg [1:0] ALUOp   ,
    output reg       memWrite,
    output reg       ALUSrc  ,
    output reg       regWrite
);
    always @(opcode)
        begin
            case (opcode)
                INST_R :
                    begin
                        branch   = 0;
                        memRead  = 0;
                        memToReg = 0;
                        ALUOp    = 2'b10;
                        memWrite = 0;
                        ALUSrc   = 0;
                        regWrite = 1;
                    end
                INST_I_IMM :
                    begin
                        branch   = 0;
                        memRead  = 0;
                        memToReg = 0;
                        ALUOp    = 2'b00;
                        memWrite = 0;
                        ALUSrc   = 1;
                        regWrite = 1;
                    end
                INST_I_LD :
                    begin
                        branch   = 0;
                        memRead  = 1;
                        memToReg = 1;
                        ALUOp    = 2'b00;
                        memWrite = 0;
                        ALUSrc   = 1;
                        regWrite = 1;
                    end
                INST_S :
                    begin
                        branch   = 0;
                        memRead  = 0;
                        memToReg = 0;
                        ALUOp    = 2'b00;
                        memWrite = 1;
                        ALUSrc   = 1;
                        regWrite = 0;
                    end
                INST_B :
                    begin
                        branch   = 1;
                        memRead  = 0;
                        memToReg = 0;
                        ALUOp    = 2'b10;
                        memWrite = 0;
                        ALUSrc   = 0;
                        regWrite = 0;
                    end
                INST_J :
                    ;
                INST_U :
                    ;
                default :
                    {branch  ,
                        memRead ,
                        memToReg,
                        ALUOp   ,
                        memWrite,
                        ALUSrc  ,
                        regWrite}=0;
            endcase
        end
endmodule
