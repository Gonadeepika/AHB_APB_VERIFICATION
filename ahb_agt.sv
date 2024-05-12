class ahb_agt extends uvm_agent;
	
	`uvm_component_utils(ahb_agt)
//virtual interface
ahb_mon monh;
ahb_drv drvh;
ahb_seqr seqrh;

ahb_config m_cfg;
function new(string name="ahb_agt",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",m_cfg))

	`uvm_fatal("UVM_CONFIG","THIS CANNOT BE CONFIG")
monh=ahb_mon::type_id::create("monh",this);
if(m_cfg.is_active==UVM_ACTIVE)
drvh=ahb_drv::type_id::create("drvh",this);
seqrh=ahb_seqr::type_id::create("seqrh",this);
endfunction

function void connect_phase(uvm_phase phase);
if(m_cfg.is_active==UVM_ACTIVE)
begin
drvh.seq_item_port.connect(seqrh.seq_item_export);
end
endfunction
endclass
