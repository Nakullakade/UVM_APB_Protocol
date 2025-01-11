class apb_functional_coverage extends uvm_subscriber#(apb_sequence_item);
   `uvm_component_utils(apb_functional_coverage)
  apb_sequence_item pkt1;
  
  covergroup cg;
    cp1:coverpoint pkt1.pwdata{bins b1[10]={[100:200]};}
    cp2:coverpoint pkt1.prdata{bins b2[10]={[100:200]};}
    cp3:coverpoint pkt1.penable{bins b3[1]={[0:1]};}
    cp4:coverpoint pkt1.pready{bins b4[1]={[0:1]};}
    cp6:coverpoint pkt1.paddr{bins b6[10]={[0:31]};}
    cp7:coverpoint pkt1.pslverr{bins b7[1]={[0:1]};}
    cp8:coverpoint pkt1.psel{bins b8[1]={[0:1]};}
  endgroup
  
  function new(string name="apb_sequence_item", uvm_component parent);
    super.new(name,parent);
    pkt1=apb_sequence_item::type_id::create("pkt1");
    cg = new();
    if(cg==null) begin
      `uvm_fatal("fn err","cg not created !!")
    end
    `uvm_info("fn cov new","inside fn new method",UVM_MEDIUM)
  endfunction
  
  
  virtual function void write(apb_sequence_item t);
    pkt1=t;
    cg.sample();
    `uvm_info("coverage",$sformatf("the functional coverage is %0d",cg.get_coverage()),UVM_MEDIUM)
  endfunction
endclass
  