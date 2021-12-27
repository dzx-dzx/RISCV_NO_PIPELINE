`timescale 1ns/1ns
`include "alu.v"
module alu_tb ();

  // Parameters
  localparam [3:0] AND = 4'b0000;

  // Ports
  reg  [ 3:0] operation;
  reg  [63:0] addend1  ;
  reg  [63:0] addend2  ;
  wire        zero     ;
  wire [63:0] result   ;

  ALU alu (
        .operation(operation),
        .addend1  (addend1  ),
        .addend2  (addend2  ),
        .zero     (zero     ),
        .result   (result   )
      );

  initial
  begin
    $dumpfile("wave.vcd");
    $dumpvars(0,operation,addend1,addend2,zero,result);
    operation=AND;
    addend1=6879870;
    addend2=89078664;
    #2 operation=AND;
    #100 ;
  end
  initial
    $monitor("%t,%b,%b,%b,%b,%b",$time,operation,addend1,addend2,zero,result);

endmodule
