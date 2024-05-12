class apb_agt extends uvm_agent;
	
	`uvm_component_utils(apb_agt)
//virtual interface
apb_mon monh;
apb_drv drvh;
apb_seqr seqrh;

apb_config m_cfg;
function new(string name="apb_agt",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(apb_config)::get(this,"","apb_config",m_cfg))

	`uvm_fatal("UVM_CONFIG","THIS CANNOT BE CONFIG")
monh=apb_mon::type_id::create("monh",this);
if(m_cfg.is_active==UVM_ACTIVE)
drvh=apb_drv::type_id::create("drvh",this);
seqrh=apb_seqr::type_id::create("seqrh",this);
endfunction

function void connect_phase(uvm_phase phase);
if(m_cfg.is_active==UVM_ACTIVE)
begin
drvh.seq_item_port.connect(seqrh.seq_item_export);
end
endfunction

endclass
