class ahb_mon extends uvm_monitor;
	
	`uvm_component_utils(ahb_mon)
//virtual interface
virtual ahb_if.AHB_MON_MP vif;
ahb_config m_cfg;
uvm_analysis_port#(ahb_xtn)monitor_port;
function new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",m_cfg))
			`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
endfunction

function void connect_phase(uvm_phase phase);
	vif=m_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
	while(vif.ahb_mon_cb.hready_out)
	@(vif.ahb_mon_cb);
	//repeat(2)
	forever
	begin
//	$display("-------------------------k");
	
		collect_data();
//	$display("-------------------------k1");

	end
endtask

task collect_data();
	ahb_xtn data_sent;
data_sent=ahb_xtn::type_id::create("data_sent");
//$display("-------------------------k2");
	

//while(((vif.ahb_mon_cb.htrans==2'b10) || (vif.ahb_mon_cb.htrans==2'b11))&& (vif.ahb_mon_cb.hready_out!==1'b1))
while(vif.ahb_mon_cb.htrans!==2'b10 && vif.ahb_mon_cb.htrans!==2'b11  && vif.ahb_mon_cb.htrans!==2'b00)

	

		@(vif.ahb_mon_cb);
data_sent.htrans=vif.ahb_mon_cb.htrans;
data_sent.hsize=vif.ahb_mon_cb.hsize;
data_sent.haddr=vif.ahb_mon_cb.haddr;
data_sent.hwrite=vif.ahb_mon_cb.hwrite;

//$display("-------------------------h");

@(vif.ahb_mon_cb);
//while(((vif.ahb_mon_cb.htrans==2'b10) || (vif.ahb_mon_cb.htrans==2'b11))&& (vif.ahb_mon_cb.hready_out!==1'b1))

//	@(vif.ahb_mon_cb);
//@(vif.ahb_mon_cb);
while(vif.ahb_mon_cb.hready_out!==1'b1)
	@(vif.ahb_mon_cb);

if(vif.ahb_mon_cb.hwrite==1'b1)
	data_sent.hwdata=vif.ahb_mon_cb.hwdata;
else
	data_sent.hrdata=vif.ahb_mon_cb.hrdata;

monitor_port.write(data_sent);
`uvm_info("AHB_MONITOR",$sformatf("printinf from driver \n %s",data_sent.sprint()),UVM_LOW)

endtask

endclass
