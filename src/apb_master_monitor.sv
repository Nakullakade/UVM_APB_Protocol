class apb_master_monitor extends uvm_monitor;
  `uvm_component_utils(apb_master_monitor)
   virtual apb_interface vif;
   uvm_analysis_port#(apb_sequence_item) master_mon2scbd;
   apb_sequence_item h_pkt;
  
  function new(string name="apb_master_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info("ip_mon","inside ip mon new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     master_mon2scbd=new("master_mon2scbd",this);
     h_pkt=apb_sequence_item::type_id::create("h_pkt");
     `uvm_info("ip_mon","inside ip mon build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(!uvm_config_db #(virtual apb_interface)::get(this,"","intf1",vif)) 
      begin
        `uvm_fatal("ip_mon","config get unsuccess at ip mon!!")
      end
    else
        begin
        `uvm_info("ip_mon","config get success at ip mon!!",UVM_MEDIUM)
        end
    `uvm_info("ip_mon","inside ip mon connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
        forever begin
          @(posedge vif.pclk);
          if(vif.preset==1 && vif.pwrite==1 && vif.psel==1)
         begin
           h_pkt=apb_sequence_item::type_id::create("h_pkt");
           h_pkt.pwdata=vif.pwdata;
           h_pkt.paddr=vif.paddr;
           h_pkt.pslverr=vif.pslverr;
           master_mon2scbd.write(h_pkt);
        //   h_pkt.print();
        end
       end
          
    `uvm_info("ip_mon","inside ip mon run phase",UVM_MEDIUM)
  endtask
endclass