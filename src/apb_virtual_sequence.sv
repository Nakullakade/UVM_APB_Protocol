class apb_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(apb_virtual_sequence)
  `uvm_declare_p_sequencer(apb_virtual_sequencer)
  apb_single_write_read     h_s_wr_seq;
  apb_multiple_write_read   h_m_wr_seq;
  apb_alternate_write_read  h_alt_wr_seq;
  apb_slave_error_check     h_slv_err_chck_seq;
  
  function new(string name="apb_virtual_sequence");
    super.new(name);
    `uvm_info("apb_vseq","inside vseq new",UVM_MEDIUM)
  endfunction
  
  
 virtual task body();
   if(p_sequencer==null) begin
     `uvm_fatal("seq err","p_sequencer is null")
   end
   
   if(p_sequencer.h_ip_seqr==null) begin
     `uvm_fatal("seq err","p_sequencer.h_ip_seqr is null")
   end
   
   h_s_wr_seq=apb_single_write_read::type_id::create("h_s_wr_seq");
   h_m_wr_seq=apb_multiple_write_read::type_id::create("h_m_wr_seq");
   h_alt_wr_seq=apb_alternate_write_read::type_id::create("h_alt_wr_seq");
   h_slv_err_chck_seq=apb_slave_error_check::type_id::create("h_slv_err_chck_seq");
   if(!h_s_wr_seq) begin
     `uvm_fatal("seq err","failed to create sequence instance")
   end
   
   h_s_wr_seq.start(p_sequencer.h_ip_seqr);
   h_m_wr_seq.start(p_sequencer.h_ip_seqr);
   h_alt_wr_seq.start(p_sequencer.h_ip_seqr);
   h_slv_err_chck_seq.start(p_sequencer.h_ip_seqr);
   `uvm_info("apb_vseq","inside vseq body task",UVM_MEDIUM)
  endtask
endclass