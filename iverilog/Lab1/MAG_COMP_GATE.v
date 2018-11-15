module mag_comp_gate(l,e,g,x,y);

input [3:0]x,y;
output l,e,g;
wire [3:0]Eq,Lt,Gt,Nx,Ny;

// equal 
xnor x3(Eq[3],x[3],y[3]),
	 x2(Eq[2],x[2],y[2]),
	 x1(Eq[1],x[1],y[1]),
	 x0(Eq[0],x[0],y[0]);
and  a1(e	,Eq[3],Eq[2],Eq[1],Eq[0]);

// less
not n1(Nx[3],x[3]),
	n2(Nx[2],x[2]),
	n3(Nx[1],x[1]),
	n4(Nx[0],x[0]),
	p1(Ny[3],y[3]),
	p2(Ny[2],y[2]),
	p3(Ny[1],y[1]),
	p4(Ny[0],y[0]);

and a2(Lt[3],Nx[3],y[3]),
	a3(Lt[2],Eq[3],Nx[2],y[2]),
	a4(Lt[1],Eq[3],Eq[2],Nx[1],y[1]),
	a5(Lt[0],Eq[3],Eq[2],Eq[1],Nx[0],y[0]);
	
or	o1(l,Lt[3],Lt[2],Lt[1],Lt[0]);
// greater

and a2(Gt[3],x[3],Ny[3]),
	a3(Gt[2],Eq[3],x[2],Ny[2]),
	a4(Gt[1],Eq[3],Eq[2],x[1],Ny[1]),
	a5(Gt[0],Eq[3],Eq[2],Eq[1],x[0],Ny[0]);
	
or	o2(g,Gt[3],Gt[2],Gt[1],Gt[0]);
endmodule

module testbench02;
reg [3:0]x,y;
wire l,e,g;
mag_comp_gate mod(l,e,g,x,y);
initial 
	begin
		$dumpfile("mcg_gate.vcd");
		$dumpvars();
		$monitor($time,"x=%4b y=%4b",x,y);
	#0	x=4'b1100;y=4'b1111;
	#10 x=4'b1111;y=4'b0000;
	#20 x=4'b1111;y=4'b1111;
	#40 $finish;
	end
endmodule