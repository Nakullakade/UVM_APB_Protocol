interface apb_interface(input logic pclk,preset);
  logic [31:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic pready;
  logic [31:0] prdata;
  logic pslverr;
  
 property preset_assertion;
    @(posedge pclk) 
    $fell(!preset) |-> (pready=='b0 && pslverr=='b0 && prdata==32'b0);
 endproperty
  
  property pslverr_assertion;
    @(posedge pclk)
    $rose(pready && paddr>32) |-> $rose(pslverr);
  endproperty
 
  
 property penable_assertion;
   @(posedge pclk)
   $rose(psel) |=> $rose(penable);
 endproperty
  
 property pready_assertion;
    @(posedge pclk)
    $rose(penable) |=> $rose(pready);
 endproperty
  
  property penable_assertion2;
    @(posedge pclk)
    $fell(pready) |->  $fell(psel) && $fell(penable);
  endproperty
  
  
  assert property(preset_assertion);
  assert property(pslverr_assertion);
  assert property(penable_assertion);
  assert property(pready_assertion);
  assert property(penable_assertion2);
endinterface