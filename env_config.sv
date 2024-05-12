class env_config extends uvm_object;
	`uvm_object_utils(env_config)

//int  has_scoreboard sb;
 ahb_config ahb_cfg_h[];
apb_config apb_cfg_h[];
bit has_functional_coverage=0;

bit has_virtual_seqr=1;

bit has_ahb=1;
bit has_apb=1;

int ahb_agts= 1;
int apb_agts=1;

bit has_scoreboard=1;

function new(string name="s_env_config");
	super.new(name);
endfunction
endclass
