set_global_assignment -name SYSTEMVERILOG_FILE $app_path/Role.sv
set_global_assignment -name SYSTEMVERILOG_FILE $app_path/SimpleDram.sv
set_global_assignment -name SYSTEMVERILOG_FILE $app_path/FPGATop.sv
set_global_assignment -name VERILOG_MACRO "RANDOMIZE_GARBAGE_ASSIGN" -remove
set_global_assignment -name VERILOG_MACRO "RANDOMIZE_INVALID_ASSIGN" -remove
set_global_assignment -name VERILOG_MACRO "RANDOMIZE_REG_INIT" -remove
set_global_assignment -name VERILOG_MACRO "RANDOMIZE_MEM_INIT" -remove