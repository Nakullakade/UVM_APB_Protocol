/*
//using queue
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
 
  `uvm_analysis_imp_decl(_ip_imp)
  `uvm_analysis_imp_decl(_op_imp)
  
  uvm_analysis_imp_ip_imp #(apb_sequence_item,apb_scoreboard) master_mon2scbd_imp_port;
  uvm_analysis_imp_op_imp #(apb_sequence_item,apb_scoreboard) slave_mon2scbd_imp_port;
  
   apb_sequence_item h_pkt;
 // apb_sequence_item  ip_arr[int];
//  apb_sequence_item  op_arr[int];
  apb_sequence_item  ip_que[$];
  apb_sequence_item  op_que[$];
  apb_sequence_item  actual_data;
  apb_sequence_item  exp_data; 
  int pass=0;
  int fail=0;
  
  function new(string name="apb_scoreboard",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_scoreboard","inside apb_scoreboard new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     `uvm_info("apb_scoreboard","inside apb_scoreboard build phase",UVM_MEDIUM)
     master_mon2scbd_imp_port=new("master_mon2scbd_imp_port",this);
     slave_mon2scbd_imp_port=new("slave_mon2scbd_imp_port",this);
    h_pkt=apb_sequence_item::type_id::create("h_pkt");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("apb_scoreboard","inside apb_scoreboard connect phase",UVM_MEDIUM)
  endfunction
  
  function void write_ip_imp(apb_sequence_item seq_item);
     // ip_mon2scbd_imp_port.get_next_item(seq_item);
    `uvm_info("write_ip_imp", $sformatf("Storing data: paddr=%0d, pwdata=%0d", seq_item.paddr, seq_item.pwdata), UVM_MEDIUM)
    ip_que.push_back(seq_item);
    //ip_arr[seq_item.paddr]=seq_item;
  endfunction
  
 function void write_op_imp(apb_sequence_item seq_item);
     // op_mon2scbd_imp_port.get_next_item(seq_item);
   `uvm_info("write_op_imp", $sformatf("Storing data: paddr=%0d, prdata=%0d", seq_item.paddr, seq_item.prdata), UVM_MEDIUM)
   if(seq_item.prdata>0) begin
   op_que.push_back(seq_item);
   end
  // op_arr[seq_item.paddr]=seq_item;
 endfunction
 
  task compare_it();

    forever begin
      actual_data=new();
      exp_data=new();
      wait(ip_que.size()>0);
      wait(op_que.size()>0);
      wait(ip_que.size()==op_que.size());
      actual_data=op_que.pop_front();
      exp_data=ip_que.pop_front();
      
      
      if(actual_data.prdata==exp_data.pwdata) begin
        `uvm_info("compare",$sformatf("DATA IS MATCHED !!  act data=%0d, exp data=%0d, act address=%0d, exp add=%0d",actual_data.prdata,exp_data.pwdata,actual_data.paddr,exp_data.paddr),UVM_MEDIUM)
         pass=pass+1;
      end
      else begin 
        `uvm_info("compare",$sformatf("DATA IS NOT MATCHED !!  act data=%0d, exp data=%0d, act address=%0d, exp add=%0d",actual_data.prdata,exp_data.pwdata,actual_data.paddr,exp_data.paddr),UVM_MEDIUM)
        fail=fail+1;
      end 
      end
   
  endtask
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
    compare_it();
    `uvm_info("apb_scoreboard","inside apb_scoreboard run phase",UVM_MEDIUM)
  endtask
  
  virtual function void report_phase(uvm_phase phase);
    if(pass>fail) begin
      `uvm_info("report testcases passed !!",$sformatf("pass count=%0d, fail count=%0d",pass,fail),UVM_MEDIUM)
    end
    else begin
  `uvm_info("report testcases failed !!",$sformatf("pass count=%0d, fail count=%0d",pass,fail),UVM_MEDIUM)
    end
  endfunction
endclass*/


