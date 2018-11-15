module BCD_TO_GRAY(y,x);
    input [3:0]x;
    output[3:0]y;
    
    xor x1(y[3],x[3],0);
    xor x2(y[2],x[3],x[2]);
    xor x3(y[1],x[2],x[1]);
    xor x4(y[0],y[1],y[0]);
endmodule

module testbench;
    reg [3:0]x;
    wire  [3:0]y;
    BCD_TO_GRAY mod(y,x);
    initial
    begin
		$dumpfile("BCD.vcd");
		$dumpvars();
		$monitor($time,"x=%4b,y=%4b",x,y);
        #0 x=4'b0000;
        repeat(9)
        #10 x=x + 4'b0001;
        #100 $finish;
    end
endmodule
