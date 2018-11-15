module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);input x,y,z;
output d0,d1,d2,d3,d4,d5,d6,d7;
wire x0,y0,z0;
not n1(x0,x);
not n2(y0,y);
not n3(z0,z);
and a0(d0,x0,y0,z0);
and a1(d1,x0,y0,z);
and a2(d2,x0,y,z0);
and a3(d3,x0,y,z);
and a4(d4,x,y0,z0);
and a5(d5,x,y0,z);
and a6(d6,x,y,z0);
and a7(d7,x,y,z);
endmodule
module FADDER(s,c,x,y,z);
input x,y,z;
wire d0,d1,d2,d3,d4,d5,d6,d7;
output s,c;
DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
assign s = d1 | d2 | d4 | d7,
c = d3 | d5 | d6 | d7;
endmodule

module adder_8_bit(s,carry,a,b,cin);
input [7:0]a,b;
input cin;
output [7:0]s;
output carry;
wire c1,c2,c3,c4,c5,c6,c7;
FADDER f1(s[0],c1,a[0],b[0],cin);
FADDER f2(s[1],c2,a[1],b[1],c1);
FADDER f3(s[2],c3,a[2],b[2],c2);
FADDER f4(s[3],c4,a[3],b[3],c3);
FADDER f5(s[4],c5,a[4],b[4],c4);
FADDER f6(s[5],c6,a[5],b[5],c5);
FADDER f7(s[6],c7,a[6],b[6],c6);
FADDER f9(s[7],carry,a[7],b[7],c7   );
endmodule

module testbench;
reg [7:0]a,b;
reg cin;
wire [7:0]s;
wire carry;
adder_8_bit mod(s,carry,a,b,cin);
initial
begin
$dumpvars();
$dumpfile("8bit.vcd");
$monitor($time,"a=%b b=%b cin=%b",a,b,cin);
a=8'b10010010;
b=8'b10010010;
cin=1'b0;
#10a=8'b10010011;
b=8'b10010001;
cin=1'b1;
end
endmodule
