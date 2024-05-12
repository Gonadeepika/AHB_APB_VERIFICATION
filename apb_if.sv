interface apb_if(input bit clock);

	logic[31:0] paddr;
	logic penable;
	logic pwrite;
	logic [31:0]pwdata;
	logic [31:0]prdata;
	logic [3:0]pselx;
	
clocking apb_drv_cb @(posedge clock);
default input #1 output #1;
input penable;
input pwrite;
input pwdata;
input paddr;
input pselx;
output prdata;
endclocking

clocking apb_mon_cb @(posedge clock);
default input #1 output #1;
input penable;
input pwrite;
input pwdata;
input paddr;
input pselx;
input prdata;
endclocking

modport APB_DRV_MP(clocking apb_drv_cb);
modport APB_MON_MP(clocking apb_mon_cb);

endinterface

