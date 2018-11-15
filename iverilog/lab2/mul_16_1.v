module mux_4_1(out,in,sel);
output out;
input [3:0]in;
input [1:0]sel;
wire [1:0]n1;
wire [3:0]mid;
not n1(n1[0],sel[0]),
    n2(n1[1],sel[1]);
and a1(mid[0],n1[0],n1[1],in[0]),
    a1(mid[1],sel[0],n1[1],in[0]),
    a1(mid[2],n1[0],sel[1],in[0]),
    a1(mid[3],sel[0],sel[1],in[0]);
    
or o1(out,mid[0],mid[1],mid[2],mid[3]);
endmodule

module mux_16_1(out,in,sel);
output out;
input [15:0]in;
input [3:0]sel;
wire [3:0]mux;
mux_4_1 m1(mux[0],in[3:0],sel[1:0]);
mux_4_1 m2(mux[1],in[7:4],sel[1:0]);
mux_4_1 m3(mux[2],in[11:8],sel[1:0]);
mux_4_1 m4(mux[3],in[15:12],sel[1:0]);

mux_4_1 m5(out,mux,sel[3:2]);
endmodule
module testbench;
reg [15:0]in;
reg [3:0]sel;
wire out;
mux_16_1 ma(out,in,sel);
initial 
begin 
$dumpfile("mul_16_1.vcd");
$dumpvars();
$monitor($time,"in=%b ,sel=%b,out=%b",in,sel,out);
in=16'b1000000000000000;
sel=4'b0010;
#3 in=16'b1000000000000000;
sel=4'b0000;
#3 in=16'b0100000000000000;
sel=4'b0001;
#3 in=16'b0010000000000000;
sel=4'b0011;
#3 in=16'b0001000000000000;
sel=4'b0100;
#3 in=16'b0000100000000000;
sel=4'b0101;
#3 in=16'b0000010000000000;
sel=4'b0110;
#3 in=16'b0000000100000000;
sel=4'b0111;
#3 in=16'b0000000010000000;
sel=4'b1000;
#3 in=16'b0000000001000000;
sel=4'b1001;
#3 in=16'b0000000000100000;
sel=4'b1010;
#3 in=16'b0000000000010000;
sel=4'b1011;
#3 in=16'b0000000000001000;
sel=4'b1100;
#3 in=16'b0000000000000100;
sel=4'b1101;
#3 in=16'b0000000000000010;
sel=4'b1110;
#3 in=16'b0000000000000001;
sel=4'b1111;

end
endmodule