//using associative array
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
 
  `uvm_analysis_imp_decl(_ip_imp)
  `uvm_analysis_imp_decl(_op_imp)
  
  uvm_analysis_imp_ip_imp #(apb_sequence_item,apb_scoreboard) master_mon2scbd_imp_port;
  uvm_analysis_imp_op_imp #(apb_sequence_item,apb_scoreboard) slave_mon2scbd_imp_port;
  
  apb_sequence_item h_pkt;
  typedef apb_sequence_item apb_item_arr[int];
  apb_item_arr ip_arr;
  apb_item_arr op_arr;
  int pass = 0;
  int fail = 0;
  
  function new(string name="apb_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("apb_scoreboard", "inside apb_scoreboard new", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("apb_scoreboard", "inside apb_scoreboard build phase", UVM_MEDIUM)
    master_mon2scbd_imp_port = new("master_mon2scbd_imp_port", this);
    slave_mon2scbd_imp_port = new("slave_mon2scbd_imp_port", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("apb_scoreboard", "inside apb_scoreboard connect phase", UVM_MEDIUM)
  endfunction
  
  function void write_ip_imp(apb_sequence_item seq_item);
    `uvm_info("write_ip_imp", $sformatf("Storing data: paddr=%0d, pwdata=%0d", seq_item.paddr, seq_item.pwdata), UVM_MEDIUM)
    ip_arr[seq_item.paddr] = seq_item;
  endfunction
  
  function void write_op_imp(apb_sequence_item seq_item);
    `uvm_info("write_op_imp", $sformatf("Storing data: paddr=%0d, prdata=%0d", seq_item.paddr, seq_item.prdata), UVM_MEDIUM)
    op_arr[seq_item.paddr] = seq_item;
  endfunction
  
  task compare_it();
    forever begin
      // Wait for some data to be written to the arrays
      wait(ip_arr.num() > 0 || op_arr.num() > 0);
      
      // Iterate over all addresses in ip_arr
      foreach (ip_arr[address]) begin
        if (op_arr.exists(address)) begin
          apb_sequence_item actual_data = op_arr[address];
          apb_sequence_item exp_data = ip_arr[address];

          if (actual_data.prdata == exp_data.pwdata) begin 
            `uvm_info("compare", $sformatf("DATA IS MATCHED!! act data=%0d, exp data=%0d", actual_data.prdata, exp_data.pwdata), UVM_MEDIUM)
            pass = pass + 1;
          end else begin 
            `uvm_info("compare", $sformatf("DATA IS NOT MATCHED!! act data=%0d, exp data=%0d", actual_data.prdata, exp_data.pwdata), UVM_MEDIUM)
            fail = fail + 1;
          end
        end
      end

      // Small delay to avoid busy waiting
      #50;
    end

  endtask
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
      compare_it();
    `uvm_info("apb_scoreboard", "inside apb_scoreboard run phase", UVM_MEDIUM)
  endtask
  
  virtual function void report_phase(uvm_phase phase);
  string msg;

  if(pass > fail) begin
    `uvm_info("report testcases passed!!", $sformatf("pass count=%0d, fail count=%0d", pass, fail), UVM_MEDIUM)
  end else begin
    `uvm_info("report testcases failed!!", $sformatf("pass count=%0d, fail count=%0d", pass, fail), UVM_MEDIUM)
  end

  msg = "ip_arr contents:\n";
  foreach (ip_arr[address]) begin
    msg = {msg, $sformatf("paddr: %0d, pwdata: %0d\n",ip_arr[address].paddr, ip_arr[address].pwdata)};
  end
  `uvm_info("ip_arr contents", msg, UVM_MEDIUM);

  msg = "op_arr contents:\n";
  foreach (op_arr[address]) begin
    msg = {msg, $sformatf("paddr: %0d, prdata: %0d\n",op_arr[address].paddr, op_arr[address].prdata)};
  end
  `uvm_info("op_arr contents", msg, UVM_MEDIUM);
endfunction

endclass

