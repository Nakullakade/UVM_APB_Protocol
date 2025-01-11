class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  
  apb_environment             h_apb_env;
  apb_virtual_sequence        h_apb_vseq;
  env_config                  h_env_cfg;
  master_agent_config         h_m_agent_cfg;
  slave_agent_config          h_s_agent_cfg;
	
  
  function new(string name="apb_test",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_test","inside test new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_apb_env=apb_environment::type_id::create("h_apb_env",this);
    h_apb_vseq=apb_virtual_sequence::type_id::create("h_apb_vseq");
    h_env_cfg=env_config::type_id::create("h_env_config");
    h_m_agent_cfg=master_agent_config::type_id::create("h_m_agent_cfg");
    h_s_agent_cfg=slave_agent_config::type_id::create("h_s_agent_cfg");
    
  uvm_config_db#(master_agent_config)::set(this,"*","master_agent_config",h_m_agent_cfg);
  //  `uvm_fatal("master agent","m agent config not created properly")
   
  uvm_config_db#(slave_agent_config)::set(this,"*","slave_agent_config",h_s_agent_cfg);
  // `uvm_fatal("master agent","m agent config not created properly")
    
  uvm_config_db#(env_config)::set(this,"*","env_config",h_env_cfg);
  // `uvm_fatal("env","env config not created properly")
  `uvm_info("apb_test","inside test build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("apb_test","inside test connect phase",UVM_MEDIUM)
  endfunction
  
   function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    h_apb_vseq.start(h_apb_env.h_vseqr);
    #50;
    phase.drop_objection(this);
    `uvm_info("apb_test","inside test run phase",UVM_MEDIUM)
  endtask
endclass
  
  