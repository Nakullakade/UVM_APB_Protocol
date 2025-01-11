class apb_slave_monitor extends uvm_monitor;
  `uvm_component_utils(apb_slave_monitor)
  virtual apb_interface vif;
  apb_sequence_item h_pkt;
  uvm_analysis_port#(apb_sequence_item) slave_mon2scbd;
  
  function new(string name="apb_slave_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info("op_mon","inside op mon new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     slave_mon2scbd=new("slave_mon2scbd",this);
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
     `uvm_info("op_mon","inside op mon build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
      if(!uvm_config_db #(virtual apb_interface)::get(this,"","intf1",vif)) 
      begin
        `uvm_fatal("op_mon err","config get unsuccess at op mon!!")
      end
   else begin
     `uvm_info("op_mon","config get success at op mon!!",UVM_MEDIUM)
    end
    `uvm_info("op_mon","inside op mon connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge vif.pclk);
      if(vif.preset==1 && vif.pwrite==0 && vif.psel==1)
         begin
           h_pkt=apb_sequence_item::type_id::create("h_pkt");
           h_pkt.prdata=vif.prdata;
           h_pkt.paddr=vif.paddr;
           h_pkt.pslverr=vif.pslverr;
           slave_mon2scbd.write(h_pkt);
         //  h_pkt.print();
        end
        end
    `uvm_info("op_mon","inside op mon run phase",UVM_MEDIUM)
  endtask
endclass