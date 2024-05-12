
class scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(scoreboard )

uvm_tlm_analysis_fifo#(ahb_xtn)ahb_fifo;
uvm_tlm_analysis_fifo#(apb_xtn)apb_fifo;

env_config m_cfg;

ahb_xtn ahbh;
apb_xtn apbh;
///*
covergroup cov1;
option.per_instance=1;

	SIZE : coverpoint ahbh.hsize[2:0]{
				bins hsize={0,1,2};}
	WRITE : coverpoint ahbh.hwrite;
	TRANS : coverpoint ahbh.htrans{
			bins htrans={2,3};}
	ADDR : coverpoint ahbh.haddr[31:0]{
			bins low={[32'h8000_0000:32'h8000_03ff]};
			bins mid1={[32'h8400_0000:32'h8400_03ff]};
			bins mid2={[32'h8800_0000:32'h8800_03ff]};
			bins high={[32'h8c00_0000:32'h8c00_03ff]};}
	WDATA : coverpoint ahbh.hwdata[31:0]{
		bins low={[32'h0000_0000:32'hffff_ffff]};}
	RDATA : coverpoint ahbh.hrdata[31:0]{
		bins low={[32'h0000_0000:32'hffff_ffff]};}
	SIZEXWRITE: cross SIZE,WRITE;
	ADDRXWDATAXRDATA :cross ADDR,WDATA,RDATA;
endgroup
covergroup cov2;
option.per_instance=1;

	WRITE : coverpoint apbh.pwrite;
	SEL : coverpoint apbh.pselx{
		bins pselx={4'b0001,4'b0010,4'b0100,4'b1000};}
	ADDR : coverpoint apbh.paddr[31:0]{
			bins low={[32'h8000_0000:32'h8000_03ff]};
			bins mid1={[32'h8400_0000:32'h8400_03ff]};
			bins mid2={[32'h8800_0000:32'h8800_03ff]};
			bins high={[32'h8c00_0000:32'h8c00_03ff]};}
	WDATA : coverpoint apbh.pwdata[31:0]{
		bins low={[32'h0000_0000:32'hffff_ffff]};}
	RDATA : coverpoint apbh.prdata[31:0]{
		bins low={[32'h0000_0000:32'hffff_ffff]};}
	WRITEXSEL: cross WRITE,SEL;
	ADDRXWDATAXRDATA :cross ADDR,WDATA,RDATA;
endgroup
//*/
function new(string name= "scoreboard ",uvm_component parent);
	super.new(name,parent);
	ahb_fifo=new("ahb_fifo",this);
	apb_fifo=new("apb_fifo",this);
	cov1=new;
	cov2=new;
endfunction
/*
function void build_phase(uvm_phase phase);
super.build_phase(phase);
	if(!uvm_config_db#(env_config)::get(this,"*","env_config",m_cfg))
		`uvm_fatal("UVM_CONFIG","sb cant get the config")
	//
	
endfunction


task run_phase(uvm_phase phase);
	fork
		forever
		begin
			$display("----------------scoreboard ahb");
		`uvm_info(get_type_name(),"getting ahb data",UVM_LOW)
			ahb_fifo.get(ahbh);
			ahbh.print;
		//	cov1.sample();
		end
	
	
		begin
			`uvm_info(get_type_name(),"getting apb data",UVM_LOW)

			apb_fifo.get(apbh);
			apbh.print;
		$display("--------------");
			check_data(ahbh,apbh);
		//	cov2.sample();
		end
	join
endtask
*/

task run_phase (uvm_phase phase);
	forever
	begin
		ahb_fifo.get(ahbh);
		cov1.sample();
		apb_fifo.get(apbh);
		check_data(ahbh,apbh);
		cov2.sample();
	end
endtask

function void check_data(ahb_xtn ahbh,apb_xtn apbh);
	begin
//$display("-------------check data-");

