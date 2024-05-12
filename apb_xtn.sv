class apb_xtn extends uvm_sequence_item;
`uvm_object_utils(apb_xtn)
//logics
///*
	 logic[31:0] paddr;
	rand bit penable;
	rand bit pwrite;
	logic [31:0]pwdata;
	logic [31:0]prdata;
	logic pselx;

//*/

function new(string name="apb_xtn");
	super.new(name);
endfunction
///*
function void do_print(uvm_printer printer );
super.do_print(printer);
printer.print_field("paddr",	this.paddr,	32,	UVM_HEX);

printer.print_field("penable",	this.penable,	64,	UVM_DEC);

printer.print_field("pwrite",	this.pwrite,	64,	UVM_DEC);

printer.print_field("pwdata",	this.pwdata,	32,	UVM_DEC);

printer.print_field("prdata",	this.prdata,	32,	UVM_DEC);

printer.print_field("pselx",	this.pselx,	4,	UVM_DEC);
endfunction
//*/
endclass
