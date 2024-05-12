	class vtest extends uvm_test;

   	`uvm_component_utils(vtest)

  
            	 tb envh;
         env_config m_tb_cfg;
        ahb_config ahb_cfg_h[] ;
	apb_config  apb_cfg_h[];


         int ahb_agts= 1;
	 int apb_agts=1;
         int has_ahb = 1;
         int has_apb = 1;
//-----------------  constructor new method  -------------------//
   	function new(string name = "vtest" , uvm_component parent);
		super.new(name,parent);
	endfunction
//----------------- function bridge()  -------------------//

function void bridge();
 	   if (has_ahb) begin
		    ahb_cfg_h= new[ahb_agts];
	
	        foreach(ahb_cfg_h[i]) begin
      		    ahb_cfg_h[i]=ahb_config::type_id::create($sformatf("ahb_cfg_h[%0d]", i));
         		 if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg_h[i].vif))
		`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
                ahb_cfg_h[i].is_active = UVM_ACTIVE;
	        m_tb_cfg.ahb_cfg_h[i] =ahb_cfg_h[i];
                
                end
             end
	             if (has_apb) begin
                          apb_cfg_h = new[apb_agts];


		foreach(apb_cfg_h[i]) begin
	                apb_cfg_h[i]=apb_config::type_id::create($sformatf("apb_cfg_h[%0d]",i));
		
                 if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_if",apb_cfg_h[i].vif))
			`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
                apb_cfg_h[i].is_active = UVM_ACTIVE;
                m_tb_cfg.apb_cfg_h[i] = apb_cfg_h[i];
                

                
                end
             end
                m_tb_cfg.ahb_agts = ahb_agts;
		m_tb_cfg.apb_agts = apb_agts;
                m_tb_cfg.has_ahb = has_ahb;
                m_tb_cfg.has_apb = has_apb;
            endfunction 


//-----------------  build() phase method  -------------------//

	function void build_phase(uvm_phase phase);
                super.build_phase(phase);
	        m_tb_cfg=env_config::type_id::create("m_tb_cfg");
                if(has_ahb)
	                m_tb_cfg.ahb_cfg_h = new[ahb_agts];
                if(has_apb)
	               m_tb_cfg.apb_cfg_h = new[apb_agts];
		bridge();
	 	uvm_config_db #(env_config)::set(this,"*","env_config",m_tb_cfg);
		envh=tb::type_id::create("envh",this);
	endfunction
endclass


class single_test extends vtest;

	`uvm_component_utils(single_test)
	
	single_tf s_tf;
function new(string name="single_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase) ;
	phase.raise_objection(this);
	s_tf=single_tf::type_id::create("s_tf");
	s_tf.start(envh.ahb_top_h[0].agnth[0].seqrh);
#30;
	phase.drop_objection(this);
endtask
endclass

class unspecified_test extends vtest;
	
	`uvm_component_utils(unspecified_test)

	unspecified unspec_h;
function new(string name="unspecified_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase);
	
	begin
	phase.raise_objection(this);
	unspec_h=unspecified::type_id::create("unspec_h");
	unspec_h.start(envh.ahb_top_h[0].agnth[0].seqrh);
#30
	phase.drop_objection(this);
	end
endtask

endclass

class inc4_test extends vtest;

	`uvm_component_utils(inc4_test)
	inc_4   inc4h;
function new(string name="inc4_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase);

	begin
	phase.raise_objection(this);
	inc4h=inc_4::type_id::create("inc4h");
	inc4h.start(envh.ahb_top_h[0].agnth[0].seqrh);
#100;
	phase.drop_objection(this);
	end
endtask
endclass

class inc8_test extends vtest;

	`uvm_component_utils(inc8_test)
	inc_8   inc8h;
function new(string name="inc8_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase);

	begin
	phase.raise_objection(this);
	inc8h=inc_8::type_id::create("inc8h");
	inc8h.start(envh.ahb_top_h[0].agnth[0].seqrh);
	phase.drop_objection(this);
	end
endtask
endclass

class wrap4_test extends vtest;
	
	`uvm_component_utils(wrap4_test)

	wrap_4 wrap_4h;

function new(string name="wrap4_test",uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase);
	
	begin
	phase.raise_objection(this);
	wrap_4h=wrap_4::type_id::create("wrap_4h");
	wrap_4h.start(envh.ahb_top_h[0].agnth[0].seqrh);
	phase.drop_objection(this);
	end
endtask
endclass