//	`uvm_info(get_type_name(),"getting check data",UVM_LOW)

	if(ahbh.hwrite)
		begin
		
			if(ahbh.hsize==2'b00)
				begin
					if(ahbh.haddr[1:0]==2'b00) 
							begin
							if(ahbh.hwdata[7:0]==apbh.pwdata[7:0])
								`uvm_info(get_type_name(),"2'b00 is successfull",UVM_LOW)
							else
								`uvm_info(get_type_name(),"2'b00 is not successfull",UVM_LOW)
							end

					if(ahbh.haddr[1:0]==2'b01) 
						begin
						if(ahbh.hwdata[15:8]==apbh.pwdata[7:0])
							`uvm_info(get_type_name(),"2'b01 is successfull",UVM_LOW)
							else
							`uvm_info(get_type_name(),"2'b01 is not successfull",UVM_LOW)
						end
					if(ahbh.haddr[1:0]==2'b10)
						begin
						if(ahbh.hwdata[23:16]==apbh.pwdata[7:0])
								`uvm_info(get_type_name(),"2'b10 is successfull",UVM_LOW)
							else
								`uvm_info(get_type_name(),"2'b10 is not successfull",UVM_LOW)

						end

					if(ahbh.haddr[1:0]==2'b11)
						begin
						if(ahbh.hwdata[31:24]==apbh.pwdata[7:0])
							`uvm_info(get_type_name(),"2'b11 is successfull",UVM_LOW)
							else
							`uvm_info(get_type_name(),"2'b11 is not successfull",UVM_LOW)
						end
				end
			else if(ahbh.hsize==2'b01)
				begin
					if(ahbh.haddr[1:0]==2'b00)
						begin
						if(ahbh.hwdata[15:0]==apbh.pwdata[7:0])
							`uvm_info(get_type_name()," size 2'b01 ,[2'b11] is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"size 2'b01,[2'b11] is not successfull",UVM_LOW)
						end
					if(ahbh.haddr[1:0]==2'b10)
						begin
						if(ahbh.hwdata[31:16]==apbh.pwdata[7:0])
							`uvm_info(get_type_name()," size 2'b01 ,[2'b01] is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"size 2'b01,[2'b01] is not successfull",UVM_LOW)
						end
				end
			else
				begin
				if(ahbh.hwdata[31:0]==apbh.pwdata[7:0])
							`uvm_info(get_type_name()," size 2'b10 ,[2'b00] is successfull",UVM_LOW)
				else
							`uvm_info(get_type_name(),"size 2'b10,[2'b00] is not successfull",UVM_LOW)
				end
	end















/////////////////////////////////////////////////////////second fifo///////////////////////////////////////
		
	else
			begin
		
			if(ahbh.hsize==2'b00)
				begin
					if(ahbh.haddr[1:0]==2'b00)
							begin
							if(apbh.prdata[7:0]==ahbh.hrdata[7:0])
								`uvm_info(get_type_name(),"2'b00 is successfull",UVM_LOW)
							else
								`uvm_info(get_type_name(),"2'b00 is not successfull",UVM_LOW)

							end
					if(ahbh.haddr[1:0]==2'b01)
						begin
						if(apbh.prdata[15:8]==ahbh.hrdata[7:0])
							`uvm_info(get_type_name(),"2'b01 is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"2'b01 is not successfull",UVM_LOW)
						end
					if(ahbh.haddr[1:0]==2'b10)
						begin
						if(apbh.prdata[23:16]==ahbh.hrdata[7:0])
								`uvm_info(get_type_name(),"2'b10 is successfull",UVM_LOW)
						else
								`uvm_info(get_type_name(),"2'b10 is not successfull",UVM_LOW)
						end
					

					if(ahbh.haddr[1:0]==2'b11)
						begin
						if(apbh.prdata[31:24]==ahbh.hrdata[7:0])
							`uvm_info(get_type_name(),"2'b11 is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"2'b11 is not successfull",UVM_LOW)
						end
				end
			else if(ahbh.hsize==2'b01)
				begin
					if(ahbh.haddr[1:0]==2'b00)
						begin
						if(apbh.prdata[15:0]==ahbh.hrdata[7:0])
							`uvm_info(get_type_name()," size 2'b01 ,[2'b11] is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"size 2'b01,[2'b11] is not successfull",UVM_LOW)
						end
					if(ahbh.haddr[1:0]==2'b10)
						begin
						if(apbh.prdata[31:16]==ahbh.hrdata[7:0])
							`uvm_info(get_type_name()," size 2'b01 ,[2'b01] is successfull",UVM_LOW)
						else
							`uvm_info(get_type_name(),"size 2'b01,[2'b01] is not successfull",UVM_LOW)
						end

				end
			else
				begin
				if(apbh.prdata[31:0]==ahbh.hrdata[7:0])
							`uvm_info(get_type_name()," size 2'b10 ,[2'b00] is successfull",UVM_LOW)
				else
							`uvm_info(get_type_name(),"size 2'b10,[2'b00] is not successfull",UVM_LOW)
				end

	end
end				
		
endfunction


endclass



