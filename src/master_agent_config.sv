class master_agent_config extends uvm_object;
	`uvm_object_utils(master_agent_config)

	uvm_active_passive_enum is_active;

	bit has_master_seqr;
	bit has_master_driver;
	bit has_master_monitor;


	function new(string name = "master_agent_config");
		super.new(name);
		is_active = UVM_ACTIVE;
		 has_master_seqr = 1'b1;
		 has_master_driver = 1'b1;
		 has_master_monitor = 1'b1;
		 `uvm_info("master_agent_config","Inside new",UVM_LOW)
	endfunction
endclass