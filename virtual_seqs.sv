class virtual_seqs extends uvm_sequence #(uvm_sequence_item);
 
	`uvm_object_utils(virtual_seqs)

	ahb_seqr ahb_seqrh[];
//	apb_seqr apb_seqrh[];


//	single_tf    single_h;
	//single_tfp single_ph;

//	unspecified  un_sh;


//	inc_4        inc_4h;


//	wrap_4       w_h;


	virtual_seqr vsqrh;


	env_config    m_cfg;


function new(string name="virtual_seqs");
	super.new(name);
endfunction

task body();

	if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get the output did you set rigth?")
	begin
	ahb_seqrh=new[m_cfg.ahb_agts];
	//apb_seqrh=new[m_cfg.apb_agts]
	end
	assert($cast(vsqrh,m_sequencer))
	else
	begin
		`uvm_error("Body","Error in vasting sequence")
	end
	foreach(ahb_seqrh[i])
	ahb_seqrh[i]=vsqrh.ahb_seqrh[i];
//	foreach(apb_seqrh[i])
//	apb_seqrh[i]=vsqrh.aph_seqrh[i];
endtask
endclass
/*
class s_tf extends virtual_seqs;

	`uvm_object_utils(s_tf)

function new(string name="s_tf");
	super.new(name);
endfunction

task body();
	super.body();
		begin
		single_h=single_tf::type_id::create("single_tfh");
		single_ph=single_tfp::type_id::create("single_ph");
*/		

