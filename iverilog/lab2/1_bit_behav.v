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

module testbench;
reg a,b,cin;
wire s,c;
bit_be mod(s,c,a,b,cin);
initial
begin 
$dumpvars();
$dumpfile("1bit.vcd");
$monitor($time,"a=%b b=%b cin=%b s=%b c=%b",a,b,cin,s,c);
#0 a=1'b0;
b=1'b1;
cin=1'b1;
#5 a=1'b1;
b=1'b1;
cin = 1'b0;
#10 a=1'b1;
b=1'b0;
cin = 1'b0;
end
endmodule
