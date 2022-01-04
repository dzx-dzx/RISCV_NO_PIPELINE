module REGISTER #(
    parameter REG_NUM_BITWIDTH = 5 ,
    parameter WORD_BITWIDTH    = 32
) (
    input                             clk       ,
    input                             rst       ,
    input      [REG_NUM_BITWIDTH-1:0] regToRead1,
    input      [REG_NUM_BITWIDTH-1:0] regToRead2,
    input      [REG_NUM_BITWIDTH-1:0] regToWrite,
    input      [   WORD_BITWIDTH-1:0] write_data,
    input                             doRegWrite,
    output reg [   WORD_BITWIDTH-1:0] read_data1,
    output reg [   WORD_BITWIDTH-1:0] read_data2
);
    reg [WORD_BITWIDTH-1:0] reg_file[0:31];
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                ;
            // begin
            //     read_data1<=0;
            //     read_data2<=0;
            // end
            else
                begin
                    if(doRegWrite)
                        reg_file[regToWrite] <= write_data;
                    else
                        reg_file[regToWrite] <= reg_file[regToWrite];
                end
        end
    always @(regToRead1 or reg_file[regToRead1])
        begin
        if(regToRead1==regToWrite)$display("At %t, register %h is both being read and written.",$time,regToRead1);
        read_data1=regToRead1==0?0:reg_file[regToRead1];
    end

    always @(regToRead2 or reg_file[regToRead2])
        begin
        if(regToRead2==regToWrite)$display("At %t, register %h is both being read and written.",$time,regToRead2);
        read_data2=regToRead2==0?0:reg_file[regToRead2];
    end
endmodule
