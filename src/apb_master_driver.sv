class apb_master_driver extends uvm_driver#(apb_sequence_item);
  `uvm_component_utils(apb_master_driver)
  virtual apb_interface vif;
  apb_sequence_item h_pkt; 
  
  function new(string name="apb_master_driver",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_master_driver","inside apb_master_driver new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_pkt=apb_sequence_item::type_id::create("h_pkt");
     `uvm_info("apb_master_driver","inside apb_master_driver build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     if(!uvm_config_db #(virtual apb_interface)::get(this,"","intf1",vif)) 
      begin
        `uvm_fatal("driver","config get unsuccess at driver!!")
      end
  else begin
    `uvm_info("driver","config get success at master driver!!",UVM_MEDIUM)
    end
    `uvm_info("apb_master_driver","inside apb_master_driver connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //idle_phase();
    forever begin
      @(posedge vif.pclk);
      idle_phase();
    seq_item_port.get_next_item(h_pkt);
    
    vif.paddr<=h_pkt.paddr;
    vif.pwdata<=h_pkt.pwdata;
    vif.pwrite<=h_pkt.pwrite;
    seq_item_port.item_done();
    
    setup_phase();
    access_phase();
   // h_pkt.print();
    end
    `uvm_info("apb_master_driver","inside apb_master_driver run phase",UVM_MEDIUM)
  endtask
  
  
  
  task idle_phase();
    @(posedge vif.pclk);
    vif.psel<='b0;
    vif.penable<='b0;
  endtask
  
  task setup_phase();
   // forever begin
    @(posedge vif.pclk);
     vif.psel<='b1;
    vif.penable<='b0;
   // end
  endtask
  
  task access_phase();
   // forever begin
    @(posedge vif.pclk);
    vif.psel<='b1;
    vif.penable<='b1;
   // end
  endtask
endclass