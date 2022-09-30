
`timescale 1ns/1ns
module test_VM();
    reg [1:0] A,B;
    reg clk;
    wire [1:0] Y,C;
    reg reset, cancel;
    VM VM0(.a(A), .b(B), .clk(clk), .y(Y), .c(C), .reset(reset), .cancel(cancel));
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
       A=2'b00; B=2'b00; reset=0;
       // Select Cocacola, Pay 10. Change=0
       #10 A=2'b01; #5 B=2'b10;
       
       // Select Cocacola, Pay 5,10. Change=5
       #10 A=2'b01; #5 B=2'b01; #5 B=2'b10;
      
       // Select Pepsi, Pay 5,10. Change=10
       #20 A=2'b10; #5 B=2'b01; #5 B=2'b10;
       
       // Select Pepsi, Pay 10,10. Change=5
       #10 A=2'b10; #5 B=2'b10; #5 B=2'b10;
       
       // Reset.
       #10 reset=1;

       // Select Cocacola, Pay 5, cancel. Change=5
       #10 A=2'b01; #5 B=2'b01; cancel=1;
      
       // Select Pepsi, Pay 10, cancel. Change=10
       #10 A=2'b10; #5 B=2'b10; cancel=1;

       #10 $finish;
   end
 endmodule
