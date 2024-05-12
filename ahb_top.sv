class ahb_top extends uvm_env;
	
	`uvm_component_utils(ahb_top)
	
	ahb_agt agnth[];
	ahb_config  ahb_cfg_h[];
	env_config m_cfg;

function new(string name="ahb_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
//uvm_config_db #(r_env_config)::get(this,"")
	//$display("--------source");
if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	if(m_cfg.has_ahb)
begin
	ahb_cfg_h=new[m_cfg.ahb_agts];
	agnth=new[m_cfg.ahb_agts];


foreach(agnth[i])
begin

//ahb_cfg_h[i]=m_config.ahb_cfg_h[i];

agnth[i]=ahb_agt::type_id::create($sformatf("agnth[%0d]*",i),this);


//uvm_config_db #(ahb_config)::set(this,$sformatf("agnth[%0d]*",i),"ahb_config", m_cfg.ahb_cfg_h[i]);

//sagnth[i]=r_source_agent::type_id::create($sformatf("sagnth[%0d]*",i),this);
end
end
endfunction

task run_phase(uvm_phase phase);
	uvm_top.print_topology();
endtask

endclass

