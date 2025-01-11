class apb_master_agent extends uvm_agent;
  `uvm_component_utils(apb_master_agent)
  apb_master_sequencer h_ip_seqr;
  apb_master_driver    ip_driv;
  apb_master_monitor   ip_mon;
  
  master_agent_config  h_m_agent_cfg; 
 
  function new(string name="apb_master_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info("ip_agent","inside ip agent new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
     `uvm_info("m_agent","Inside m_agent build phase",UVM_LOW)

  if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",h_m_agent_cfg)) 
    begin
       `uvm_fatal("master agent","m agent config not collected properly")
    end

    if(h_m_agent_cfg.has_master_seqr == 1) 
          begin
          h_ip_seqr = apb_master_sequencer :: type_id :: create("h_ip_seqr",this);
	      end

	if(h_m_agent_cfg.has_master_driver == 1) 
          begin
          ip_driv = apb_master_driver :: type_id :: create("ip_driv",this);
	 	  end
     
    if(h_m_agent_cfg.has_master_monitor == 1)
          begin
          ip_mon = apb_master_monitor :: type_id :: create("ip_mon",this);
	 	  end
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ip_driv.seq_item_port.connect(h_ip_seqr.seq_item_export);
    `uvm_info("ip_agent connect phase","seq to driver connection success !!",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("ip_agent","inside ip agent run phase",UVM_MEDIUM)
  endtask
endclass