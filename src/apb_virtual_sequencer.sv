class apb_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(apb_virtual_sequencer)
  
  apb_master_sequencer h_ip_seqr;
  
  function new(string name="apb_virtual_sequencer",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_vseqr","inside vseqr new",UVM_MEDIUM)
  endfunction
 
  
  virtual task body();
    h_ip_seqr=apb_master_sequencer::type_id::create("h_ip_seqr",this);
     
   if(!h_ip_seqr) begin
     `uvm_fatal("virtual seqr err","failed to create master sequencer instance")
   end
  endtask
endclass
  
  