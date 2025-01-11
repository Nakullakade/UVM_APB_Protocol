class apb_environment extends uvm_env;
  `uvm_component_utils(apb_environment)
  
  apb_virtual_sequencer      h_vseqr;
  apb_master_agent           h_m_agent;
  apb_slave_agent            h_s_agent;
  apb_scoreboard             h_scbd;
  apb_functional_coverage    h_fn_cov;
  env_config                 h_env_cfg;
  
  function new(string name="apb_environment",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_env","inside env new",UVM_MEDIUM)
  endfunction
  
   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("Env","Inside build phase",UVM_LOW)

		if(!uvm_config_db#(env_config)::get(this,"","env_config",h_env_cfg)) begin
			`uvm_fatal("env","env config not collected properly")
		end

		h_env_cfg.build_configs();

		if(h_env_cfg.has_master_agent == 1) begin
          h_m_agent = apb_master_agent :: type_id :: create("h_m_agent",this);
	        end

		if(h_env_cfg.has_slave_agent == 1) begin
          h_s_agent = apb_slave_agent :: type_id :: create("h_s_agent",this);
	 	 end
     
        if(h_env_cfg.has_scoreboard == 1) begin
          h_scbd = apb_scoreboard :: type_id :: create("h_scbd",this);
	 	 end
     
        if(h_env_cfg.has_vseqr == 1) begin
          h_vseqr = apb_virtual_sequencer :: type_id :: create("h_vseqr",this);
	 	 end
     
       if(h_env_cfg.has_cov_collect == 1) begin
          h_fn_cov = apb_functional_coverage :: type_id :: create("h_fn_cov",this);
	 	 end
  endfunction
  
 
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //port connection
    h_vseqr.h_ip_seqr=h_m_agent.h_ip_seqr;
    if(h_vseqr.h_ip_seqr==null)begin
      `uvm_fatal("env connect err","failed to connect seqr in vr seqr and mastr agent")
    end
    h_m_agent.ip_mon.master_mon2scbd.connect(h_scbd.master_mon2scbd_imp_port);
    h_s_agent.op_mon.slave_mon2scbd.connect(h_scbd.slave_mon2scbd_imp_port);
    h_m_agent.ip_mon.master_mon2scbd.connect(h_fn_cov.analysis_export);
    h_s_agent.op_mon.slave_mon2scbd.connect(h_fn_cov.analysis_export);
    `uvm_info("apb_env","inside env connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("apb_env","inside env run phase",UVM_MEDIUM)
  endtask
endclass