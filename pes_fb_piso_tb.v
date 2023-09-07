// Code your testbench here
// or browse Examples
module pes_fb_piso_tb();
  
  reg clk, load;
  reg [3:0] data_in;
  
  wire data_out;
  
  iiitb_piso u1 (clk, load, data_in, data_out);
  
  initial begin
    $dumpfile("pes_fb_piso.vcd");
    $dumpvars(0);
  end
  
  initial begin
    clk = 0; load = 0; data_in = 4'b1011;
    
    #10
    load= 1;
    
  end

    always #5 clk=~clk;
  
endmodule
