class tb extends uvm_env;

        
             	`uvm_component_utils(tb)

		ahb_top ahb_top_h[];
		apb_top apb_top_h[];	
	
		virtual_seqr vseqrh;
		scoreboard sb;

                env_config m_cfg;
//-----------------  constructor new met/ Define Constructor new() function
	function new(string name = "tb", uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build phase method  -------------------//

 function void build_phase(uvm_phase phase);
		  if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
               if(m_cfg.has_ahb) begin
		 ahb_top_h= new[m_cfg.ahb_agts];
		foreach(ahb_top_h[i])begin
	              uvm_config_db #(ahb_config)::set(this,$sformatf("ahb_top_h[%0d]*",i),"ahb_config", m_cfg.ahb_cfg_h[i]);
		          ahb_top_h[i]=ahb_top::type_id::create($sformatf("ahb_top_h[%0d]*",i),this);
                 end 
                end
                if(m_cfg.has_apb == 1) begin
                 	apb_top_h=new[m_cfg.apb_agts];
                 foreach(apb_top_h[i]) begin
               uvm_config_db #(apb_config)::set(this,$sformatf("apb_top_h[%0d]*",i),"apb_config", m_cfg.apb_cfg_h[i]);

		          apb_top_h[i]=apb_top::type_id::create($sformatf("apb_top_h[%0d]*",i),this);
	        
               end
                end

        	super.build_phase(phase);
               if(m_cfg.has_virtual_seqr)
		       vseqrh=virtual_seqr::type_id::create("vseqrh",this);
               if(m_cfg.has_scoreboard) begin
	//	foreach(sb[i])
                sb=scoreboard::type_id::create("sb",this);

               end
		endfunction

//-----------------  connect phase method  -------------------//
   		function void connect_phase(uvm_phase phase);
                      if(m_cfg.has_virtual_seqr) begin
                        if(m_cfg.has_ahb)
				foreach(apb_top_h[i]) 
					begin 
							vseqrh.ahb_seqrh[i] = ahb_top_h[i].agnth[i].seqrh;                    
					end

                        if(m_cfg.has_apb)
				begin
                           	foreach(apb_top_h[i]) 
						vseqrh.apb_seqrh[i] = apb_top_h[i].pagnth[i].seqrh;
				end

                      end
	

   		     if(m_cfg.has_scoreboard) begin
    		
		foreach(ahb_top_h[i])
     				ahb_top_h[i].agnth[i].monh.monitor_port.connect(sb.ahb_fifo.analysis_export);
   			foreach(apb_top_h[i])
      				apb_top_h[i].pagnth[i].monh.monitor_port1.connect(sb.apb_fifo.analysis_export);



					      end

			endfunction

endclass
