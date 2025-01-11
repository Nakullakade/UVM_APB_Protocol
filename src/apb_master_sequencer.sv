class apb_master_sequencer extends uvm_sequencer#(apb_sequence_item);
  `uvm_component_utils(apb_master_sequencer)
  
  function new(string name="apb_master_sequencer",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_seqr","inside seqr new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     `uvm_info("apb_seqr","inside seqr build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("apb_seqr","inside seqr connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("apb_seqr","inside seqr run phase",UVM_MEDIUM)
  endtask
endclass