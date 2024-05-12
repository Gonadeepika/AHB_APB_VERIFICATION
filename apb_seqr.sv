class apb_seqr extends uvm_sequencer #(apb_xtn);
	
	`uvm_component_utils(apb_seqr)
//virtual interface
function new(string name="apb_seqr",uvm_component parent);
	super.new(name,parent);
endfunction

endclass
