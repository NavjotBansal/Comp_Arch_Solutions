module bit_be(s,c,a,b,cin);
input a,b,cin;
output s,c;
reg s,c;
always @(*)
begin
if(a==1 & b==1)
begin
s=cin;
c=1;
end
else
begin
        if(cin==0)
        begin
        s=a+b;c=0;
        end
        else
        begin
        if(a==1 | b==1)
        begin s=0;c=1; end
        else 
        begin 
        s=1;c=0;
        end
        end
end
end
endmodule


module ADDSUB(s,carry,v,M,a,b,cin);
    input [3:0]a,b;
    input cin,M;
    output [3:0]s;
    output carry,v;
    wire [3:0]x;   
    xor x1(x[0],b[0],M),
        x2(x[1],b[1],M),
        x3(x[2],b[2],M),
        x4(x[3],b[3],M);
    wire c1,c2,c3;
    bit_be b1(s[0],c1,a[0],x[0],cin),
           b2(s[1],c2,a[1],x[1],c1),
           b3(s[2],c3,a[2],x[2],c2),
           b4(s[3],carry,a[3],x[3],c3);
    xor(v,carry,c3);
endmodule

module testbench;
reg [3:0]a,b;
reg cin,M;
wire [3:0]s;
wire carry,v;
ADDSUB P(s,carry,v,M,a,b,cin);
initial
begin 
$dumpvars();
$dumpfile("ADDSUB.vcd");
$monitor($time,"a=%b b=%b cin=%b M=%b s=%b carry=%b v=%b",a,b,cin,M,s,carry,v);
#0 a=4'b1010;
b=4'b0101;
cin=1'b1;
M=1'b0;
#5 a=4'b1010;
b=4'b0101;
cin = 1'b0;
M=1'b1;
end
endmodule

