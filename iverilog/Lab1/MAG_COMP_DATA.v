module mag_comp_data(e,l,g,x,y);
input [3:0]x,y;
output e,l,g;
assign l = (x<y)	,
	   e = (x==y),
	   g = (x>y);
endmodule

module testbench;
	reg [3:0]x,y;
	wire e,l,g;
	mag_comp_data mod(e,l,g,x,y);
initial 
	begin
	$dumpfile("mag.vcd");
	$dumpvars();
	$monitor($time,"x=%4b y=%4b",x,y);
	#0	x=4'b1100;y=4'b1111;
	#10 x=4'b1111;y=4'b0000;
	#20 x=4'b1111;y=4'b1111;
	#30 $finish;
	end
endmodule