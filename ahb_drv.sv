class ahb_drv extends uvm_driver#(ahb_xtn);
	
	`uvm_component_utils(ahb_drv)
virtual ahb_if.AHB_DRV_MP vif;
ahb_config m_cfg;
function new(string name="ahb_drv",uvm_component parent);
	super.new(name,parent);
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
@(vif.ahb_drv_cb);
vif.ahb_drv_cb.hresetn<=1'b0;
repeat(3)
@(vif.ahb_drv_cb);
vif.ahb_drv_cb.hresetn<=1'b1;
//while(vif.ahb_drv_cb.hready_out!==1'b1)
//	@(vif.ahb_drv_cb)

	forever
	begin
	seq_item_port.get_next_item(req);
	send_to_dut(req);
	seq_item_port.item_done();
	end
endtask

task send_to_dut(ahb_xtn xtn);

	`uvm_info("AHB_DRIVER",$sformatf("printinf from driver \n %s",xtn.sprint()),UVM_LOW)
	while(vif.ahb_drv_cb.hready_out!==1'b1)
	@(vif.ahb_drv_cb);
	vif.ahb_drv_cb.haddr<=xtn.haddr;
	vif.ahb_drv_cb.hsize<=xtn.hsize;
//	vif.ahb_drv_cb.hburst<=xtn.hburst;
	vif.ahb_drv_cb.htrans<=xtn.htrans;
	vif.ahb_drv_cb.hwrite<=xtn.hwrite;
	vif.ahb_drv_cb.hready_in<=1'b1;
	@(vif.ahb_drv_cb);
	//while(!vif.ahb_drv_cb.hready_out)
	//	@(vif.ahb_drv_cb)
	//vif.ahb_drv_cb,hwdata<=hwdata;
while(vif.ahb_drv_cb.hready_out!==1'b1)
	@(vif.ahb_drv_cb);

//if(xtn.hwrite)
	vif.ahb_drv_cb.hwdata<=xtn.hwdata;
	m_cfg.drv_data_sent_cnt++;
endtask
function void report_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("Report:ahb driver sent %0d transcations",m_cfg.drv_data_sent_cnt),UVM_LOW)
endfunction

endclass
