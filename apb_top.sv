class apb_top extends uvm_env;
	
	`uvm_component_utils(apb_top)
	
	apb_agt pagnth[];
	apb_config  apb_cfg_h[];
	env_config m_config;

function new(string name="apb_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
//uvm_config_db #(r_env_config)::get(this,"")
	$display("--------source");
if(!uvm_config_db #(env_config)::get(this,"","env_config",m_config))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	if(m_config.has_apb)
begin
	apb_cfg_h=new[m_config.apb_agts];
	pagnth=new[m_config.apb_agts];


foreach(pagnth[i])
begin

//apb_cfg_h[i]=m_config.apb_cfg_h[i];

pagnth[i]=apb_agt::type_id::create($sformatf("pagnth[%0d]*",i),this);


//uvm_config_db #(apb_config)::set(this,$sformatf("pagnth[%0d]*",i),"apb_config", m_config.apb_cfg_h[i]);

//sagnth[i]=r_source_agent::type_id::create($sformatf("sagnth[%0d]*",i),this);
end
end
endfunction
/*
task run_phase(uvm_phase phase);
	uvm_top.print_topology();
endtask
*/

endclass
