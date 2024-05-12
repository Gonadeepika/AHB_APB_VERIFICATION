class apb_mon extends uvm_monitor;
	
	`uvm_component_utils(apb_mon)
//virtual interface
virtual apb_if.APB_MON_MP vif;
apb_config m_cfg; 
uvm_analysis_port#(apb_xtn)monitor_port1;

function new(string name="apb_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port1=new("monitor_port1",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(apb_config)::get(this,"","apb_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 

endfunction
///*
function void connect_phase(uvm_phase phase);
vif=m_cfg.vif;
endfunction

task run_phase (uvm_phase phase);
	forever
	begin
		collect_data();
	end
endtask

task collect_data();
apb_xtn data_sent;

data_sent=apb_xtn::type_id::create("data_sent");

while(vif.apb_mon_cb.penable!==1'b1)
@(vif.apb_mon_cb);

data_sent.paddr=vif.apb_mon_cb.paddr;
data_sent.pwrite=vif.apb_mon_cb.pwrite;
data_sent.pselx=vif.apb_mon_cb.pselx;
//data_sent.pwrite=vif.apb_mon_cb.pwrite;
while(vif.apb_mon_cb.penable!==1'b1)
@(vif.apb_mon_cb);

if(data_sent.pwrite==1'b0)
data_sent.prdata=vif.apb_mon_cb.prdata;
else
data_sent.pwdata=vif.apb_mon_cb.pwdata;

@(vif.apb_mon_cb);

`uvm_info("UVM_MON",$sformatf("printf from monitor \n %s",data_sent.sprint()),UVM_LOW)

m_cfg.mon_data_sent_cnt++;


monitor_port1.write(data_sent);
//*/
endtask
function void report_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("Report:apb driver sent %0d transcations",m_cfg.mon_data_sent_cnt),UVM_LOW)
endfunction


endclass
