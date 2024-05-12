interface ahb_if(input bit clock);

logic hresetn;
logic [1:0]htrans;
logic hwrite;
logic hready_in;
logic hready_out;
//logic [2:0]hburst;
logic [31:0]hwdata;
logic [31:0]hrdata;
logic [1:0]hresp;
logic [2:0]hsize;
logic [31:0]haddr;

clocking ahb_drv_cb @(posedge clock);
default input #1 output #1;
output hresetn;
output htrans;
output hwrite;
output hready_in;
//input hburst;
output hwdata;
input hrdata;
input hresp;
output hsize;
output haddr;
input hready_out;
endclocking

clocking ahb_mon_cb @(posedge clock);
default input #1 output #1;
input hresetn;
input htrans;
input hwrite;
input hready_in;
//input hburst;
input hwdata;
input hrdata;
input hresp;
input hsize;
input haddr;
input hready_out;
endclocking



modport AHB_DRV_MP(clocking ahb_drv_cb);
modport AHB_MON_MP(clocking ahb_mon_cb);

endinterface


