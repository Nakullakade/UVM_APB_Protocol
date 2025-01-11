class apb_sequence_item extends uvm_sequence_item;
 // `uvm_object_utils(apb_sequence_item)
  rand bit [31:0] paddr;
   bit psel;
   bit penable;
   bit pwrite;
  rand bit [31:0]pwdata;
  bit pready;
  bit [31:0]prdata;
  bit pslverr;
  
  constraint c1{paddr inside {[0:31]};}
  constraint c2{pwdata inside {[100:200]};}
  
  function new(string name="apb_sequence_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(apb_sequence_item)
  `uvm_field_int(paddr, UVM_ALL_ON)
  `uvm_field_int(psel, UVM_ALL_ON)
  `uvm_field_int(penable, UVM_ALL_ON)
  `uvm_field_int(pwrite, UVM_ALL_ON)
  `uvm_field_int(pwdata, UVM_ALL_ON)
  `uvm_field_int(pready,UVM_ALL_ON)
  `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_field_int(pslverr, UVM_ALL_ON)
  `uvm_object_utils_end
endclass