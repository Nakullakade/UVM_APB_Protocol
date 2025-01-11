class apb_slave_agent extends uvm_agent;
  `uvm_component_utils(apb_slave_agent)
  apb_slave_monitor   op_mon;
  slave_agent_config  h_s_agent_cfg;
  
  function new(string name="apb_master_agent",uvm_component parent);
    super.new(name,parent);
     `uvm_info("op_agent","inside op agent new",UVM_MEDIUM)
  endfunction
  
   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
     `uvm_info("m_agent","Inside m_agent build phase",UVM_LOW)

   if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",h_s_agent_cfg)) 
     begin
       `uvm_fatal("master agent","m agent config not collected properly")
	 end

     if(h_s_agent_cfg.has_slave_monitor == 1) 
      begin
          op_mon = apb_slave_monitor :: type_id :: create("op_mon",this);
	  end
  endfunction
 
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("op_agent","inside op agent connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("op_agent","inside op agent run phase",UVM_MEDIUM)
  endtask
endclass