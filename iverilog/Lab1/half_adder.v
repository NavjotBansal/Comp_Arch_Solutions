module half(s,c,a,b);
input a,b;
wire a0,b0,x,y,z;
output s,c;
nand n1(a0,a,1),
     n2(b0,b,1),
     n3(x,a,b0),
     n4(y,b,a0),
     n5(s,x,y),
     n6(z,a,b),
     n7(c,z,1);
endmodule

module testbench;
reg a,b;
wire s,c;
half x(s,c,a,b);
initial 
begin 
 $dumpfile("half.vcd");
 $dumpvars();
$monitor($time,"a=%b b=%b",a,b);
#0 a=1'b0;
b=1'b0;
#10 a=1'b0;
b=1'b1;
#10 a=1'b1;
b=1'b0;
#10 a=1'b1;
b=1'b1;
end
endmodule
