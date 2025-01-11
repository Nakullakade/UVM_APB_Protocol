`include "uvm_macros.svh"
import uvm_pkg::*;

`include "apb_package.sv"
import apb_package::*;

`include "apb_interface.sv"

module apb_tb_top;
  bit pclk;
  bit preset;
  
  parameter rst_period=5;
  parameter clk_period=6;
  
  apb_interface intf(pclk,preset);
  
  apb_design i_apb_design(.pclk(pclk),.preset(preset),
                          .paddr(intf.paddr),.psel(intf.psel),
                          .penable(intf.penable),.pwrite(intf.pwrite),
                          .pwdata(intf.pwdata),.pready(intf.pready),
                          .prdata(intf.prdata),.pslverr(intf.pslverr));
  
  initial begin 
    clk_generate();
  end
  
  initial begin
    reset_generate();
  end
  
  initial begin 
    uvm_config_db #(virtual apb_interface)::set(null,"*","intf1",intf);
    run_test("apb_test");
  end
  
  task clk_generate();
    pclk='b0;
    forever begin
      #(clk_period/2) pclk=~pclk;
    end
  endtask
  
  task reset_generate();
      #(rst_period);
      preset='b1;
      #(rst_period);
      preset='b0;
    #(rst_period);
      preset='b1;
  endtask
  
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    #1000;
    $finish;
  end
endmodule
      
  
  
