`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:54:21 11/17/2013 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module UltiMem(reset, clock, r_w, address, data, io, flash_ce, ram_ce, we, oe, ram1, ram2, ram3, blk1, blk2, blk3, blk5, irq, nmi, led, switch, baddress, bdata);
inout reset;
input clock;
input r_w;
input [12:0]address;
inout [7:0]data;
input [3:2] io;
output flash_ce;
output ram_ce;
output we;
output oe;
input ram1;
input ram2;
input ram3;
input blk1;
input blk2;
input blk3;
input blk5;
output irq;
output nmi;
output led;
input [1:0]switch;
output [22:0]baddress;
inout [7:0]bdata;

wire [7:0]reg_data;
wire reg_data_read;
wire reset_out;
wire [9:0]bank;
wire data_read;
wire [7:0]mux_data;

//assign irq = 1'bz;
//assign nmi = 1'bz;

assign baddress[12:0] = address[12:0]; // level shift address lines
assign baddress[22:13] = bank[9:0];
assign data = (data_read | reg_data_read ? mux_data : 8'bz);
assign bdata = (!r_w ? data : 8'bz);

assign reset    =                (!reset_out ? 0 : 1'bz);  // reset_out is active low

MemExpander #(.WIDTH(10), .MEMEXPANDER_ID('b00010001))			MemExpander1(1, 
                                              reset, 
                                              reset_out, 
															 clock, 
															 r_w, 
															 address, 
															 data, 
															 reg_data, 
															 reg_data_read, 
															 io, 
															 flash_ce, 
															 ram_ce, 
															 we, 
															 oe, 
															 ram1, 
															 ram2, 
															 ram3, 
															 blk1, 
															 blk2, 
															 blk3, 
															 blk5, 
															 bank,
															 led,
															 switch,
															 data_read
															);


mux2_1 #(.WIDTH(8))            data_mux(reg_data_read, 
                                        bdata, 
													 reg_data, 
													 mux_data
													);

endmodule
