class apb_drv extends uvm_driver#(apb_xtn);
	
	`uvm_component_utils(apb_drv)
//virtual interface
virtual apb_if.APB_DRV_MP vif;
apb_config m_cfg;
//apb_xtn xtn1;
function new(string name="apb_drv",uvm_component parent);
	super.new(name,parent);
	//monitor_port=new("monitor_port",this);
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

task run_phase(uvm_phase phase); 
	//repeat
		forever
			begin
			$display("this is running");
			//seq_item_port.get_next_item(req);
			send_to_dut();
			//seq_item_port.item_done();
			end
		
endtask

task send_to_dut();

	//`uvm_info("APB DRIVER",$sformatf("printinf from driver \n %s",xtn.sprint()),UVM_LOW)

while(vif.apb_drv_cb.pselx===0)
@(vif.apb_drv_cb);	

 //&& vif.apb_drv_cb.penable==1'b1 )
if(vif.apb_drv_cb.pwrite==1'b0)
	vif.apb_drv_cb.prdata<={$random};
else
	vif.apb_drv_cb.prdata<='bz;
//$display("%0p",vif);
repeat(2)
@(vif.apb_drv_cb);
//`uvm_info("APB DRIVER",$sformatf("printinf from driver \n %s",xtn.sprint()),UVM_LOW)
//@(vif.apb_drv_cb);

m_cfg.drv_data_sent_cnt++;
endtask
function void report_phase(uvm_phase phase);
	//`uvm_info(get_type_name(),$sformatf("Report:apb driver sent %0d transcations",m_cfg.drv_data_sent_cnt),UVM_LOW)
endfunction

//*/  
endclass
