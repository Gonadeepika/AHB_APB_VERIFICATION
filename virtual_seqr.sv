class virtual_seqr extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(virtual_seqr)

	ahb_seqr ahb_seqrh[];
	apb_seqr apb_seqrh[];

	env_config m_cfg;

function new(string name="virtual_seqr",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);

if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. have set() it ?")
		ahb_seqrh=new[m_cfg.ahb_agts];
		apb_seqrh=new[m_cfg.apb_agts];
endfunction
endclass
