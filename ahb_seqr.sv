class ahb_seqr extends uvm_sequencer #(ahb_xtn);
	
	`uvm_component_utils(ahb_seqr)
//virtual interface
function new(string name="ahb_seqr",uvm_component parent);
	super.new(name,parent);
endfunction

endclass
