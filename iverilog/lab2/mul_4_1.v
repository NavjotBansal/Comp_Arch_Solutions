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

module testbench;
reg [3:0]in;
reg [1:0]sel;
wire out;
mux_4_1 ma(out,in,sel);
initial 
begin 
$monitor($time,"in=%4b ,sel=%2b,out=%1b",in,sel,out);
#0 in=4'b0000;
#0 sel=2'b00;
repeat(15)
begin 
#10 in=in+4'b0001; 
sel=sel+2'b01;
end
end
endmodule

