class apb_config extends uvm_object;

`uvm_object_utils(apb_config)
virtual apb_if vif;
uvm_active_passive_enum is_active=UVM_ACTIVE;

static int drv_data_sent_cnt=0;
static int mon_data_sent_cnt=0;

function new(string name="apb_config");
	super.new(name);
endfunction
endclass

