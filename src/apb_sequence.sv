class apb_single_write_read extends uvm_sequence#(apb_sequence_item);
  `uvm_object_utils(apb_single_write_read)
  
  apb_sequence_item h_pkt;
  int addr_collect;
  
  function new(string name ="apb_single_write_read");
    super.new(name);
    `uvm_info("apb_s_seq","inside seq new",UVM_MEDIUM)
  endfunction

  
 /* virtual task body();
    single_write();
    single_read();
  endtask
  
  virtual task single_write();
    idle_phase();
    setup_phase_write();
    access_phase_write();
  //  idle_phase();
  endtask*/
  
  virtual task body();
    single_write();
    single_read();
  endtask
  
/*  virtual task single_read();
     idle_phase();
     setup_phase_read();
    access_phase_read();
  //  idle_phase();
  endtask*/
  
  
  
  
  virtual task single_write();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.randomize();
    h_pkt.pwrite='b1;
    addr_collect=h_pkt.paddr;
    finish_item(h_pkt);
  endtask
  
  virtual task single_read();
    start_item(h_pkt);
    h_pkt.paddr=addr_collect;
    h_pkt.pwrite='b0;
    finish_item(h_pkt);
  endtask
  
 /* virtual task s_write_start();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.randomize() with {psel=='b1; pwrite=='b1; penable=='b1;};
    addr_collect=h_pkt.paddr;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
     h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
  virtual task s_write_end();
   //  h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.psel='b0;
    h_pkt.pwrite='b0;
    h_pkt.penable='b0;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
     h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
   
  virtual task s_read_start();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.paddr=addr_collect;
    h_pkt.psel='b1;
    h_pkt.pwrite='b0;
    h_pkt.penable='b1;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
     h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
  virtual task s_read_end();
 // h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.psel='b0;
    h_pkt.pwrite='b0;
    h_pkt.penable='b0;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
     h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask*/
  
 /* virtual task idle_phase();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.psel=0;
    h_pkt.penable=0;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
   //  h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
   virtual task setup_phase_write();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
     h_pkt.randomize() with {psel=='b1; pwrite=='b1; penable=='b0;};
    addr_collect=h_pkt.paddr;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
   //  h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
  virtual task setup_phase_read();
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    //h_pkt.randomize() with {psel=='b1; pwrite=='b0; penable=='b0;};
    h_pkt.psel='b1;
    h_pkt.pwrite='b0;
    h_pkt.penable='b0;
    h_pkt.paddr= addr_collect;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
   //  h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
   virtual task access_phase_write();
    // h_pkt=apb_sequence_item::type_id::create("h_pkt");
     start_item(h_pkt);
     h_pkt.psel='b1; 
     h_pkt.pwrite='b1; 
     h_pkt.penable='b1;
     finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
   //  h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask
  
  virtual task access_phase_read();
    // h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.psel='b1; 
    h_pkt.pwrite='b0; 
    h_pkt.penable='b1;
    finish_item(h_pkt);
    
    if(h_pkt==null) begin
      `uvm_fatal("seq err","packet is not generated")
    end
    // h_pkt.print();
    `uvm_info("seq",$sformatf("Done generation of data is %s items",h_pkt), UVM_MEDIUM)
    `uvm_info("apb seq","inside seq task body",UVM_MEDIUM)
  endtask*/
endclass

class apb_multiple_write_read extends apb_single_write_read;
  `uvm_object_utils(apb_multiple_write_read)
   apb_sequence_item h_pkt;
  bit [7:0][31:0]addr_arr;
  int i;
  
  function new(string name ="apb_multiple_write_read");
    super.new(name);
    `uvm_info("apb_m_seq","inside seq new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
     
    multiple_write();
    multiple_read();
  endtask
  
   virtual task multiple_write();
     i=0;
     repeat(8) begin
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.randomize();
    h_pkt.pwrite='b1;
    addr_arr[i]=h_pkt.paddr;
    finish_item(h_pkt);
       i++;
     end
  endtask
  
  virtual task multiple_read();
    i=0;
    repeat(8) begin
    start_item(h_pkt);
    h_pkt.paddr=addr_arr[i];
    h_pkt.pwrite='b0;
    finish_item(h_pkt);
    i++;
    end
  endtask
endclass
    
class apb_alternate_write_read extends apb_multiple_write_read;
  `uvm_object_utils(apb_alternate_write_read)
   apb_sequence_item h_pkt;
  
  function new(string name ="apb_alternate_write_read");
    super.new(name);
    `uvm_info("apb_m_seq","inside seq new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
    repeat(10) begin
      super.single_write();
      super.single_read();
    end
  endtask
  
endclass

class apb_slave_error_check extends apb_alternate_write_read;
  `uvm_object_utils(apb_slave_error_check)
   apb_sequence_item h_pkt;
  
  function new(string name ="apb_slave_error_check");
    super.new(name);
    `uvm_info("apb_m_seq","inside seq new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
    #20;
    incorrect_read_addr();
  endtask
  
  virtual task incorrect_read_addr();
    h_pkt=apb_sequence_item::type_id::create("h_pkt");
    start_item(h_pkt);
    h_pkt.paddr=200;
    h_pkt.pwrite='b0;
    finish_item(h_pkt);
  endtask
  
endclass


    
    