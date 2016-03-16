

module DES_hw(clk, reset, key, din, dinvld, dout, doutvld);
  
	input clk;
	input reset;
	input [63:0] key;
	input [63:0] din;
	input dinvld;
	output [63:0] dout;
	output doutvld;

endmodule	
