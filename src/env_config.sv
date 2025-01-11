class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	bit has_master_agent;
	bit has_slave_agent;
	bit has_vseqr;
	bit has_scoreboard;
	bit has_cov_collect;
	
	function new(string name = "env_config");
		super.new(name);
	endfunction

       function void build_configs();
	   has_master_agent = 1'b1;
	   has_slave_agent = 1'b1;
	   has_vseqr = 1'b1;
	   has_scoreboard = 1'b1;
	   has_cov_collect = 1'b1;
	endfunction
  
 

endclass