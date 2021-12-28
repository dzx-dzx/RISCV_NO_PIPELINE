`include "if.v"
`include "id.v"
`include "ex.v"
`include "register.v"
`include "mem.v"
module riscv #(
        parameter REG_NUM_BITWIDTH = 5,
        parameter WORD_BITWIDTH = 32
    )(

        input wire				 clk,
        input wire				 rst,         // high is reset

        // inst_mem
        input wire[31:0]         inst_i,
        output wire[31:0]        inst_addr_o,
        output wire              inst_ce_o,

        // data_mem
        input wire[31:0]         data_i,      // load data from data_mem
        output wire              data_we_o,
        output wire              data_ce_o,
        output wire[31:0]        data_addr_o,
        output wire[31:0]        data_o       // store data to  data_mem

    );
    wire branch;
    wire ALUzero;
    wire [WORD_BITWIDTH-1:0] imm;

    wire memRead;
    wire memToReg;
    wire [1:0]ALUOp;
    wire memWrite;
    wire ALUSrc;
    wire regWrite;
    wire [REG_NUM_BITWIDTH-1:0] regToRead1;
    wire [REG_NUM_BITWIDTH-1:0] regToRead2;
    wire [REG_NUM_BITWIDTH-1:0] regToWrite;

    wire [WORD_BITWIDTH-1:0] regReadData1;
    wire [WORD_BITWIDTH-1:0] regReadData2;

    wire [WORD_BITWIDTH-1:0] ALUresult;

    wire [WORD_BITWIDTH-1:0] regWriteData;

    assign inst_ce_o=~rst;

    assign data_we_o=memWrite;
    assign data_ce_o=memRead;

    //  instance your module  below
    IF #(
           .REG_NUM_BITWIDTH(REG_NUM_BITWIDTH),
           .WORD_BITWIDTH(WORD_BITWIDTH)
       )
       if_u(
           .clk(clk),
           .rst(rst),
           .branch_pc(branch),
           .zero(ALUzero),
           .imm(imm),
           .pc(inst_addr_o)
       );

    ID #(
           .REG_NUM_BITWIDTH(REG_NUM_BITWIDTH),
           .WORD_BITWIDTH(WORD_BITWIDTH)
       )id_u(
           .instruction(inst_i),
           .branch(branch),
           .memRead(memRead),
           .memToReg(memToReg),
           .ALUOp(ALUOp),
           .memWrite(memWrite),
           .ALUSrc(ALUSrc),
           .regWrite(regWrite),
           .regToRead1(regToRead1),
           .regToRead2(regToRead2),
           .regToWrite(regToWrite),
           .imm(imm)
       );

    REGISTER #(
                 .REG_NUM_BITWIDTH(REG_NUM_BITWIDTH),
                 .WORD_BITWIDTH(WORD_BITWIDTH)
             ) register(
                 .clk(clk),
                 .rst(rst),
                 .regToRead1(regToRead1),
                 .regToRead2(regToRead2),
                 .regToWrite(regToWrite),
                 .write_data(regWriteData),
                 .doRegWrite(regWrite),
                 .read_data1(regReadData1),
                 .read_data2(regReadData2)
             );

    EX #(
           .REG_NUM_BITWIDTH(REG_NUM_BITWIDTH),
           .WORD_BITWIDTH(WORD_BITWIDTH)
       )ex_u(
           .regReadData1(regReadData1),
           .regReadData2(regReadData2),
           .imm(imm),
           .ALUSrc(ALUSrc),
           .ALUOp(ALUOp),
           .inst_ALU({inst_i[30],inst_i[14:12]}),
           .zero(ALUzero),
           .ALUresult(ALUresult)
       );

    MEM #(
            .REG_NUM_BITWIDTH(REG_NUM_BITWIDTH),
            .WORD_BITWIDTH(WORD_BITWIDTH)
        )mem_u(
            .ALUresult(ALUresult),
            .regReadData2(regReadData2),
            .memWrite(memWrite),
            .memRead(memRead),
            .memToReg(memToReg),
            .regWriteData(regWriteData),
            .address(data_addr_o),
            .memWriteData(data_o),
            .memReadData(data_i)
        );

endmodule
