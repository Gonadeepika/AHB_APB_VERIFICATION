class ahb_seq extends uvm_sequence #(ahb_xtn);
	
	`uvm_object_utils(ahb_seq)
//virtual interface

	logic [31:0]Haddr;
	logic Hwrite;
	logic [2:0]Hsize;
	logic [2:0]Hburst;
function new(string name="ahb_seq");
	super.new(name);
endfunction
endclass

class single_tf extends ahb_seq;

	`uvm_object_utils(single_tf)


function new(string name="single_tf");
	super.new(name);
endfunction

task body();
	repeat(15)
	begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10 ; hburst==3'b000;hwrite==1'b1;});
	finish_item(req);
	end	

	/*Haddr=req.haddr;
	Hsize=req.hsize;
	Hburst=req.hwdata;
	Hsize=req.hsize;*/
endtask
endclass
//unspecified length----//
class unspecified extends ahb_seq;

	`uvm_object_utils(unspecified)

	logic [31:0]Haddr;
	logic Hwrite;
	logic [2:0]Hsize;
	logic [2:0]Hburst;

function new(string name="unspecified");
	super.new(name);
endfunction

task body();
	//for(int=0;i<3;i++)
	begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10; hburst==3'b001;hwrite==1'b0;});
	finish_item(req);
	end	

	Haddr=req.haddr;
	Hsize=req.hsize;
	Hwrite=req.hwrite;
	Hsize=req.hsize;

	for(int i=0;i<req.length;i++)
	begin
	start_item(req);
		assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite;hsize==Hsize;haddr==Haddr+(3'b001<<Hsize);});
	finish_item(req);
	Haddr=req.haddr;
	end
	start_item(req);
		assert(req.randomize() with {htrans==2'b00;});
	finish_item(req);

endtask 
//$display("---------unspecified---------");
endclass
	

class inc_4 extends ahb_seq;

	`uvm_object_utils(inc_4)

	logic [31:0]Haddr;
	logic Hwrite;
	logic [2:0]Hsize;
	logic [2:0]Hburst;

function new(string name="inc_4");
	super.new(name);
endfunction

task body();
//	repeat(10)
	begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10 ; hburst==3'b011 ; hwrite==1'b0;});
	finish_item(req);
	
	Haddr=req.haddr;
	Hsize=req.hsize;
	Hburst=req.hburst;
	Hwrite=req.hwrite;

if(Hburst==3'b011)
begin
	for(int i=0;i<3;i++)
	begin
		start_item(req);
			if(Hsize==0)
			assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+1'b1;});
			if(Hsize==1)
			assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+2'b10;});
			if(Hsize==2)
			assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+3'b100;});

		finish_item(req);
		Haddr=req.haddr;
		
	end
	start_item(req);
		assert(req.randomize() with {htrans==2'b00;});
	finish_item(req);
end
end
endtask
endclass


class inc_8 extends ahb_seq;

	`uvm_object_utils(inc_8)

	logic [31:0]Haddr;
	logic Hwrite;
	logic [2:0]Hsize;
	logic [2:0]Hburst;

function new(string name="inc_8");
	super.new(name);
endfunction

task body();
	repeat(10)
	begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10 ;hburst==3'b101 ; hwrite==1'b0;});
	finish_item(req);
	end
	Haddr=req.haddr;
//	Htrans=req.htrans;
	Hburst=req.hburst;
	Hsize=req.hsize;
	Hwrite=req.hwrite;

	if(Hburst==3'b101)
	begin
	for(int i=0;i<7;i++)
	begin
	start_item(req);
	assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+1'b1;});
        if(Hsize==1)
	assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+2'b10;});
	if(Hsize==2)
	assert(req.randomize() with {htrans==2'b11; hwrite==Hwrite; hsize==Hsize; haddr==Haddr+3'b100;});
	finish_item(req);
	Haddr=req.haddr;
	end
	start_item(req);
	assert(req.randomize() with {htrans==2'b00;});
	finish_item(req);
	end
endtask
endclass

/*
class inc_16 extends ahb_seq;

	`uvm_object_utils(inc_16)

	logic [31:0]haddr1;
	logic hwrite1;
	logic [2:0]hsize1;
	logic [2:0]hburst1;

function new(string name="inc_16");
	super.new(name);
endfunction

task body();

	begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10 && hburst==3'b110 && hwdata inside {[0:32'h0000_ffff]};});
	finish_item(req);
	end
	haddr=req.haddr;
	htrans=req.htrans;
	hburst=req.hwdata;
	hsize=req.hsize;

	for(int i=0;i<3;i++)
	begin
	start_item(req);
	assert(req.randomize() with {htrans==2'b11; hwrite==hwrite;  hsize==hsize; haddr==haddr+(3'b001<<hsize);});
	finish_item(req);
	end
	start_item(req);
	assert(req.randomize() with {htrans==2'b00;});
	finish_item(req);
endtask
endclass
*/
 class wrap_4 extends ahb_seq;

	`uvm_object_utils(wrap_4)
	
	logic [31:0]Haddr;
	logic Hwrite;
	logic [2:0]Hsize;
	logic [2:0]Hburst;

function new(string name="wrap_4");
	super.new(name);
endfunction

task body();
	repeat(10)
	begin 
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {htrans==2'b10 ; hburst==3'b010;hwrite==1'b0;})
	finish_item(req);
	end
	Haddr=req.haddr;
	Hsize=req.hsize;
	Hburst=req.hburst;
	//Hsize=req.hsize;
	Hwrite=req.hwrite;
	if(Hburst==3'b010)
	for(int i=0;i<3;i++)
	begin
		start_item(req);
		if(Hsize==0)
		begin
		assert(req.randomize() with {htrans==2'b11;hwrite==Hwrite;hsize==Hsize;haddr==Haddr+1'b1;});

		end
		if(Hsize==1)
		begin
		assert(req.randomize() with {htrans==2'b11;hwrite==Hwrite;hsize==Hsize;haddr==Haddr+2'b10;});
		end

		if(Hsize==2)
		begin
		assert(req.randomize() with {htrans==2'b11;hwrite==Hwrite;hsize==Hsize;haddr==Haddr+3'b100;});
		end
		finish_item(req);
		Haddr=req.haddr;
	end
	start_item(req);
	assert(req.randomize() with {htrans==2'b00;});
	finish_item(req);
endtask
endclass




