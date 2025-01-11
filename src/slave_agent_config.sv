class slave_agent_config extends uvm_object;
  `uvm_object_utils(slave_agent_config)

	uvm_active_passive_enum is_passive;

	bit has_master_seqr;
	bit has_master_driver;
	bit has_slave_monitor;


  function new(string name = "slave_agent_config");
		super.new(name);
		is_passive = UVM_PASSIVE;
		 has_master_seqr = 1'b0;
		 has_master_driver = 1'b0;
		 has_slave_monitor = 1'b1;
		 `uvm_info("master_agent_config","Inside new",UVM_LOW)
	endfunction
endclass