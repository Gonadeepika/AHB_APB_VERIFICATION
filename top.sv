 module top;

`include "uvm_macros.svh"
	import pkg::*;

	import uvm_pkg::*;
	bit clock;
	always
	#10 	clock=~clock;

	ahb_if in0(clock);
	apb_if in1(clock);
//	apb_if in2(clock);
//	apb_if in3(clock);


	rtl_top DUT(.Hclk(in0.clock),.Hresetn(in0.hresetn),.Htrans(in0.htrans),.Hwrite(in0.hwrite),.Hsize(in0.hsize),.Hreadyin(in0.hready_in),.Hwdata(in0.hwdata),.Hresp(in0.hresp),.Hreadyout(in0.hready_out),.Hrdata(in0.hrdata),.Haddr(in0.haddr),.Penable(in1.penable),.Pwrite(in1.pwrite),.Prdata(in1.prdata),.Paddr(in1.paddr),.Pselx(in1.pselx),.Pwdata(in1.pwdata));


	initial
		begin

			`ifdef VCS
			$fsdbDumpvars(0,top);
			`endif
			uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_if",in0);
			uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",in1);
		//	uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",in2);
		//	uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",in3);

			
			run_test();
		end
endmodule
