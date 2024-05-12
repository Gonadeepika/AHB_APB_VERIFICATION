class apb_seq extends uvm_sequence #(apb_xtn);
	
	`uvm_object_utils(apb_seq)
//virtual interface
function new(string name="apb_seq");
	super.new(name);
endfunction

endclass

class test_seq extends apb_seq;

	`uvm_object_utils(test_seq)

function new(string name="test_seq");
	super.new(name);
endfunction

task body();
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
	end
endtask
endclass
		
