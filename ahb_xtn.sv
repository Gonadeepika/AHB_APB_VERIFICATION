class ahb_xtn extends uvm_sequence_item;
`uvm_object_utils(ahb_xtn)
//logics
rand bit hresetn;
rand bit[1:0]htrans;
rand bit hwrite;
rand bit hready_in;
rand bit hready_out;
rand bit [2:0]hburst;
rand bit[31:0]hwdata;
rand bit[31:0]hrdata;
rand bit[1:0]hresp;
rand bit[2:0]hsize;
rand bit[31:0]haddr;
rand bit [7:0]length;

constraint a1{haddr inside{[32'h8000_0000:32'h8000_03ff],
				[32'h8400_0000:32'h8400_03ff],
				[32'h8800_0000:32'h8800_03ff],
				[32'h8c00_0000:32'h8c00_03f]};}

constraint a2{((haddr%1024)+length*(1<<hsize))<=1024;}
constraint a3{hsize inside {[0:2]};}
constraint a4{if(hsize==1)
			haddr%2==0;
		if(hsize==2)
			haddr%4==0;}

function new(string name="ahb_xtn");
	super.new(name);
endfunction

function void do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field("htrans",	this.htrans,	2,	UVM_DEC);

printer.print_field("hwrite",	this.hwrite,	1,	UVM_DEC);

printer.print_field("hready_in",	this.hready_in,	64,	UVM_DEC);

printer.print_field("hburst",	this.hburst,	3,	UVM_DEC);

printer.print_field("hwdata",	this.hwdata,	32,	UVM_DEC);

printer.print_field("hrdata",	this.hrdata,	32,	UVM_DEC);

printer.print_field("hresp",	this.hresp,	2,	UVM_DEC);

printer.print_field("hsize",	this.hsize,	3,	UVM_DEC);

printer.print_field("haddr",	this.haddr,	32,	UVM_HEX);

endfunction
endclass



