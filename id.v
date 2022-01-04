`include "control.v"
module ID #(
    parameter INST_R = 7'b0110011,
    parameter INST_I_LD = 7'b0000011,
    parameter INST_I_IMM = 7'b0010011,
    parameter INST_S = 7'b0100011,
    parameter INST_B = 7'b1100011,
    parameter INST_J = 7'b1101111,
    parameter INST_U = 7'b0010011,
    parameter REG_NUM_BITWIDTH = 5,
    parameter WORD_BITWIDTH = 32
)(
    input [WORD_BITWIDTH-1:0] instruction,
    output branch,
    output memRead,
    output memToReg,
    output [1:0]ALUOp,
    output memWrite,
    output ALUSrc,
    output regWrite,
    output [REG_NUM_BITWIDTH-1:0] regToRead1,
    output [REG_NUM_BITWIDTH-1:0] regToRead2,
    output [REG_NUM_BITWIDTH-1:0] regToWrite,
    output reg [WORD_BITWIDTH-1:0] imm,
    output [6:0] opcode
);
assign regToRead1 = instruction[19:15];
assign regToRead2 = instruction[24:20];
assign regToWrite = instruction[11:7];
assign opcode     = instruction[6:0];
CONTROL #(
    .INST_R    (INST_R    ),
    .INST_I_LD (INST_I_LD ),
    .INST_I_IMM(INST_I_IMM),
    .INST_S    (INST_S    ),
    .INST_B    (INST_B    ),
    .INST_J    (INST_J    ),
    .INST_U    (INST_U    )
) control (
    .opcode  (instruction[6:0]),
    .branch  (branch          ),
    .memRead (memRead         ),
    .memToReg(memToReg        ),
    .ALUOp   (ALUOp           ),
    .memWrite(memWrite        ),
    .ALUSrc  (ALUSrc          ),
    .regWrite(regWrite        )
);
always @(*)
    begin
        case (instruction[6:0])
            INST_R :
                begin
                    imm = 0;
                end
            INST_I_LD :
                begin
                    imm = {(instruction[31]==0)?{20'b0}:{20{1'b1}},instruction[31:20]};
                end
            INST_I_IMM :
                begin
                    imm = {(instruction[31]==0)?{20'b0}:{20{1'b1}},instruction[31:20]};
                end
            INST_S :
                begin
                    imm = {(instruction[31]==0)?{20'b0}:{20{1'b1}},instruction[31:25],instruction[11:7]};
                end
            INST_B :
                begin
                    imm = {(instruction[31]==0)?{19'b0}:{19{1'b1}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
                end
            INST_J :
                imm = {
                    (instruction[31] == 0) ? {19'b0} : {19{1'b1}},
                    instruction[31],
                    instruction[19:12],
                    instruction[20],
                    instruction[30:21],
                    1'b0
                };
            INST_U :
                imm = 0;
            default :
                imm = 0;
        endcase
    end

endmodule
