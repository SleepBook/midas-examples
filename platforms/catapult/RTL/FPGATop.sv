`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif

module RegChainDatapath(
  input         clock,
  output        io_dataIo_in_ready,
  input         io_dataIo_in_valid,
  input  [63:0] io_dataIo_in_bits,
  input         io_dataIo_out_ready,
  output        io_dataIo_out_valid,
  output [63:0] io_dataIo_out_bits,
  input  [63:0] io_dataIo_data_0,
  input         io_ctrlIo_copyCond,
  input         io_ctrlIo_readCond,
  input         io_ctrlIo_cntrNotZero,
  output        io_ctrlIo_outFire,
  output        io_ctrlIo_inValid
);
  reg [63:0] regs_0;
  reg [63:0] _RAND_0;
  wire  _T_60;
  wire  readCondAndOutFire;
  wire [63:0] _GEN_0;
  wire [63:0] _GEN_1;
  assign io_dataIo_in_ready = io_dataIo_out_ready;
  assign io_dataIo_out_valid = io_ctrlIo_cntrNotZero;
  assign io_dataIo_out_bits = regs_0;
  assign io_ctrlIo_outFire = _T_60;
  assign io_ctrlIo_inValid = io_dataIo_in_valid;
  assign _T_60 = io_dataIo_out_ready & io_dataIo_out_valid;
  assign readCondAndOutFire = io_ctrlIo_readCond & _T_60;
  assign _GEN_0 = io_ctrlIo_copyCond ? io_dataIo_data_0 : regs_0;
  assign _GEN_1 = readCondAndOutFire ? io_dataIo_in_bits : _GEN_0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{$random}};
  regs_0 = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (readCondAndOutFire) begin
      regs_0 <= io_dataIo_in_bits;
    end else begin
      if (io_ctrlIo_copyCond) begin
        regs_0 <= io_dataIo_data_0;
      end
    end
  end
endmodule
module RegChainControl(
  input   clock,
  input   reset,
  input   io_stall,
  output  io_ctrlIo_copyCond,
  output  io_ctrlIo_readCond,
  output  io_ctrlIo_cntrNotZero,
  input   io_ctrlIo_outFire,
  input   io_ctrlIo_inValid
);
  reg  copied;
  reg [31:0] _RAND_0;
  reg  counter;
  reg [31:0] _RAND_1;
  wire  _T_17;
  wire  _GEN_0;
  wire  _T_20;
  wire  _T_21;
  wire  _GEN_1;
  wire  _T_23;
  wire  _T_25;
  wire  _T_26;
  wire  _T_30;
  wire  _T_31;
  wire  _T_32;
  wire [1:0] _T_34;
  wire [1:0] _T_35;
  wire  _T_36;
  wire  _GEN_2;
  wire  _T_40;
  wire  _T_41;
  reg  _T_42;
  reg [31:0] _RAND_2;
  wire  _T_43;
  wire  _T_44;
  wire  _T_47;
  assign io_ctrlIo_copyCond = _T_43;
  assign io_ctrlIo_readCond = _T_47;
  assign io_ctrlIo_cntrNotZero = counter;
  assign _T_17 = io_stall == 1'h0;
  assign _GEN_0 = _T_17 ? 1'h0 : counter;
  assign _T_20 = _T_17 == 1'h0;
  assign _T_21 = _T_20 & io_ctrlIo_copyCond;
  assign _GEN_1 = _T_21 ? 1'h1 : _GEN_0;
  assign _T_23 = io_ctrlIo_readCond & io_ctrlIo_outFire;
  assign _T_25 = io_ctrlIo_inValid == 1'h0;
  assign _T_26 = _T_23 & _T_25;
  assign _T_30 = io_ctrlIo_copyCond == 1'h0;
  assign _T_31 = _T_20 & _T_30;
  assign _T_32 = _T_31 & _T_26;
  assign _T_34 = counter - 1'h1;
  assign _T_35 = $unsigned(_T_34);
  assign _T_36 = _T_35[0:0];
  assign _GEN_2 = _T_32 ? _T_36 : _GEN_1;
  assign _T_40 = copied == 1'h0;
  assign _T_41 = io_stall & _T_40;
  assign _T_43 = _T_41 | _T_42;
  assign _T_44 = io_stall & copied;
  assign _T_47 = _T_44 & counter;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  copied = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  counter = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  _T_42 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    copied <= io_stall;
    if (reset) begin
      counter <= 1'h0;
    end else begin
      if (_T_32) begin
        counter <= _T_36;
      end else begin
        if (_T_21) begin
          counter <= 1'h1;
        end else begin
          if (_T_17) begin
            counter <= 1'h0;
          end
        end
      end
    end
    _T_42 <= reset;
  end
endmodule
module RegChain(
  input         clock,
  input         reset,
  input         io_stall,
  output        io_dataIo_in_ready,
  input         io_dataIo_in_valid,
  input  [63:0] io_dataIo_in_bits,
  input         io_dataIo_out_ready,
  output        io_dataIo_out_valid,
  output [63:0] io_dataIo_out_bits,
  input  [63:0] io_dataIo_data_0
);
  wire  datapath_clock;
  wire  datapath_io_dataIo_in_ready;
  wire  datapath_io_dataIo_in_valid;
  wire [63:0] datapath_io_dataIo_in_bits;
  wire  datapath_io_dataIo_out_ready;
  wire  datapath_io_dataIo_out_valid;
  wire [63:0] datapath_io_dataIo_out_bits;
  wire [63:0] datapath_io_dataIo_data_0;
  wire  datapath_io_ctrlIo_copyCond;
  wire  datapath_io_ctrlIo_readCond;
  wire  datapath_io_ctrlIo_cntrNotZero;
  wire  datapath_io_ctrlIo_outFire;
  wire  datapath_io_ctrlIo_inValid;
  wire  control_clock;
  wire  control_reset;
  wire  control_io_stall;
  wire  control_io_ctrlIo_copyCond;
  wire  control_io_ctrlIo_readCond;
  wire  control_io_ctrlIo_cntrNotZero;
  wire  control_io_ctrlIo_outFire;
  wire  control_io_ctrlIo_inValid;
  RegChainDatapath datapath (
    .clock(datapath_clock),
    .io_dataIo_in_ready(datapath_io_dataIo_in_ready),
    .io_dataIo_in_valid(datapath_io_dataIo_in_valid),
    .io_dataIo_in_bits(datapath_io_dataIo_in_bits),
    .io_dataIo_out_ready(datapath_io_dataIo_out_ready),
    .io_dataIo_out_valid(datapath_io_dataIo_out_valid),
    .io_dataIo_out_bits(datapath_io_dataIo_out_bits),
    .io_dataIo_data_0(datapath_io_dataIo_data_0),
    .io_ctrlIo_copyCond(datapath_io_ctrlIo_copyCond),
    .io_ctrlIo_readCond(datapath_io_ctrlIo_readCond),
    .io_ctrlIo_cntrNotZero(datapath_io_ctrlIo_cntrNotZero),
    .io_ctrlIo_outFire(datapath_io_ctrlIo_outFire),
    .io_ctrlIo_inValid(datapath_io_ctrlIo_inValid)
  );
  RegChainControl control (
    .clock(control_clock),
    .reset(control_reset),
    .io_stall(control_io_stall),
    .io_ctrlIo_copyCond(control_io_ctrlIo_copyCond),
    .io_ctrlIo_readCond(control_io_ctrlIo_readCond),
    .io_ctrlIo_cntrNotZero(control_io_ctrlIo_cntrNotZero),
    .io_ctrlIo_outFire(control_io_ctrlIo_outFire),
    .io_ctrlIo_inValid(control_io_ctrlIo_inValid)
  );
  assign io_dataIo_in_ready = datapath_io_dataIo_in_ready;
  assign io_dataIo_out_valid = datapath_io_dataIo_out_valid;
  assign io_dataIo_out_bits = datapath_io_dataIo_out_bits;
  assign datapath_clock = clock;
  assign datapath_io_dataIo_in_valid = io_dataIo_in_valid;
  assign datapath_io_dataIo_in_bits = io_dataIo_in_bits;
  assign datapath_io_dataIo_out_ready = io_dataIo_out_ready;
  assign datapath_io_dataIo_data_0 = io_dataIo_data_0;
  assign datapath_io_ctrlIo_copyCond = control_io_ctrlIo_copyCond;
  assign datapath_io_ctrlIo_readCond = control_io_ctrlIo_readCond;
  assign datapath_io_ctrlIo_cntrNotZero = control_io_ctrlIo_cntrNotZero;
  assign control_clock = clock;
  assign control_reset = reset;
  assign control_io_stall = io_stall;
  assign control_io_ctrlIo_outFire = datapath_io_ctrlIo_outFire;
  assign control_io_ctrlIo_inValid = datapath_io_ctrlIo_inValid;
endmodule
module ShiftRegister(
  input         clock,
  input         reset,
  input         io_in,
  output        io_out,
  input         targetFire,
  input         daisyReset,
  output        daisy_regs_0_in_ready,
  input         daisy_regs_0_in_valid,
  input  [63:0] daisy_regs_0_in_bits,
  input         daisy_regs_0_out_ready,
  output        daisy_regs_0_out_valid,
  output [63:0] daisy_regs_0_out_bits
);
  reg  r0;
  reg [31:0] _RAND_0;
  reg  r1;
  reg [31:0] _RAND_1;
  reg  r2;
  reg [31:0] _RAND_2;
  reg  r3;
  reg [31:0] _RAND_3;
  wire  _GEN_0;
  wire  _GEN_1;
  wire  _GEN_2;
  wire  _GEN_3;
  wire  regs_0_clock;
  wire  regs_0_reset;
  wire  regs_0_io_stall;
  wire  regs_0_io_dataIo_in_ready;
  wire  regs_0_io_dataIo_in_valid;
  wire [63:0] regs_0_io_dataIo_in_bits;
  wire  regs_0_io_dataIo_out_ready;
  wire  regs_0_io_dataIo_out_valid;
  wire [63:0] regs_0_io_dataIo_out_bits;
  wire [63:0] regs_0_io_dataIo_data_0;
  wire [60:0] _GEN_4;
  wire [1:0] _GEN_5;
  wire [61:0] _GEN_6;
  RegChain regs_0 (
    .clock(regs_0_clock),
    .reset(regs_0_reset),
    .io_stall(regs_0_io_stall),
    .io_dataIo_in_ready(regs_0_io_dataIo_in_ready),
    .io_dataIo_in_valid(regs_0_io_dataIo_in_valid),
    .io_dataIo_in_bits(regs_0_io_dataIo_in_bits),
    .io_dataIo_out_ready(regs_0_io_dataIo_out_ready),
    .io_dataIo_out_valid(regs_0_io_dataIo_out_valid),
    .io_dataIo_out_bits(regs_0_io_dataIo_out_bits),
    .io_dataIo_data_0(regs_0_io_dataIo_data_0)
  );
  assign io_out = r3;
  assign daisy_regs_0_in_ready = regs_0_io_dataIo_in_ready;
  assign daisy_regs_0_out_valid = regs_0_io_dataIo_out_valid;
  assign daisy_regs_0_out_bits = regs_0_io_dataIo_out_bits;
  assign _GEN_0 = targetFire ? io_in : r0;
  assign _GEN_1 = targetFire ? r0 : r1;
  assign _GEN_2 = targetFire ? r1 : r2;
  assign _GEN_3 = targetFire ? r2 : r3;
  assign regs_0_clock = clock;
  assign regs_0_reset = daisyReset;
  assign regs_0_io_stall = ~ targetFire;
  assign regs_0_io_dataIo_in_valid = daisy_regs_0_in_valid;
  assign regs_0_io_dataIo_in_bits = daisy_regs_0_in_bits;
  assign regs_0_io_dataIo_out_ready = daisy_regs_0_out_ready;
  assign regs_0_io_dataIo_data_0 = {_GEN_5,_GEN_6};
  assign _GEN_4 = {r3,60'h0};
  assign _GEN_5 = {r0,r1};
  assign _GEN_6 = {r2,_GEN_4};
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  r0 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  r1 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  r2 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  r3 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (targetFire) begin
      r0 <= io_in;
    end
    if (targetFire) begin
      r1 <= r0;
    end
    if (targetFire) begin
      r2 <= r1;
    end
    if (targetFire) begin
      r3 <= r2;
    end
  end
endmodule
module Queue(
  input   clock,
  input   reset,
  output  io_enq_ready,
  input   io_enq_valid,
  input   io_enq_bits,
  input   io_deq_ready,
  output  io_deq_valid,
  output  io_deq_bits
);
  reg  ram [0:15];
  reg [31:0] _RAND_0;
  wire  ram__T_50_data;
  wire [3:0] ram__T_50_addr;
  wire  ram__T_36_data;
  wire [3:0] ram__T_36_addr;
  wire  ram__T_36_mask;
  wire  ram__T_36_en;
  reg [3:0] value;
  reg [31:0] _RAND_1;
  reg [3:0] value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_29;
  wire  _T_31;
  wire  _T_32;
  wire  _T_33;
  wire  _T_34;
  wire  do_enq;
  wire  _T_35;
  wire  do_deq;
  wire [4:0] _T_39;
  wire [3:0] _T_40;
  wire [3:0] _GEN_4;
  wire [4:0] _T_43;
  wire [3:0] _T_44;
  wire [3:0] _GEN_5;
  wire  _T_45;
  wire  _GEN_6;
  wire  _T_47;
  wire  _T_49;
  assign io_enq_ready = _T_49;
  assign io_deq_valid = _T_47;
  assign io_deq_bits = ram__T_50_data;
  assign ram__T_50_addr = value_1;
  assign ram__T_50_data = ram[ram__T_50_addr];
  assign ram__T_36_data = io_enq_bits;
  assign ram__T_36_addr = value;
  assign ram__T_36_mask = do_enq;
  assign ram__T_36_en = do_enq;
  assign _T_29 = value == value_1;
  assign _T_31 = maybe_full == 1'h0;
  assign _T_32 = _T_29 & _T_31;
  assign _T_33 = _T_29 & maybe_full;
  assign _T_34 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_34;
  assign _T_35 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_35;
  assign _T_39 = value + 4'h1;
  assign _T_40 = _T_39[3:0];
  assign _GEN_4 = do_enq ? _T_40 : value;
  assign _T_43 = value_1 + 4'h1;
  assign _T_44 = _T_43[3:0];
  assign _GEN_5 = do_deq ? _T_44 : value_1;
  assign _T_45 = do_enq != do_deq;
  assign _GEN_6 = _T_45 ? do_enq : maybe_full;
  assign _T_47 = _T_32 == 1'h0;
  assign _T_49 = _T_33 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[0:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value_1 = _RAND_2[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_36_en & ram__T_36_mask) begin
      ram[ram__T_36_addr] <= ram__T_36_data;
    end
    if (reset) begin
      value <= 4'h0;
    end else begin
      if (do_enq) begin
        value <= _T_40;
      end
    end
    if (reset) begin
      value_1 <= 4'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_44;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_45) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module TraceQueue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input        io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output       io_deq_bits,
  input  [9:0] io_limit
);
  wire  do_flow;
  wire  _T_28;
  wire  _T_30;
  wire  do_enq;
  wire  _T_31;
  wire  do_deq;
  reg  maybe_full;
  reg [31:0] _RAND_0;
  reg [9:0] enq_ptr;
  reg [31:0] _RAND_1;
  reg [9:0] deq_ptr;
  reg [31:0] _RAND_2;
  wire [10:0] _T_38;
  wire [10:0] _T_39;
  wire [9:0] _T_40;
  wire  enq_wrap;
  wire  deq_wrap;
  wire [10:0] _T_47;
  wire [9:0] _T_48;
  wire [9:0] _T_49;
  wire [9:0] _GEN_0;
  wire [10:0] _T_52;
  wire [9:0] _T_53;
  wire [9:0] _T_54;
  wire [9:0] _GEN_1;
  wire  _T_55;
  wire  _GEN_2;
  wire  ptr_match;
  wire  _T_57;
  wire  empty;
  wire  full;
  wire [10:0] _T_58;
  wire [10:0] _T_59;
  wire [9:0] _T_60;
  wire  _T_62;
  wire  atLeastTwo;
  wire  _T_63;
  reg  ram [0:1023];
  reg [31:0] _RAND_3;
  wire  ram__T_85_data;
  wire [9:0] ram__T_85_addr;
  wire  ram__T_65_data;
  wire [9:0] ram__T_65_addr;
  wire  ram__T_65_mask;
  wire  ram__T_65_en;
  wire  _GEN_11;
  reg [9:0] ram__T_85_addr_pipe_0;
  reg [31:0] _RAND_4;
  wire  _T_67;
  wire  _T_69;
  wire  _T_70;
  wire  _T_71;
  wire  ren;
  reg  ram_out_valid;
  reg [31:0] _RAND_5;
  wire [9:0] raddr;
  wire  _T_78;
  wire  _T_79;
  wire [9:0] _T_81;
  wire  _T_86;
  assign io_enq_ready = _T_78;
  assign io_deq_valid = _T_79;
  assign io_deq_bits = _T_86;
  assign do_flow = _T_63;
  assign _T_28 = io_enq_ready & io_enq_valid;
  assign _T_30 = do_flow == 1'h0;
  assign do_enq = _T_28 & _T_30;
  assign _T_31 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_31 & _T_30;
  assign _T_38 = io_limit - 10'h2;
  assign _T_39 = $unsigned(_T_38);
  assign _T_40 = _T_39[9:0];
  assign enq_wrap = enq_ptr == _T_40;
  assign deq_wrap = deq_ptr == _T_40;
  assign _T_47 = enq_ptr + 10'h1;
  assign _T_48 = _T_47[9:0];
  assign _T_49 = enq_wrap ? 10'h0 : _T_48;
  assign _GEN_0 = do_enq ? _T_49 : enq_ptr;
  assign _T_52 = deq_ptr + 10'h1;
  assign _T_53 = _T_52[9:0];
  assign _T_54 = deq_wrap ? 10'h0 : _T_53;
  assign _GEN_1 = do_deq ? _T_54 : deq_ptr;
  assign _T_55 = do_enq != do_deq;
  assign _GEN_2 = _T_55 ? do_enq : maybe_full;
  assign ptr_match = enq_ptr == deq_ptr;
  assign _T_57 = maybe_full == 1'h0;
  assign empty = ptr_match & _T_57;
  assign full = ptr_match & maybe_full;
  assign _T_58 = enq_ptr - deq_ptr;
  assign _T_59 = $unsigned(_T_58);
  assign _T_60 = _T_59[9:0];
  assign _T_62 = _T_60 >= 10'h2;
  assign atLeastTwo = full | _T_62;
  assign _T_63 = empty & io_deq_ready;
  assign ram__T_85_addr = ram__T_85_addr_pipe_0;
  assign ram__T_85_data = ram[ram__T_85_addr];
  assign ram__T_65_data = io_enq_bits;
  assign ram__T_65_addr = enq_ptr;
  assign ram__T_65_mask = do_enq;
  assign ram__T_65_en = do_enq;
  assign _GEN_11 = ren;
  assign _T_67 = io_deq_valid == 1'h0;
  assign _T_69 = empty == 1'h0;
  assign _T_70 = _T_67 & _T_69;
  assign _T_71 = atLeastTwo | _T_70;
  assign ren = io_deq_ready & _T_71;
  assign raddr = io_deq_valid ? _T_54 : deq_ptr;
  assign _T_78 = full == 1'h0;
  assign _T_79 = empty ? io_enq_valid : ram_out_valid;
  assign _T_81 = raddr;
  assign _T_86 = empty ? io_enq_bits : ram__T_85_data;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  maybe_full = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  enq_ptr = _RAND_1[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  deq_ptr = _RAND_2[9:0];
  `endif // RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    ram[initvar] = _RAND_3[0:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  ram__T_85_addr_pipe_0 = _RAND_4[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  ram_out_valid = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_55) begin
        maybe_full <= do_enq;
      end
    end
    if (reset) begin
      enq_ptr <= 10'h0;
    end else begin
      if (do_enq) begin
        if (enq_wrap) begin
          enq_ptr <= 10'h0;
        end else begin
          enq_ptr <= _T_48;
        end
      end
    end
    if (reset) begin
      deq_ptr <= 10'h0;
    end else begin
      if (do_deq) begin
        if (deq_wrap) begin
          deq_ptr <= 10'h0;
        end else begin
          deq_ptr <= _T_53;
        end
      end
    end
    if(ram__T_65_en & ram__T_65_mask) begin
      ram[ram__T_65_addr] <= ram__T_65_data;
    end
    if (_GEN_11) begin
      ram__T_85_addr_pipe_0 <= _T_81;
    end
    ram_out_valid <= ren;
  end
endmodule
module Queue_1(
  input   clock,
  input   reset,
  output  io_enq_ready,
  input   io_enq_valid,
  input   io_enq_bits,
  input   io_deq_ready,
  output  io_deq_valid,
  output  io_deq_bits
);
  reg  ram [0:0];
  reg [31:0] _RAND_0;
  wire  ram__T_44_data;
  wire  ram__T_44_addr;
  wire  ram__T_35_data;
  wire  ram__T_35_addr;
  wire  ram__T_35_mask;
  wire  ram__T_35_en;
  reg  maybe_full;
  reg [31:0] _RAND_1;
  wire  _T_29;
  wire  _T_32;
  wire  do_enq;
  wire  _T_33;
  wire  do_deq;
  wire  _T_38;
  wire  _GEN_4;
  wire  _T_40;
  wire  _GEN_5;
  assign io_enq_ready = _GEN_5;
  assign io_deq_valid = _T_40;
  assign io_deq_bits = ram__T_44_data;
  assign ram__T_44_addr = 1'h0;
  assign ram__T_44_data = ram[ram__T_44_addr];
  assign ram__T_35_data = io_enq_bits;
  assign ram__T_35_addr = 1'h0;
  assign ram__T_35_mask = do_enq;
  assign ram__T_35_en = do_enq;
  assign _T_29 = maybe_full == 1'h0;
  assign _T_32 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_32;
  assign _T_33 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_33;
  assign _T_38 = do_enq != do_deq;
  assign _GEN_4 = _T_38 ? do_enq : maybe_full;
  assign _T_40 = _T_29 == 1'h0;
  assign _GEN_5 = io_deq_ready ? 1'h1 : _T_29;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram[initvar] = _RAND_0[0:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  maybe_full = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_35_en & ram__T_35_mask) begin
      ram[ram__T_35_addr] <= ram__T_35_data;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_38) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module WireChannel(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input         io_in_bits,
  input         io_out_ready,
  output        io_out_valid,
  output        io_out_bits,
  input         io_trace_ready,
  output        io_trace_valid,
  output        io_trace_bits,
  input  [10:0] io_traceLen
);
  wire  tokens_clock;
  wire  tokens_reset;
  wire  tokens_io_enq_ready;
  wire  tokens_io_enq_valid;
  wire  tokens_io_enq_bits;
  wire  tokens_io_deq_ready;
  wire  tokens_io_deq_valid;
  wire  tokens_io_deq_bits;
  wire  trace_clock;
  wire  trace_reset;
  wire  trace_io_enq_ready;
  wire  trace_io_enq_valid;
  wire  trace_io_enq_bits;
  wire  trace_io_deq_ready;
  wire  trace_io_deq_valid;
  wire  trace_io_deq_bits;
  wire [9:0] trace_io_limit;
  wire  _T_36;
  wire  Queue_clock;
  wire  Queue_reset;
  wire  Queue_io_enq_ready;
  wire  Queue_io_enq_valid;
  wire  Queue_io_enq_bits;
  wire  Queue_io_deq_ready;
  wire  Queue_io_deq_valid;
  wire  Queue_io_deq_bits;
  Queue tokens (
    .clock(tokens_clock),
    .reset(tokens_reset),
    .io_enq_ready(tokens_io_enq_ready),
    .io_enq_valid(tokens_io_enq_valid),
    .io_enq_bits(tokens_io_enq_bits),
    .io_deq_ready(tokens_io_deq_ready),
    .io_deq_valid(tokens_io_deq_valid),
    .io_deq_bits(tokens_io_deq_bits)
  );
  TraceQueue trace (
    .clock(trace_clock),
    .reset(trace_reset),
    .io_enq_ready(trace_io_enq_ready),
    .io_enq_valid(trace_io_enq_valid),
    .io_enq_bits(trace_io_enq_bits),
    .io_deq_ready(trace_io_deq_ready),
    .io_deq_valid(trace_io_deq_valid),
    .io_deq_bits(trace_io_deq_bits),
    .io_limit(trace_io_limit)
  );
  Queue_1 Queue (
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  assign io_in_ready = tokens_io_enq_ready;
  assign io_out_valid = tokens_io_deq_valid;
  assign io_out_bits = tokens_io_deq_bits;
  assign io_trace_valid = Queue_io_deq_valid;
  assign io_trace_bits = Queue_io_deq_bits;
  assign tokens_clock = clock;
  assign tokens_reset = reset;
  assign tokens_io_enq_valid = io_in_valid;
  assign tokens_io_enq_bits = io_in_bits;
  assign tokens_io_deq_ready = io_out_ready;
  assign trace_clock = clock;
  assign trace_reset = reset;
  assign trace_io_enq_valid = _T_36;
  assign trace_io_enq_bits = tokens_io_deq_bits;
  assign trace_io_deq_ready = Queue_io_enq_ready;
  assign trace_io_limit = io_traceLen[9:0];
  assign _T_36 = tokens_io_deq_ready & tokens_io_deq_valid;
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = trace_io_deq_valid;
  assign Queue_io_enq_bits = trace_io_deq_bits;
  assign Queue_io_deq_ready = io_trace_ready;
endmodule
module SimWrapper(
  input         clock,
  input         reset,
  output        io_wireIns_0_ready,
  input         io_wireIns_0_valid,
  input  [63:0] io_wireIns_0_bits,
  output        io_wireIns_1_ready,
  input         io_wireIns_1_valid,
  input  [63:0] io_wireIns_1_bits,
  input         io_wireOuts_0_ready,
  output        io_wireOuts_0_valid,
  output [63:0] io_wireOuts_0_bits,
  output        io_daisy_regs_0_in_ready,
  input         io_daisy_regs_0_in_valid,
  input  [63:0] io_daisy_regs_0_in_bits,
  input         io_daisy_regs_0_out_ready,
  output        io_daisy_regs_0_out_valid,
  output [63:0] io_daisy_regs_0_out_bits,
  input  [10:0] io_traceLen,
  input         io_wireInTraces_0_ready,
  output        io_wireInTraces_0_valid,
  output [63:0] io_wireInTraces_0_bits,
  input         io_wireInTraces_1_ready,
  output        io_wireInTraces_1_valid,
  output [63:0] io_wireInTraces_1_bits,
  input         io_wireOutTraces_0_ready,
  output        io_wireOutTraces_0_valid,
  output [63:0] io_wireOutTraces_0_bits
);
  wire  target_clock;
  wire  target_reset;
  wire  target_io_in;
  wire  target_io_out;
  wire  target_targetFire;
  wire  target_daisyReset;
  wire  target_daisy_regs_0_in_ready;
  wire  target_daisy_regs_0_in_valid;
  wire [63:0] target_daisy_regs_0_in_bits;
  wire  target_daisy_regs_0_out_ready;
  wire  target_daisy_regs_0_out_valid;
  wire [63:0] target_daisy_regs_0_out_bits;
  wire  fire;
  wire  WireChannel_reset_0_clock;
  wire  WireChannel_reset_0_reset;
  wire  WireChannel_reset_0_io_in_ready;
  wire  WireChannel_reset_0_io_in_valid;
  wire  WireChannel_reset_0_io_in_bits;
  wire  WireChannel_reset_0_io_out_ready;
  wire  WireChannel_reset_0_io_out_valid;
  wire  WireChannel_reset_0_io_out_bits;
  wire  WireChannel_reset_0_io_trace_ready;
  wire  WireChannel_reset_0_io_trace_valid;
  wire  WireChannel_reset_0_io_trace_bits;
  wire [10:0] WireChannel_reset_0_io_traceLen;
  wire  WireChannel_io_in_0_clock;
  wire  WireChannel_io_in_0_reset;
  wire  WireChannel_io_in_0_io_in_ready;
  wire  WireChannel_io_in_0_io_in_valid;
  wire  WireChannel_io_in_0_io_in_bits;
  wire  WireChannel_io_in_0_io_out_ready;
  wire  WireChannel_io_in_0_io_out_valid;
  wire  WireChannel_io_in_0_io_out_bits;
  wire  WireChannel_io_in_0_io_trace_ready;
  wire  WireChannel_io_in_0_io_trace_valid;
  wire  WireChannel_io_in_0_io_trace_bits;
  wire [10:0] WireChannel_io_in_0_io_traceLen;
  wire  WireChannel_io_out_0_clock;
  wire  WireChannel_io_out_0_reset;
  wire  WireChannel_io_out_0_io_in_ready;
  wire  WireChannel_io_out_0_io_in_valid;
  wire  WireChannel_io_out_0_io_in_bits;
  wire  WireChannel_io_out_0_io_out_ready;
  wire  WireChannel_io_out_0_io_out_valid;
  wire  WireChannel_io_out_0_io_out_bits;
  wire  WireChannel_io_out_0_io_trace_ready;
  wire  WireChannel_io_out_0_io_trace_valid;
  wire  WireChannel_io_out_0_io_trace_bits;
  wire [10:0] WireChannel_io_out_0_io_traceLen;
  wire  _T_523;
  wire  _T_525;
  wire  _T_526;
  wire  _T_528;
  wire  _T_529;
  reg  resetNext;
  reg [31:0] _RAND_0;
  wire  _T_534;
  reg [63:0] cycles;
  reg [63:0] _RAND_1;
  wire [64:0] _T_538;
  wire [63:0] _T_539;
  wire [63:0] _T_540;
  wire [63:0] _GEN_0;
  ShiftRegister target (
    .clock(target_clock),
    .reset(target_reset),
    .io_in(target_io_in),
    .io_out(target_io_out),
    .targetFire(target_targetFire),
    .daisyReset(target_daisyReset),
    .daisy_regs_0_in_ready(target_daisy_regs_0_in_ready),
    .daisy_regs_0_in_valid(target_daisy_regs_0_in_valid),
    .daisy_regs_0_in_bits(target_daisy_regs_0_in_bits),
    .daisy_regs_0_out_ready(target_daisy_regs_0_out_ready),
    .daisy_regs_0_out_valid(target_daisy_regs_0_out_valid),
    .daisy_regs_0_out_bits(target_daisy_regs_0_out_bits)
  );
  WireChannel WireChannel_reset_0 (
    .clock(WireChannel_reset_0_clock),
    .reset(WireChannel_reset_0_reset),
    .io_in_ready(WireChannel_reset_0_io_in_ready),
    .io_in_valid(WireChannel_reset_0_io_in_valid),
    .io_in_bits(WireChannel_reset_0_io_in_bits),
    .io_out_ready(WireChannel_reset_0_io_out_ready),
    .io_out_valid(WireChannel_reset_0_io_out_valid),
    .io_out_bits(WireChannel_reset_0_io_out_bits),
    .io_trace_ready(WireChannel_reset_0_io_trace_ready),
    .io_trace_valid(WireChannel_reset_0_io_trace_valid),
    .io_trace_bits(WireChannel_reset_0_io_trace_bits),
    .io_traceLen(WireChannel_reset_0_io_traceLen)
  );
  WireChannel WireChannel_io_in_0 (
    .clock(WireChannel_io_in_0_clock),
    .reset(WireChannel_io_in_0_reset),
    .io_in_ready(WireChannel_io_in_0_io_in_ready),
    .io_in_valid(WireChannel_io_in_0_io_in_valid),
    .io_in_bits(WireChannel_io_in_0_io_in_bits),
    .io_out_ready(WireChannel_io_in_0_io_out_ready),
    .io_out_valid(WireChannel_io_in_0_io_out_valid),
    .io_out_bits(WireChannel_io_in_0_io_out_bits),
    .io_trace_ready(WireChannel_io_in_0_io_trace_ready),
    .io_trace_valid(WireChannel_io_in_0_io_trace_valid),
    .io_trace_bits(WireChannel_io_in_0_io_trace_bits),
    .io_traceLen(WireChannel_io_in_0_io_traceLen)
  );
  WireChannel WireChannel_io_out_0 (
    .clock(WireChannel_io_out_0_clock),
    .reset(WireChannel_io_out_0_reset),
    .io_in_ready(WireChannel_io_out_0_io_in_ready),
    .io_in_valid(WireChannel_io_out_0_io_in_valid),
    .io_in_bits(WireChannel_io_out_0_io_in_bits),
    .io_out_ready(WireChannel_io_out_0_io_out_ready),
    .io_out_valid(WireChannel_io_out_0_io_out_valid),
    .io_out_bits(WireChannel_io_out_0_io_out_bits),
    .io_trace_ready(WireChannel_io_out_0_io_trace_ready),
    .io_trace_valid(WireChannel_io_out_0_io_trace_valid),
    .io_trace_bits(WireChannel_io_out_0_io_trace_bits),
    .io_traceLen(WireChannel_io_out_0_io_traceLen)
  );
  assign io_wireIns_0_ready = WireChannel_reset_0_io_in_ready;
  assign io_wireIns_1_ready = WireChannel_io_in_0_io_in_ready;
  assign io_wireOuts_0_valid = WireChannel_io_out_0_io_out_valid;
  assign io_wireOuts_0_bits = {{63'd0}, WireChannel_io_out_0_io_out_bits};
  assign io_daisy_regs_0_in_ready = target_daisy_regs_0_in_ready;
  assign io_daisy_regs_0_out_valid = target_daisy_regs_0_out_valid;
  assign io_daisy_regs_0_out_bits = target_daisy_regs_0_out_bits;
  assign io_wireInTraces_0_valid = WireChannel_reset_0_io_trace_valid;
  assign io_wireInTraces_0_bits = {{63'd0}, WireChannel_reset_0_io_trace_bits};
  assign io_wireInTraces_1_valid = WireChannel_io_in_0_io_trace_valid;
  assign io_wireInTraces_1_bits = {{63'd0}, WireChannel_io_in_0_io_trace_bits};
  assign io_wireOutTraces_0_valid = WireChannel_io_out_0_io_trace_valid;
  assign io_wireOutTraces_0_bits = {{63'd0}, WireChannel_io_out_0_io_trace_bits};
  assign target_clock = clock;
  assign target_reset = WireChannel_reset_0_io_out_bits;
  assign target_io_in = WireChannel_io_in_0_io_out_bits;
  assign target_targetFire = fire;
  assign target_daisyReset = reset;
  assign target_daisy_regs_0_in_valid = io_daisy_regs_0_in_valid;
  assign target_daisy_regs_0_in_bits = io_daisy_regs_0_in_bits;
  assign target_daisy_regs_0_out_ready = io_daisy_regs_0_out_ready;
  assign fire = _T_529;
  assign WireChannel_reset_0_clock = clock;
  assign WireChannel_reset_0_reset = reset;
  assign WireChannel_reset_0_io_in_valid = io_wireIns_0_valid;
  assign WireChannel_reset_0_io_in_bits = io_wireIns_0_bits[0];
  assign WireChannel_reset_0_io_out_ready = fire;
  assign WireChannel_reset_0_io_trace_ready = io_wireInTraces_0_ready;
  assign WireChannel_reset_0_io_traceLen = io_traceLen;
  assign WireChannel_io_in_0_clock = clock;
  assign WireChannel_io_in_0_reset = reset;
  assign WireChannel_io_in_0_io_in_valid = io_wireIns_1_valid;
  assign WireChannel_io_in_0_io_in_bits = io_wireIns_1_bits[0];
  assign WireChannel_io_in_0_io_out_ready = fire;
  assign WireChannel_io_in_0_io_trace_ready = io_wireInTraces_1_ready;
  assign WireChannel_io_in_0_io_traceLen = io_traceLen;
  assign WireChannel_io_out_0_clock = clock;
  assign WireChannel_io_out_0_reset = reset;
  assign WireChannel_io_out_0_io_in_valid = _T_534;
  assign WireChannel_io_out_0_io_in_bits = _T_523;
  assign WireChannel_io_out_0_io_out_ready = io_wireOuts_0_ready;
  assign WireChannel_io_out_0_io_trace_ready = io_wireOutTraces_0_ready;
  assign WireChannel_io_out_0_io_traceLen = io_traceLen;
  assign _T_523 = target_io_out;
  assign _T_525 = WireChannel_reset_0_io_out_valid;
  assign _T_526 = _T_525 & WireChannel_io_in_0_io_out_valid;
  assign _T_528 = WireChannel_io_out_0_io_in_ready;
  assign _T_529 = _T_526 & _T_528;
  assign _T_534 = fire | resetNext;
  assign _T_538 = cycles + 64'h1;
  assign _T_539 = _T_538[63:0];
  assign _T_540 = target_reset ? 64'h0 : _T_539;
  assign _GEN_0 = fire ? _T_540 : cycles;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  resetNext = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{$random}};
  cycles = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    resetNext <= reset;
    if (fire) begin
      if (target_reset) begin
        cycles <= 64'h0;
      end else begin
        cycles <= _T_539;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"%d",cycles);
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module Queue_0(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits
);
  reg [63:0] ram [0:1];
  reg [63:0] _RAND_0;
  wire [63:0] ram__T_50_data;
  wire  ram__T_50_addr;
  wire [63:0] ram__T_36_data;
  wire  ram__T_36_addr;
  wire  ram__T_36_mask;
  wire  ram__T_36_en;
  reg  value;
  reg [31:0] _RAND_1;
  reg  value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_29;
  wire  _T_31;
  wire  _T_32;
  wire  _T_33;
  wire  _T_34;
  wire  do_enq;
  wire  _T_35;
  wire  do_deq;
  wire [1:0] _T_39;
  wire  _T_40;
  wire  _GEN_4;
  wire [1:0] _T_43;
  wire  _T_44;
  wire  _GEN_5;
  wire  _T_45;
  wire  _GEN_6;
  wire  _T_47;
  wire  _T_49;
  assign io_enq_ready = _T_49;
  assign io_deq_valid = _T_47;
  assign io_deq_bits = ram__T_50_data;
  assign ram__T_50_addr = value_1;
  assign ram__T_50_data = ram[ram__T_50_addr];
  assign ram__T_36_data = io_enq_bits;
  assign ram__T_36_addr = value;
  assign ram__T_36_mask = do_enq;
  assign ram__T_36_en = do_enq;
  assign _T_29 = value == value_1;
  assign _T_31 = maybe_full == 1'h0;
  assign _T_32 = _T_29 & _T_31;
  assign _T_33 = _T_29 & maybe_full;
  assign _T_34 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_34;
  assign _T_35 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_35;
  assign _T_39 = value + 1'h1;
  assign _T_40 = _T_39[0:0];
  assign _GEN_4 = do_enq ? _T_40 : value;
  assign _T_43 = value_1 + 1'h1;
  assign _T_44 = _T_43[0:0];
  assign _GEN_5 = do_deq ? _T_44 : value_1;
  assign _T_45 = do_enq != do_deq;
  assign _GEN_6 = _T_45 ? do_enq : maybe_full;
  assign _T_47 = _T_32 == 1'h0;
  assign _T_49 = _T_33 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {2{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram[initvar] = _RAND_0[63:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value_1 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_36_en & ram__T_36_mask) begin
      ram[ram__T_36_addr] <= ram__T_36_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_40;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_44;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_45) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module MCRFile(
  input         clock,
  input         reset,
  output        io_nasti_aw_ready,
  input         io_nasti_aw_valid,
  input  [31:0] io_nasti_aw_bits_addr,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [63:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [63:0] io_nasti_r_bits_data,
  output        io_nasti_r_bits_last,
  input  [63:0] io_mcr_read_0_bits,
  output        io_mcr_read_1_ready,
  input         io_mcr_read_1_valid,
  input  [63:0] io_mcr_read_1_bits,
  input  [63:0] io_mcr_read_2_bits,
  output        io_mcr_write_0_valid,
  output [63:0] io_mcr_write_0_bits,
  input         io_mcr_write_1_ready,
  output        io_mcr_write_1_valid,
  output [63:0] io_mcr_write_1_bits,
  output        io_mcr_write_2_valid,
  output [63:0] io_mcr_write_2_bits
);
  reg  arFired;
  reg [31:0] _RAND_0;
  reg  awFired;
  reg [31:0] _RAND_1;
  reg  wFired;
  reg [31:0] _RAND_2;
  reg  wCommited;
  reg [31:0] _RAND_3;
  reg [63:0] wData;
  reg [63:0] _RAND_4;
  reg [1:0] wAddr;
  reg [31:0] _RAND_5;
  reg [1:0] rAddr;
  reg [31:0] _RAND_6;
  wire  _T_444;
  wire [28:0] _T_446;
  wire  _GEN_6;
  wire [28:0] _GEN_7;
  wire  _T_452;
  wire  _GEN_9;
  wire [63:0] _GEN_10;
  wire  _T_454;
  wire [28:0] _T_456;
  wire [1:0] _T_457;
  wire  _GEN_12;
  wire [1:0] _GEN_13;
  wire  _T_463;
  wire  _GEN_15;
  wire  _T_465;
  wire  _GEN_16;
  wire  _GEN_17;
  wire  _GEN_18;
  wire  _GEN_0_ready;
  wire  _GEN_19;
  wire  _GEN_20;
  wire  _GEN_22;
  wire  _GEN_23;
  wire  _GEN_1_valid;
  wire  _T_475;
  wire  _GEN_31;
  wire  _T_489;
  wire  _T_490;
  wire  _T_491;
  wire  _GEN_2;
  wire  _GEN_32;
  wire  _GEN_33;
  wire  _GEN_34;
  wire  _T_498;
  wire  _GEN_3;
  wire  _GEN_36;
  wire [63:0] _T_513_data;
  wire [63:0] _GEN_4_bits;
  wire  _GEN_39;
  wire [63:0] _GEN_40;
  wire  _GEN_42;
  wire [63:0] _GEN_43;
  wire  _GEN_5_valid;
  wire  _T_526;
  wire  _T_538;
  wire  _T_539;
  wire  _T_540;
  wire  _T_541;
  assign io_nasti_aw_ready = _T_540;
  assign io_nasti_w_ready = _T_541;
  assign io_nasti_b_valid = _T_538;
  assign io_nasti_ar_ready = _T_539;
  assign io_nasti_r_valid = _T_526;
  assign io_nasti_r_bits_data = _T_513_data;
  assign io_nasti_r_bits_last = 1'h1;
  assign io_mcr_read_1_ready = _GEN_36;
  assign io_mcr_write_0_valid = _GEN_32;
  assign io_mcr_write_0_bits = wData;
  assign io_mcr_write_1_valid = _GEN_33;
  assign io_mcr_write_1_bits = wData;
  assign io_mcr_write_2_valid = _GEN_34;
  assign io_mcr_write_2_bits = wData;
  assign _T_444 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_446 = io_nasti_aw_bits_addr[31:3];
  assign _GEN_6 = _T_444 ? 1'h1 : awFired;
  assign _GEN_7 = _T_444 ? _T_446 : {{27'd0}, wAddr};
  assign _T_452 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_452 ? 1'h1 : wFired;
  assign _GEN_10 = _T_452 ? io_nasti_w_bits_data : wData;
  assign _T_454 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_456 = io_nasti_ar_bits_addr[31:3];
  assign _T_457 = _T_456[1:0];
  assign _GEN_12 = _T_454 ? 1'h1 : arFired;
  assign _GEN_13 = _T_454 ? _T_457 : rAddr;
  assign _T_463 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_463 ? 1'h0 : _GEN_12;
  assign _T_465 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_465 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_465 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_465 ? 1'h0 : wCommited;
  assign _GEN_0_ready = _GEN_22;
  assign _GEN_19 = 2'h1 == wAddr ? io_mcr_write_1_ready : 1'h1;
  assign _GEN_20 = 2'h1 == wAddr ? io_mcr_write_1_valid : io_mcr_write_0_valid;
  assign _GEN_22 = 2'h2 == wAddr ? 1'h1 : _GEN_19;
  assign _GEN_23 = 2'h2 == wAddr ? io_mcr_write_2_valid : _GEN_20;
  assign _GEN_1_valid = _GEN_23;
  assign _T_475 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_31 = _T_475 ? 1'h1 : _GEN_18;
  assign _T_489 = awFired & wFired;
  assign _T_490 = ~ wCommited;
  assign _T_491 = _T_489 & _T_490;
  assign _GEN_2 = _T_491;
  assign _GEN_32 = 2'h0 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_33 = 2'h1 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_34 = 2'h2 == wAddr ? _GEN_2 : 1'h0;
  assign _T_498 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_498;
  assign _GEN_36 = 2'h1 == rAddr ? _GEN_3 : 1'h0;
  assign _T_513_data = _GEN_4_bits;
  assign _GEN_4_bits = _GEN_43;
  assign _GEN_39 = 2'h1 == rAddr ? io_mcr_read_1_valid : 1'h1;
  assign _GEN_40 = 2'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_42 = 2'h2 == rAddr ? 1'h1 : _GEN_39;
  assign _GEN_43 = 2'h2 == rAddr ? io_mcr_read_2_bits : _GEN_40;
  assign _GEN_5_valid = _GEN_42;
  assign _T_526 = arFired & _GEN_5_valid;
  assign _T_538 = _T_489 & wCommited;
  assign _T_539 = ~ arFired;
  assign _T_540 = ~ awFired;
  assign _T_541 = ~ wFired;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  arFired = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  awFired = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  wFired = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  wCommited = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{$random}};
  wData = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  wAddr = _RAND_5[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  rAddr = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_463) begin
        arFired <= 1'h0;
      end else begin
        if (_T_454) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_465) begin
        awFired <= 1'h0;
      end else begin
        if (_T_444) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_465) begin
        wFired <= 1'h0;
      end else begin
        if (_T_452) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_475) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_465) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_452) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[1:0];
    if (_T_454) begin
      rAddr <= _T_457;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:315 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:328 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module EmulationMaster(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  output        io_simReset,
  input         io_done,
  input         io_step_ready,
  output        io_step_valid,
  output [63:0] io_step_bits
);
  reg  SIM_RESET;
  reg [31:0] _RAND_0;
  reg [1:0] value;
  reg [31:0] _RAND_1;
  wire  _T_369;
  wire [2:0] _T_371;
  wire [1:0] _T_372;
  wire [1:0] _GEN_0;
  wire  _GEN_1;
  wire [1:0] _GEN_2;
  wire  _T_384_ready;
  wire  _T_384_valid;
  wire [63:0] _T_384_bits;
  wire  Queue_clock;
  wire  Queue_reset;
  wire  Queue_io_enq_ready;
  wire  Queue_io_enq_valid;
  wire [63:0] Queue_io_enq_bits;
  wire  Queue_io_deq_ready;
  wire  Queue_io_deq_valid;
  wire [63:0] Queue_io_deq_bits;
  wire  _T_392;
  wire  _T_393;
  reg [63:0] DONE;
  reg [63:0] _RAND_2;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [63:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [63:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [63:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [63:0] MCRFile_io_mcr_read_1_bits;
  wire [63:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [63:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [63:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [63:0] MCRFile_io_mcr_write_2_bits;
  wire [63:0] _GEN_3;
  wire  _T_398;
  wire  _T_399;
  wire  _T_401;
  wire [63:0] _GEN_4;
  Queue_0 Queue (
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  MCRFile MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_mcr_read_0_bits(MCRFile_io_mcr_read_0_bits),
    .io_mcr_read_1_ready(MCRFile_io_mcr_read_1_ready),
    .io_mcr_read_1_valid(MCRFile_io_mcr_read_1_valid),
    .io_mcr_read_1_bits(MCRFile_io_mcr_read_1_bits),
    .io_mcr_read_2_bits(MCRFile_io_mcr_read_2_bits),
    .io_mcr_write_0_valid(MCRFile_io_mcr_write_0_valid),
    .io_mcr_write_0_bits(MCRFile_io_mcr_write_0_bits),
    .io_mcr_write_1_ready(MCRFile_io_mcr_write_1_ready),
    .io_mcr_write_1_valid(MCRFile_io_mcr_write_1_valid),
    .io_mcr_write_1_bits(MCRFile_io_mcr_write_1_bits),
    .io_mcr_write_2_valid(MCRFile_io_mcr_write_2_valid),
    .io_mcr_write_2_bits(MCRFile_io_mcr_write_2_bits)
  );
  assign io_ctrl_aw_ready = MCRFile_io_nasti_aw_ready;
  assign io_ctrl_w_ready = MCRFile_io_nasti_w_ready;
  assign io_ctrl_b_valid = MCRFile_io_nasti_b_valid;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_simReset = SIM_RESET;
  assign io_step_valid = Queue_io_deq_valid;
  assign io_step_bits = Queue_io_deq_bits;
  assign _T_369 = value == 2'h3;
  assign _T_371 = value + 2'h1;
  assign _T_372 = _T_371[1:0];
  assign _GEN_0 = SIM_RESET ? _T_372 : value;
  assign _GEN_1 = _T_369 ? 1'h0 : SIM_RESET;
  assign _GEN_2 = _T_369 ? 2'h0 : _GEN_0;
  assign _T_384_ready = Queue_io_enq_ready;
  assign _T_384_valid = MCRFile_io_mcr_write_1_valid;
  assign _T_384_bits = MCRFile_io_mcr_write_1_bits;
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = _T_384_valid;
  assign Queue_io_enq_bits = _T_384_bits;
  assign Queue_io_deq_ready = io_step_ready;
  assign _T_392 = ~ io_simReset;
  assign _T_393 = io_done & _T_392;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_bits = {{63'd0}, SIM_RESET};
  assign MCRFile_io_mcr_read_1_valid = 1'h0;
  assign MCRFile_io_mcr_read_1_bits = 64'h0;
  assign MCRFile_io_mcr_read_2_bits = DONE;
  assign MCRFile_io_mcr_write_1_ready = _T_384_ready;
  assign _GEN_3 = MCRFile_io_mcr_write_0_valid ? MCRFile_io_mcr_write_0_bits : {{63'd0}, _GEN_1};
  assign _T_398 = MCRFile_io_mcr_read_1_ready == 1'h0;
  assign _T_399 = _T_398 | reset;
  assign _T_401 = _T_399 == 1'h0;
  assign _GEN_4 = MCRFile_io_mcr_write_2_valid ? MCRFile_io_mcr_write_2_bits : {{63'd0}, _T_393};
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  SIM_RESET = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{$random}};
  DONE = _RAND_2[63:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      SIM_RESET <= 1'h0;
    end else begin
      SIM_RESET <= _GEN_3[0];
    end
    if (reset) begin
      value <= 2'h0;
    end else begin
      if (_T_369) begin
        value <= 2'h0;
      end else begin
        if (SIM_RESET) begin
          value <= _T_372;
        end
      end
    end
    if (reset) begin
      DONE <= 64'h0;
    end else begin
      if (MCRFile_io_mcr_write_2_valid) begin
        DONE <= MCRFile_io_mcr_write_2_bits;
      end else begin
        DONE <= {{63'd0}, _T_393};
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_401) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_401) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module PeekPokeIOWidget(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  output        io_ctrl_r_bits_last,
  input         io_ins_0_ready,
  output        io_ins_0_valid,
  output [63:0] io_ins_0_bits,
  input         io_ins_1_ready,
  output        io_ins_1_valid,
  output [63:0] io_ins_1_bits,
  output        io_outs_0_ready,
  input         io_outs_0_valid,
  input  [63:0] io_outs_0_bits,
  output        io_step_ready,
  input         io_step_valid,
  input  [63:0] io_step_bits,
  output        io_idle
);
  reg [63:0] iTokensAvailable;
  reg [63:0] _RAND_0;
  reg [63:0] oTokensPending;
  reg [63:0] _RAND_1;
  wire  fromHostReady;
  wire  _T_461;
  wire  _T_463;
  wire  _T_464;
  reg [63:0] target_reset;
  reg [63:0] _RAND_2;
  wire  _T_466;
  wire  _T_467;
  reg [63:0] target_io_in;
  reg [63:0] _RAND_3;
  wire  _T_471;
  reg [63:0] target_io_out;
  reg [63:0] _RAND_4;
  wire [63:0] _GEN_0;
  wire  _T_474;
  wire  _T_475;
  wire [64:0] _T_480;
  wire [64:0] _T_481;
  wire [63:0] _T_482;
  wire [63:0] _GEN_1;
  wire [64:0] _T_487;
  wire [64:0] _T_488;
  wire [63:0] _T_489;
  wire [63:0] _GEN_2;
  wire  _T_490;
  wire [63:0] _GEN_3;
  wire [63:0] _GEN_4;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [63:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [63:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [63:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [63:0] MCRFile_io_mcr_read_1_bits;
  wire [63:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [63:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [63:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [63:0] MCRFile_io_mcr_write_2_bits;
  wire [63:0] _GEN_5;
  wire [63:0] _GEN_6;
  wire [63:0] _GEN_7;
  MCRFile MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_mcr_read_0_bits(MCRFile_io_mcr_read_0_bits),
    .io_mcr_read_1_ready(MCRFile_io_mcr_read_1_ready),
    .io_mcr_read_1_valid(MCRFile_io_mcr_read_1_valid),
    .io_mcr_read_1_bits(MCRFile_io_mcr_read_1_bits),
    .io_mcr_read_2_bits(MCRFile_io_mcr_read_2_bits),
    .io_mcr_write_0_valid(MCRFile_io_mcr_write_0_valid),
    .io_mcr_write_0_bits(MCRFile_io_mcr_write_0_bits),
    .io_mcr_write_1_ready(MCRFile_io_mcr_write_1_ready),
    .io_mcr_write_1_valid(MCRFile_io_mcr_write_1_valid),
    .io_mcr_write_1_bits(MCRFile_io_mcr_write_1_bits),
    .io_mcr_write_2_valid(MCRFile_io_mcr_write_2_valid),
    .io_mcr_write_2_bits(MCRFile_io_mcr_write_2_bits)
  );
  assign io_ctrl_aw_ready = MCRFile_io_nasti_aw_ready;
  assign io_ctrl_w_ready = MCRFile_io_nasti_w_ready;
  assign io_ctrl_b_valid = MCRFile_io_nasti_b_valid;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_last = MCRFile_io_nasti_r_bits_last;
  assign io_ins_0_valid = _T_467;
  assign io_ins_0_bits = target_reset;
  assign io_ins_1_valid = _T_467;
  assign io_ins_1_bits = target_io_in;
  assign io_outs_0_ready = _T_475;
  assign io_step_ready = io_idle;
  assign io_idle = _T_464;
  assign fromHostReady = io_ins_0_ready & io_ins_1_ready;
  assign _T_461 = iTokensAvailable == 64'h0;
  assign _T_463 = oTokensPending == 64'h0;
  assign _T_464 = _T_461 & _T_463;
  assign _T_466 = iTokensAvailable != 64'h0;
  assign _T_467 = _T_466 & fromHostReady;
  assign _T_471 = io_outs_0_ready & io_outs_0_valid;
  assign _GEN_0 = _T_471 ? io_outs_0_bits : target_io_out;
  assign _T_474 = oTokensPending != 64'h0;
  assign _T_475 = _T_474 & io_outs_0_valid;
  assign _T_480 = iTokensAvailable - 64'h1;
  assign _T_481 = $unsigned(_T_480);
  assign _T_482 = _T_481[63:0];
  assign _GEN_1 = _T_467 ? _T_482 : iTokensAvailable;
  assign _T_487 = oTokensPending - 64'h1;
  assign _T_488 = $unsigned(_T_487);
  assign _T_489 = _T_488[63:0];
  assign _GEN_2 = _T_475 ? _T_489 : oTokensPending;
  assign _T_490 = io_step_ready & io_step_valid;
  assign _GEN_3 = _T_490 ? io_step_bits : _GEN_1;
  assign _GEN_4 = _T_490 ? io_step_bits : _GEN_2;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_bits = target_reset;
  assign MCRFile_io_mcr_read_1_valid = 1'h1;
  assign MCRFile_io_mcr_read_1_bits = target_io_in;
  assign MCRFile_io_mcr_read_2_bits = target_io_out;
  assign MCRFile_io_mcr_write_1_ready = 1'h1;
  assign _GEN_5 = MCRFile_io_mcr_write_0_valid ? MCRFile_io_mcr_write_0_bits : target_reset;
  assign _GEN_6 = MCRFile_io_mcr_write_1_valid ? MCRFile_io_mcr_write_1_bits : target_io_in;
  assign _GEN_7 = MCRFile_io_mcr_write_2_valid ? MCRFile_io_mcr_write_2_bits : _GEN_0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{$random}};
  iTokensAvailable = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{$random}};
  oTokensPending = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{$random}};
  target_reset = _RAND_2[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {2{$random}};
  target_io_in = _RAND_3[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{$random}};
  target_io_out = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      iTokensAvailable <= 64'h0;
    end else begin
      if (_T_490) begin
        iTokensAvailable <= io_step_bits;
      end else begin
        if (_T_467) begin
          iTokensAvailable <= _T_482;
        end
      end
    end
    if (reset) begin
      oTokensPending <= 64'h1;
    end else begin
      if (_T_490) begin
        oTokensPending <= io_step_bits;
      end else begin
        if (_T_475) begin
          oTokensPending <= _T_489;
        end
      end
    end
    if (MCRFile_io_mcr_write_0_valid) begin
      target_reset <= MCRFile_io_mcr_write_0_bits;
    end
    if (MCRFile_io_mcr_write_1_valid) begin
      target_io_in <= MCRFile_io_mcr_write_1_bits;
    end
    if (MCRFile_io_mcr_write_2_valid) begin
      target_io_out <= MCRFile_io_mcr_write_2_bits;
    end else begin
      if (_T_471) begin
        target_io_out <= io_outs_0_bits;
      end
    end
  end
endmodule
module MCRFile_2(
  input         clock,
  input         reset,
  output        io_nasti_aw_ready,
  input         io_nasti_aw_valid,
  input  [31:0] io_nasti_aw_bits_addr,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [63:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [63:0] io_nasti_r_bits_data,
  input  [63:0] io_mcr_read_0_bits,
  input  [63:0] io_mcr_read_1_bits,
  output        io_mcr_read_2_ready,
  output        io_mcr_read_4_ready,
  output        io_mcr_read_5_ready,
  input         io_mcr_read_5_valid,
  input  [63:0] io_mcr_read_5_bits,
  output        io_mcr_read_6_ready,
  output        io_mcr_read_8_ready,
  output        io_mcr_read_10_ready,
  output        io_mcr_write_0_valid,
  output [63:0] io_mcr_write_0_bits,
  output        io_mcr_write_1_valid,
  output [63:0] io_mcr_write_1_bits,
  output        io_mcr_write_2_valid,
  output        io_mcr_write_3_valid,
  input         io_mcr_write_4_ready,
  output        io_mcr_write_4_valid,
  output [63:0] io_mcr_write_4_bits,
  output        io_mcr_write_5_valid,
  output        io_mcr_write_6_valid,
  output        io_mcr_write_7_valid,
  output        io_mcr_write_8_valid,
  output        io_mcr_write_9_valid,
  output        io_mcr_write_10_valid,
  output        io_mcr_write_11_valid
);
  reg  arFired;
  reg [31:0] _RAND_0;
  reg  awFired;
  reg [31:0] _RAND_1;
  reg  wFired;
  reg [31:0] _RAND_2;
  reg  wCommited;
  reg [31:0] _RAND_3;
  reg [63:0] wData;
  reg [63:0] _RAND_4;
  reg [3:0] wAddr;
  reg [31:0] _RAND_5;
  reg [3:0] rAddr;
  reg [31:0] _RAND_6;
  wire  _T_552;
  wire [28:0] _T_554;
  wire  _GEN_6;
  wire [28:0] _GEN_7;
  wire  _T_560;
  wire  _GEN_9;
  wire [63:0] _GEN_10;
  wire  _T_562;
  wire [28:0] _T_564;
  wire [3:0] _T_565;
  wire  _GEN_12;
  wire [3:0] _GEN_13;
  wire  _T_571;
  wire  _GEN_15;
  wire  _T_573;
  wire  _GEN_16;
  wire  _GEN_17;
  wire  _GEN_18;
  wire  _GEN_0_ready;
  wire  _GEN_20;
  wire  _GEN_22;
  wire  _GEN_23;
  wire  _GEN_25;
  wire  _GEN_26;
  wire  _GEN_28;
  wire  _GEN_29;
  wire  _GEN_31;
  wire  _GEN_32;
  wire  _GEN_34;
  wire  _GEN_35;
  wire  _GEN_37;
  wire  _GEN_38;
  wire  _GEN_40;
  wire  _GEN_41;
  wire  _GEN_43;
  wire  _GEN_44;
  wire  _GEN_46;
  wire  _GEN_47;
  wire  _GEN_49;
  wire  _GEN_50;
  wire  _GEN_1_valid;
  wire  _T_583;
  wire  _GEN_85;
  wire  _T_615;
  wire  _T_616;
  wire  _T_617;
  wire  _GEN_2;
  wire  _GEN_86;
  wire  _GEN_87;
  wire  _GEN_88;
  wire  _GEN_89;
  wire  _GEN_90;
  wire  _GEN_91;
  wire  _GEN_92;
  wire  _GEN_93;
  wire  _GEN_94;
  wire  _GEN_95;
  wire  _GEN_96;
  wire  _GEN_97;
  wire  _T_624;
  wire  _GEN_3;
  wire  _GEN_100;
  wire  _GEN_102;
  wire  _GEN_103;
  wire  _GEN_104;
  wire  _GEN_106;
  wire  _GEN_108;
  wire [63:0] _T_639_data;
  wire [63:0] _GEN_4_bits;
  wire [63:0] _GEN_112;
  wire  _GEN_114;
  wire [63:0] _GEN_115;
  wire  _GEN_117;
  wire [63:0] _GEN_118;
  wire  _GEN_120;
  wire [63:0] _GEN_121;
  wire  _GEN_123;
  wire [63:0] _GEN_124;
  wire  _GEN_126;
  wire [63:0] _GEN_127;
  wire  _GEN_129;
  wire [63:0] _GEN_130;
  wire  _GEN_132;
  wire [63:0] _GEN_133;
  wire  _GEN_135;
  wire [63:0] _GEN_136;
  wire  _GEN_138;
  wire [63:0] _GEN_139;
  wire  _GEN_141;
  wire [63:0] _GEN_142;
  wire  _GEN_5_valid;
  wire  _T_652;
  wire  _T_664;
  wire  _T_665;
  wire  _T_666;
  wire  _T_667;
  assign io_nasti_aw_ready = _T_666;
  assign io_nasti_w_ready = _T_667;
  assign io_nasti_b_valid = _T_664;
  assign io_nasti_ar_ready = _T_665;
  assign io_nasti_r_valid = _T_652;
  assign io_nasti_r_bits_data = _T_639_data;
  assign io_mcr_read_2_ready = _GEN_100;
  assign io_mcr_read_4_ready = _GEN_102;
  assign io_mcr_read_5_ready = _GEN_103;
  assign io_mcr_read_6_ready = _GEN_104;
  assign io_mcr_read_8_ready = _GEN_106;
  assign io_mcr_read_10_ready = _GEN_108;
  assign io_mcr_write_0_valid = _GEN_86;
  assign io_mcr_write_0_bits = wData;
  assign io_mcr_write_1_valid = _GEN_87;
  assign io_mcr_write_1_bits = wData;
  assign io_mcr_write_2_valid = _GEN_88;
  assign io_mcr_write_3_valid = _GEN_89;
  assign io_mcr_write_4_valid = _GEN_90;
  assign io_mcr_write_4_bits = wData;
  assign io_mcr_write_5_valid = _GEN_91;
  assign io_mcr_write_6_valid = _GEN_92;
  assign io_mcr_write_7_valid = _GEN_93;
  assign io_mcr_write_8_valid = _GEN_94;
  assign io_mcr_write_9_valid = _GEN_95;
  assign io_mcr_write_10_valid = _GEN_96;
  assign io_mcr_write_11_valid = _GEN_97;
  assign _T_552 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_554 = io_nasti_aw_bits_addr[31:3];
  assign _GEN_6 = _T_552 ? 1'h1 : awFired;
  assign _GEN_7 = _T_552 ? _T_554 : {{25'd0}, wAddr};
  assign _T_560 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_560 ? 1'h1 : wFired;
  assign _GEN_10 = _T_560 ? io_nasti_w_bits_data : wData;
  assign _T_562 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_564 = io_nasti_ar_bits_addr[31:3];
  assign _T_565 = _T_564[3:0];
  assign _GEN_12 = _T_562 ? 1'h1 : arFired;
  assign _GEN_13 = _T_562 ? _T_565 : rAddr;
  assign _T_571 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_571 ? 1'h0 : _GEN_12;
  assign _T_573 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_573 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_573 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_573 ? 1'h0 : wCommited;
  assign _GEN_0_ready = _GEN_49;
  assign _GEN_20 = 4'h1 == wAddr ? io_mcr_write_1_valid : io_mcr_write_0_valid;
  assign _GEN_22 = 4'h2 == wAddr ? 1'h0 : 1'h1;
  assign _GEN_23 = 4'h2 == wAddr ? io_mcr_write_2_valid : _GEN_20;
  assign _GEN_25 = 4'h3 == wAddr ? 1'h0 : _GEN_22;
  assign _GEN_26 = 4'h3 == wAddr ? io_mcr_write_3_valid : _GEN_23;
  assign _GEN_28 = 4'h4 == wAddr ? io_mcr_write_4_ready : _GEN_25;
  assign _GEN_29 = 4'h4 == wAddr ? io_mcr_write_4_valid : _GEN_26;
  assign _GEN_31 = 4'h5 == wAddr ? 1'h0 : _GEN_28;
  assign _GEN_32 = 4'h5 == wAddr ? io_mcr_write_5_valid : _GEN_29;
  assign _GEN_34 = 4'h6 == wAddr ? 1'h0 : _GEN_31;
  assign _GEN_35 = 4'h6 == wAddr ? io_mcr_write_6_valid : _GEN_32;
  assign _GEN_37 = 4'h7 == wAddr ? 1'h0 : _GEN_34;
  assign _GEN_38 = 4'h7 == wAddr ? io_mcr_write_7_valid : _GEN_35;
  assign _GEN_40 = 4'h8 == wAddr ? 1'h0 : _GEN_37;
  assign _GEN_41 = 4'h8 == wAddr ? io_mcr_write_8_valid : _GEN_38;
  assign _GEN_43 = 4'h9 == wAddr ? 1'h0 : _GEN_40;
  assign _GEN_44 = 4'h9 == wAddr ? io_mcr_write_9_valid : _GEN_41;
  assign _GEN_46 = 4'ha == wAddr ? 1'h0 : _GEN_43;
  assign _GEN_47 = 4'ha == wAddr ? io_mcr_write_10_valid : _GEN_44;
  assign _GEN_49 = 4'hb == wAddr ? 1'h0 : _GEN_46;
  assign _GEN_50 = 4'hb == wAddr ? io_mcr_write_11_valid : _GEN_47;
  assign _GEN_1_valid = _GEN_50;
  assign _T_583 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_85 = _T_583 ? 1'h1 : _GEN_18;
  assign _T_615 = awFired & wFired;
  assign _T_616 = ~ wCommited;
  assign _T_617 = _T_615 & _T_616;
  assign _GEN_2 = _T_617;
  assign _GEN_86 = 4'h0 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_87 = 4'h1 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_88 = 4'h2 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_89 = 4'h3 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_90 = 4'h4 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_91 = 4'h5 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_92 = 4'h6 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_93 = 4'h7 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_94 = 4'h8 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_95 = 4'h9 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_96 = 4'ha == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_97 = 4'hb == wAddr ? _GEN_2 : 1'h0;
  assign _T_624 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_624;
  assign _GEN_100 = 4'h2 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_102 = 4'h4 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_103 = 4'h5 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_104 = 4'h6 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_106 = 4'h8 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_108 = 4'ha == rAddr ? _GEN_3 : 1'h0;
  assign _T_639_data = _GEN_4_bits;
  assign _GEN_4_bits = _GEN_142;
  assign _GEN_112 = 4'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_114 = 4'h2 == rAddr ? 1'h0 : 1'h1;
  assign _GEN_115 = 4'h2 == rAddr ? 64'h0 : _GEN_112;
  assign _GEN_117 = 4'h3 == rAddr ? 1'h0 : _GEN_114;
  assign _GEN_118 = 4'h3 == rAddr ? 64'h0 : _GEN_115;
  assign _GEN_120 = 4'h4 == rAddr ? 1'h0 : _GEN_117;
  assign _GEN_121 = 4'h4 == rAddr ? 64'h0 : _GEN_118;
  assign _GEN_123 = 4'h5 == rAddr ? io_mcr_read_5_valid : _GEN_120;
  assign _GEN_124 = 4'h5 == rAddr ? io_mcr_read_5_bits : _GEN_121;
  assign _GEN_126 = 4'h6 == rAddr ? 1'h0 : _GEN_123;
  assign _GEN_127 = 4'h6 == rAddr ? 64'h0 : _GEN_124;
  assign _GEN_129 = 4'h7 == rAddr ? 1'h0 : _GEN_126;
  assign _GEN_130 = 4'h7 == rAddr ? 64'h0 : _GEN_127;
  assign _GEN_132 = 4'h8 == rAddr ? 1'h0 : _GEN_129;
  assign _GEN_133 = 4'h8 == rAddr ? 64'h0 : _GEN_130;
  assign _GEN_135 = 4'h9 == rAddr ? 1'h0 : _GEN_132;
  assign _GEN_136 = 4'h9 == rAddr ? 64'h0 : _GEN_133;
  assign _GEN_138 = 4'ha == rAddr ? 1'h0 : _GEN_135;
  assign _GEN_139 = 4'ha == rAddr ? 64'h0 : _GEN_136;
  assign _GEN_141 = 4'hb == rAddr ? 1'h0 : _GEN_138;
  assign _GEN_142 = 4'hb == rAddr ? 64'h0 : _GEN_139;
  assign _GEN_5_valid = _GEN_141;
  assign _T_652 = arFired & _GEN_5_valid;
  assign _T_664 = _T_615 & wCommited;
  assign _T_665 = ~ arFired;
  assign _T_666 = ~ awFired;
  assign _T_667 = ~ wFired;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  arFired = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  awFired = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  wFired = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  wCommited = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{$random}};
  wData = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  wAddr = _RAND_5[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  rAddr = _RAND_6[3:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_571) begin
        arFired <= 1'h0;
      end else begin
        if (_T_562) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_573) begin
        awFired <= 1'h0;
      end else begin
        if (_T_552) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_573) begin
        wFired <= 1'h0;
      end else begin
        if (_T_560) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_583) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_573) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_560) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[3:0];
    if (_T_562) begin
      rAddr <= _T_565;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:315 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:328 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module DaisyController(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  input         io_daisy_regs_0_in_ready,
  output        io_daisy_regs_0_in_valid,
  output [63:0] io_daisy_regs_0_in_bits,
  output        io_daisy_regs_0_out_ready,
  input         io_daisy_regs_0_out_valid,
  input  [63:0] io_daisy_regs_0_out_bits
);
  reg  SRAM_RESTART_0;
  reg [31:0] _RAND_0;
  wire  _GEN_0;
  reg  REGFILE_RESTART_0;
  reg [31:0] _RAND_1;
  wire  _GEN_1;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [63:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [63:0] MCRFile_io_nasti_r_bits_data;
  wire [63:0] MCRFile_io_mcr_read_0_bits;
  wire [63:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_4_ready;
  wire  MCRFile_io_mcr_read_5_ready;
  wire  MCRFile_io_mcr_read_5_valid;
  wire [63:0] MCRFile_io_mcr_read_5_bits;
  wire  MCRFile_io_mcr_read_6_ready;
  wire  MCRFile_io_mcr_read_8_ready;
  wire  MCRFile_io_mcr_read_10_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [63:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [63:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire  MCRFile_io_mcr_write_3_valid;
  wire  MCRFile_io_mcr_write_4_ready;
  wire  MCRFile_io_mcr_write_4_valid;
  wire [63:0] MCRFile_io_mcr_write_4_bits;
  wire  MCRFile_io_mcr_write_5_valid;
  wire  MCRFile_io_mcr_write_6_valid;
  wire  MCRFile_io_mcr_write_7_valid;
  wire  MCRFile_io_mcr_write_8_valid;
  wire  MCRFile_io_mcr_write_9_valid;
  wire  MCRFile_io_mcr_write_10_valid;
  wire  MCRFile_io_mcr_write_11_valid;
  wire [63:0] _GEN_2;
  wire [63:0] _GEN_3;
  wire  _T_1109;
  wire  _T_1110;
  wire  _T_1112;
  wire  _T_1114;
  wire  _T_1115;
  wire  _T_1117;
  wire  _T_1119;
  wire  _T_1120;
  wire  _T_1122;
  wire  _T_1124;
  wire  _T_1125;
  wire  _T_1127;
  wire  _T_1129;
  wire  _T_1130;
  wire  _T_1132;
  wire  _T_1134;
  wire  _T_1135;
  wire  _T_1137;
  wire  _T_1139;
  wire  _T_1140;
  wire  _T_1142;
  wire  _T_1144;
  wire  _T_1145;
  wire  _T_1147;
  wire  _T_1149;
  wire  _T_1150;
  wire  _T_1152;
  wire  _T_1154;
  wire  _T_1155;
  wire  _T_1157;
  MCRFile_2 MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_mcr_read_0_bits(MCRFile_io_mcr_read_0_bits),
    .io_mcr_read_1_bits(MCRFile_io_mcr_read_1_bits),
    .io_mcr_read_2_ready(MCRFile_io_mcr_read_2_ready),
    .io_mcr_read_4_ready(MCRFile_io_mcr_read_4_ready),
    .io_mcr_read_5_ready(MCRFile_io_mcr_read_5_ready),
    .io_mcr_read_5_valid(MCRFile_io_mcr_read_5_valid),
    .io_mcr_read_5_bits(MCRFile_io_mcr_read_5_bits),
    .io_mcr_read_6_ready(MCRFile_io_mcr_read_6_ready),
    .io_mcr_read_8_ready(MCRFile_io_mcr_read_8_ready),
    .io_mcr_read_10_ready(MCRFile_io_mcr_read_10_ready),
    .io_mcr_write_0_valid(MCRFile_io_mcr_write_0_valid),
    .io_mcr_write_0_bits(MCRFile_io_mcr_write_0_bits),
    .io_mcr_write_1_valid(MCRFile_io_mcr_write_1_valid),
    .io_mcr_write_1_bits(MCRFile_io_mcr_write_1_bits),
    .io_mcr_write_2_valid(MCRFile_io_mcr_write_2_valid),
    .io_mcr_write_3_valid(MCRFile_io_mcr_write_3_valid),
    .io_mcr_write_4_ready(MCRFile_io_mcr_write_4_ready),
    .io_mcr_write_4_valid(MCRFile_io_mcr_write_4_valid),
    .io_mcr_write_4_bits(MCRFile_io_mcr_write_4_bits),
    .io_mcr_write_5_valid(MCRFile_io_mcr_write_5_valid),
    .io_mcr_write_6_valid(MCRFile_io_mcr_write_6_valid),
    .io_mcr_write_7_valid(MCRFile_io_mcr_write_7_valid),
    .io_mcr_write_8_valid(MCRFile_io_mcr_write_8_valid),
    .io_mcr_write_9_valid(MCRFile_io_mcr_write_9_valid),
    .io_mcr_write_10_valid(MCRFile_io_mcr_write_10_valid),
    .io_mcr_write_11_valid(MCRFile_io_mcr_write_11_valid)
  );
  assign io_ctrl_aw_ready = MCRFile_io_nasti_aw_ready;
  assign io_ctrl_w_ready = MCRFile_io_nasti_w_ready;
  assign io_ctrl_b_valid = MCRFile_io_nasti_b_valid;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_daisy_regs_0_in_valid = MCRFile_io_mcr_write_4_valid;
  assign io_daisy_regs_0_in_bits = MCRFile_io_mcr_write_4_bits;
  assign io_daisy_regs_0_out_ready = MCRFile_io_mcr_read_5_ready;
  assign _GEN_0 = SRAM_RESTART_0 ? 1'h0 : SRAM_RESTART_0;
  assign _GEN_1 = REGFILE_RESTART_0 ? 1'h0 : REGFILE_RESTART_0;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_bits = {{63'd0}, SRAM_RESTART_0};
  assign MCRFile_io_mcr_read_1_bits = {{63'd0}, REGFILE_RESTART_0};
  assign MCRFile_io_mcr_read_5_valid = io_daisy_regs_0_out_valid;
  assign MCRFile_io_mcr_read_5_bits = io_daisy_regs_0_out_bits;
  assign MCRFile_io_mcr_write_4_ready = io_daisy_regs_0_in_ready;
  assign _GEN_2 = MCRFile_io_mcr_write_0_valid ? MCRFile_io_mcr_write_0_bits : {{63'd0}, _GEN_0};
  assign _GEN_3 = MCRFile_io_mcr_write_1_valid ? MCRFile_io_mcr_write_1_bits : {{63'd0}, _GEN_1};
  assign _T_1109 = MCRFile_io_mcr_read_2_ready == 1'h0;
  assign _T_1110 = _T_1109 | reset;
  assign _T_1112 = _T_1110 == 1'h0;
  assign _T_1114 = MCRFile_io_mcr_write_3_valid != 1'h1;
  assign _T_1115 = _T_1114 | reset;
  assign _T_1117 = _T_1115 == 1'h0;
  assign _T_1119 = MCRFile_io_mcr_read_4_ready == 1'h0;
  assign _T_1120 = _T_1119 | reset;
  assign _T_1122 = _T_1120 == 1'h0;
  assign _T_1124 = MCRFile_io_mcr_write_5_valid != 1'h1;
  assign _T_1125 = _T_1124 | reset;
  assign _T_1127 = _T_1125 == 1'h0;
  assign _T_1129 = MCRFile_io_mcr_read_6_ready == 1'h0;
  assign _T_1130 = _T_1129 | reset;
  assign _T_1132 = _T_1130 == 1'h0;
  assign _T_1134 = MCRFile_io_mcr_write_7_valid != 1'h1;
  assign _T_1135 = _T_1134 | reset;
  assign _T_1137 = _T_1135 == 1'h0;
  assign _T_1139 = MCRFile_io_mcr_read_8_ready == 1'h0;
  assign _T_1140 = _T_1139 | reset;
  assign _T_1142 = _T_1140 == 1'h0;
  assign _T_1144 = MCRFile_io_mcr_write_9_valid != 1'h1;
  assign _T_1145 = _T_1144 | reset;
  assign _T_1147 = _T_1145 == 1'h0;
  assign _T_1149 = MCRFile_io_mcr_read_10_ready == 1'h0;
  assign _T_1150 = _T_1149 | reset;
  assign _T_1152 = _T_1150 == 1'h0;
  assign _T_1154 = MCRFile_io_mcr_write_11_valid != 1'h1;
  assign _T_1155 = _T_1154 | reset;
  assign _T_1157 = _T_1155 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  SRAM_RESTART_0 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  REGFILE_RESTART_0 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      SRAM_RESTART_0 <= 1'h0;
    end else begin
      SRAM_RESTART_0 <= _GEN_2[0];
    end
    if (reset) begin
      REGFILE_RESTART_0 <= 1'h0;
    end else begin
      REGFILE_RESTART_0 <= _GEN_3[0];
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1112) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1112) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1117) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1117) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1122) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1122) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1127) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1127) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1132) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1132) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1137) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1137) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1142) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1142) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1147) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1147) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1152) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1152) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1157) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1157) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module MCRFile_3(
  input         clock,
  input         reset,
  output        io_nasti_aw_ready,
  input         io_nasti_aw_valid,
  input  [31:0] io_nasti_aw_bits_addr,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [63:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [63:0] io_nasti_r_bits_data,
  output        io_nasti_r_bits_last,
  output        io_mcr_read_0_ready,
  input         io_mcr_read_0_valid,
  input  [63:0] io_mcr_read_0_bits,
  output        io_mcr_read_1_ready,
  input         io_mcr_read_1_valid,
  input  [63:0] io_mcr_read_1_bits,
  output        io_mcr_read_2_ready,
  input         io_mcr_read_2_valid,
  input  [63:0] io_mcr_read_2_bits,
  output        io_mcr_read_3_ready,
  input         io_mcr_read_3_valid,
  input  [63:0] io_mcr_read_3_bits,
  input         io_mcr_write_0_ready,
  output        io_mcr_write_0_valid,
  output [63:0] io_mcr_write_0_bits,
  input         io_mcr_write_1_ready,
  output        io_mcr_write_1_valid,
  output [63:0] io_mcr_write_1_bits,
  input         io_mcr_write_2_ready,
  output        io_mcr_write_2_valid,
  output [63:0] io_mcr_write_2_bits,
  input         io_mcr_write_3_ready,
  output        io_mcr_write_3_valid,
  output [63:0] io_mcr_write_3_bits
);
  reg  arFired;
  reg [31:0] _RAND_0;
  reg  awFired;
  reg [31:0] _RAND_1;
  reg  wFired;
  reg [31:0] _RAND_2;
  reg  wCommited;
  reg [31:0] _RAND_3;
  reg [63:0] wData;
  reg [63:0] _RAND_4;
  reg [1:0] wAddr;
  reg [31:0] _RAND_5;
  reg [1:0] rAddr;
  reg [31:0] _RAND_6;
  wire  _T_456;
  wire [28:0] _T_458;
  wire  _GEN_6;
  wire [28:0] _GEN_7;
  wire  _T_464;
  wire  _GEN_9;
  wire [63:0] _GEN_10;
  wire  _T_466;
  wire [28:0] _T_468;
  wire [1:0] _T_469;
  wire  _GEN_12;
  wire [1:0] _GEN_13;
  wire  _T_475;
  wire  _GEN_15;
  wire  _T_477;
  wire  _GEN_16;
  wire  _GEN_17;
  wire  _GEN_18;
  wire  _GEN_0_ready;
  wire  _GEN_19;
  wire  _GEN_20;
  wire  _GEN_22;
  wire  _GEN_23;
  wire  _GEN_25;
  wire  _GEN_26;
  wire  _GEN_1_valid;
  wire  _T_487;
  wire  _GEN_37;
  wire  _T_503;
  wire  _T_504;
  wire  _T_505;
  wire  _GEN_2;
  wire  _GEN_38;
  wire  _GEN_39;
  wire  _GEN_40;
  wire  _GEN_41;
  wire  _T_512;
  wire  _GEN_3;
  wire  _GEN_42;
  wire  _GEN_43;
  wire  _GEN_44;
  wire  _GEN_45;
  wire [63:0] _T_527_data;
  wire [63:0] _GEN_4_bits;
  wire  _GEN_47;
  wire [63:0] _GEN_48;
  wire  _GEN_50;
  wire [63:0] _GEN_51;
  wire  _GEN_53;
  wire [63:0] _GEN_54;
  wire  _GEN_5_valid;
  wire  _T_540;
  wire  _T_552;
  wire  _T_553;
  wire  _T_554;
  wire  _T_555;
  assign io_nasti_aw_ready = _T_554;
  assign io_nasti_w_ready = _T_555;
  assign io_nasti_b_valid = _T_552;
  assign io_nasti_ar_ready = _T_553;
  assign io_nasti_r_valid = _T_540;
  assign io_nasti_r_bits_data = _T_527_data;
  assign io_nasti_r_bits_last = 1'h1;
  assign io_mcr_read_0_ready = _GEN_42;
  assign io_mcr_read_1_ready = _GEN_43;
  assign io_mcr_read_2_ready = _GEN_44;
  assign io_mcr_read_3_ready = _GEN_45;
  assign io_mcr_write_0_valid = _GEN_38;
  assign io_mcr_write_0_bits = wData;
  assign io_mcr_write_1_valid = _GEN_39;
  assign io_mcr_write_1_bits = wData;
  assign io_mcr_write_2_valid = _GEN_40;
  assign io_mcr_write_2_bits = wData;
  assign io_mcr_write_3_valid = _GEN_41;
  assign io_mcr_write_3_bits = wData;
  assign _T_456 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_458 = io_nasti_aw_bits_addr[31:3];
  assign _GEN_6 = _T_456 ? 1'h1 : awFired;
  assign _GEN_7 = _T_456 ? _T_458 : {{27'd0}, wAddr};
  assign _T_464 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_464 ? 1'h1 : wFired;
  assign _GEN_10 = _T_464 ? io_nasti_w_bits_data : wData;
  assign _T_466 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_468 = io_nasti_ar_bits_addr[31:3];
  assign _T_469 = _T_468[1:0];
  assign _GEN_12 = _T_466 ? 1'h1 : arFired;
  assign _GEN_13 = _T_466 ? _T_469 : rAddr;
  assign _T_475 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_475 ? 1'h0 : _GEN_12;
  assign _T_477 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_477 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_477 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_477 ? 1'h0 : wCommited;
  assign _GEN_0_ready = _GEN_25;
  assign _GEN_19 = 2'h1 == wAddr ? io_mcr_write_1_ready : io_mcr_write_0_ready;
  assign _GEN_20 = 2'h1 == wAddr ? io_mcr_write_1_valid : io_mcr_write_0_valid;
  assign _GEN_22 = 2'h2 == wAddr ? io_mcr_write_2_ready : _GEN_19;
  assign _GEN_23 = 2'h2 == wAddr ? io_mcr_write_2_valid : _GEN_20;
  assign _GEN_25 = 2'h3 == wAddr ? io_mcr_write_3_ready : _GEN_22;
  assign _GEN_26 = 2'h3 == wAddr ? io_mcr_write_3_valid : _GEN_23;
  assign _GEN_1_valid = _GEN_26;
  assign _T_487 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_37 = _T_487 ? 1'h1 : _GEN_18;
  assign _T_503 = awFired & wFired;
  assign _T_504 = ~ wCommited;
  assign _T_505 = _T_503 & _T_504;
  assign _GEN_2 = _T_505;
  assign _GEN_38 = 2'h0 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_39 = 2'h1 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_40 = 2'h2 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_41 = 2'h3 == wAddr ? _GEN_2 : 1'h0;
  assign _T_512 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_512;
  assign _GEN_42 = 2'h0 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_43 = 2'h1 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_44 = 2'h2 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_45 = 2'h3 == rAddr ? _GEN_3 : 1'h0;
  assign _T_527_data = _GEN_4_bits;
  assign _GEN_4_bits = _GEN_54;
  assign _GEN_47 = 2'h1 == rAddr ? io_mcr_read_1_valid : io_mcr_read_0_valid;
  assign _GEN_48 = 2'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_50 = 2'h2 == rAddr ? io_mcr_read_2_valid : _GEN_47;
  assign _GEN_51 = 2'h2 == rAddr ? io_mcr_read_2_bits : _GEN_48;
  assign _GEN_53 = 2'h3 == rAddr ? io_mcr_read_3_valid : _GEN_50;
  assign _GEN_54 = 2'h3 == rAddr ? io_mcr_read_3_bits : _GEN_51;
  assign _GEN_5_valid = _GEN_53;
  assign _T_540 = arFired & _GEN_5_valid;
  assign _T_552 = _T_503 & wCommited;
  assign _T_553 = ~ arFired;
  assign _T_554 = ~ awFired;
  assign _T_555 = ~ wFired;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  arFired = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  awFired = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  wFired = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  wCommited = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{$random}};
  wData = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  wAddr = _RAND_5[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  rAddr = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_475) begin
        arFired <= 1'h0;
      end else begin
        if (_T_466) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_477) begin
        awFired <= 1'h0;
      end else begin
        if (_T_456) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_477) begin
        wFired <= 1'h0;
      end else begin
        if (_T_464) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_487) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_477) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_464) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[1:0];
    if (_T_466) begin
      rAddr <= _T_469;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:315 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (1'h0) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:328 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (1'h0) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module IOTraceWidget(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  output [63:0] io_traceLen,
  output        io_wireIns_0_ready,
  input         io_wireIns_0_valid,
  input  [63:0] io_wireIns_0_bits,
  output        io_wireIns_1_ready,
  input         io_wireIns_1_valid,
  input  [63:0] io_wireIns_1_bits,
  output        io_wireOuts_0_ready,
  input         io_wireOuts_0_valid,
  input  [63:0] io_wireOuts_0_bits
);
  reg [63:0] traceLen;
  reg [63:0] _RAND_0;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [63:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [63:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire  MCRFile_io_mcr_read_0_ready;
  wire  MCRFile_io_mcr_read_0_valid;
  wire [63:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [63:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_2_valid;
  wire [63:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_read_3_ready;
  wire  MCRFile_io_mcr_read_3_valid;
  wire [63:0] MCRFile_io_mcr_read_3_bits;
  wire  MCRFile_io_mcr_write_0_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [63:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [63:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_ready;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [63:0] MCRFile_io_mcr_write_2_bits;
  wire  MCRFile_io_mcr_write_3_ready;
  wire  MCRFile_io_mcr_write_3_valid;
  wire [63:0] MCRFile_io_mcr_write_3_bits;
  wire  _T_481;
  wire  _T_482;
  wire  _T_484;
  wire  _T_486;
  wire  _T_487;
  wire  _T_489;
  wire  _T_491;
  wire  _T_492;
  wire  _T_494;
  wire [63:0] _GEN_0;
  MCRFile_3 MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_mcr_read_0_ready(MCRFile_io_mcr_read_0_ready),
    .io_mcr_read_0_valid(MCRFile_io_mcr_read_0_valid),
    .io_mcr_read_0_bits(MCRFile_io_mcr_read_0_bits),
    .io_mcr_read_1_ready(MCRFile_io_mcr_read_1_ready),
    .io_mcr_read_1_valid(MCRFile_io_mcr_read_1_valid),
    .io_mcr_read_1_bits(MCRFile_io_mcr_read_1_bits),
    .io_mcr_read_2_ready(MCRFile_io_mcr_read_2_ready),
    .io_mcr_read_2_valid(MCRFile_io_mcr_read_2_valid),
    .io_mcr_read_2_bits(MCRFile_io_mcr_read_2_bits),
    .io_mcr_read_3_ready(MCRFile_io_mcr_read_3_ready),
    .io_mcr_read_3_valid(MCRFile_io_mcr_read_3_valid),
    .io_mcr_read_3_bits(MCRFile_io_mcr_read_3_bits),
    .io_mcr_write_0_ready(MCRFile_io_mcr_write_0_ready),
    .io_mcr_write_0_valid(MCRFile_io_mcr_write_0_valid),
    .io_mcr_write_0_bits(MCRFile_io_mcr_write_0_bits),
    .io_mcr_write_1_ready(MCRFile_io_mcr_write_1_ready),
    .io_mcr_write_1_valid(MCRFile_io_mcr_write_1_valid),
    .io_mcr_write_1_bits(MCRFile_io_mcr_write_1_bits),
    .io_mcr_write_2_ready(MCRFile_io_mcr_write_2_ready),
    .io_mcr_write_2_valid(MCRFile_io_mcr_write_2_valid),
    .io_mcr_write_2_bits(MCRFile_io_mcr_write_2_bits),
    .io_mcr_write_3_ready(MCRFile_io_mcr_write_3_ready),
    .io_mcr_write_3_valid(MCRFile_io_mcr_write_3_valid),
    .io_mcr_write_3_bits(MCRFile_io_mcr_write_3_bits)
  );
  assign io_ctrl_aw_ready = MCRFile_io_nasti_aw_ready;
  assign io_ctrl_w_ready = MCRFile_io_nasti_w_ready;
  assign io_ctrl_b_valid = MCRFile_io_nasti_b_valid;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_traceLen = traceLen;
  assign io_wireIns_0_ready = MCRFile_io_mcr_read_0_ready;
  assign io_wireIns_1_ready = MCRFile_io_mcr_read_1_ready;
  assign io_wireOuts_0_ready = MCRFile_io_mcr_read_2_ready;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_valid = io_wireIns_0_valid;
  assign MCRFile_io_mcr_read_0_bits = io_wireIns_0_bits;
  assign MCRFile_io_mcr_read_1_valid = io_wireIns_1_valid;
  assign MCRFile_io_mcr_read_1_bits = io_wireIns_1_bits;
  assign MCRFile_io_mcr_read_2_valid = io_wireOuts_0_valid;
  assign MCRFile_io_mcr_read_2_bits = io_wireOuts_0_bits;
  assign MCRFile_io_mcr_read_3_valid = 1'h1;
  assign MCRFile_io_mcr_read_3_bits = traceLen;
  assign MCRFile_io_mcr_write_0_ready = 1'h0;
  assign MCRFile_io_mcr_write_1_ready = 1'h0;
  assign MCRFile_io_mcr_write_2_ready = 1'h0;
  assign MCRFile_io_mcr_write_3_ready = 1'h1;
  assign _T_481 = MCRFile_io_mcr_write_0_valid != 1'h1;
  assign _T_482 = _T_481 | reset;
  assign _T_484 = _T_482 == 1'h0;
  assign _T_486 = MCRFile_io_mcr_write_1_valid != 1'h1;
  assign _T_487 = _T_486 | reset;
  assign _T_489 = _T_487 == 1'h0;
  assign _T_491 = MCRFile_io_mcr_write_2_valid != 1'h1;
  assign _T_492 = _T_491 | reset;
  assign _T_494 = _T_492 == 1'h0;
  assign _GEN_0 = MCRFile_io_mcr_write_3_valid ? MCRFile_io_mcr_write_3_bits : traceLen;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{$random}};
  traceLen = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      traceLen <= 64'h80;
    end else begin
      if (MCRFile_io_mcr_write_3_valid) begin
        traceLen <= MCRFile_io_mcr_write_3_bits;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_484) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_484) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_489) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_489) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_494) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_494) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module NastiArbiter(
  output        io_master_0_aw_ready,
  input         io_master_0_aw_valid,
  input  [31:0] io_master_0_aw_bits_addr,
  output        io_master_0_w_ready,
  input         io_master_0_w_valid,
  input  [63:0] io_master_0_w_bits_data,
  output        io_master_0_ar_ready,
  input         io_master_0_ar_valid,
  input  [31:0] io_master_0_ar_bits_addr,
  input         io_master_0_r_ready,
  output        io_master_0_r_valid,
  input         io_slave_aw_ready,
  output        io_slave_aw_valid,
  output [31:0] io_slave_aw_bits_addr,
  input         io_slave_w_ready,
  output        io_slave_w_valid,
  output [63:0] io_slave_w_bits_data,
  input         io_slave_ar_ready,
  output        io_slave_ar_valid,
  output [31:0] io_slave_ar_bits_addr,
  output        io_slave_r_ready,
  input         io_slave_r_valid
);
  assign io_master_0_aw_ready = io_slave_aw_ready;
  assign io_master_0_w_ready = io_slave_w_ready;
  assign io_master_0_ar_ready = io_slave_ar_ready;
  assign io_master_0_r_valid = io_slave_r_valid;
  assign io_slave_aw_valid = io_master_0_aw_valid;
  assign io_slave_aw_bits_addr = io_master_0_aw_bits_addr;
  assign io_slave_w_valid = io_master_0_w_valid;
  assign io_slave_w_bits_data = io_master_0_w_bits_data;
  assign io_slave_ar_valid = io_master_0_ar_valid;
  assign io_slave_ar_bits_addr = io_master_0_ar_bits_addr;
  assign io_slave_r_ready = io_master_0_r_ready;
endmodule
module Queue_1_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
  reg [31:0] ram [0:1];
  reg [31:0] _RAND_0;
  wire [31:0] ram__T_50_data;
  wire  ram__T_50_addr;
  wire [31:0] ram__T_36_data;
  wire  ram__T_36_addr;
  wire  ram__T_36_mask;
  wire  ram__T_36_en;
  reg  value;
  reg [31:0] _RAND_1;
  reg  value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_29;
  wire  _T_31;
  wire  _T_32;
  wire  _T_33;
  wire  _T_34;
  wire  do_enq;
  wire  _T_35;
  wire  do_deq;
  wire [1:0] _T_39;
  wire  _T_40;
  wire  _GEN_4;
  wire [1:0] _T_43;
  wire  _T_44;
  wire  _GEN_5;
  wire  _T_45;
  wire  _GEN_6;
  wire  _T_47;
  wire  _T_49;
  assign io_enq_ready = _T_49;
  assign io_deq_valid = _T_47;
  assign io_deq_bits = ram__T_50_data;
  assign ram__T_50_addr = value_1;
  assign ram__T_50_data = ram[ram__T_50_addr];
  assign ram__T_36_data = io_enq_bits;
  assign ram__T_36_addr = value;
  assign ram__T_36_mask = do_enq;
  assign ram__T_36_en = do_enq;
  assign _T_29 = value == value_1;
  assign _T_31 = maybe_full == 1'h0;
  assign _T_32 = _T_29 & _T_31;
  assign _T_33 = _T_29 & maybe_full;
  assign _T_34 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_34;
  assign _T_35 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_35;
  assign _T_39 = value + 1'h1;
  assign _T_40 = _T_39[0:0];
  assign _GEN_4 = do_enq ? _T_40 : value;
  assign _T_43 = value_1 + 1'h1;
  assign _T_44 = _T_43[0:0];
  assign _GEN_5 = do_deq ? _T_44 : value_1;
  assign _T_45 = do_enq != do_deq;
  assign _GEN_6 = _T_45 ? do_enq : maybe_full;
  assign _T_47 = _T_32 == 1'h0;
  assign _T_49 = _T_33 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value_1 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_36_en & ram__T_36_mask) begin
      ram[ram__T_36_addr] <= ram__T_36_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_40;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_44;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_45) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module MultiWidthFifo(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [63:0] io_in_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  wire  Queue_clock;
  wire  Queue_reset;
  wire  Queue_io_enq_ready;
  wire  Queue_io_enq_valid;
  wire [63:0] Queue_io_enq_bits;
  wire  Queue_io_deq_ready;
  wire  Queue_io_deq_valid;
  wire [63:0] Queue_io_deq_bits;
  Queue_0 Queue (
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  assign io_in_ready = Queue_io_enq_ready;
  assign io_out_valid = Queue_io_deq_valid;
  assign io_out_bits = Queue_io_deq_bits;
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = io_in_valid;
  assign Queue_io_enq_bits = io_in_bits;
  assign Queue_io_deq_ready = io_out_ready;
endmodule
module LoadMemWidget(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  output        io_ctrl_r_bits_last,
  input         io_toSlaveMem_aw_ready,
  output        io_toSlaveMem_aw_valid,
  output [31:0] io_toSlaveMem_aw_bits_addr,
  input         io_toSlaveMem_w_ready,
  output        io_toSlaveMem_w_valid,
  output [63:0] io_toSlaveMem_w_bits_data,
  input         io_toSlaveMem_ar_ready,
  output        io_toSlaveMem_ar_valid,
  output [31:0] io_toSlaveMem_ar_bits_addr,
  output        io_toSlaveMem_r_ready,
  input         io_toSlaveMem_r_valid
);
  wire  wAddrQ_ready;
  wire  wAddrQ_valid;
  wire [31:0] wAddrQ_bits;
  wire  _T_584_ready;
  wire  _T_584_valid;
  wire [31:0] _T_584_bits;
  wire  Queue_clock;
  wire  Queue_reset;
  wire  Queue_io_enq_ready;
  wire  Queue_io_enq_valid;
  wire [31:0] Queue_io_enq_bits;
  wire  Queue_io_deq_ready;
  wire  Queue_io_deq_valid;
  wire [31:0] Queue_io_deq_bits;
  wire [31:0] _T_607_addr;
  wire  wDataQ_clock;
  wire  wDataQ_reset;
  wire  wDataQ_io_in_ready;
  wire  wDataQ_io_in_valid;
  wire [63:0] wDataQ_io_in_bits;
  wire  wDataQ_io_out_ready;
  wire  wDataQ_io_out_valid;
  wire [63:0] wDataQ_io_out_bits;
  wire [63:0] _T_637_data;
  wire  rAddrQ_ready;
  wire  rAddrQ_valid;
  wire [31:0] rAddrQ_bits;
  wire  _T_671_ready;
  wire  _T_671_valid;
  wire [31:0] _T_671_bits;
  wire  Queue_1_clock;
  wire  Queue_1_reset;
  wire  Queue_1_io_enq_ready;
  wire  Queue_1_io_enq_valid;
  wire [31:0] Queue_1_io_enq_bits;
  wire  Queue_1_io_deq_ready;
  wire  Queue_1_io_deq_valid;
  wire [31:0] Queue_1_io_deq_bits;
  wire [31:0] _T_694_addr;
  wire  rDataQ_clock;
  wire  rDataQ_reset;
  wire  rDataQ_io_in_ready;
  wire  rDataQ_io_in_valid;
  wire [63:0] rDataQ_io_in_bits;
  wire  rDataQ_io_out_ready;
  wire  rDataQ_io_out_valid;
  wire [63:0] rDataQ_io_out_bits;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [63:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [63:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire  MCRFile_io_mcr_read_0_ready;
  wire  MCRFile_io_mcr_read_0_valid;
  wire [63:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [63:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_2_valid;
  wire [63:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_read_3_ready;
  wire  MCRFile_io_mcr_read_3_valid;
  wire [63:0] MCRFile_io_mcr_read_3_bits;
  wire  MCRFile_io_mcr_write_0_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [63:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [63:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_ready;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [63:0] MCRFile_io_mcr_write_2_bits;
  wire  MCRFile_io_mcr_write_3_ready;
  wire  MCRFile_io_mcr_write_3_valid;
  wire [63:0] MCRFile_io_mcr_write_3_bits;
  wire  _T_717;
  wire  _T_718;
  wire  _T_720;
  wire  _T_722;
  wire  _T_723;
  wire  _T_725;
  wire  _T_727;
  wire  _T_728;
  wire  _T_730;
  wire  _T_732;
  wire  _T_733;
  wire  _T_735;
  Queue_1_1 Queue (
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  MultiWidthFifo wDataQ (
    .clock(wDataQ_clock),
    .reset(wDataQ_reset),
    .io_in_ready(wDataQ_io_in_ready),
    .io_in_valid(wDataQ_io_in_valid),
    .io_in_bits(wDataQ_io_in_bits),
    .io_out_ready(wDataQ_io_out_ready),
    .io_out_valid(wDataQ_io_out_valid),
    .io_out_bits(wDataQ_io_out_bits)
  );
  Queue_1_1 Queue_1 (
    .clock(Queue_1_clock),
    .reset(Queue_1_reset),
    .io_enq_ready(Queue_1_io_enq_ready),
    .io_enq_valid(Queue_1_io_enq_valid),
    .io_enq_bits(Queue_1_io_enq_bits),
    .io_deq_ready(Queue_1_io_deq_ready),
    .io_deq_valid(Queue_1_io_deq_valid),
    .io_deq_bits(Queue_1_io_deq_bits)
  );
  MultiWidthFifo rDataQ (
    .clock(rDataQ_clock),
    .reset(rDataQ_reset),
    .io_in_ready(rDataQ_io_in_ready),
    .io_in_valid(rDataQ_io_in_valid),
    .io_in_bits(rDataQ_io_in_bits),
    .io_out_ready(rDataQ_io_out_ready),
    .io_out_valid(rDataQ_io_out_valid),
    .io_out_bits(rDataQ_io_out_bits)
  );
  MCRFile_3 MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_mcr_read_0_ready(MCRFile_io_mcr_read_0_ready),
    .io_mcr_read_0_valid(MCRFile_io_mcr_read_0_valid),
    .io_mcr_read_0_bits(MCRFile_io_mcr_read_0_bits),
    .io_mcr_read_1_ready(MCRFile_io_mcr_read_1_ready),
    .io_mcr_read_1_valid(MCRFile_io_mcr_read_1_valid),
    .io_mcr_read_1_bits(MCRFile_io_mcr_read_1_bits),
    .io_mcr_read_2_ready(MCRFile_io_mcr_read_2_ready),
    .io_mcr_read_2_valid(MCRFile_io_mcr_read_2_valid),
    .io_mcr_read_2_bits(MCRFile_io_mcr_read_2_bits),
    .io_mcr_read_3_ready(MCRFile_io_mcr_read_3_ready),
    .io_mcr_read_3_valid(MCRFile_io_mcr_read_3_valid),
    .io_mcr_read_3_bits(MCRFile_io_mcr_read_3_bits),
    .io_mcr_write_0_ready(MCRFile_io_mcr_write_0_ready),
    .io_mcr_write_0_valid(MCRFile_io_mcr_write_0_valid),
    .io_mcr_write_0_bits(MCRFile_io_mcr_write_0_bits),
    .io_mcr_write_1_ready(MCRFile_io_mcr_write_1_ready),
    .io_mcr_write_1_valid(MCRFile_io_mcr_write_1_valid),
    .io_mcr_write_1_bits(MCRFile_io_mcr_write_1_bits),
    .io_mcr_write_2_ready(MCRFile_io_mcr_write_2_ready),
    .io_mcr_write_2_valid(MCRFile_io_mcr_write_2_valid),
    .io_mcr_write_2_bits(MCRFile_io_mcr_write_2_bits),
    .io_mcr_write_3_ready(MCRFile_io_mcr_write_3_ready),
    .io_mcr_write_3_valid(MCRFile_io_mcr_write_3_valid),
    .io_mcr_write_3_bits(MCRFile_io_mcr_write_3_bits)
  );
  assign io_ctrl_aw_ready = MCRFile_io_nasti_aw_ready;
  assign io_ctrl_w_ready = MCRFile_io_nasti_w_ready;
  assign io_ctrl_b_valid = MCRFile_io_nasti_b_valid;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_last = MCRFile_io_nasti_r_bits_last;
  assign io_toSlaveMem_aw_valid = wAddrQ_valid;
  assign io_toSlaveMem_aw_bits_addr = _T_607_addr;
  assign io_toSlaveMem_w_valid = wDataQ_io_out_valid;
  assign io_toSlaveMem_w_bits_data = _T_637_data;
  assign io_toSlaveMem_ar_valid = rAddrQ_valid;
  assign io_toSlaveMem_ar_bits_addr = _T_694_addr;
  assign io_toSlaveMem_r_ready = rDataQ_io_in_ready;
  assign wAddrQ_ready = io_toSlaveMem_aw_ready;
  assign wAddrQ_valid = Queue_io_deq_valid;
  assign wAddrQ_bits = Queue_io_deq_bits;
  assign _T_584_ready = Queue_io_enq_ready;
  assign _T_584_valid = MCRFile_io_mcr_write_0_valid;
  assign _T_584_bits = MCRFile_io_mcr_write_0_bits[31:0];
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = _T_584_valid;
  assign Queue_io_enq_bits = _T_584_bits;
  assign Queue_io_deq_ready = wAddrQ_ready;
  assign _T_607_addr = wAddrQ_bits;
  assign wDataQ_clock = clock;
  assign wDataQ_reset = reset;
  assign wDataQ_io_in_valid = MCRFile_io_mcr_write_1_valid;
  assign wDataQ_io_in_bits = MCRFile_io_mcr_write_1_bits;
  assign wDataQ_io_out_ready = io_toSlaveMem_w_ready;
  assign _T_637_data = wDataQ_io_out_bits;
  assign rAddrQ_ready = io_toSlaveMem_ar_ready;
  assign rAddrQ_valid = Queue_1_io_deq_valid;
  assign rAddrQ_bits = Queue_1_io_deq_bits;
  assign _T_671_ready = Queue_1_io_enq_ready;
  assign _T_671_valid = MCRFile_io_mcr_write_2_valid;
  assign _T_671_bits = MCRFile_io_mcr_write_2_bits[31:0];
  assign Queue_1_clock = clock;
  assign Queue_1_reset = reset;
  assign Queue_1_io_enq_valid = _T_671_valid;
  assign Queue_1_io_enq_bits = _T_671_bits;
  assign Queue_1_io_deq_ready = rAddrQ_ready;
  assign _T_694_addr = rAddrQ_bits;
  assign rDataQ_clock = clock;
  assign rDataQ_reset = reset;
  assign rDataQ_io_in_valid = io_toSlaveMem_r_valid;
  assign rDataQ_io_in_bits = 64'h0;
  assign rDataQ_io_out_ready = MCRFile_io_mcr_read_3_ready;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_valid = 1'h0;
  assign MCRFile_io_mcr_read_0_bits = 64'h0;
  assign MCRFile_io_mcr_read_1_valid = 1'h0;
  assign MCRFile_io_mcr_read_1_bits = 64'h0;
  assign MCRFile_io_mcr_read_2_valid = 1'h0;
  assign MCRFile_io_mcr_read_2_bits = 64'h0;
  assign MCRFile_io_mcr_read_3_valid = rDataQ_io_out_valid;
  assign MCRFile_io_mcr_read_3_bits = rDataQ_io_out_bits;
  assign MCRFile_io_mcr_write_0_ready = _T_584_ready;
  assign MCRFile_io_mcr_write_1_ready = wDataQ_io_in_ready;
  assign MCRFile_io_mcr_write_2_ready = _T_671_ready;
  assign MCRFile_io_mcr_write_3_ready = 1'h0;
  assign _T_717 = MCRFile_io_mcr_read_0_ready == 1'h0;
  assign _T_718 = _T_717 | reset;
  assign _T_720 = _T_718 == 1'h0;
  assign _T_722 = MCRFile_io_mcr_read_1_ready == 1'h0;
  assign _T_723 = _T_722 | reset;
  assign _T_725 = _T_723 == 1'h0;
  assign _T_727 = MCRFile_io_mcr_read_2_ready == 1'h0;
  assign _T_728 = _T_727 | reset;
  assign _T_730 = _T_728 == 1'h0;
  assign _T_732 = MCRFile_io_mcr_write_3_valid != 1'h1;
  assign _T_733 = _T_732 | reset;
  assign _T_735 = _T_733 == 1'h0;
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_720) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_720) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_725) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_725) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_730) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:281 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_730) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_735) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:286 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_735) begin
          $fatal;
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module Queue_5(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits_len
);
  reg [7:0] ram_len [0:0];
  reg [31:0] _RAND_0;
  wire [7:0] ram_len__T_132_data;
  wire  ram_len__T_132_addr;
  wire [7:0] ram_len__T_112_data;
  wire  ram_len__T_112_addr;
  wire  ram_len__T_112_mask;
  wire  ram_len__T_112_en;
  reg  maybe_full;
  reg [31:0] _RAND_1;
  wire  _T_106;
  wire  _T_109;
  wire  do_enq;
  wire  _T_110;
  wire  do_deq;
  wire  _T_126;
  wire  _GEN_14;
  wire  _T_128;
  assign io_enq_ready = _T_106;
  assign io_deq_valid = _T_128;
  assign io_deq_bits_len = ram_len__T_132_data;
  assign ram_len__T_132_addr = 1'h0;
  assign ram_len__T_132_data = ram_len[ram_len__T_132_addr];
  assign ram_len__T_112_data = 8'h0;
  assign ram_len__T_112_addr = 1'h0;
  assign ram_len__T_112_mask = do_enq;
  assign ram_len__T_112_en = do_enq;
  assign _T_106 = maybe_full == 1'h0;
  assign _T_109 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_109;
  assign _T_110 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_110;
  assign _T_126 = do_enq != do_deq;
  assign _GEN_14 = _T_126 ? do_enq : maybe_full;
  assign _T_128 = _T_106 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_len[initvar] = _RAND_0[7:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  maybe_full = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_len__T_112_en & ram_len__T_112_mask) begin
      ram_len[ram_len__T_112_addr] <= ram_len__T_112_data;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_126) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_6(
  input   clock,
  input   reset,
  output  io_enq_ready,
  input   io_enq_valid,
  input   io_deq_ready,
  output  io_deq_valid
);
  reg  maybe_full;
  reg [31:0] _RAND_0;
  wire  _T_29;
  wire  _T_32;
  wire  do_enq;
  wire  _T_33;
  wire  do_deq;
  wire  _T_38;
  wire  _GEN_4;
  wire  _T_40;
  assign io_enq_ready = _T_29;
  assign io_deq_valid = _T_40;
  assign _T_29 = maybe_full == 1'h0;
  assign _T_32 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_32;
  assign _T_33 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_33;
  assign _T_38 = do_enq != do_deq;
  assign _GEN_4 = _T_38 ? do_enq : maybe_full;
  assign _T_40 = _T_29 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  maybe_full = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_38) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module NastiErrorSlave(
  input         clock,
  input         reset,
  output        io_aw_ready,
  input         io_aw_valid,
  input  [31:0] io_aw_bits_addr,
  output        io_w_ready,
  input         io_w_valid,
  input         io_b_ready,
  output        io_b_valid,
  output        io_ar_ready,
  input         io_ar_valid,
  input  [31:0] io_ar_bits_addr,
  input         io_r_ready,
  output        io_r_valid,
  output        io_r_bits_last
);
  wire  _T_353;
  wire  _T_355;
  wire  _T_356;
  wire  r_queue_clock;
  wire  r_queue_reset;
  wire  r_queue_io_enq_ready;
  wire  r_queue_io_enq_valid;
  wire  r_queue_io_deq_ready;
  wire  r_queue_io_deq_valid;
  wire [7:0] r_queue_io_deq_bits_len;
  reg  responding;
  reg [31:0] _RAND_0;
  reg [7:0] beats_left;
  reg [31:0] _RAND_1;
  wire  _T_374;
  wire  _T_375;
  wire  _GEN_0;
  wire [7:0] _GEN_1;
  wire  _T_377;
  wire  _T_381;
  wire  _T_382;
  wire  _T_383;
  wire  _GEN_2;
  wire  _T_389;
  wire [8:0] _T_391;
  wire [8:0] _T_392;
  wire [7:0] _T_393;
  wire [7:0] _GEN_3;
  wire  _GEN_4;
  wire [7:0] _GEN_5;
  reg  draining;
  reg [31:0] _RAND_2;
  wire  _GEN_6;
  wire  _T_397;
  wire  _GEN_7;
  wire  b_queue_clock;
  wire  b_queue_reset;
  wire  b_queue_io_enq_ready;
  wire  b_queue_io_enq_valid;
  wire  b_queue_io_deq_ready;
  wire  b_queue_io_deq_valid;
  wire  _T_402;
  wire  _T_403;
  wire  _T_406;
  wire  _T_409;
  wire  _T_413;
  Queue_5 r_queue (
    .clock(r_queue_clock),
    .reset(r_queue_reset),
    .io_enq_ready(r_queue_io_enq_ready),
    .io_enq_valid(r_queue_io_enq_valid),
    .io_deq_ready(r_queue_io_deq_ready),
    .io_deq_valid(r_queue_io_deq_valid),
    .io_deq_bits_len(r_queue_io_deq_bits_len)
  );
  Queue_6 b_queue (
    .clock(b_queue_clock),
    .reset(b_queue_reset),
    .io_enq_ready(b_queue_io_enq_ready),
    .io_enq_valid(b_queue_io_enq_valid),
    .io_deq_ready(b_queue_io_deq_ready),
    .io_deq_valid(b_queue_io_deq_valid)
  );
  assign io_aw_ready = _T_406;
  assign io_w_ready = draining;
  assign io_b_valid = _T_409;
  assign io_ar_ready = r_queue_io_enq_ready;
  assign io_r_valid = _T_377;
  assign io_r_bits_last = _T_381;
  assign _T_353 = io_ar_ready & io_ar_valid;
  assign _T_355 = reset == 1'h0;
  assign _T_356 = io_aw_ready & io_aw_valid;
  assign r_queue_clock = clock;
  assign r_queue_reset = reset;
  assign r_queue_io_enq_valid = io_ar_valid;
  assign r_queue_io_deq_ready = _T_383;
  assign _T_374 = responding == 1'h0;
  assign _T_375 = _T_374 & r_queue_io_deq_valid;
  assign _GEN_0 = _T_375 ? 1'h1 : responding;
  assign _GEN_1 = _T_375 ? r_queue_io_deq_bits_len : beats_left;
  assign _T_377 = r_queue_io_deq_valid & responding;
  assign _T_381 = beats_left == 8'h0;
  assign _T_382 = io_r_ready & io_r_valid;
  assign _T_383 = _T_382 & io_r_bits_last;
  assign _GEN_2 = _T_381 ? 1'h0 : _GEN_0;
  assign _T_389 = _T_381 == 1'h0;
  assign _T_391 = beats_left - 8'h1;
  assign _T_392 = $unsigned(_T_391);
  assign _T_393 = _T_392[7:0];
  assign _GEN_3 = _T_389 ? _T_393 : _GEN_1;
  assign _GEN_4 = _T_382 ? _GEN_2 : _GEN_0;
  assign _GEN_5 = _T_382 ? _GEN_3 : _GEN_1;
  assign _GEN_6 = _T_356 ? 1'h1 : draining;
  assign _T_397 = io_w_ready & io_w_valid;
  assign _GEN_7 = _T_397 ? 1'h0 : _GEN_6;
  assign b_queue_clock = clock;
  assign b_queue_reset = reset;
  assign b_queue_io_enq_valid = _T_403;
  assign b_queue_io_deq_ready = _T_413;
  assign _T_402 = draining == 1'h0;
  assign _T_403 = io_aw_valid & _T_402;
  assign _T_406 = b_queue_io_enq_ready & _T_402;
  assign _T_409 = b_queue_io_deq_valid & _T_402;
  assign _T_413 = io_b_ready & _T_402;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  responding = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  beats_left = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  draining = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      responding <= 1'h0;
    end else begin
      if (_T_382) begin
        if (_T_381) begin
          responding <= 1'h0;
        end else begin
          if (_T_375) begin
            responding <= 1'h1;
          end
        end
      end else begin
        if (_T_375) begin
          responding <= 1'h1;
        end
      end
    end
    if (reset) begin
      beats_left <= 8'h0;
    end else begin
      if (_T_382) begin
        if (_T_389) begin
          beats_left <= _T_393;
        end else begin
          if (_T_375) begin
            beats_left <= r_queue_io_deq_bits_len;
          end
        end
      end else begin
        if (_T_375) begin
          beats_left <= r_queue_io_deq_bits_len;
        end
      end
    end
    if (reset) begin
      draining <= 1'h0;
    end else begin
      if (_T_397) begin
        draining <= 1'h0;
      end else begin
        if (_T_356) begin
          draining <= 1'h1;
        end
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_353 & _T_355) begin
          $fwrite(32'h80000002,"Invalid read address %h\n",io_ar_bits_addr);
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_356 & _T_355) begin
          $fwrite(32'h80000002,"Invalid write address %h\n",io_aw_bits_addr);
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module RRArbiter(
  input        clock,
  output       io_in_0_ready,
  input        io_in_0_valid,
  output       io_in_1_ready,
  input        io_in_1_valid,
  output       io_in_2_ready,
  input        io_in_2_valid,
  output       io_in_3_ready,
  input        io_in_3_valid,
  output       io_in_4_ready,
  input        io_in_4_valid,
  output       io_in_5_ready,
  input        io_in_5_valid,
  input        io_out_ready,
  output       io_out_valid,
  output [2:0] io_chosen
);
  wire [2:0] choice;
  wire  _GEN_0_valid;
  wire  _GEN_5;
  wire  _GEN_10;
  wire  _GEN_15;
  wire  _GEN_20;
  wire  _GEN_25;
  wire  _T_345;
  reg [2:0] lastGrant;
  reg [31:0] _RAND_0;
  wire [2:0] _GEN_29;
  wire  grantMask_1;
  wire  grantMask_2;
  wire  grantMask_3;
  wire  grantMask_4;
  wire  grantMask_5;
  wire  validMask_1;
  wire  validMask_2;
  wire  validMask_3;
  wire  validMask_4;
  wire  validMask_5;
  wire  _T_354;
  wire  _T_355;
  wire  _T_356;
  wire  _T_357;
  wire  _T_358;
  wire  _T_359;
  wire  _T_360;
  wire  _T_361;
  wire  _T_362;
  wire  _T_366;
  wire  _T_368;
  wire  _T_370;
  wire  _T_372;
  wire  _T_374;
  wire  _T_376;
  wire  _T_378;
  wire  _T_380;
  wire  _T_382;
  wire  _T_384;
  wire  _T_388;
  wire  _T_389;
  wire  _T_390;
  wire  _T_391;
  wire  _T_392;
  wire  _T_393;
  wire  _T_394;
  wire  _T_395;
  wire  _T_396;
  wire  _T_397;
  wire  _T_398;
  wire  _T_399;
  wire  _T_400;
  wire  _T_401;
  wire  _T_402;
  wire [2:0] _GEN_30;
  wire [2:0] _GEN_31;
  wire [2:0] _GEN_32;
  wire [2:0] _GEN_33;
  wire [2:0] _GEN_34;
  wire [2:0] _GEN_35;
  wire [2:0] _GEN_36;
  wire [2:0] _GEN_37;
  wire [2:0] _GEN_38;
  wire [2:0] _GEN_39;
  assign io_in_0_ready = _T_397;
  assign io_in_1_ready = _T_398;
  assign io_in_2_ready = _T_399;
  assign io_in_3_ready = _T_400;
  assign io_in_4_ready = _T_401;
  assign io_in_5_ready = _T_402;
  assign io_out_valid = _GEN_0_valid;
  assign io_chosen = choice;
  assign choice = _GEN_39;
  assign _GEN_0_valid = _GEN_25;
  assign _GEN_5 = 3'h1 == io_chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_10 = 3'h2 == io_chosen ? io_in_2_valid : _GEN_5;
  assign _GEN_15 = 3'h3 == io_chosen ? io_in_3_valid : _GEN_10;
  assign _GEN_20 = 3'h4 == io_chosen ? io_in_4_valid : _GEN_15;
  assign _GEN_25 = 3'h5 == io_chosen ? io_in_5_valid : _GEN_20;
  assign _T_345 = io_out_ready & io_out_valid;
  assign _GEN_29 = _T_345 ? io_chosen : lastGrant;
  assign grantMask_1 = 3'h1 > lastGrant;
  assign grantMask_2 = 3'h2 > lastGrant;
  assign grantMask_3 = 3'h3 > lastGrant;
  assign grantMask_4 = 3'h4 > lastGrant;
  assign grantMask_5 = 3'h5 > lastGrant;
  assign validMask_1 = io_in_1_valid & grantMask_1;
  assign validMask_2 = io_in_2_valid & grantMask_2;
  assign validMask_3 = io_in_3_valid & grantMask_3;
  assign validMask_4 = io_in_4_valid & grantMask_4;
  assign validMask_5 = io_in_5_valid & grantMask_5;
  assign _T_354 = validMask_1 | validMask_2;
  assign _T_355 = _T_354 | validMask_3;
  assign _T_356 = _T_355 | validMask_4;
  assign _T_357 = _T_356 | validMask_5;
  assign _T_358 = _T_357 | io_in_0_valid;
  assign _T_359 = _T_358 | io_in_1_valid;
  assign _T_360 = _T_359 | io_in_2_valid;
  assign _T_361 = _T_360 | io_in_3_valid;
  assign _T_362 = _T_361 | io_in_4_valid;
  assign _T_366 = validMask_1 == 1'h0;
  assign _T_368 = _T_354 == 1'h0;
  assign _T_370 = _T_355 == 1'h0;
  assign _T_372 = _T_356 == 1'h0;
  assign _T_374 = _T_357 == 1'h0;
  assign _T_376 = _T_358 == 1'h0;
  assign _T_378 = _T_359 == 1'h0;
  assign _T_380 = _T_360 == 1'h0;
  assign _T_382 = _T_361 == 1'h0;
  assign _T_384 = _T_362 == 1'h0;
  assign _T_388 = grantMask_1 | _T_376;
  assign _T_389 = _T_366 & grantMask_2;
  assign _T_390 = _T_389 | _T_378;
  assign _T_391 = _T_368 & grantMask_3;
  assign _T_392 = _T_391 | _T_380;
  assign _T_393 = _T_370 & grantMask_4;
  assign _T_394 = _T_393 | _T_382;
  assign _T_395 = _T_372 & grantMask_5;
  assign _T_396 = _T_395 | _T_384;
  assign _T_397 = _T_374 & io_out_ready;
  assign _T_398 = _T_388 & io_out_ready;
  assign _T_399 = _T_390 & io_out_ready;
  assign _T_400 = _T_392 & io_out_ready;
  assign _T_401 = _T_394 & io_out_ready;
  assign _T_402 = _T_396 & io_out_ready;
  assign _GEN_30 = io_in_4_valid ? 3'h4 : 3'h5;
  assign _GEN_31 = io_in_3_valid ? 3'h3 : _GEN_30;
  assign _GEN_32 = io_in_2_valid ? 3'h2 : _GEN_31;
  assign _GEN_33 = io_in_1_valid ? 3'h1 : _GEN_32;
  assign _GEN_34 = io_in_0_valid ? 3'h0 : _GEN_33;
  assign _GEN_35 = validMask_5 ? 3'h5 : _GEN_34;
  assign _GEN_36 = validMask_4 ? 3'h4 : _GEN_35;
  assign _GEN_37 = validMask_3 ? 3'h3 : _GEN_36;
  assign _GEN_38 = validMask_2 ? 3'h2 : _GEN_37;
  assign _GEN_39 = validMask_1 ? 3'h1 : _GEN_38;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  lastGrant = _RAND_0[2:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_345) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module HellaPeekingArbiter(
  input         clock,
  input         reset,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits_data,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits_data,
  output        io_in_2_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits_data,
  input         io_in_2_bits_last,
  output        io_in_3_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits_data,
  output        io_in_4_ready,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits_data,
  input         io_in_4_bits_last,
  output        io_in_5_ready,
  input         io_in_5_valid,
  input         io_in_5_bits_last,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_data,
  output        io_out_bits_last
);
  reg [2:0] lockIdx;
  reg [31:0] _RAND_0;
  reg  locked;
  reg [31:0] _RAND_1;
  wire [2:0] _T_403;
  wire [2:0] _T_404;
  wire [2:0] _T_405;
  wire [2:0] _T_406;
  wire [2:0] choice;
  wire [2:0] chosen;
  wire  _T_408;
  wire  _T_409;
  wire  _T_411;
  wire  _T_412;
  wire  _T_414;
  wire  _T_415;
  wire  _T_417;
  wire  _T_418;
  wire  _T_420;
  wire  _T_421;
  wire  _T_423;
  wire  _T_424;
  wire  _GEN_0_valid;
  wire  _GEN_7;
  wire [63:0] _GEN_9;
  wire  _GEN_14;
  wire [63:0] _GEN_16;
  wire  _GEN_17;
  wire  _GEN_21;
  wire [63:0] _GEN_23;
  wire  _GEN_24;
  wire  _GEN_28;
  wire [63:0] _GEN_30;
  wire  _GEN_31;
  wire  _GEN_35;
  wire [63:0] _GEN_37;
  wire  _GEN_38;
  wire [63:0] _GEN_2_bits_data;
  wire  _GEN_3_bits_last;
  wire  _T_491;
  wire  _T_493;
  wire [2:0] _GEN_41;
  wire  _GEN_42;
  wire  _GEN_43;
  wire [2:0] _GEN_44;
  wire  _GEN_45;
  assign io_in_0_ready = _T_409;
  assign io_in_1_ready = _T_412;
  assign io_in_2_ready = _T_415;
  assign io_in_3_ready = _T_418;
  assign io_in_4_ready = _T_421;
  assign io_in_5_ready = _T_424;
  assign io_out_valid = _GEN_0_valid;
  assign io_out_bits_data = _GEN_2_bits_data;
  assign io_out_bits_last = _GEN_3_bits_last;
  assign _T_403 = io_in_4_valid ? 3'h4 : 3'h5;
  assign _T_404 = io_in_3_valid ? 3'h3 : _T_403;
  assign _T_405 = io_in_2_valid ? 3'h2 : _T_404;
  assign _T_406 = io_in_1_valid ? 3'h1 : _T_405;
  assign choice = io_in_0_valid ? 3'h0 : _T_406;
  assign chosen = locked ? lockIdx : choice;
  assign _T_408 = chosen == 3'h0;
  assign _T_409 = io_out_ready & _T_408;
  assign _T_411 = chosen == 3'h1;
  assign _T_412 = io_out_ready & _T_411;
  assign _T_414 = chosen == 3'h2;
  assign _T_415 = io_out_ready & _T_414;
  assign _T_417 = chosen == 3'h3;
  assign _T_418 = io_out_ready & _T_417;
  assign _T_420 = chosen == 3'h4;
  assign _T_421 = io_out_ready & _T_420;
  assign _T_423 = chosen == 3'h5;
  assign _T_424 = io_out_ready & _T_423;
  assign _GEN_0_valid = _GEN_35;
  assign _GEN_7 = 3'h1 == chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_9 = 3'h1 == chosen ? io_in_1_bits_data : io_in_0_bits_data;
  assign _GEN_14 = 3'h2 == chosen ? io_in_2_valid : _GEN_7;
  assign _GEN_16 = 3'h2 == chosen ? io_in_2_bits_data : _GEN_9;
  assign _GEN_17 = 3'h2 == chosen ? io_in_2_bits_last : 1'h1;
  assign _GEN_21 = 3'h3 == chosen ? io_in_3_valid : _GEN_14;
  assign _GEN_23 = 3'h3 == chosen ? io_in_3_bits_data : _GEN_16;
  assign _GEN_24 = 3'h3 == chosen ? 1'h1 : _GEN_17;
  assign _GEN_28 = 3'h4 == chosen ? io_in_4_valid : _GEN_21;
  assign _GEN_30 = 3'h4 == chosen ? io_in_4_bits_data : _GEN_23;
  assign _GEN_31 = 3'h4 == chosen ? io_in_4_bits_last : _GEN_24;
  assign _GEN_35 = 3'h5 == chosen ? io_in_5_valid : _GEN_28;
  assign _GEN_37 = 3'h5 == chosen ? 64'h0 : _GEN_30;
  assign _GEN_38 = 3'h5 == chosen ? io_in_5_bits_last : _GEN_31;
  assign _GEN_2_bits_data = _GEN_37;
  assign _GEN_3_bits_last = _GEN_38;
  assign _T_491 = io_out_ready & io_out_valid;
  assign _T_493 = locked == 1'h0;
  assign _GEN_41 = _T_493 ? choice : lockIdx;
  assign _GEN_42 = _T_493 ? 1'h1 : locked;
  assign _GEN_43 = io_out_bits_last ? 1'h0 : _GEN_42;
  assign _GEN_44 = _T_491 ? _GEN_41 : lockIdx;
  assign _GEN_45 = _T_491 ? _GEN_43 : locked;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  lockIdx = _RAND_0[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  locked = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      lockIdx <= 3'h0;
    end else begin
      if (_T_491) begin
        if (_T_493) begin
          if (io_in_0_valid) begin
            lockIdx <= 3'h0;
          end else begin
            if (io_in_1_valid) begin
              lockIdx <= 3'h1;
            end else begin
              if (io_in_2_valid) begin
                lockIdx <= 3'h2;
              end else begin
                if (io_in_3_valid) begin
                  lockIdx <= 3'h3;
                end else begin
                  if (io_in_4_valid) begin
                    lockIdx <= 3'h4;
                  end else begin
                    lockIdx <= 3'h5;
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      locked <= 1'h0;
    end else begin
      if (_T_491) begin
        if (io_out_bits_last) begin
          locked <= 1'h0;
        end else begin
          if (_T_493) begin
            locked <= 1'h1;
          end
        end
      end
    end
  end
endmodule
module NastiRouter(
  input         clock,
  input         reset,
  output        io_master_aw_ready,
  input         io_master_aw_valid,
  input  [31:0] io_master_aw_bits_addr,
  output        io_master_w_ready,
  input         io_master_w_valid,
  input  [63:0] io_master_w_bits_data,
  input         io_master_b_ready,
  output        io_master_b_valid,
  output        io_master_ar_ready,
  input         io_master_ar_valid,
  input  [31:0] io_master_ar_bits_addr,
  input         io_master_r_ready,
  output        io_master_r_valid,
  output [63:0] io_master_r_bits_data,
  input         io_slave_0_aw_ready,
  output        io_slave_0_aw_valid,
  output [31:0] io_slave_0_aw_bits_addr,
  input         io_slave_0_w_ready,
  output        io_slave_0_w_valid,
  output [63:0] io_slave_0_w_bits_data,
  output        io_slave_0_w_bits_last,
  output        io_slave_0_b_ready,
  input         io_slave_0_b_valid,
  input         io_slave_0_ar_ready,
  output        io_slave_0_ar_valid,
  output [31:0] io_slave_0_ar_bits_addr,
  output        io_slave_0_r_ready,
  input         io_slave_0_r_valid,
  input  [63:0] io_slave_0_r_bits_data,
  input         io_slave_1_aw_ready,
  output        io_slave_1_aw_valid,
  output [31:0] io_slave_1_aw_bits_addr,
  input         io_slave_1_w_ready,
  output        io_slave_1_w_valid,
  output [63:0] io_slave_1_w_bits_data,
  output        io_slave_1_w_bits_last,
  output        io_slave_1_b_ready,
  input         io_slave_1_b_valid,
  input         io_slave_1_ar_ready,
  output        io_slave_1_ar_valid,
  output [31:0] io_slave_1_ar_bits_addr,
  output        io_slave_1_r_ready,
  input         io_slave_1_r_valid,
  input  [63:0] io_slave_1_r_bits_data,
  input         io_slave_2_aw_ready,
  output        io_slave_2_aw_valid,
  output [31:0] io_slave_2_aw_bits_addr,
  input         io_slave_2_w_ready,
  output        io_slave_2_w_valid,
  output [63:0] io_slave_2_w_bits_data,
  output        io_slave_2_w_bits_last,
  output        io_slave_2_b_ready,
  input         io_slave_2_b_valid,
  input         io_slave_2_ar_ready,
  output        io_slave_2_ar_valid,
  output [31:0] io_slave_2_ar_bits_addr,
  output        io_slave_2_r_ready,
  input         io_slave_2_r_valid,
  input  [63:0] io_slave_2_r_bits_data,
  input         io_slave_2_r_bits_last,
  input         io_slave_3_aw_ready,
  output        io_slave_3_aw_valid,
  output [31:0] io_slave_3_aw_bits_addr,
  input         io_slave_3_w_ready,
  output        io_slave_3_w_valid,
  output [63:0] io_slave_3_w_bits_data,
  output        io_slave_3_w_bits_last,
  output        io_slave_3_b_ready,
  input         io_slave_3_b_valid,
  input         io_slave_3_ar_ready,
  output        io_slave_3_ar_valid,
  output [31:0] io_slave_3_ar_bits_addr,
  output        io_slave_3_r_ready,
  input         io_slave_3_r_valid,
  input  [63:0] io_slave_3_r_bits_data,
  input         io_slave_4_aw_ready,
  output        io_slave_4_aw_valid,
  output [31:0] io_slave_4_aw_bits_addr,
  input         io_slave_4_w_ready,
  output        io_slave_4_w_valid,
  output [63:0] io_slave_4_w_bits_data,
  output        io_slave_4_w_bits_last,
  output        io_slave_4_b_ready,
  input         io_slave_4_b_valid,
  input         io_slave_4_ar_ready,
  output        io_slave_4_ar_valid,
  output [31:0] io_slave_4_ar_bits_addr,
  output        io_slave_4_r_ready,
  input         io_slave_4_r_valid,
  input  [63:0] io_slave_4_r_bits_data,
  input         io_slave_4_r_bits_last
);
  wire  _T_1585;
  wire  _T_1588;
  wire  _T_1590;
  wire  _T_1591;
  wire  _T_1593;
  wire  _T_1595;
  wire  _T_1596;
  wire  _T_1598;
  wire  _T_1600;
  wire  _T_1601;
  wire  _T_1603;
  wire  _T_1605;
  wire  _T_1606;
  wire [1:0] _T_1607;
  wire [1:0] _T_1608;
  wire [2:0] _T_1609;
  wire [4:0] ar_route;
  wire  _T_1613;
  wire  _T_1616;
  wire  _T_1618;
  wire  _T_1619;
  wire  _T_1621;
  wire  _T_1623;
  wire  _T_1624;
  wire  _T_1626;
  wire  _T_1628;
  wire  _T_1629;
  wire  _T_1631;
  wire  _T_1633;
  wire  _T_1634;
  wire [1:0] _T_1635;
  wire [1:0] _T_1636;
  wire [2:0] _T_1637;
  wire [4:0] aw_route;
  wire  _T_1641;
  wire  _T_1642;
  wire  _T_1644;
  wire  _T_1646;
  wire  _T_1647;
  wire  _T_1649;
  reg  _T_1652;
  reg [31:0] _RAND_0;
  wire  _T_1653;
  wire  _T_1654;
  wire  _GEN_0;
  wire  _T_1656;
  wire  _GEN_1;
  wire  _T_1658;
  wire  _T_1659;
  wire  _T_1661;
  wire  _T_1662;
  wire  _T_1664;
  wire  _T_1665;
  wire  _T_1666;
  wire  _T_1667;
  wire  _T_1669;
  wire  _T_1670;
  reg  _T_1672;
  reg [31:0] _RAND_1;
  wire  _T_1673;
  wire  _T_1674;
  wire  _GEN_2;
  wire  _T_1676;
  wire  _GEN_3;
  wire  _T_1678;
  wire  _T_1679;
  wire  _T_1680;
  wire  _T_1681;
  wire  _T_1682;
  wire  _T_1684;
  wire  _T_1685;
  wire  _T_1686;
  wire  _T_1687;
  wire  _T_1689;
  wire  _T_1690;
  reg  _T_1692;
  reg [31:0] _RAND_2;
  wire  _T_1693;
  wire  _T_1694;
  wire  _GEN_4;
  wire  _T_1696;
  wire  _GEN_5;
  wire  _T_1698;
  wire  _T_1699;
  wire  _T_1700;
  wire  _T_1701;
  wire  _T_1702;
  wire  _T_1704;
  wire  _T_1705;
  wire  _T_1706;
  wire  _T_1707;
  wire  _T_1709;
  wire  _T_1710;
  reg  _T_1712;
  reg [31:0] _RAND_3;
  wire  _T_1713;
  wire  _T_1714;
  wire  _GEN_6;
  wire  _T_1716;
  wire  _GEN_7;
  wire  _T_1718;
  wire  _T_1719;
  wire  _T_1720;
  wire  _T_1721;
  wire  _T_1722;
  wire  _T_1724;
  wire  ar_ready;
  wire  _T_1725;
  wire  _T_1726;
  wire  _T_1728;
  wire  aw_ready;
  reg  _T_1730;
  reg [31:0] _RAND_4;
  wire  _T_1731;
  wire  _T_1732;
  wire  _GEN_8;
  wire  _T_1734;
  wire  _GEN_9;
  wire  _T_1736;
  wire  _T_1737;
  wire  w_ready;
  wire  _T_1739;
  wire  r_invalid;
  wire  _T_1742;
  wire  w_invalid;
  wire  err_slave_clock;
  wire  err_slave_reset;
  wire  err_slave_io_aw_ready;
  wire  err_slave_io_aw_valid;
  wire [31:0] err_slave_io_aw_bits_addr;
  wire  err_slave_io_w_ready;
  wire  err_slave_io_w_valid;
  wire  err_slave_io_b_ready;
  wire  err_slave_io_b_valid;
  wire  err_slave_io_ar_ready;
  wire  err_slave_io_ar_valid;
  wire [31:0] err_slave_io_ar_bits_addr;
  wire  err_slave_io_r_ready;
  wire  err_slave_io_r_valid;
  wire  err_slave_io_r_bits_last;
  wire  _T_1744;
  wire  _T_1745;
  wire  _T_1746;
  wire  _T_1747;
  wire  _T_1748;
  wire  _T_1749;
  wire  _T_1750;
  wire  b_arb_clock;
  wire  b_arb_io_in_0_ready;
  wire  b_arb_io_in_0_valid;
  wire  b_arb_io_in_1_ready;
  wire  b_arb_io_in_1_valid;
  wire  b_arb_io_in_2_ready;
  wire  b_arb_io_in_2_valid;
  wire  b_arb_io_in_3_ready;
  wire  b_arb_io_in_3_valid;
  wire  b_arb_io_in_4_ready;
  wire  b_arb_io_in_4_valid;
  wire  b_arb_io_in_5_ready;
  wire  b_arb_io_in_5_valid;
  wire  b_arb_io_out_ready;
  wire  b_arb_io_out_valid;
  wire [2:0] b_arb_io_chosen;
  wire  r_arb_clock;
  wire  r_arb_reset;
  wire  r_arb_io_in_0_ready;
  wire  r_arb_io_in_0_valid;
  wire [63:0] r_arb_io_in_0_bits_data;
  wire  r_arb_io_in_1_ready;
  wire  r_arb_io_in_1_valid;
  wire [63:0] r_arb_io_in_1_bits_data;
  wire  r_arb_io_in_2_ready;
  wire  r_arb_io_in_2_valid;
  wire [63:0] r_arb_io_in_2_bits_data;
  wire  r_arb_io_in_2_bits_last;
  wire  r_arb_io_in_3_ready;
  wire  r_arb_io_in_3_valid;
  wire [63:0] r_arb_io_in_3_bits_data;
  wire  r_arb_io_in_4_ready;
  wire  r_arb_io_in_4_valid;
  wire [63:0] r_arb_io_in_4_bits_data;
  wire  r_arb_io_in_4_bits_last;
  wire  r_arb_io_in_5_ready;
  wire  r_arb_io_in_5_valid;
  wire  r_arb_io_in_5_bits_last;
  wire  r_arb_io_out_ready;
  wire  r_arb_io_out_valid;
  wire [63:0] r_arb_io_out_bits_data;
  wire  r_arb_io_out_bits_last;
  NastiErrorSlave err_slave (
    .clock(err_slave_clock),
    .reset(err_slave_reset),
    .io_aw_ready(err_slave_io_aw_ready),
    .io_aw_valid(err_slave_io_aw_valid),
    .io_aw_bits_addr(err_slave_io_aw_bits_addr),
    .io_w_ready(err_slave_io_w_ready),
    .io_w_valid(err_slave_io_w_valid),
    .io_b_ready(err_slave_io_b_ready),
    .io_b_valid(err_slave_io_b_valid),
    .io_ar_ready(err_slave_io_ar_ready),
    .io_ar_valid(err_slave_io_ar_valid),
    .io_ar_bits_addr(err_slave_io_ar_bits_addr),
    .io_r_ready(err_slave_io_r_ready),
    .io_r_valid(err_slave_io_r_valid),
    .io_r_bits_last(err_slave_io_r_bits_last)
  );
  RRArbiter b_arb (
    .clock(b_arb_clock),
    .io_in_0_ready(b_arb_io_in_0_ready),
    .io_in_0_valid(b_arb_io_in_0_valid),
    .io_in_1_ready(b_arb_io_in_1_ready),
    .io_in_1_valid(b_arb_io_in_1_valid),
    .io_in_2_ready(b_arb_io_in_2_ready),
    .io_in_2_valid(b_arb_io_in_2_valid),
    .io_in_3_ready(b_arb_io_in_3_ready),
    .io_in_3_valid(b_arb_io_in_3_valid),
    .io_in_4_ready(b_arb_io_in_4_ready),
    .io_in_4_valid(b_arb_io_in_4_valid),
    .io_in_5_ready(b_arb_io_in_5_ready),
    .io_in_5_valid(b_arb_io_in_5_valid),
    .io_out_ready(b_arb_io_out_ready),
    .io_out_valid(b_arb_io_out_valid),
    .io_chosen(b_arb_io_chosen)
  );
  HellaPeekingArbiter r_arb (
    .clock(r_arb_clock),
    .reset(r_arb_reset),
    .io_in_0_ready(r_arb_io_in_0_ready),
    .io_in_0_valid(r_arb_io_in_0_valid),
    .io_in_0_bits_data(r_arb_io_in_0_bits_data),
    .io_in_1_ready(r_arb_io_in_1_ready),
    .io_in_1_valid(r_arb_io_in_1_valid),
    .io_in_1_bits_data(r_arb_io_in_1_bits_data),
    .io_in_2_ready(r_arb_io_in_2_ready),
    .io_in_2_valid(r_arb_io_in_2_valid),
    .io_in_2_bits_data(r_arb_io_in_2_bits_data),
    .io_in_2_bits_last(r_arb_io_in_2_bits_last),
    .io_in_3_ready(r_arb_io_in_3_ready),
    .io_in_3_valid(r_arb_io_in_3_valid),
    .io_in_3_bits_data(r_arb_io_in_3_bits_data),
    .io_in_4_ready(r_arb_io_in_4_ready),
    .io_in_4_valid(r_arb_io_in_4_valid),
    .io_in_4_bits_data(r_arb_io_in_4_bits_data),
    .io_in_4_bits_last(r_arb_io_in_4_bits_last),
    .io_in_5_ready(r_arb_io_in_5_ready),
    .io_in_5_valid(r_arb_io_in_5_valid),
    .io_in_5_bits_last(r_arb_io_in_5_bits_last),
    .io_out_ready(r_arb_io_out_ready),
    .io_out_valid(r_arb_io_out_valid),
    .io_out_bits_data(r_arb_io_out_bits_data),
    .io_out_bits_last(r_arb_io_out_bits_last)
  );
  assign io_master_aw_ready = _T_1749;
  assign io_master_w_ready = _T_1750;
  assign io_master_b_valid = b_arb_io_out_valid;
  assign io_master_ar_ready = _T_1747;
  assign io_master_r_valid = r_arb_io_out_valid;
  assign io_master_r_bits_data = r_arb_io_out_bits_data;
  assign io_slave_0_aw_valid = _T_1647;
  assign io_slave_0_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_0_w_valid = _T_1658;
  assign io_slave_0_w_bits_data = io_master_w_bits_data;
  assign io_slave_0_w_bits_last = 1'h1;
  assign io_slave_0_b_ready = b_arb_io_in_0_ready;
  assign io_slave_0_ar_valid = _T_1642;
  assign io_slave_0_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_0_r_ready = r_arb_io_in_0_ready;
  assign io_slave_1_aw_valid = _T_1667;
  assign io_slave_1_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_1_w_valid = _T_1678;
  assign io_slave_1_w_bits_data = io_master_w_bits_data;
  assign io_slave_1_w_bits_last = 1'h1;
  assign io_slave_1_b_ready = b_arb_io_in_1_ready;
  assign io_slave_1_ar_valid = _T_1662;
  assign io_slave_1_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_1_r_ready = r_arb_io_in_1_ready;
  assign io_slave_2_aw_valid = _T_1687;
  assign io_slave_2_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_2_w_valid = _T_1698;
  assign io_slave_2_w_bits_data = io_master_w_bits_data;
  assign io_slave_2_w_bits_last = 1'h1;
  assign io_slave_2_b_ready = b_arb_io_in_2_ready;
  assign io_slave_2_ar_valid = _T_1682;
  assign io_slave_2_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_2_r_ready = r_arb_io_in_2_ready;
  assign io_slave_3_aw_valid = _T_1707;
  assign io_slave_3_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_3_w_valid = _T_1718;
  assign io_slave_3_w_bits_data = io_master_w_bits_data;
  assign io_slave_3_w_bits_last = 1'h1;
  assign io_slave_3_b_ready = b_arb_io_in_3_ready;
  assign io_slave_3_ar_valid = _T_1702;
  assign io_slave_3_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_3_r_ready = r_arb_io_in_3_ready;
  assign io_slave_4_aw_valid = _T_1726;
  assign io_slave_4_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_4_w_valid = _T_1736;
  assign io_slave_4_w_bits_data = io_master_w_bits_data;
  assign io_slave_4_w_bits_last = 1'h1;
  assign io_slave_4_b_ready = b_arb_io_in_4_ready;
  assign io_slave_4_ar_valid = _T_1722;
  assign io_slave_4_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_4_r_ready = r_arb_io_in_4_ready;
  assign _T_1585 = io_master_ar_bits_addr < 32'h80;
  assign _T_1588 = 32'h80 <= io_master_ar_bits_addr;
  assign _T_1590 = io_master_ar_bits_addr < 32'ha0;
  assign _T_1591 = _T_1588 & _T_1590;
  assign _T_1593 = 32'ha0 <= io_master_ar_bits_addr;
  assign _T_1595 = io_master_ar_bits_addr < 32'hc0;
  assign _T_1596 = _T_1593 & _T_1595;
  assign _T_1598 = 32'hc0 <= io_master_ar_bits_addr;
  assign _T_1600 = io_master_ar_bits_addr < 32'he0;
  assign _T_1601 = _T_1598 & _T_1600;
  assign _T_1603 = 32'he0 <= io_master_ar_bits_addr;
  assign _T_1605 = io_master_ar_bits_addr < 32'h100;
  assign _T_1606 = _T_1603 & _T_1605;
  assign _T_1607 = {_T_1591,_T_1585};
  assign _T_1608 = {_T_1606,_T_1601};
  assign _T_1609 = {_T_1608,_T_1596};
  assign ar_route = {_T_1609,_T_1607};
  assign _T_1613 = io_master_aw_bits_addr < 32'h80;
  assign _T_1616 = 32'h80 <= io_master_aw_bits_addr;
  assign _T_1618 = io_master_aw_bits_addr < 32'ha0;
  assign _T_1619 = _T_1616 & _T_1618;
  assign _T_1621 = 32'ha0 <= io_master_aw_bits_addr;
  assign _T_1623 = io_master_aw_bits_addr < 32'hc0;
  assign _T_1624 = _T_1621 & _T_1623;
  assign _T_1626 = 32'hc0 <= io_master_aw_bits_addr;
  assign _T_1628 = io_master_aw_bits_addr < 32'he0;
  assign _T_1629 = _T_1626 & _T_1628;
  assign _T_1631 = 32'he0 <= io_master_aw_bits_addr;
  assign _T_1633 = io_master_aw_bits_addr < 32'h100;
  assign _T_1634 = _T_1631 & _T_1633;
  assign _T_1635 = {_T_1619,_T_1613};
  assign _T_1636 = {_T_1634,_T_1629};
  assign _T_1637 = {_T_1636,_T_1624};
  assign aw_route = {_T_1637,_T_1635};
  assign _T_1641 = ar_route[0];
  assign _T_1642 = io_master_ar_valid & _T_1641;
  assign _T_1644 = io_slave_0_ar_ready & _T_1641;
  assign _T_1646 = aw_route[0];
  assign _T_1647 = io_master_aw_valid & _T_1646;
  assign _T_1649 = io_slave_0_aw_ready & _T_1646;
  assign _T_1653 = io_slave_0_w_ready & io_slave_0_w_valid;
  assign _T_1654 = _T_1653 & io_slave_0_w_bits_last;
  assign _GEN_0 = _T_1654 ? 1'h0 : _T_1652;
  assign _T_1656 = io_slave_0_aw_ready & io_slave_0_aw_valid;
  assign _GEN_1 = _T_1656 ? 1'h1 : _GEN_0;
  assign _T_1658 = io_master_w_valid & _T_1652;
  assign _T_1659 = io_slave_0_w_ready & _T_1652;
  assign _T_1661 = ar_route[1];
  assign _T_1662 = io_master_ar_valid & _T_1661;
  assign _T_1664 = io_slave_1_ar_ready & _T_1661;
  assign _T_1665 = _T_1644 | _T_1664;
  assign _T_1666 = aw_route[1];
  assign _T_1667 = io_master_aw_valid & _T_1666;
  assign _T_1669 = io_slave_1_aw_ready & _T_1666;
  assign _T_1670 = _T_1649 | _T_1669;
  assign _T_1673 = io_slave_1_w_ready & io_slave_1_w_valid;
  assign _T_1674 = _T_1673 & io_slave_1_w_bits_last;
  assign _GEN_2 = _T_1674 ? 1'h0 : _T_1672;
  assign _T_1676 = io_slave_1_aw_ready & io_slave_1_aw_valid;
  assign _GEN_3 = _T_1676 ? 1'h1 : _GEN_2;
  assign _T_1678 = io_master_w_valid & _T_1672;
  assign _T_1679 = io_slave_1_w_ready & _T_1672;
  assign _T_1680 = _T_1659 | _T_1679;
  assign _T_1681 = ar_route[2];
  assign _T_1682 = io_master_ar_valid & _T_1681;
  assign _T_1684 = io_slave_2_ar_ready & _T_1681;
  assign _T_1685 = _T_1665 | _T_1684;
  assign _T_1686 = aw_route[2];
  assign _T_1687 = io_master_aw_valid & _T_1686;
  assign _T_1689 = io_slave_2_aw_ready & _T_1686;
  assign _T_1690 = _T_1670 | _T_1689;
  assign _T_1693 = io_slave_2_w_ready & io_slave_2_w_valid;
  assign _T_1694 = _T_1693 & io_slave_2_w_bits_last;
  assign _GEN_4 = _T_1694 ? 1'h0 : _T_1692;
  assign _T_1696 = io_slave_2_aw_ready & io_slave_2_aw_valid;
  assign _GEN_5 = _T_1696 ? 1'h1 : _GEN_4;
  assign _T_1698 = io_master_w_valid & _T_1692;
  assign _T_1699 = io_slave_2_w_ready & _T_1692;
  assign _T_1700 = _T_1680 | _T_1699;
  assign _T_1701 = ar_route[3];
  assign _T_1702 = io_master_ar_valid & _T_1701;
  assign _T_1704 = io_slave_3_ar_ready & _T_1701;
  assign _T_1705 = _T_1685 | _T_1704;
  assign _T_1706 = aw_route[3];
  assign _T_1707 = io_master_aw_valid & _T_1706;
  assign _T_1709 = io_slave_3_aw_ready & _T_1706;
  assign _T_1710 = _T_1690 | _T_1709;
  assign _T_1713 = io_slave_3_w_ready & io_slave_3_w_valid;
  assign _T_1714 = _T_1713 & io_slave_3_w_bits_last;
  assign _GEN_6 = _T_1714 ? 1'h0 : _T_1712;
  assign _T_1716 = io_slave_3_aw_ready & io_slave_3_aw_valid;
  assign _GEN_7 = _T_1716 ? 1'h1 : _GEN_6;
  assign _T_1718 = io_master_w_valid & _T_1712;
  assign _T_1719 = io_slave_3_w_ready & _T_1712;
  assign _T_1720 = _T_1700 | _T_1719;
  assign _T_1721 = ar_route[4];
  assign _T_1722 = io_master_ar_valid & _T_1721;
  assign _T_1724 = io_slave_4_ar_ready & _T_1721;
  assign ar_ready = _T_1705 | _T_1724;
  assign _T_1725 = aw_route[4];
  assign _T_1726 = io_master_aw_valid & _T_1725;
  assign _T_1728 = io_slave_4_aw_ready & _T_1725;
  assign aw_ready = _T_1710 | _T_1728;
  assign _T_1731 = io_slave_4_w_ready & io_slave_4_w_valid;
  assign _T_1732 = _T_1731 & io_slave_4_w_bits_last;
  assign _GEN_8 = _T_1732 ? 1'h0 : _T_1730;
  assign _T_1734 = io_slave_4_aw_ready & io_slave_4_aw_valid;
  assign _GEN_9 = _T_1734 ? 1'h1 : _GEN_8;
  assign _T_1736 = io_master_w_valid & _T_1730;
  assign _T_1737 = io_slave_4_w_ready & _T_1730;
  assign w_ready = _T_1720 | _T_1737;
  assign _T_1739 = ar_route != 5'h0;
  assign r_invalid = _T_1739 == 1'h0;
  assign _T_1742 = aw_route != 5'h0;
  assign w_invalid = _T_1742 == 1'h0;
  assign err_slave_clock = clock;
  assign err_slave_reset = reset;
  assign err_slave_io_aw_valid = _T_1745;
  assign err_slave_io_aw_bits_addr = io_master_aw_bits_addr;
  assign err_slave_io_w_valid = io_master_w_valid;
  assign err_slave_io_b_ready = b_arb_io_in_5_ready;
  assign err_slave_io_ar_valid = _T_1744;
  assign err_slave_io_ar_bits_addr = io_master_ar_bits_addr;
  assign err_slave_io_r_ready = r_arb_io_in_5_ready;
  assign _T_1744 = r_invalid & io_master_ar_valid;
  assign _T_1745 = w_invalid & io_master_aw_valid;
  assign _T_1746 = r_invalid & err_slave_io_ar_ready;
  assign _T_1747 = ar_ready | _T_1746;
  assign _T_1748 = w_invalid & err_slave_io_aw_ready;
  assign _T_1749 = aw_ready | _T_1748;
  assign _T_1750 = w_ready | err_slave_io_w_ready;
  assign b_arb_clock = clock;
  assign b_arb_io_in_0_valid = io_slave_0_b_valid;
  assign b_arb_io_in_1_valid = io_slave_1_b_valid;
  assign b_arb_io_in_2_valid = io_slave_2_b_valid;
  assign b_arb_io_in_3_valid = io_slave_3_b_valid;
  assign b_arb_io_in_4_valid = io_slave_4_b_valid;
  assign b_arb_io_in_5_valid = err_slave_io_b_valid;
  assign b_arb_io_out_ready = io_master_b_ready;
  assign r_arb_clock = clock;
  assign r_arb_reset = reset;
  assign r_arb_io_in_0_valid = io_slave_0_r_valid;
  assign r_arb_io_in_0_bits_data = io_slave_0_r_bits_data;
  assign r_arb_io_in_1_valid = io_slave_1_r_valid;
  assign r_arb_io_in_1_bits_data = io_slave_1_r_bits_data;
  assign r_arb_io_in_2_valid = io_slave_2_r_valid;
  assign r_arb_io_in_2_bits_data = io_slave_2_r_bits_data;
  assign r_arb_io_in_2_bits_last = io_slave_2_r_bits_last;
  assign r_arb_io_in_3_valid = io_slave_3_r_valid;
  assign r_arb_io_in_3_bits_data = io_slave_3_r_bits_data;
  assign r_arb_io_in_4_valid = io_slave_4_r_valid;
  assign r_arb_io_in_4_bits_data = io_slave_4_r_bits_data;
  assign r_arb_io_in_4_bits_last = io_slave_4_r_bits_last;
  assign r_arb_io_in_5_valid = err_slave_io_r_valid;
  assign r_arb_io_in_5_bits_last = err_slave_io_r_bits_last;
  assign r_arb_io_out_ready = io_master_r_ready;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  _T_1652 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  _T_1672 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  _T_1692 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  _T_1712 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  _T_1730 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      _T_1652 <= 1'h0;
    end else begin
      if (_T_1656) begin
        _T_1652 <= 1'h1;
      end else begin
        if (_T_1654) begin
          _T_1652 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1672 <= 1'h0;
    end else begin
      if (_T_1676) begin
        _T_1672 <= 1'h1;
      end else begin
        if (_T_1674) begin
          _T_1672 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1692 <= 1'h0;
    end else begin
      if (_T_1696) begin
        _T_1692 <= 1'h1;
      end else begin
        if (_T_1694) begin
          _T_1692 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1712 <= 1'h0;
    end else begin
      if (_T_1716) begin
        _T_1712 <= 1'h1;
      end else begin
        if (_T_1714) begin
          _T_1712 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1730 <= 1'h0;
    end else begin
      if (_T_1734) begin
        _T_1730 <= 1'h1;
      end else begin
        if (_T_1732) begin
          _T_1730 <= 1'h0;
        end
      end
    end
  end
endmodule
module NastiCrossbar(
  input         clock,
  input         reset,
  output        io_masters_0_aw_ready,
  input         io_masters_0_aw_valid,
  input  [31:0] io_masters_0_aw_bits_addr,
  output        io_masters_0_w_ready,
  input         io_masters_0_w_valid,
  input  [63:0] io_masters_0_w_bits_data,
  input         io_masters_0_b_ready,
  output        io_masters_0_b_valid,
  output        io_masters_0_ar_ready,
  input         io_masters_0_ar_valid,
  input  [31:0] io_masters_0_ar_bits_addr,
  input         io_masters_0_r_ready,
  output        io_masters_0_r_valid,
  output [63:0] io_masters_0_r_bits_data,
  input         io_slaves_0_aw_ready,
  output        io_slaves_0_aw_valid,
  output [31:0] io_slaves_0_aw_bits_addr,
  input         io_slaves_0_w_ready,
  output        io_slaves_0_w_valid,
  output [63:0] io_slaves_0_w_bits_data,
  output        io_slaves_0_b_ready,
  input         io_slaves_0_b_valid,
  input         io_slaves_0_ar_ready,
  output        io_slaves_0_ar_valid,
  output [31:0] io_slaves_0_ar_bits_addr,
  output        io_slaves_0_r_ready,
  input         io_slaves_0_r_valid,
  input  [63:0] io_slaves_0_r_bits_data,
  input         io_slaves_1_aw_ready,
  output        io_slaves_1_aw_valid,
  output [31:0] io_slaves_1_aw_bits_addr,
  input         io_slaves_1_w_ready,
  output        io_slaves_1_w_valid,
  output [63:0] io_slaves_1_w_bits_data,
  output        io_slaves_1_b_ready,
  input         io_slaves_1_b_valid,
  input         io_slaves_1_ar_ready,
  output        io_slaves_1_ar_valid,
  output [31:0] io_slaves_1_ar_bits_addr,
  output        io_slaves_1_r_ready,
  input         io_slaves_1_r_valid,
  input  [63:0] io_slaves_1_r_bits_data,
  input         io_slaves_2_aw_ready,
  output        io_slaves_2_aw_valid,
  output [31:0] io_slaves_2_aw_bits_addr,
  input         io_slaves_2_w_ready,
  output        io_slaves_2_w_valid,
  output [63:0] io_slaves_2_w_bits_data,
  output        io_slaves_2_b_ready,
  input         io_slaves_2_b_valid,
  input         io_slaves_2_ar_ready,
  output        io_slaves_2_ar_valid,
  output [31:0] io_slaves_2_ar_bits_addr,
  output        io_slaves_2_r_ready,
  input         io_slaves_2_r_valid,
  input  [63:0] io_slaves_2_r_bits_data,
  input         io_slaves_2_r_bits_last,
  input         io_slaves_3_aw_ready,
  output        io_slaves_3_aw_valid,
  output [31:0] io_slaves_3_aw_bits_addr,
  input         io_slaves_3_w_ready,
  output        io_slaves_3_w_valid,
  output [63:0] io_slaves_3_w_bits_data,
  output        io_slaves_3_b_ready,
  input         io_slaves_3_b_valid,
  input         io_slaves_3_ar_ready,
  output        io_slaves_3_ar_valid,
  output [31:0] io_slaves_3_ar_bits_addr,
  output        io_slaves_3_r_ready,
  input         io_slaves_3_r_valid,
  input  [63:0] io_slaves_3_r_bits_data,
  input         io_slaves_4_aw_ready,
  output        io_slaves_4_aw_valid,
  output [31:0] io_slaves_4_aw_bits_addr,
  input         io_slaves_4_w_ready,
  output        io_slaves_4_w_valid,
  output [63:0] io_slaves_4_w_bits_data,
  output        io_slaves_4_b_ready,
  input         io_slaves_4_b_valid,
  input         io_slaves_4_ar_ready,
  output        io_slaves_4_ar_valid,
  output [31:0] io_slaves_4_ar_bits_addr,
  output        io_slaves_4_r_ready,
  input         io_slaves_4_r_valid,
  input  [63:0] io_slaves_4_r_bits_data,
  input         io_slaves_4_r_bits_last
);
  wire  NastiRouter_clock;
  wire  NastiRouter_reset;
  wire  NastiRouter_io_master_aw_ready;
  wire  NastiRouter_io_master_aw_valid;
  wire [31:0] NastiRouter_io_master_aw_bits_addr;
  wire  NastiRouter_io_master_w_ready;
  wire  NastiRouter_io_master_w_valid;
  wire [63:0] NastiRouter_io_master_w_bits_data;
  wire  NastiRouter_io_master_b_ready;
  wire  NastiRouter_io_master_b_valid;
  wire  NastiRouter_io_master_ar_ready;
  wire  NastiRouter_io_master_ar_valid;
  wire [31:0] NastiRouter_io_master_ar_bits_addr;
  wire  NastiRouter_io_master_r_ready;
  wire  NastiRouter_io_master_r_valid;
  wire [63:0] NastiRouter_io_master_r_bits_data;
  wire  NastiRouter_io_slave_0_aw_ready;
  wire  NastiRouter_io_slave_0_aw_valid;
  wire [31:0] NastiRouter_io_slave_0_aw_bits_addr;
  wire  NastiRouter_io_slave_0_w_ready;
  wire  NastiRouter_io_slave_0_w_valid;
  wire [63:0] NastiRouter_io_slave_0_w_bits_data;
  wire  NastiRouter_io_slave_0_w_bits_last;
  wire  NastiRouter_io_slave_0_b_ready;
  wire  NastiRouter_io_slave_0_b_valid;
  wire  NastiRouter_io_slave_0_ar_ready;
  wire  NastiRouter_io_slave_0_ar_valid;
  wire [31:0] NastiRouter_io_slave_0_ar_bits_addr;
  wire  NastiRouter_io_slave_0_r_ready;
  wire  NastiRouter_io_slave_0_r_valid;
  wire [63:0] NastiRouter_io_slave_0_r_bits_data;
  wire  NastiRouter_io_slave_1_aw_ready;
  wire  NastiRouter_io_slave_1_aw_valid;
  wire [31:0] NastiRouter_io_slave_1_aw_bits_addr;
  wire  NastiRouter_io_slave_1_w_ready;
  wire  NastiRouter_io_slave_1_w_valid;
  wire [63:0] NastiRouter_io_slave_1_w_bits_data;
  wire  NastiRouter_io_slave_1_w_bits_last;
  wire  NastiRouter_io_slave_1_b_ready;
  wire  NastiRouter_io_slave_1_b_valid;
  wire  NastiRouter_io_slave_1_ar_ready;
  wire  NastiRouter_io_slave_1_ar_valid;
  wire [31:0] NastiRouter_io_slave_1_ar_bits_addr;
  wire  NastiRouter_io_slave_1_r_ready;
  wire  NastiRouter_io_slave_1_r_valid;
  wire [63:0] NastiRouter_io_slave_1_r_bits_data;
  wire  NastiRouter_io_slave_2_aw_ready;
  wire  NastiRouter_io_slave_2_aw_valid;
  wire [31:0] NastiRouter_io_slave_2_aw_bits_addr;
  wire  NastiRouter_io_slave_2_w_ready;
  wire  NastiRouter_io_slave_2_w_valid;
  wire [63:0] NastiRouter_io_slave_2_w_bits_data;
  wire  NastiRouter_io_slave_2_w_bits_last;
  wire  NastiRouter_io_slave_2_b_ready;
  wire  NastiRouter_io_slave_2_b_valid;
  wire  NastiRouter_io_slave_2_ar_ready;
  wire  NastiRouter_io_slave_2_ar_valid;
  wire [31:0] NastiRouter_io_slave_2_ar_bits_addr;
  wire  NastiRouter_io_slave_2_r_ready;
  wire  NastiRouter_io_slave_2_r_valid;
  wire [63:0] NastiRouter_io_slave_2_r_bits_data;
  wire  NastiRouter_io_slave_2_r_bits_last;
  wire  NastiRouter_io_slave_3_aw_ready;
  wire  NastiRouter_io_slave_3_aw_valid;
  wire [31:0] NastiRouter_io_slave_3_aw_bits_addr;
  wire  NastiRouter_io_slave_3_w_ready;
  wire  NastiRouter_io_slave_3_w_valid;
  wire [63:0] NastiRouter_io_slave_3_w_bits_data;
  wire  NastiRouter_io_slave_3_w_bits_last;
  wire  NastiRouter_io_slave_3_b_ready;
  wire  NastiRouter_io_slave_3_b_valid;
  wire  NastiRouter_io_slave_3_ar_ready;
  wire  NastiRouter_io_slave_3_ar_valid;
  wire [31:0] NastiRouter_io_slave_3_ar_bits_addr;
  wire  NastiRouter_io_slave_3_r_ready;
  wire  NastiRouter_io_slave_3_r_valid;
  wire [63:0] NastiRouter_io_slave_3_r_bits_data;
  wire  NastiRouter_io_slave_4_aw_ready;
  wire  NastiRouter_io_slave_4_aw_valid;
  wire [31:0] NastiRouter_io_slave_4_aw_bits_addr;
  wire  NastiRouter_io_slave_4_w_ready;
  wire  NastiRouter_io_slave_4_w_valid;
  wire [63:0] NastiRouter_io_slave_4_w_bits_data;
  wire  NastiRouter_io_slave_4_w_bits_last;
  wire  NastiRouter_io_slave_4_b_ready;
  wire  NastiRouter_io_slave_4_b_valid;
  wire  NastiRouter_io_slave_4_ar_ready;
  wire  NastiRouter_io_slave_4_ar_valid;
  wire [31:0] NastiRouter_io_slave_4_ar_bits_addr;
  wire  NastiRouter_io_slave_4_r_ready;
  wire  NastiRouter_io_slave_4_r_valid;
  wire [63:0] NastiRouter_io_slave_4_r_bits_data;
  wire  NastiRouter_io_slave_4_r_bits_last;
  NastiRouter NastiRouter (
    .clock(NastiRouter_clock),
    .reset(NastiRouter_reset),
    .io_master_aw_ready(NastiRouter_io_master_aw_ready),
    .io_master_aw_valid(NastiRouter_io_master_aw_valid),
    .io_master_aw_bits_addr(NastiRouter_io_master_aw_bits_addr),
    .io_master_w_ready(NastiRouter_io_master_w_ready),
    .io_master_w_valid(NastiRouter_io_master_w_valid),
    .io_master_w_bits_data(NastiRouter_io_master_w_bits_data),
    .io_master_b_ready(NastiRouter_io_master_b_ready),
    .io_master_b_valid(NastiRouter_io_master_b_valid),
    .io_master_ar_ready(NastiRouter_io_master_ar_ready),
    .io_master_ar_valid(NastiRouter_io_master_ar_valid),
    .io_master_ar_bits_addr(NastiRouter_io_master_ar_bits_addr),
    .io_master_r_ready(NastiRouter_io_master_r_ready),
    .io_master_r_valid(NastiRouter_io_master_r_valid),
    .io_master_r_bits_data(NastiRouter_io_master_r_bits_data),
    .io_slave_0_aw_ready(NastiRouter_io_slave_0_aw_ready),
    .io_slave_0_aw_valid(NastiRouter_io_slave_0_aw_valid),
    .io_slave_0_aw_bits_addr(NastiRouter_io_slave_0_aw_bits_addr),
    .io_slave_0_w_ready(NastiRouter_io_slave_0_w_ready),
    .io_slave_0_w_valid(NastiRouter_io_slave_0_w_valid),
    .io_slave_0_w_bits_data(NastiRouter_io_slave_0_w_bits_data),
    .io_slave_0_w_bits_last(NastiRouter_io_slave_0_w_bits_last),
    .io_slave_0_b_ready(NastiRouter_io_slave_0_b_ready),
    .io_slave_0_b_valid(NastiRouter_io_slave_0_b_valid),
    .io_slave_0_ar_ready(NastiRouter_io_slave_0_ar_ready),
    .io_slave_0_ar_valid(NastiRouter_io_slave_0_ar_valid),
    .io_slave_0_ar_bits_addr(NastiRouter_io_slave_0_ar_bits_addr),
    .io_slave_0_r_ready(NastiRouter_io_slave_0_r_ready),
    .io_slave_0_r_valid(NastiRouter_io_slave_0_r_valid),
    .io_slave_0_r_bits_data(NastiRouter_io_slave_0_r_bits_data),
    .io_slave_1_aw_ready(NastiRouter_io_slave_1_aw_ready),
    .io_slave_1_aw_valid(NastiRouter_io_slave_1_aw_valid),
    .io_slave_1_aw_bits_addr(NastiRouter_io_slave_1_aw_bits_addr),
    .io_slave_1_w_ready(NastiRouter_io_slave_1_w_ready),
    .io_slave_1_w_valid(NastiRouter_io_slave_1_w_valid),
    .io_slave_1_w_bits_data(NastiRouter_io_slave_1_w_bits_data),
    .io_slave_1_w_bits_last(NastiRouter_io_slave_1_w_bits_last),
    .io_slave_1_b_ready(NastiRouter_io_slave_1_b_ready),
    .io_slave_1_b_valid(NastiRouter_io_slave_1_b_valid),
    .io_slave_1_ar_ready(NastiRouter_io_slave_1_ar_ready),
    .io_slave_1_ar_valid(NastiRouter_io_slave_1_ar_valid),
    .io_slave_1_ar_bits_addr(NastiRouter_io_slave_1_ar_bits_addr),
    .io_slave_1_r_ready(NastiRouter_io_slave_1_r_ready),
    .io_slave_1_r_valid(NastiRouter_io_slave_1_r_valid),
    .io_slave_1_r_bits_data(NastiRouter_io_slave_1_r_bits_data),
    .io_slave_2_aw_ready(NastiRouter_io_slave_2_aw_ready),
    .io_slave_2_aw_valid(NastiRouter_io_slave_2_aw_valid),
    .io_slave_2_aw_bits_addr(NastiRouter_io_slave_2_aw_bits_addr),
    .io_slave_2_w_ready(NastiRouter_io_slave_2_w_ready),
    .io_slave_2_w_valid(NastiRouter_io_slave_2_w_valid),
    .io_slave_2_w_bits_data(NastiRouter_io_slave_2_w_bits_data),
    .io_slave_2_w_bits_last(NastiRouter_io_slave_2_w_bits_last),
    .io_slave_2_b_ready(NastiRouter_io_slave_2_b_ready),
    .io_slave_2_b_valid(NastiRouter_io_slave_2_b_valid),
    .io_slave_2_ar_ready(NastiRouter_io_slave_2_ar_ready),
    .io_slave_2_ar_valid(NastiRouter_io_slave_2_ar_valid),
    .io_slave_2_ar_bits_addr(NastiRouter_io_slave_2_ar_bits_addr),
    .io_slave_2_r_ready(NastiRouter_io_slave_2_r_ready),
    .io_slave_2_r_valid(NastiRouter_io_slave_2_r_valid),
    .io_slave_2_r_bits_data(NastiRouter_io_slave_2_r_bits_data),
    .io_slave_2_r_bits_last(NastiRouter_io_slave_2_r_bits_last),
    .io_slave_3_aw_ready(NastiRouter_io_slave_3_aw_ready),
    .io_slave_3_aw_valid(NastiRouter_io_slave_3_aw_valid),
    .io_slave_3_aw_bits_addr(NastiRouter_io_slave_3_aw_bits_addr),
    .io_slave_3_w_ready(NastiRouter_io_slave_3_w_ready),
    .io_slave_3_w_valid(NastiRouter_io_slave_3_w_valid),
    .io_slave_3_w_bits_data(NastiRouter_io_slave_3_w_bits_data),
    .io_slave_3_w_bits_last(NastiRouter_io_slave_3_w_bits_last),
    .io_slave_3_b_ready(NastiRouter_io_slave_3_b_ready),
    .io_slave_3_b_valid(NastiRouter_io_slave_3_b_valid),
    .io_slave_3_ar_ready(NastiRouter_io_slave_3_ar_ready),
    .io_slave_3_ar_valid(NastiRouter_io_slave_3_ar_valid),
    .io_slave_3_ar_bits_addr(NastiRouter_io_slave_3_ar_bits_addr),
    .io_slave_3_r_ready(NastiRouter_io_slave_3_r_ready),
    .io_slave_3_r_valid(NastiRouter_io_slave_3_r_valid),
    .io_slave_3_r_bits_data(NastiRouter_io_slave_3_r_bits_data),
    .io_slave_4_aw_ready(NastiRouter_io_slave_4_aw_ready),
    .io_slave_4_aw_valid(NastiRouter_io_slave_4_aw_valid),
    .io_slave_4_aw_bits_addr(NastiRouter_io_slave_4_aw_bits_addr),
    .io_slave_4_w_ready(NastiRouter_io_slave_4_w_ready),
    .io_slave_4_w_valid(NastiRouter_io_slave_4_w_valid),
    .io_slave_4_w_bits_data(NastiRouter_io_slave_4_w_bits_data),
    .io_slave_4_w_bits_last(NastiRouter_io_slave_4_w_bits_last),
    .io_slave_4_b_ready(NastiRouter_io_slave_4_b_ready),
    .io_slave_4_b_valid(NastiRouter_io_slave_4_b_valid),
    .io_slave_4_ar_ready(NastiRouter_io_slave_4_ar_ready),
    .io_slave_4_ar_valid(NastiRouter_io_slave_4_ar_valid),
    .io_slave_4_ar_bits_addr(NastiRouter_io_slave_4_ar_bits_addr),
    .io_slave_4_r_ready(NastiRouter_io_slave_4_r_ready),
    .io_slave_4_r_valid(NastiRouter_io_slave_4_r_valid),
    .io_slave_4_r_bits_data(NastiRouter_io_slave_4_r_bits_data),
    .io_slave_4_r_bits_last(NastiRouter_io_slave_4_r_bits_last)
  );
  assign io_masters_0_aw_ready = NastiRouter_io_master_aw_ready;
  assign io_masters_0_w_ready = NastiRouter_io_master_w_ready;
  assign io_masters_0_b_valid = NastiRouter_io_master_b_valid;
  assign io_masters_0_ar_ready = NastiRouter_io_master_ar_ready;
  assign io_masters_0_r_valid = NastiRouter_io_master_r_valid;
  assign io_masters_0_r_bits_data = NastiRouter_io_master_r_bits_data;
  assign io_slaves_0_aw_valid = NastiRouter_io_slave_0_aw_valid;
  assign io_slaves_0_aw_bits_addr = NastiRouter_io_slave_0_aw_bits_addr;
  assign io_slaves_0_w_valid = NastiRouter_io_slave_0_w_valid;
  assign io_slaves_0_w_bits_data = NastiRouter_io_slave_0_w_bits_data;
  assign io_slaves_0_b_ready = NastiRouter_io_slave_0_b_ready;
  assign io_slaves_0_ar_valid = NastiRouter_io_slave_0_ar_valid;
  assign io_slaves_0_ar_bits_addr = NastiRouter_io_slave_0_ar_bits_addr;
  assign io_slaves_0_r_ready = NastiRouter_io_slave_0_r_ready;
  assign io_slaves_1_aw_valid = NastiRouter_io_slave_1_aw_valid;
  assign io_slaves_1_aw_bits_addr = NastiRouter_io_slave_1_aw_bits_addr;
  assign io_slaves_1_w_valid = NastiRouter_io_slave_1_w_valid;
  assign io_slaves_1_w_bits_data = NastiRouter_io_slave_1_w_bits_data;
  assign io_slaves_1_b_ready = NastiRouter_io_slave_1_b_ready;
  assign io_slaves_1_ar_valid = NastiRouter_io_slave_1_ar_valid;
  assign io_slaves_1_ar_bits_addr = NastiRouter_io_slave_1_ar_bits_addr;
  assign io_slaves_1_r_ready = NastiRouter_io_slave_1_r_ready;
  assign io_slaves_2_aw_valid = NastiRouter_io_slave_2_aw_valid;
  assign io_slaves_2_aw_bits_addr = NastiRouter_io_slave_2_aw_bits_addr;
  assign io_slaves_2_w_valid = NastiRouter_io_slave_2_w_valid;
  assign io_slaves_2_w_bits_data = NastiRouter_io_slave_2_w_bits_data;
  assign io_slaves_2_b_ready = NastiRouter_io_slave_2_b_ready;
  assign io_slaves_2_ar_valid = NastiRouter_io_slave_2_ar_valid;
  assign io_slaves_2_ar_bits_addr = NastiRouter_io_slave_2_ar_bits_addr;
  assign io_slaves_2_r_ready = NastiRouter_io_slave_2_r_ready;
  assign io_slaves_3_aw_valid = NastiRouter_io_slave_3_aw_valid;
  assign io_slaves_3_aw_bits_addr = NastiRouter_io_slave_3_aw_bits_addr;
  assign io_slaves_3_w_valid = NastiRouter_io_slave_3_w_valid;
  assign io_slaves_3_w_bits_data = NastiRouter_io_slave_3_w_bits_data;
  assign io_slaves_3_b_ready = NastiRouter_io_slave_3_b_ready;
  assign io_slaves_3_ar_valid = NastiRouter_io_slave_3_ar_valid;
  assign io_slaves_3_ar_bits_addr = NastiRouter_io_slave_3_ar_bits_addr;
  assign io_slaves_3_r_ready = NastiRouter_io_slave_3_r_ready;
  assign io_slaves_4_aw_valid = NastiRouter_io_slave_4_aw_valid;
  assign io_slaves_4_aw_bits_addr = NastiRouter_io_slave_4_aw_bits_addr;
  assign io_slaves_4_w_valid = NastiRouter_io_slave_4_w_valid;
  assign io_slaves_4_w_bits_data = NastiRouter_io_slave_4_w_bits_data;
  assign io_slaves_4_b_ready = NastiRouter_io_slave_4_b_ready;
  assign io_slaves_4_ar_valid = NastiRouter_io_slave_4_ar_valid;
  assign io_slaves_4_ar_bits_addr = NastiRouter_io_slave_4_ar_bits_addr;
  assign io_slaves_4_r_ready = NastiRouter_io_slave_4_r_ready;
  assign NastiRouter_clock = clock;
  assign NastiRouter_reset = reset;
  assign NastiRouter_io_master_aw_valid = io_masters_0_aw_valid;
  assign NastiRouter_io_master_aw_bits_addr = io_masters_0_aw_bits_addr;
  assign NastiRouter_io_master_w_valid = io_masters_0_w_valid;
  assign NastiRouter_io_master_w_bits_data = io_masters_0_w_bits_data;
  assign NastiRouter_io_master_b_ready = io_masters_0_b_ready;
  assign NastiRouter_io_master_ar_valid = io_masters_0_ar_valid;
  assign NastiRouter_io_master_ar_bits_addr = io_masters_0_ar_bits_addr;
  assign NastiRouter_io_master_r_ready = io_masters_0_r_ready;
  assign NastiRouter_io_slave_0_aw_ready = io_slaves_0_aw_ready;
  assign NastiRouter_io_slave_0_w_ready = io_slaves_0_w_ready;
  assign NastiRouter_io_slave_0_b_valid = io_slaves_0_b_valid;
  assign NastiRouter_io_slave_0_ar_ready = io_slaves_0_ar_ready;
  assign NastiRouter_io_slave_0_r_valid = io_slaves_0_r_valid;
  assign NastiRouter_io_slave_0_r_bits_data = io_slaves_0_r_bits_data;
  assign NastiRouter_io_slave_1_aw_ready = io_slaves_1_aw_ready;
  assign NastiRouter_io_slave_1_w_ready = io_slaves_1_w_ready;
  assign NastiRouter_io_slave_1_b_valid = io_slaves_1_b_valid;
  assign NastiRouter_io_slave_1_ar_ready = io_slaves_1_ar_ready;
  assign NastiRouter_io_slave_1_r_valid = io_slaves_1_r_valid;
  assign NastiRouter_io_slave_1_r_bits_data = io_slaves_1_r_bits_data;
  assign NastiRouter_io_slave_2_aw_ready = io_slaves_2_aw_ready;
  assign NastiRouter_io_slave_2_w_ready = io_slaves_2_w_ready;
  assign NastiRouter_io_slave_2_b_valid = io_slaves_2_b_valid;
  assign NastiRouter_io_slave_2_ar_ready = io_slaves_2_ar_ready;
  assign NastiRouter_io_slave_2_r_valid = io_slaves_2_r_valid;
  assign NastiRouter_io_slave_2_r_bits_data = io_slaves_2_r_bits_data;
  assign NastiRouter_io_slave_2_r_bits_last = io_slaves_2_r_bits_last;
  assign NastiRouter_io_slave_3_aw_ready = io_slaves_3_aw_ready;
  assign NastiRouter_io_slave_3_w_ready = io_slaves_3_w_ready;
  assign NastiRouter_io_slave_3_b_valid = io_slaves_3_b_valid;
  assign NastiRouter_io_slave_3_ar_ready = io_slaves_3_ar_ready;
  assign NastiRouter_io_slave_3_r_valid = io_slaves_3_r_valid;
  assign NastiRouter_io_slave_3_r_bits_data = io_slaves_3_r_bits_data;
  assign NastiRouter_io_slave_4_aw_ready = io_slaves_4_aw_ready;
  assign NastiRouter_io_slave_4_w_ready = io_slaves_4_w_ready;
  assign NastiRouter_io_slave_4_b_valid = io_slaves_4_b_valid;
  assign NastiRouter_io_slave_4_ar_ready = io_slaves_4_ar_ready;
  assign NastiRouter_io_slave_4_r_valid = io_slaves_4_r_valid;
  assign NastiRouter_io_slave_4_r_bits_data = io_slaves_4_r_bits_data;
  assign NastiRouter_io_slave_4_r_bits_last = io_slaves_4_r_bits_last;
endmodule
module NastiRecursiveInterconnect(
  input         clock,
  input         reset,
  output        io_masters_0_aw_ready,
  input         io_masters_0_aw_valid,
  input  [31:0] io_masters_0_aw_bits_addr,
  output        io_masters_0_w_ready,
  input         io_masters_0_w_valid,
  input  [63:0] io_masters_0_w_bits_data,
  input         io_masters_0_b_ready,
  output        io_masters_0_b_valid,
  output        io_masters_0_ar_ready,
  input         io_masters_0_ar_valid,
  input  [31:0] io_masters_0_ar_bits_addr,
  input         io_masters_0_r_ready,
  output        io_masters_0_r_valid,
  output [63:0] io_masters_0_r_bits_data,
  input         io_slaves_0_aw_ready,
  output        io_slaves_0_aw_valid,
  output [31:0] io_slaves_0_aw_bits_addr,
  input         io_slaves_0_w_ready,
  output        io_slaves_0_w_valid,
  output [63:0] io_slaves_0_w_bits_data,
  output        io_slaves_0_b_ready,
  input         io_slaves_0_b_valid,
  input         io_slaves_0_ar_ready,
  output        io_slaves_0_ar_valid,
  output [31:0] io_slaves_0_ar_bits_addr,
  output        io_slaves_0_r_ready,
  input         io_slaves_0_r_valid,
  input  [63:0] io_slaves_0_r_bits_data,
  input         io_slaves_1_aw_ready,
  output        io_slaves_1_aw_valid,
  output [31:0] io_slaves_1_aw_bits_addr,
  input         io_slaves_1_w_ready,
  output        io_slaves_1_w_valid,
  output [63:0] io_slaves_1_w_bits_data,
  output        io_slaves_1_b_ready,
  input         io_slaves_1_b_valid,
  input         io_slaves_1_ar_ready,
  output        io_slaves_1_ar_valid,
  output [31:0] io_slaves_1_ar_bits_addr,
  output        io_slaves_1_r_ready,
  input         io_slaves_1_r_valid,
  input  [63:0] io_slaves_1_r_bits_data,
  input         io_slaves_2_aw_ready,
  output        io_slaves_2_aw_valid,
  output [31:0] io_slaves_2_aw_bits_addr,
  input         io_slaves_2_w_ready,
  output        io_slaves_2_w_valid,
  output [63:0] io_slaves_2_w_bits_data,
  output        io_slaves_2_b_ready,
  input         io_slaves_2_b_valid,
  input         io_slaves_2_ar_ready,
  output        io_slaves_2_ar_valid,
  output [31:0] io_slaves_2_ar_bits_addr,
  output        io_slaves_2_r_ready,
  input         io_slaves_2_r_valid,
  input  [63:0] io_slaves_2_r_bits_data,
  input         io_slaves_2_r_bits_last,
  input         io_slaves_3_aw_ready,
  output        io_slaves_3_aw_valid,
  output [31:0] io_slaves_3_aw_bits_addr,
  input         io_slaves_3_w_ready,
  output        io_slaves_3_w_valid,
  output [63:0] io_slaves_3_w_bits_data,
  output        io_slaves_3_b_ready,
  input         io_slaves_3_b_valid,
  input         io_slaves_3_ar_ready,
  output        io_slaves_3_ar_valid,
  output [31:0] io_slaves_3_ar_bits_addr,
  output        io_slaves_3_r_ready,
  input         io_slaves_3_r_valid,
  input  [63:0] io_slaves_3_r_bits_data,
  input         io_slaves_4_aw_ready,
  output        io_slaves_4_aw_valid,
  output [31:0] io_slaves_4_aw_bits_addr,
  input         io_slaves_4_w_ready,
  output        io_slaves_4_w_valid,
  output [63:0] io_slaves_4_w_bits_data,
  output        io_slaves_4_b_ready,
  input         io_slaves_4_b_valid,
  input         io_slaves_4_ar_ready,
  output        io_slaves_4_ar_valid,
  output [31:0] io_slaves_4_ar_bits_addr,
  output        io_slaves_4_r_ready,
  input         io_slaves_4_r_valid,
  input  [63:0] io_slaves_4_r_bits_data,
  input         io_slaves_4_r_bits_last
);
  wire  xbar_clock;
  wire  xbar_reset;
  wire  xbar_io_masters_0_aw_ready;
  wire  xbar_io_masters_0_aw_valid;
  wire [31:0] xbar_io_masters_0_aw_bits_addr;
  wire  xbar_io_masters_0_w_ready;
  wire  xbar_io_masters_0_w_valid;
  wire [63:0] xbar_io_masters_0_w_bits_data;
  wire  xbar_io_masters_0_b_ready;
  wire  xbar_io_masters_0_b_valid;
  wire  xbar_io_masters_0_ar_ready;
  wire  xbar_io_masters_0_ar_valid;
  wire [31:0] xbar_io_masters_0_ar_bits_addr;
  wire  xbar_io_masters_0_r_ready;
  wire  xbar_io_masters_0_r_valid;
  wire [63:0] xbar_io_masters_0_r_bits_data;
  wire  xbar_io_slaves_0_aw_ready;
  wire  xbar_io_slaves_0_aw_valid;
  wire [31:0] xbar_io_slaves_0_aw_bits_addr;
  wire  xbar_io_slaves_0_w_ready;
  wire  xbar_io_slaves_0_w_valid;
  wire [63:0] xbar_io_slaves_0_w_bits_data;
  wire  xbar_io_slaves_0_b_ready;
  wire  xbar_io_slaves_0_b_valid;
  wire  xbar_io_slaves_0_ar_ready;
  wire  xbar_io_slaves_0_ar_valid;
  wire [31:0] xbar_io_slaves_0_ar_bits_addr;
  wire  xbar_io_slaves_0_r_ready;
  wire  xbar_io_slaves_0_r_valid;
  wire [63:0] xbar_io_slaves_0_r_bits_data;
  wire  xbar_io_slaves_1_aw_ready;
  wire  xbar_io_slaves_1_aw_valid;
  wire [31:0] xbar_io_slaves_1_aw_bits_addr;
  wire  xbar_io_slaves_1_w_ready;
  wire  xbar_io_slaves_1_w_valid;
  wire [63:0] xbar_io_slaves_1_w_bits_data;
  wire  xbar_io_slaves_1_b_ready;
  wire  xbar_io_slaves_1_b_valid;
  wire  xbar_io_slaves_1_ar_ready;
  wire  xbar_io_slaves_1_ar_valid;
  wire [31:0] xbar_io_slaves_1_ar_bits_addr;
  wire  xbar_io_slaves_1_r_ready;
  wire  xbar_io_slaves_1_r_valid;
  wire [63:0] xbar_io_slaves_1_r_bits_data;
  wire  xbar_io_slaves_2_aw_ready;
  wire  xbar_io_slaves_2_aw_valid;
  wire [31:0] xbar_io_slaves_2_aw_bits_addr;
  wire  xbar_io_slaves_2_w_ready;
  wire  xbar_io_slaves_2_w_valid;
  wire [63:0] xbar_io_slaves_2_w_bits_data;
  wire  xbar_io_slaves_2_b_ready;
  wire  xbar_io_slaves_2_b_valid;
  wire  xbar_io_slaves_2_ar_ready;
  wire  xbar_io_slaves_2_ar_valid;
  wire [31:0] xbar_io_slaves_2_ar_bits_addr;
  wire  xbar_io_slaves_2_r_ready;
  wire  xbar_io_slaves_2_r_valid;
  wire [63:0] xbar_io_slaves_2_r_bits_data;
  wire  xbar_io_slaves_2_r_bits_last;
  wire  xbar_io_slaves_3_aw_ready;
  wire  xbar_io_slaves_3_aw_valid;
  wire [31:0] xbar_io_slaves_3_aw_bits_addr;
  wire  xbar_io_slaves_3_w_ready;
  wire  xbar_io_slaves_3_w_valid;
  wire [63:0] xbar_io_slaves_3_w_bits_data;
  wire  xbar_io_slaves_3_b_ready;
  wire  xbar_io_slaves_3_b_valid;
  wire  xbar_io_slaves_3_ar_ready;
  wire  xbar_io_slaves_3_ar_valid;
  wire [31:0] xbar_io_slaves_3_ar_bits_addr;
  wire  xbar_io_slaves_3_r_ready;
  wire  xbar_io_slaves_3_r_valid;
  wire [63:0] xbar_io_slaves_3_r_bits_data;
  wire  xbar_io_slaves_4_aw_ready;
  wire  xbar_io_slaves_4_aw_valid;
  wire [31:0] xbar_io_slaves_4_aw_bits_addr;
  wire  xbar_io_slaves_4_w_ready;
  wire  xbar_io_slaves_4_w_valid;
  wire [63:0] xbar_io_slaves_4_w_bits_data;
  wire  xbar_io_slaves_4_b_ready;
  wire  xbar_io_slaves_4_b_valid;
  wire  xbar_io_slaves_4_ar_ready;
  wire  xbar_io_slaves_4_ar_valid;
  wire [31:0] xbar_io_slaves_4_ar_bits_addr;
  wire  xbar_io_slaves_4_r_ready;
  wire  xbar_io_slaves_4_r_valid;
  wire [63:0] xbar_io_slaves_4_r_bits_data;
  wire  xbar_io_slaves_4_r_bits_last;
  NastiCrossbar xbar (
    .clock(xbar_clock),
    .reset(xbar_reset),
    .io_masters_0_aw_ready(xbar_io_masters_0_aw_ready),
    .io_masters_0_aw_valid(xbar_io_masters_0_aw_valid),
    .io_masters_0_aw_bits_addr(xbar_io_masters_0_aw_bits_addr),
    .io_masters_0_w_ready(xbar_io_masters_0_w_ready),
    .io_masters_0_w_valid(xbar_io_masters_0_w_valid),
    .io_masters_0_w_bits_data(xbar_io_masters_0_w_bits_data),
    .io_masters_0_b_ready(xbar_io_masters_0_b_ready),
    .io_masters_0_b_valid(xbar_io_masters_0_b_valid),
    .io_masters_0_ar_ready(xbar_io_masters_0_ar_ready),
    .io_masters_0_ar_valid(xbar_io_masters_0_ar_valid),
    .io_masters_0_ar_bits_addr(xbar_io_masters_0_ar_bits_addr),
    .io_masters_0_r_ready(xbar_io_masters_0_r_ready),
    .io_masters_0_r_valid(xbar_io_masters_0_r_valid),
    .io_masters_0_r_bits_data(xbar_io_masters_0_r_bits_data),
    .io_slaves_0_aw_ready(xbar_io_slaves_0_aw_ready),
    .io_slaves_0_aw_valid(xbar_io_slaves_0_aw_valid),
    .io_slaves_0_aw_bits_addr(xbar_io_slaves_0_aw_bits_addr),
    .io_slaves_0_w_ready(xbar_io_slaves_0_w_ready),
    .io_slaves_0_w_valid(xbar_io_slaves_0_w_valid),
    .io_slaves_0_w_bits_data(xbar_io_slaves_0_w_bits_data),
    .io_slaves_0_b_ready(xbar_io_slaves_0_b_ready),
    .io_slaves_0_b_valid(xbar_io_slaves_0_b_valid),
    .io_slaves_0_ar_ready(xbar_io_slaves_0_ar_ready),
    .io_slaves_0_ar_valid(xbar_io_slaves_0_ar_valid),
    .io_slaves_0_ar_bits_addr(xbar_io_slaves_0_ar_bits_addr),
    .io_slaves_0_r_ready(xbar_io_slaves_0_r_ready),
    .io_slaves_0_r_valid(xbar_io_slaves_0_r_valid),
    .io_slaves_0_r_bits_data(xbar_io_slaves_0_r_bits_data),
    .io_slaves_1_aw_ready(xbar_io_slaves_1_aw_ready),
    .io_slaves_1_aw_valid(xbar_io_slaves_1_aw_valid),
    .io_slaves_1_aw_bits_addr(xbar_io_slaves_1_aw_bits_addr),
    .io_slaves_1_w_ready(xbar_io_slaves_1_w_ready),
    .io_slaves_1_w_valid(xbar_io_slaves_1_w_valid),
    .io_slaves_1_w_bits_data(xbar_io_slaves_1_w_bits_data),
    .io_slaves_1_b_ready(xbar_io_slaves_1_b_ready),
    .io_slaves_1_b_valid(xbar_io_slaves_1_b_valid),
    .io_slaves_1_ar_ready(xbar_io_slaves_1_ar_ready),
    .io_slaves_1_ar_valid(xbar_io_slaves_1_ar_valid),
    .io_slaves_1_ar_bits_addr(xbar_io_slaves_1_ar_bits_addr),
    .io_slaves_1_r_ready(xbar_io_slaves_1_r_ready),
    .io_slaves_1_r_valid(xbar_io_slaves_1_r_valid),
    .io_slaves_1_r_bits_data(xbar_io_slaves_1_r_bits_data),
    .io_slaves_2_aw_ready(xbar_io_slaves_2_aw_ready),
    .io_slaves_2_aw_valid(xbar_io_slaves_2_aw_valid),
    .io_slaves_2_aw_bits_addr(xbar_io_slaves_2_aw_bits_addr),
    .io_slaves_2_w_ready(xbar_io_slaves_2_w_ready),
    .io_slaves_2_w_valid(xbar_io_slaves_2_w_valid),
    .io_slaves_2_w_bits_data(xbar_io_slaves_2_w_bits_data),
    .io_slaves_2_b_ready(xbar_io_slaves_2_b_ready),
    .io_slaves_2_b_valid(xbar_io_slaves_2_b_valid),
    .io_slaves_2_ar_ready(xbar_io_slaves_2_ar_ready),
    .io_slaves_2_ar_valid(xbar_io_slaves_2_ar_valid),
    .io_slaves_2_ar_bits_addr(xbar_io_slaves_2_ar_bits_addr),
    .io_slaves_2_r_ready(xbar_io_slaves_2_r_ready),
    .io_slaves_2_r_valid(xbar_io_slaves_2_r_valid),
    .io_slaves_2_r_bits_data(xbar_io_slaves_2_r_bits_data),
    .io_slaves_2_r_bits_last(xbar_io_slaves_2_r_bits_last),
    .io_slaves_3_aw_ready(xbar_io_slaves_3_aw_ready),
    .io_slaves_3_aw_valid(xbar_io_slaves_3_aw_valid),
    .io_slaves_3_aw_bits_addr(xbar_io_slaves_3_aw_bits_addr),
    .io_slaves_3_w_ready(xbar_io_slaves_3_w_ready),
    .io_slaves_3_w_valid(xbar_io_slaves_3_w_valid),
    .io_slaves_3_w_bits_data(xbar_io_slaves_3_w_bits_data),
    .io_slaves_3_b_ready(xbar_io_slaves_3_b_ready),
    .io_slaves_3_b_valid(xbar_io_slaves_3_b_valid),
    .io_slaves_3_ar_ready(xbar_io_slaves_3_ar_ready),
    .io_slaves_3_ar_valid(xbar_io_slaves_3_ar_valid),
    .io_slaves_3_ar_bits_addr(xbar_io_slaves_3_ar_bits_addr),
    .io_slaves_3_r_ready(xbar_io_slaves_3_r_ready),
    .io_slaves_3_r_valid(xbar_io_slaves_3_r_valid),
    .io_slaves_3_r_bits_data(xbar_io_slaves_3_r_bits_data),
    .io_slaves_4_aw_ready(xbar_io_slaves_4_aw_ready),
    .io_slaves_4_aw_valid(xbar_io_slaves_4_aw_valid),
    .io_slaves_4_aw_bits_addr(xbar_io_slaves_4_aw_bits_addr),
    .io_slaves_4_w_ready(xbar_io_slaves_4_w_ready),
    .io_slaves_4_w_valid(xbar_io_slaves_4_w_valid),
    .io_slaves_4_w_bits_data(xbar_io_slaves_4_w_bits_data),
    .io_slaves_4_b_ready(xbar_io_slaves_4_b_ready),
    .io_slaves_4_b_valid(xbar_io_slaves_4_b_valid),
    .io_slaves_4_ar_ready(xbar_io_slaves_4_ar_ready),
    .io_slaves_4_ar_valid(xbar_io_slaves_4_ar_valid),
    .io_slaves_4_ar_bits_addr(xbar_io_slaves_4_ar_bits_addr),
    .io_slaves_4_r_ready(xbar_io_slaves_4_r_ready),
    .io_slaves_4_r_valid(xbar_io_slaves_4_r_valid),
    .io_slaves_4_r_bits_data(xbar_io_slaves_4_r_bits_data),
    .io_slaves_4_r_bits_last(xbar_io_slaves_4_r_bits_last)
  );
  assign io_masters_0_aw_ready = xbar_io_masters_0_aw_ready;
  assign io_masters_0_w_ready = xbar_io_masters_0_w_ready;
  assign io_masters_0_b_valid = xbar_io_masters_0_b_valid;
  assign io_masters_0_ar_ready = xbar_io_masters_0_ar_ready;
  assign io_masters_0_r_valid = xbar_io_masters_0_r_valid;
  assign io_masters_0_r_bits_data = xbar_io_masters_0_r_bits_data;
  assign io_slaves_0_aw_valid = xbar_io_slaves_0_aw_valid;
  assign io_slaves_0_aw_bits_addr = xbar_io_slaves_0_aw_bits_addr;
  assign io_slaves_0_w_valid = xbar_io_slaves_0_w_valid;
  assign io_slaves_0_w_bits_data = xbar_io_slaves_0_w_bits_data;
  assign io_slaves_0_b_ready = xbar_io_slaves_0_b_ready;
  assign io_slaves_0_ar_valid = xbar_io_slaves_0_ar_valid;
  assign io_slaves_0_ar_bits_addr = xbar_io_slaves_0_ar_bits_addr;
  assign io_slaves_0_r_ready = xbar_io_slaves_0_r_ready;
  assign io_slaves_1_aw_valid = xbar_io_slaves_1_aw_valid;
  assign io_slaves_1_aw_bits_addr = xbar_io_slaves_1_aw_bits_addr;
  assign io_slaves_1_w_valid = xbar_io_slaves_1_w_valid;
  assign io_slaves_1_w_bits_data = xbar_io_slaves_1_w_bits_data;
  assign io_slaves_1_b_ready = xbar_io_slaves_1_b_ready;
  assign io_slaves_1_ar_valid = xbar_io_slaves_1_ar_valid;
  assign io_slaves_1_ar_bits_addr = xbar_io_slaves_1_ar_bits_addr;
  assign io_slaves_1_r_ready = xbar_io_slaves_1_r_ready;
  assign io_slaves_2_aw_valid = xbar_io_slaves_2_aw_valid;
  assign io_slaves_2_aw_bits_addr = xbar_io_slaves_2_aw_bits_addr;
  assign io_slaves_2_w_valid = xbar_io_slaves_2_w_valid;
  assign io_slaves_2_w_bits_data = xbar_io_slaves_2_w_bits_data;
  assign io_slaves_2_b_ready = xbar_io_slaves_2_b_ready;
  assign io_slaves_2_ar_valid = xbar_io_slaves_2_ar_valid;
  assign io_slaves_2_ar_bits_addr = xbar_io_slaves_2_ar_bits_addr;
  assign io_slaves_2_r_ready = xbar_io_slaves_2_r_ready;
  assign io_slaves_3_aw_valid = xbar_io_slaves_3_aw_valid;
  assign io_slaves_3_aw_bits_addr = xbar_io_slaves_3_aw_bits_addr;
  assign io_slaves_3_w_valid = xbar_io_slaves_3_w_valid;
  assign io_slaves_3_w_bits_data = xbar_io_slaves_3_w_bits_data;
  assign io_slaves_3_b_ready = xbar_io_slaves_3_b_ready;
  assign io_slaves_3_ar_valid = xbar_io_slaves_3_ar_valid;
  assign io_slaves_3_ar_bits_addr = xbar_io_slaves_3_ar_bits_addr;
  assign io_slaves_3_r_ready = xbar_io_slaves_3_r_ready;
  assign io_slaves_4_aw_valid = xbar_io_slaves_4_aw_valid;
  assign io_slaves_4_aw_bits_addr = xbar_io_slaves_4_aw_bits_addr;
  assign io_slaves_4_w_valid = xbar_io_slaves_4_w_valid;
  assign io_slaves_4_w_bits_data = xbar_io_slaves_4_w_bits_data;
  assign io_slaves_4_b_ready = xbar_io_slaves_4_b_ready;
  assign io_slaves_4_ar_valid = xbar_io_slaves_4_ar_valid;
  assign io_slaves_4_ar_bits_addr = xbar_io_slaves_4_ar_bits_addr;
  assign io_slaves_4_r_ready = xbar_io_slaves_4_r_ready;
  assign xbar_clock = clock;
  assign xbar_reset = reset;
  assign xbar_io_masters_0_aw_valid = io_masters_0_aw_valid;
  assign xbar_io_masters_0_aw_bits_addr = io_masters_0_aw_bits_addr;
  assign xbar_io_masters_0_w_valid = io_masters_0_w_valid;
  assign xbar_io_masters_0_w_bits_data = io_masters_0_w_bits_data;
  assign xbar_io_masters_0_b_ready = io_masters_0_b_ready;
  assign xbar_io_masters_0_ar_valid = io_masters_0_ar_valid;
  assign xbar_io_masters_0_ar_bits_addr = io_masters_0_ar_bits_addr;
  assign xbar_io_masters_0_r_ready = io_masters_0_r_ready;
  assign xbar_io_slaves_0_aw_ready = io_slaves_0_aw_ready;
  assign xbar_io_slaves_0_w_ready = io_slaves_0_w_ready;
  assign xbar_io_slaves_0_b_valid = io_slaves_0_b_valid;
  assign xbar_io_slaves_0_ar_ready = io_slaves_0_ar_ready;
  assign xbar_io_slaves_0_r_valid = io_slaves_0_r_valid;
  assign xbar_io_slaves_0_r_bits_data = io_slaves_0_r_bits_data;
  assign xbar_io_slaves_1_aw_ready = io_slaves_1_aw_ready;
  assign xbar_io_slaves_1_w_ready = io_slaves_1_w_ready;
  assign xbar_io_slaves_1_b_valid = io_slaves_1_b_valid;
  assign xbar_io_slaves_1_ar_ready = io_slaves_1_ar_ready;
  assign xbar_io_slaves_1_r_valid = io_slaves_1_r_valid;
  assign xbar_io_slaves_1_r_bits_data = io_slaves_1_r_bits_data;
  assign xbar_io_slaves_2_aw_ready = io_slaves_2_aw_ready;
  assign xbar_io_slaves_2_w_ready = io_slaves_2_w_ready;
  assign xbar_io_slaves_2_b_valid = io_slaves_2_b_valid;
  assign xbar_io_slaves_2_ar_ready = io_slaves_2_ar_ready;
  assign xbar_io_slaves_2_r_valid = io_slaves_2_r_valid;
  assign xbar_io_slaves_2_r_bits_data = io_slaves_2_r_bits_data;
  assign xbar_io_slaves_2_r_bits_last = io_slaves_2_r_bits_last;
  assign xbar_io_slaves_3_aw_ready = io_slaves_3_aw_ready;
  assign xbar_io_slaves_3_w_ready = io_slaves_3_w_ready;
  assign xbar_io_slaves_3_b_valid = io_slaves_3_b_valid;
  assign xbar_io_slaves_3_ar_ready = io_slaves_3_ar_ready;
  assign xbar_io_slaves_3_r_valid = io_slaves_3_r_valid;
  assign xbar_io_slaves_3_r_bits_data = io_slaves_3_r_bits_data;
  assign xbar_io_slaves_4_aw_ready = io_slaves_4_aw_ready;
  assign xbar_io_slaves_4_w_ready = io_slaves_4_w_ready;
  assign xbar_io_slaves_4_b_valid = io_slaves_4_b_valid;
  assign xbar_io_slaves_4_ar_ready = io_slaves_4_ar_ready;
  assign xbar_io_slaves_4_r_valid = io_slaves_4_r_valid;
  assign xbar_io_slaves_4_r_bits_data = io_slaves_4_r_bits_data;
  assign xbar_io_slaves_4_r_bits_last = io_slaves_4_r_bits_last;
endmodule
module FPGATop(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [63:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [63:0] io_ctrl_r_bits_data,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  output [31:0] io_mem_aw_bits_addr,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output [63:0] io_mem_w_bits_data,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output        io_mem_r_ready,
  input         io_mem_r_valid
);
  wire  sim_clock;
  wire  sim_reset;
  wire  sim_io_wireIns_0_ready;
  wire  sim_io_wireIns_0_valid;
  wire [63:0] sim_io_wireIns_0_bits;
  wire  sim_io_wireIns_1_ready;
  wire  sim_io_wireIns_1_valid;
  wire [63:0] sim_io_wireIns_1_bits;
  wire  sim_io_wireOuts_0_ready;
  wire  sim_io_wireOuts_0_valid;
  wire [63:0] sim_io_wireOuts_0_bits;
  wire  sim_io_daisy_regs_0_in_ready;
  wire  sim_io_daisy_regs_0_in_valid;
  wire [63:0] sim_io_daisy_regs_0_in_bits;
  wire  sim_io_daisy_regs_0_out_ready;
  wire  sim_io_daisy_regs_0_out_valid;
  wire [63:0] sim_io_daisy_regs_0_out_bits;
  wire [10:0] sim_io_traceLen;
  wire  sim_io_wireInTraces_0_ready;
  wire  sim_io_wireInTraces_0_valid;
  wire [63:0] sim_io_wireInTraces_0_bits;
  wire  sim_io_wireInTraces_1_ready;
  wire  sim_io_wireInTraces_1_valid;
  wire [63:0] sim_io_wireInTraces_1_bits;
  wire  sim_io_wireOutTraces_0_ready;
  wire  sim_io_wireOutTraces_0_valid;
  wire [63:0] sim_io_wireOutTraces_0_bits;
  wire  simReset;
  wire  _T_531;
  wire  Master_clock;
  wire  Master_reset;
  wire  Master_io_ctrl_aw_ready;
  wire  Master_io_ctrl_aw_valid;
  wire [31:0] Master_io_ctrl_aw_bits_addr;
  wire  Master_io_ctrl_w_ready;
  wire  Master_io_ctrl_w_valid;
  wire [63:0] Master_io_ctrl_w_bits_data;
  wire  Master_io_ctrl_b_ready;
  wire  Master_io_ctrl_b_valid;
  wire  Master_io_ctrl_ar_ready;
  wire  Master_io_ctrl_ar_valid;
  wire [31:0] Master_io_ctrl_ar_bits_addr;
  wire  Master_io_ctrl_r_ready;
  wire  Master_io_ctrl_r_valid;
  wire [63:0] Master_io_ctrl_r_bits_data;
  wire  Master_io_simReset;
  wire  Master_io_done;
  wire  Master_io_step_ready;
  wire  Master_io_step_valid;
  wire [63:0] Master_io_step_bits;
  wire  DefaultIOWidget_clock;
  wire  DefaultIOWidget_reset;
  wire  DefaultIOWidget_io_ctrl_aw_ready;
  wire  DefaultIOWidget_io_ctrl_aw_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_aw_bits_addr;
  wire  DefaultIOWidget_io_ctrl_w_ready;
  wire  DefaultIOWidget_io_ctrl_w_valid;
  wire [63:0] DefaultIOWidget_io_ctrl_w_bits_data;
  wire  DefaultIOWidget_io_ctrl_b_ready;
  wire  DefaultIOWidget_io_ctrl_b_valid;
  wire  DefaultIOWidget_io_ctrl_ar_ready;
  wire  DefaultIOWidget_io_ctrl_ar_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_ar_bits_addr;
  wire  DefaultIOWidget_io_ctrl_r_ready;
  wire  DefaultIOWidget_io_ctrl_r_valid;
  wire [63:0] DefaultIOWidget_io_ctrl_r_bits_data;
  wire  DefaultIOWidget_io_ctrl_r_bits_last;
  wire  DefaultIOWidget_io_ins_0_ready;
  wire  DefaultIOWidget_io_ins_0_valid;
  wire [63:0] DefaultIOWidget_io_ins_0_bits;
  wire  DefaultIOWidget_io_ins_1_ready;
  wire  DefaultIOWidget_io_ins_1_valid;
  wire [63:0] DefaultIOWidget_io_ins_1_bits;
  wire  DefaultIOWidget_io_outs_0_ready;
  wire  DefaultIOWidget_io_outs_0_valid;
  wire [63:0] DefaultIOWidget_io_outs_0_bits;
  wire  DefaultIOWidget_io_step_ready;
  wire  DefaultIOWidget_io_step_valid;
  wire [63:0] DefaultIOWidget_io_step_bits;
  wire  DefaultIOWidget_io_idle;
  wire  DaisyChainController_clock;
  wire  DaisyChainController_reset;
  wire  DaisyChainController_io_ctrl_aw_ready;
  wire  DaisyChainController_io_ctrl_aw_valid;
  wire [31:0] DaisyChainController_io_ctrl_aw_bits_addr;
  wire  DaisyChainController_io_ctrl_w_ready;
  wire  DaisyChainController_io_ctrl_w_valid;
  wire [63:0] DaisyChainController_io_ctrl_w_bits_data;
  wire  DaisyChainController_io_ctrl_b_ready;
  wire  DaisyChainController_io_ctrl_b_valid;
  wire  DaisyChainController_io_ctrl_ar_ready;
  wire  DaisyChainController_io_ctrl_ar_valid;
  wire [31:0] DaisyChainController_io_ctrl_ar_bits_addr;
  wire  DaisyChainController_io_ctrl_r_ready;
  wire  DaisyChainController_io_ctrl_r_valid;
  wire [63:0] DaisyChainController_io_ctrl_r_bits_data;
  wire  DaisyChainController_io_daisy_regs_0_in_ready;
  wire  DaisyChainController_io_daisy_regs_0_in_valid;
  wire [63:0] DaisyChainController_io_daisy_regs_0_in_bits;
  wire  DaisyChainController_io_daisy_regs_0_out_ready;
  wire  DaisyChainController_io_daisy_regs_0_out_valid;
  wire [63:0] DaisyChainController_io_daisy_regs_0_out_bits;
  wire  IOTraces_clock;
  wire  IOTraces_reset;
  wire  IOTraces_io_ctrl_aw_ready;
  wire  IOTraces_io_ctrl_aw_valid;
  wire [31:0] IOTraces_io_ctrl_aw_bits_addr;
  wire  IOTraces_io_ctrl_w_ready;
  wire  IOTraces_io_ctrl_w_valid;
  wire [63:0] IOTraces_io_ctrl_w_bits_data;
  wire  IOTraces_io_ctrl_b_ready;
  wire  IOTraces_io_ctrl_b_valid;
  wire  IOTraces_io_ctrl_ar_ready;
  wire  IOTraces_io_ctrl_ar_valid;
  wire [31:0] IOTraces_io_ctrl_ar_bits_addr;
  wire  IOTraces_io_ctrl_r_ready;
  wire  IOTraces_io_ctrl_r_valid;
  wire [63:0] IOTraces_io_ctrl_r_bits_data;
  wire [63:0] IOTraces_io_traceLen;
  wire  IOTraces_io_wireIns_0_ready;
  wire  IOTraces_io_wireIns_0_valid;
  wire [63:0] IOTraces_io_wireIns_0_bits;
  wire  IOTraces_io_wireIns_1_ready;
  wire  IOTraces_io_wireIns_1_valid;
  wire [63:0] IOTraces_io_wireIns_1_bits;
  wire  IOTraces_io_wireOuts_0_ready;
  wire  IOTraces_io_wireOuts_0_valid;
  wire [63:0] IOTraces_io_wireOuts_0_bits;
  wire  arb_io_master_0_aw_ready;
  wire  arb_io_master_0_aw_valid;
  wire [31:0] arb_io_master_0_aw_bits_addr;
  wire  arb_io_master_0_w_ready;
  wire  arb_io_master_0_w_valid;
  wire [63:0] arb_io_master_0_w_bits_data;
  wire  arb_io_master_0_ar_ready;
  wire  arb_io_master_0_ar_valid;
  wire [31:0] arb_io_master_0_ar_bits_addr;
  wire  arb_io_master_0_r_ready;
  wire  arb_io_master_0_r_valid;
  wire  arb_io_slave_aw_ready;
  wire  arb_io_slave_aw_valid;
  wire [31:0] arb_io_slave_aw_bits_addr;
  wire  arb_io_slave_w_ready;
  wire  arb_io_slave_w_valid;
  wire [63:0] arb_io_slave_w_bits_data;
  wire  arb_io_slave_ar_ready;
  wire  arb_io_slave_ar_valid;
  wire [31:0] arb_io_slave_ar_bits_addr;
  wire  arb_io_slave_r_ready;
  wire  arb_io_slave_r_valid;
  wire  LOADMEM_clock;
  wire  LOADMEM_reset;
  wire  LOADMEM_io_ctrl_aw_ready;
  wire  LOADMEM_io_ctrl_aw_valid;
  wire [31:0] LOADMEM_io_ctrl_aw_bits_addr;
  wire  LOADMEM_io_ctrl_w_ready;
  wire  LOADMEM_io_ctrl_w_valid;
  wire [63:0] LOADMEM_io_ctrl_w_bits_data;
  wire  LOADMEM_io_ctrl_b_ready;
  wire  LOADMEM_io_ctrl_b_valid;
  wire  LOADMEM_io_ctrl_ar_ready;
  wire  LOADMEM_io_ctrl_ar_valid;
  wire [31:0] LOADMEM_io_ctrl_ar_bits_addr;
  wire  LOADMEM_io_ctrl_r_ready;
  wire  LOADMEM_io_ctrl_r_valid;
  wire [63:0] LOADMEM_io_ctrl_r_bits_data;
  wire  LOADMEM_io_ctrl_r_bits_last;
  wire  LOADMEM_io_toSlaveMem_aw_ready;
  wire  LOADMEM_io_toSlaveMem_aw_valid;
  wire [31:0] LOADMEM_io_toSlaveMem_aw_bits_addr;
  wire  LOADMEM_io_toSlaveMem_w_ready;
  wire  LOADMEM_io_toSlaveMem_w_valid;
  wire [63:0] LOADMEM_io_toSlaveMem_w_bits_data;
  wire  LOADMEM_io_toSlaveMem_ar_ready;
  wire  LOADMEM_io_toSlaveMem_ar_valid;
  wire [31:0] LOADMEM_io_toSlaveMem_ar_bits_addr;
  wire  LOADMEM_io_toSlaveMem_r_ready;
  wire  LOADMEM_io_toSlaveMem_r_valid;
  wire  NastiRecursiveInterconnect_clock;
  wire  NastiRecursiveInterconnect_reset;
  wire  NastiRecursiveInterconnect_io_masters_0_aw_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_masters_0_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_masters_0_w_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_masters_0_w_bits_data;
  wire  NastiRecursiveInterconnect_io_masters_0_b_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_b_valid;
  wire  NastiRecursiveInterconnect_io_masters_0_ar_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_masters_0_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_masters_0_r_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_masters_0_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_0_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_0_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_0_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_0_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_b_valid;
  wire  NastiRecursiveInterconnect_io_slaves_0_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_0_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_0_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_1_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_1_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_1_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_1_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_b_valid;
  wire  NastiRecursiveInterconnect_io_slaves_1_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_1_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_2_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_2_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_2_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_2_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_b_valid;
  wire  NastiRecursiveInterconnect_io_slaves_2_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_2_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_2_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_2_r_bits_last;
  wire  NastiRecursiveInterconnect_io_slaves_3_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_3_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_3_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_3_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_b_valid;
  wire  NastiRecursiveInterconnect_io_slaves_3_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_3_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_4_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_aw_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_4_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_w_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_4_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_4_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_b_valid;
  wire  NastiRecursiveInterconnect_io_slaves_4_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr;
  wire  NastiRecursiveInterconnect_io_slaves_4_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_r_valid;
  wire [63:0] NastiRecursiveInterconnect_io_slaves_4_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_4_r_bits_last;
  wire [12:0] _T_537;
  wire [12:0] _T_538;
  SimWrapper sim (
    .clock(sim_clock),
    .reset(sim_reset),
    .io_wireIns_0_ready(sim_io_wireIns_0_ready),
    .io_wireIns_0_valid(sim_io_wireIns_0_valid),
    .io_wireIns_0_bits(sim_io_wireIns_0_bits),
    .io_wireIns_1_ready(sim_io_wireIns_1_ready),
    .io_wireIns_1_valid(sim_io_wireIns_1_valid),
    .io_wireIns_1_bits(sim_io_wireIns_1_bits),
    .io_wireOuts_0_ready(sim_io_wireOuts_0_ready),
    .io_wireOuts_0_valid(sim_io_wireOuts_0_valid),
    .io_wireOuts_0_bits(sim_io_wireOuts_0_bits),
    .io_daisy_regs_0_in_ready(sim_io_daisy_regs_0_in_ready),
    .io_daisy_regs_0_in_valid(sim_io_daisy_regs_0_in_valid),
    .io_daisy_regs_0_in_bits(sim_io_daisy_regs_0_in_bits),
    .io_daisy_regs_0_out_ready(sim_io_daisy_regs_0_out_ready),
    .io_daisy_regs_0_out_valid(sim_io_daisy_regs_0_out_valid),
    .io_daisy_regs_0_out_bits(sim_io_daisy_regs_0_out_bits),
    .io_traceLen(sim_io_traceLen),
    .io_wireInTraces_0_ready(sim_io_wireInTraces_0_ready),
    .io_wireInTraces_0_valid(sim_io_wireInTraces_0_valid),
    .io_wireInTraces_0_bits(sim_io_wireInTraces_0_bits),
    .io_wireInTraces_1_ready(sim_io_wireInTraces_1_ready),
    .io_wireInTraces_1_valid(sim_io_wireInTraces_1_valid),
    .io_wireInTraces_1_bits(sim_io_wireInTraces_1_bits),
    .io_wireOutTraces_0_ready(sim_io_wireOutTraces_0_ready),
    .io_wireOutTraces_0_valid(sim_io_wireOutTraces_0_valid),
    .io_wireOutTraces_0_bits(sim_io_wireOutTraces_0_bits)
  );
  EmulationMaster Master (
    .clock(Master_clock),
    .reset(Master_reset),
    .io_ctrl_aw_ready(Master_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(Master_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(Master_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(Master_io_ctrl_w_ready),
    .io_ctrl_w_valid(Master_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(Master_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(Master_io_ctrl_b_ready),
    .io_ctrl_b_valid(Master_io_ctrl_b_valid),
    .io_ctrl_ar_ready(Master_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(Master_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(Master_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(Master_io_ctrl_r_ready),
    .io_ctrl_r_valid(Master_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(Master_io_ctrl_r_bits_data),
    .io_simReset(Master_io_simReset),
    .io_done(Master_io_done),
    .io_step_ready(Master_io_step_ready),
    .io_step_valid(Master_io_step_valid),
    .io_step_bits(Master_io_step_bits)
  );
  PeekPokeIOWidget DefaultIOWidget (
    .clock(DefaultIOWidget_clock),
    .reset(DefaultIOWidget_reset),
    .io_ctrl_aw_ready(DefaultIOWidget_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(DefaultIOWidget_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(DefaultIOWidget_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(DefaultIOWidget_io_ctrl_w_ready),
    .io_ctrl_w_valid(DefaultIOWidget_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(DefaultIOWidget_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(DefaultIOWidget_io_ctrl_b_ready),
    .io_ctrl_b_valid(DefaultIOWidget_io_ctrl_b_valid),
    .io_ctrl_ar_ready(DefaultIOWidget_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(DefaultIOWidget_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(DefaultIOWidget_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(DefaultIOWidget_io_ctrl_r_ready),
    .io_ctrl_r_valid(DefaultIOWidget_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(DefaultIOWidget_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_last(DefaultIOWidget_io_ctrl_r_bits_last),
    .io_ins_0_ready(DefaultIOWidget_io_ins_0_ready),
    .io_ins_0_valid(DefaultIOWidget_io_ins_0_valid),
    .io_ins_0_bits(DefaultIOWidget_io_ins_0_bits),
    .io_ins_1_ready(DefaultIOWidget_io_ins_1_ready),
    .io_ins_1_valid(DefaultIOWidget_io_ins_1_valid),
    .io_ins_1_bits(DefaultIOWidget_io_ins_1_bits),
    .io_outs_0_ready(DefaultIOWidget_io_outs_0_ready),
    .io_outs_0_valid(DefaultIOWidget_io_outs_0_valid),
    .io_outs_0_bits(DefaultIOWidget_io_outs_0_bits),
    .io_step_ready(DefaultIOWidget_io_step_ready),
    .io_step_valid(DefaultIOWidget_io_step_valid),
    .io_step_bits(DefaultIOWidget_io_step_bits),
    .io_idle(DefaultIOWidget_io_idle)
  );
  DaisyController DaisyChainController (
    .clock(DaisyChainController_clock),
    .reset(DaisyChainController_reset),
    .io_ctrl_aw_ready(DaisyChainController_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(DaisyChainController_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(DaisyChainController_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(DaisyChainController_io_ctrl_w_ready),
    .io_ctrl_w_valid(DaisyChainController_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(DaisyChainController_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(DaisyChainController_io_ctrl_b_ready),
    .io_ctrl_b_valid(DaisyChainController_io_ctrl_b_valid),
    .io_ctrl_ar_ready(DaisyChainController_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(DaisyChainController_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(DaisyChainController_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(DaisyChainController_io_ctrl_r_ready),
    .io_ctrl_r_valid(DaisyChainController_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(DaisyChainController_io_ctrl_r_bits_data),
    .io_daisy_regs_0_in_ready(DaisyChainController_io_daisy_regs_0_in_ready),
    .io_daisy_regs_0_in_valid(DaisyChainController_io_daisy_regs_0_in_valid),
    .io_daisy_regs_0_in_bits(DaisyChainController_io_daisy_regs_0_in_bits),
    .io_daisy_regs_0_out_ready(DaisyChainController_io_daisy_regs_0_out_ready),
    .io_daisy_regs_0_out_valid(DaisyChainController_io_daisy_regs_0_out_valid),
    .io_daisy_regs_0_out_bits(DaisyChainController_io_daisy_regs_0_out_bits)
  );
  IOTraceWidget IOTraces (
    .clock(IOTraces_clock),
    .reset(IOTraces_reset),
    .io_ctrl_aw_ready(IOTraces_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(IOTraces_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(IOTraces_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(IOTraces_io_ctrl_w_ready),
    .io_ctrl_w_valid(IOTraces_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(IOTraces_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(IOTraces_io_ctrl_b_ready),
    .io_ctrl_b_valid(IOTraces_io_ctrl_b_valid),
    .io_ctrl_ar_ready(IOTraces_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(IOTraces_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(IOTraces_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(IOTraces_io_ctrl_r_ready),
    .io_ctrl_r_valid(IOTraces_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(IOTraces_io_ctrl_r_bits_data),
    .io_traceLen(IOTraces_io_traceLen),
    .io_wireIns_0_ready(IOTraces_io_wireIns_0_ready),
    .io_wireIns_0_valid(IOTraces_io_wireIns_0_valid),
    .io_wireIns_0_bits(IOTraces_io_wireIns_0_bits),
    .io_wireIns_1_ready(IOTraces_io_wireIns_1_ready),
    .io_wireIns_1_valid(IOTraces_io_wireIns_1_valid),
    .io_wireIns_1_bits(IOTraces_io_wireIns_1_bits),
    .io_wireOuts_0_ready(IOTraces_io_wireOuts_0_ready),
    .io_wireOuts_0_valid(IOTraces_io_wireOuts_0_valid),
    .io_wireOuts_0_bits(IOTraces_io_wireOuts_0_bits)
  );
  NastiArbiter arb (
    .io_master_0_aw_ready(arb_io_master_0_aw_ready),
    .io_master_0_aw_valid(arb_io_master_0_aw_valid),
    .io_master_0_aw_bits_addr(arb_io_master_0_aw_bits_addr),
    .io_master_0_w_ready(arb_io_master_0_w_ready),
    .io_master_0_w_valid(arb_io_master_0_w_valid),
    .io_master_0_w_bits_data(arb_io_master_0_w_bits_data),
    .io_master_0_ar_ready(arb_io_master_0_ar_ready),
    .io_master_0_ar_valid(arb_io_master_0_ar_valid),
    .io_master_0_ar_bits_addr(arb_io_master_0_ar_bits_addr),
    .io_master_0_r_ready(arb_io_master_0_r_ready),
    .io_master_0_r_valid(arb_io_master_0_r_valid),
    .io_slave_aw_ready(arb_io_slave_aw_ready),
    .io_slave_aw_valid(arb_io_slave_aw_valid),
    .io_slave_aw_bits_addr(arb_io_slave_aw_bits_addr),
    .io_slave_w_ready(arb_io_slave_w_ready),
    .io_slave_w_valid(arb_io_slave_w_valid),
    .io_slave_w_bits_data(arb_io_slave_w_bits_data),
    .io_slave_ar_ready(arb_io_slave_ar_ready),
    .io_slave_ar_valid(arb_io_slave_ar_valid),
    .io_slave_ar_bits_addr(arb_io_slave_ar_bits_addr),
    .io_slave_r_ready(arb_io_slave_r_ready),
    .io_slave_r_valid(arb_io_slave_r_valid)
  );
  LoadMemWidget LOADMEM (
    .clock(LOADMEM_clock),
    .reset(LOADMEM_reset),
    .io_ctrl_aw_ready(LOADMEM_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(LOADMEM_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(LOADMEM_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(LOADMEM_io_ctrl_w_ready),
    .io_ctrl_w_valid(LOADMEM_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(LOADMEM_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(LOADMEM_io_ctrl_b_ready),
    .io_ctrl_b_valid(LOADMEM_io_ctrl_b_valid),
    .io_ctrl_ar_ready(LOADMEM_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(LOADMEM_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(LOADMEM_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(LOADMEM_io_ctrl_r_ready),
    .io_ctrl_r_valid(LOADMEM_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(LOADMEM_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_last(LOADMEM_io_ctrl_r_bits_last),
    .io_toSlaveMem_aw_ready(LOADMEM_io_toSlaveMem_aw_ready),
    .io_toSlaveMem_aw_valid(LOADMEM_io_toSlaveMem_aw_valid),
    .io_toSlaveMem_aw_bits_addr(LOADMEM_io_toSlaveMem_aw_bits_addr),
    .io_toSlaveMem_w_ready(LOADMEM_io_toSlaveMem_w_ready),
    .io_toSlaveMem_w_valid(LOADMEM_io_toSlaveMem_w_valid),
    .io_toSlaveMem_w_bits_data(LOADMEM_io_toSlaveMem_w_bits_data),
    .io_toSlaveMem_ar_ready(LOADMEM_io_toSlaveMem_ar_ready),
    .io_toSlaveMem_ar_valid(LOADMEM_io_toSlaveMem_ar_valid),
    .io_toSlaveMem_ar_bits_addr(LOADMEM_io_toSlaveMem_ar_bits_addr),
    .io_toSlaveMem_r_ready(LOADMEM_io_toSlaveMem_r_ready),
    .io_toSlaveMem_r_valid(LOADMEM_io_toSlaveMem_r_valid)
  );
  NastiRecursiveInterconnect NastiRecursiveInterconnect (
    .clock(NastiRecursiveInterconnect_clock),
    .reset(NastiRecursiveInterconnect_reset),
    .io_masters_0_aw_ready(NastiRecursiveInterconnect_io_masters_0_aw_ready),
    .io_masters_0_aw_valid(NastiRecursiveInterconnect_io_masters_0_aw_valid),
    .io_masters_0_aw_bits_addr(NastiRecursiveInterconnect_io_masters_0_aw_bits_addr),
    .io_masters_0_w_ready(NastiRecursiveInterconnect_io_masters_0_w_ready),
    .io_masters_0_w_valid(NastiRecursiveInterconnect_io_masters_0_w_valid),
    .io_masters_0_w_bits_data(NastiRecursiveInterconnect_io_masters_0_w_bits_data),
    .io_masters_0_b_ready(NastiRecursiveInterconnect_io_masters_0_b_ready),
    .io_masters_0_b_valid(NastiRecursiveInterconnect_io_masters_0_b_valid),
    .io_masters_0_ar_ready(NastiRecursiveInterconnect_io_masters_0_ar_ready),
    .io_masters_0_ar_valid(NastiRecursiveInterconnect_io_masters_0_ar_valid),
    .io_masters_0_ar_bits_addr(NastiRecursiveInterconnect_io_masters_0_ar_bits_addr),
    .io_masters_0_r_ready(NastiRecursiveInterconnect_io_masters_0_r_ready),
    .io_masters_0_r_valid(NastiRecursiveInterconnect_io_masters_0_r_valid),
    .io_masters_0_r_bits_data(NastiRecursiveInterconnect_io_masters_0_r_bits_data),
    .io_slaves_0_aw_ready(NastiRecursiveInterconnect_io_slaves_0_aw_ready),
    .io_slaves_0_aw_valid(NastiRecursiveInterconnect_io_slaves_0_aw_valid),
    .io_slaves_0_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_0_aw_bits_addr),
    .io_slaves_0_w_ready(NastiRecursiveInterconnect_io_slaves_0_w_ready),
    .io_slaves_0_w_valid(NastiRecursiveInterconnect_io_slaves_0_w_valid),
    .io_slaves_0_w_bits_data(NastiRecursiveInterconnect_io_slaves_0_w_bits_data),
    .io_slaves_0_b_ready(NastiRecursiveInterconnect_io_slaves_0_b_ready),
    .io_slaves_0_b_valid(NastiRecursiveInterconnect_io_slaves_0_b_valid),
    .io_slaves_0_ar_ready(NastiRecursiveInterconnect_io_slaves_0_ar_ready),
    .io_slaves_0_ar_valid(NastiRecursiveInterconnect_io_slaves_0_ar_valid),
    .io_slaves_0_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr),
    .io_slaves_0_r_ready(NastiRecursiveInterconnect_io_slaves_0_r_ready),
    .io_slaves_0_r_valid(NastiRecursiveInterconnect_io_slaves_0_r_valid),
    .io_slaves_0_r_bits_data(NastiRecursiveInterconnect_io_slaves_0_r_bits_data),
    .io_slaves_1_aw_ready(NastiRecursiveInterconnect_io_slaves_1_aw_ready),
    .io_slaves_1_aw_valid(NastiRecursiveInterconnect_io_slaves_1_aw_valid),
    .io_slaves_1_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_1_aw_bits_addr),
    .io_slaves_1_w_ready(NastiRecursiveInterconnect_io_slaves_1_w_ready),
    .io_slaves_1_w_valid(NastiRecursiveInterconnect_io_slaves_1_w_valid),
    .io_slaves_1_w_bits_data(NastiRecursiveInterconnect_io_slaves_1_w_bits_data),
    .io_slaves_1_b_ready(NastiRecursiveInterconnect_io_slaves_1_b_ready),
    .io_slaves_1_b_valid(NastiRecursiveInterconnect_io_slaves_1_b_valid),
    .io_slaves_1_ar_ready(NastiRecursiveInterconnect_io_slaves_1_ar_ready),
    .io_slaves_1_ar_valid(NastiRecursiveInterconnect_io_slaves_1_ar_valid),
    .io_slaves_1_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr),
    .io_slaves_1_r_ready(NastiRecursiveInterconnect_io_slaves_1_r_ready),
    .io_slaves_1_r_valid(NastiRecursiveInterconnect_io_slaves_1_r_valid),
    .io_slaves_1_r_bits_data(NastiRecursiveInterconnect_io_slaves_1_r_bits_data),
    .io_slaves_2_aw_ready(NastiRecursiveInterconnect_io_slaves_2_aw_ready),
    .io_slaves_2_aw_valid(NastiRecursiveInterconnect_io_slaves_2_aw_valid),
    .io_slaves_2_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr),
    .io_slaves_2_w_ready(NastiRecursiveInterconnect_io_slaves_2_w_ready),
    .io_slaves_2_w_valid(NastiRecursiveInterconnect_io_slaves_2_w_valid),
    .io_slaves_2_w_bits_data(NastiRecursiveInterconnect_io_slaves_2_w_bits_data),
    .io_slaves_2_b_ready(NastiRecursiveInterconnect_io_slaves_2_b_ready),
    .io_slaves_2_b_valid(NastiRecursiveInterconnect_io_slaves_2_b_valid),
    .io_slaves_2_ar_ready(NastiRecursiveInterconnect_io_slaves_2_ar_ready),
    .io_slaves_2_ar_valid(NastiRecursiveInterconnect_io_slaves_2_ar_valid),
    .io_slaves_2_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr),
    .io_slaves_2_r_ready(NastiRecursiveInterconnect_io_slaves_2_r_ready),
    .io_slaves_2_r_valid(NastiRecursiveInterconnect_io_slaves_2_r_valid),
    .io_slaves_2_r_bits_data(NastiRecursiveInterconnect_io_slaves_2_r_bits_data),
    .io_slaves_2_r_bits_last(NastiRecursiveInterconnect_io_slaves_2_r_bits_last),
    .io_slaves_3_aw_ready(NastiRecursiveInterconnect_io_slaves_3_aw_ready),
    .io_slaves_3_aw_valid(NastiRecursiveInterconnect_io_slaves_3_aw_valid),
    .io_slaves_3_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr),
    .io_slaves_3_w_ready(NastiRecursiveInterconnect_io_slaves_3_w_ready),
    .io_slaves_3_w_valid(NastiRecursiveInterconnect_io_slaves_3_w_valid),
    .io_slaves_3_w_bits_data(NastiRecursiveInterconnect_io_slaves_3_w_bits_data),
    .io_slaves_3_b_ready(NastiRecursiveInterconnect_io_slaves_3_b_ready),
    .io_slaves_3_b_valid(NastiRecursiveInterconnect_io_slaves_3_b_valid),
    .io_slaves_3_ar_ready(NastiRecursiveInterconnect_io_slaves_3_ar_ready),
    .io_slaves_3_ar_valid(NastiRecursiveInterconnect_io_slaves_3_ar_valid),
    .io_slaves_3_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr),
    .io_slaves_3_r_ready(NastiRecursiveInterconnect_io_slaves_3_r_ready),
    .io_slaves_3_r_valid(NastiRecursiveInterconnect_io_slaves_3_r_valid),
    .io_slaves_3_r_bits_data(NastiRecursiveInterconnect_io_slaves_3_r_bits_data),
    .io_slaves_4_aw_ready(NastiRecursiveInterconnect_io_slaves_4_aw_ready),
    .io_slaves_4_aw_valid(NastiRecursiveInterconnect_io_slaves_4_aw_valid),
    .io_slaves_4_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_4_aw_bits_addr),
    .io_slaves_4_w_ready(NastiRecursiveInterconnect_io_slaves_4_w_ready),
    .io_slaves_4_w_valid(NastiRecursiveInterconnect_io_slaves_4_w_valid),
    .io_slaves_4_w_bits_data(NastiRecursiveInterconnect_io_slaves_4_w_bits_data),
    .io_slaves_4_b_ready(NastiRecursiveInterconnect_io_slaves_4_b_ready),
    .io_slaves_4_b_valid(NastiRecursiveInterconnect_io_slaves_4_b_valid),
    .io_slaves_4_ar_ready(NastiRecursiveInterconnect_io_slaves_4_ar_ready),
    .io_slaves_4_ar_valid(NastiRecursiveInterconnect_io_slaves_4_ar_valid),
    .io_slaves_4_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr),
    .io_slaves_4_r_ready(NastiRecursiveInterconnect_io_slaves_4_r_ready),
    .io_slaves_4_r_valid(NastiRecursiveInterconnect_io_slaves_4_r_valid),
    .io_slaves_4_r_bits_data(NastiRecursiveInterconnect_io_slaves_4_r_bits_data),
    .io_slaves_4_r_bits_last(NastiRecursiveInterconnect_io_slaves_4_r_bits_last)
  );
  assign io_ctrl_aw_ready = NastiRecursiveInterconnect_io_masters_0_aw_ready;
  assign io_ctrl_w_ready = NastiRecursiveInterconnect_io_masters_0_w_ready;
  assign io_ctrl_b_valid = NastiRecursiveInterconnect_io_masters_0_b_valid;
  assign io_ctrl_ar_ready = NastiRecursiveInterconnect_io_masters_0_ar_ready;
  assign io_ctrl_r_valid = NastiRecursiveInterconnect_io_masters_0_r_valid;
  assign io_ctrl_r_bits_data = NastiRecursiveInterconnect_io_masters_0_r_bits_data;
  assign io_mem_aw_valid = arb_io_slave_aw_valid;
  assign io_mem_aw_bits_addr = arb_io_slave_aw_bits_addr;
  assign io_mem_w_valid = arb_io_slave_w_valid;
  assign io_mem_w_bits_data = arb_io_slave_w_bits_data;
  assign io_mem_ar_valid = arb_io_slave_ar_valid;
  assign io_mem_ar_bits_addr = arb_io_slave_ar_bits_addr;
  assign io_mem_r_ready = arb_io_slave_r_ready;
  assign sim_clock = clock;
  assign sim_reset = _T_531;
  assign sim_io_wireIns_0_valid = DefaultIOWidget_io_ins_0_valid;
  assign sim_io_wireIns_0_bits = DefaultIOWidget_io_ins_0_bits;
  assign sim_io_wireIns_1_valid = DefaultIOWidget_io_ins_1_valid;
  assign sim_io_wireIns_1_bits = DefaultIOWidget_io_ins_1_bits;
  assign sim_io_wireOuts_0_ready = DefaultIOWidget_io_outs_0_ready;
  assign sim_io_daisy_regs_0_in_valid = DaisyChainController_io_daisy_regs_0_in_valid;
  assign sim_io_daisy_regs_0_in_bits = DaisyChainController_io_daisy_regs_0_in_bits;
  assign sim_io_daisy_regs_0_out_ready = DaisyChainController_io_daisy_regs_0_out_ready;
  assign sim_io_traceLen = IOTraces_io_traceLen[10:0];
  assign sim_io_wireInTraces_0_ready = IOTraces_io_wireIns_0_ready;
  assign sim_io_wireInTraces_1_ready = IOTraces_io_wireIns_1_ready;
  assign sim_io_wireOutTraces_0_ready = IOTraces_io_wireOuts_0_ready;
  assign simReset = Master_io_simReset;
  assign _T_531 = reset | simReset;
  assign Master_clock = clock;
  assign Master_reset = reset;
  assign Master_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_1_aw_valid;
  assign Master_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_1_aw_bits_addr;
  assign Master_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_1_w_valid;
  assign Master_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_1_w_bits_data;
  assign Master_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_1_b_ready;
  assign Master_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_1_ar_valid;
  assign Master_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr;
  assign Master_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_1_r_ready;
  assign Master_io_done = DefaultIOWidget_io_idle;
  assign Master_io_step_ready = DefaultIOWidget_io_step_ready;
  assign DefaultIOWidget_clock = clock;
  assign DefaultIOWidget_reset = _T_531;
  assign DefaultIOWidget_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_2_aw_valid;
  assign DefaultIOWidget_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr;
  assign DefaultIOWidget_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_2_w_valid;
  assign DefaultIOWidget_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_2_w_bits_data;
  assign DefaultIOWidget_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_2_b_ready;
  assign DefaultIOWidget_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_2_ar_valid;
  assign DefaultIOWidget_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr;
  assign DefaultIOWidget_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_2_r_ready;
  assign DefaultIOWidget_io_ins_0_ready = sim_io_wireIns_0_ready;
  assign DefaultIOWidget_io_ins_1_ready = sim_io_wireIns_1_ready;
  assign DefaultIOWidget_io_outs_0_valid = sim_io_wireOuts_0_valid;
  assign DefaultIOWidget_io_outs_0_bits = sim_io_wireOuts_0_bits;
  assign DefaultIOWidget_io_step_valid = Master_io_step_valid;
  assign DefaultIOWidget_io_step_bits = Master_io_step_bits;
  assign DaisyChainController_clock = clock;
  assign DaisyChainController_reset = _T_531;
  assign DaisyChainController_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_0_aw_valid;
  assign DaisyChainController_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_0_aw_bits_addr;
  assign DaisyChainController_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_0_w_valid;
  assign DaisyChainController_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_0_w_bits_data;
  assign DaisyChainController_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_0_b_ready;
  assign DaisyChainController_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_0_ar_valid;
  assign DaisyChainController_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr;
  assign DaisyChainController_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_0_r_ready;
  assign DaisyChainController_io_daisy_regs_0_in_ready = sim_io_daisy_regs_0_in_ready;
  assign DaisyChainController_io_daisy_regs_0_out_valid = sim_io_daisy_regs_0_out_valid;
  assign DaisyChainController_io_daisy_regs_0_out_bits = sim_io_daisy_regs_0_out_bits;
  assign IOTraces_clock = clock;
  assign IOTraces_reset = _T_531;
  assign IOTraces_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_3_aw_valid;
  assign IOTraces_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr;
  assign IOTraces_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_3_w_valid;
  assign IOTraces_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_3_w_bits_data;
  assign IOTraces_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_3_b_ready;
  assign IOTraces_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_3_ar_valid;
  assign IOTraces_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr;
  assign IOTraces_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_3_r_ready;
  assign IOTraces_io_wireIns_0_valid = sim_io_wireInTraces_0_valid;
  assign IOTraces_io_wireIns_0_bits = sim_io_wireInTraces_0_bits;
  assign IOTraces_io_wireIns_1_valid = sim_io_wireInTraces_1_valid;
  assign IOTraces_io_wireIns_1_bits = sim_io_wireInTraces_1_bits;
  assign IOTraces_io_wireOuts_0_valid = sim_io_wireOutTraces_0_valid;
  assign IOTraces_io_wireOuts_0_bits = sim_io_wireOutTraces_0_bits;
  assign arb_io_master_0_aw_valid = LOADMEM_io_toSlaveMem_aw_valid;
  assign arb_io_master_0_aw_bits_addr = LOADMEM_io_toSlaveMem_aw_bits_addr;
  assign arb_io_master_0_w_valid = LOADMEM_io_toSlaveMem_w_valid;
  assign arb_io_master_0_w_bits_data = LOADMEM_io_toSlaveMem_w_bits_data;
  assign arb_io_master_0_ar_valid = LOADMEM_io_toSlaveMem_ar_valid;
  assign arb_io_master_0_ar_bits_addr = LOADMEM_io_toSlaveMem_ar_bits_addr;
  assign arb_io_master_0_r_ready = LOADMEM_io_toSlaveMem_r_ready;
  assign arb_io_slave_aw_ready = io_mem_aw_ready;
  assign arb_io_slave_w_ready = io_mem_w_ready;
  assign arb_io_slave_ar_ready = io_mem_ar_ready;
  assign arb_io_slave_r_valid = io_mem_r_valid;
  assign LOADMEM_clock = clock;
  assign LOADMEM_reset = _T_531;
  assign LOADMEM_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_4_aw_valid;
  assign LOADMEM_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_4_aw_bits_addr;
  assign LOADMEM_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_4_w_valid;
  assign LOADMEM_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_4_w_bits_data;
  assign LOADMEM_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_4_b_ready;
  assign LOADMEM_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_4_ar_valid;
  assign LOADMEM_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr;
  assign LOADMEM_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_4_r_ready;
  assign LOADMEM_io_toSlaveMem_aw_ready = arb_io_master_0_aw_ready;
  assign LOADMEM_io_toSlaveMem_w_ready = arb_io_master_0_w_ready;
  assign LOADMEM_io_toSlaveMem_ar_ready = arb_io_master_0_ar_ready;
  assign LOADMEM_io_toSlaveMem_r_valid = arb_io_master_0_r_valid;
  assign NastiRecursiveInterconnect_clock = clock;
  assign NastiRecursiveInterconnect_reset = reset;
  assign NastiRecursiveInterconnect_io_masters_0_aw_valid = io_ctrl_aw_valid;
  assign NastiRecursiveInterconnect_io_masters_0_aw_bits_addr = {{19'd0}, _T_537};
  assign NastiRecursiveInterconnect_io_masters_0_w_valid = io_ctrl_w_valid;
  assign NastiRecursiveInterconnect_io_masters_0_w_bits_data = io_ctrl_w_bits_data;
  assign NastiRecursiveInterconnect_io_masters_0_b_ready = io_ctrl_b_ready;
  assign NastiRecursiveInterconnect_io_masters_0_ar_valid = io_ctrl_ar_valid;
  assign NastiRecursiveInterconnect_io_masters_0_ar_bits_addr = {{19'd0}, _T_538};
  assign NastiRecursiveInterconnect_io_masters_0_r_ready = io_ctrl_r_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_aw_ready = DaisyChainController_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_w_ready = DaisyChainController_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_b_valid = DaisyChainController_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_0_ar_ready = DaisyChainController_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_r_valid = DaisyChainController_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_0_r_bits_data = DaisyChainController_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_1_aw_ready = Master_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_w_ready = Master_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_b_valid = Master_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_1_ar_ready = Master_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_r_valid = Master_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_data = Master_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_2_aw_ready = DefaultIOWidget_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_w_ready = DefaultIOWidget_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_b_valid = DefaultIOWidget_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_2_ar_ready = DefaultIOWidget_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_r_valid = DefaultIOWidget_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_2_r_bits_data = DefaultIOWidget_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_2_r_bits_last = DefaultIOWidget_io_ctrl_r_bits_last;
  assign NastiRecursiveInterconnect_io_slaves_3_aw_ready = IOTraces_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_w_ready = IOTraces_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_b_valid = IOTraces_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_3_ar_ready = IOTraces_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_r_valid = IOTraces_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_data = IOTraces_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_4_aw_ready = LOADMEM_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_w_ready = LOADMEM_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_b_valid = LOADMEM_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_4_ar_ready = LOADMEM_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_r_valid = LOADMEM_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_4_r_bits_data = LOADMEM_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_4_r_bits_last = LOADMEM_io_ctrl_r_bits_last;
  assign _T_537 = io_ctrl_aw_bits_addr[12:0];
  assign _T_538 = io_ctrl_ar_bits_addr[12:0];
endmodule
module Queue_7(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_len
);
  reg [31:0] ram_addr [0:1];
  reg [31:0] _RAND_0;
  wire [31:0] ram_addr__T_138_data;
  wire  ram_addr__T_138_addr;
  wire [31:0] ram_addr__T_113_data;
  wire  ram_addr__T_113_addr;
  wire  ram_addr__T_113_mask;
  wire  ram_addr__T_113_en;
  reg [7:0] ram_len [0:1];
  reg [31:0] _RAND_1;
  wire [7:0] ram_len__T_138_data;
  wire  ram_len__T_138_addr;
  wire [7:0] ram_len__T_113_data;
  wire  ram_len__T_113_addr;
  wire  ram_len__T_113_mask;
  wire  ram_len__T_113_en;
  reg  value;
  reg [31:0] _RAND_2;
  reg  value_1;
  reg [31:0] _RAND_3;
  reg  maybe_full;
  reg [31:0] _RAND_4;
  wire  _T_106;
  wire  _T_108;
  wire  _T_109;
  wire  _T_110;
  wire  _T_111;
  wire  do_enq;
  wire  _T_112;
  wire  do_deq;
  wire [1:0] _T_127;
  wire  _T_128;
  wire  _GEN_14;
  wire [1:0] _T_131;
  wire  _T_132;
  wire  _GEN_15;
  wire  _T_133;
  wire  _GEN_16;
  wire  _T_135;
  wire  _T_137;
  assign io_enq_ready = _T_137;
  assign io_deq_valid = _T_135;
  assign io_deq_bits_addr = ram_addr__T_138_data;
  assign io_deq_bits_len = ram_len__T_138_data;
  assign ram_addr__T_138_addr = value_1;
  assign ram_addr__T_138_data = ram_addr[ram_addr__T_138_addr];
  assign ram_addr__T_113_data = io_enq_bits_addr;
  assign ram_addr__T_113_addr = value;
  assign ram_addr__T_113_mask = do_enq;
  assign ram_addr__T_113_en = do_enq;
  assign ram_len__T_138_addr = value_1;
  assign ram_len__T_138_data = ram_len[ram_len__T_138_addr];
  assign ram_len__T_113_data = 8'h0;
  assign ram_len__T_113_addr = value;
  assign ram_len__T_113_mask = do_enq;
  assign ram_len__T_113_en = do_enq;
  assign _T_106 = value == value_1;
  assign _T_108 = maybe_full == 1'h0;
  assign _T_109 = _T_106 & _T_108;
  assign _T_110 = _T_106 & maybe_full;
  assign _T_111 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_111;
  assign _T_112 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_112;
  assign _T_127 = value + 1'h1;
  assign _T_128 = _T_127[0:0];
  assign _GEN_14 = do_enq ? _T_128 : value;
  assign _T_131 = value_1 + 1'h1;
  assign _T_132 = _T_131[0:0];
  assign _GEN_15 = do_deq ? _T_132 : value_1;
  assign _T_133 = do_enq != do_deq;
  assign _GEN_16 = _T_133 ? do_enq : maybe_full;
  assign _T_135 = _T_109 == 1'h0;
  assign _T_137 = _T_110 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_len[initvar] = _RAND_1[7:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  value_1 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  maybe_full = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_addr__T_113_en & ram_addr__T_113_mask) begin
      ram_addr[ram_addr__T_113_addr] <= ram_addr__T_113_data;
    end
    if(ram_len__T_113_en & ram_len__T_113_mask) begin
      ram_len[ram_len__T_113_addr] <= ram_len__T_113_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_128;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_132;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_133) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_8(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_data
);
  reg [63:0] ram_data [0:1];
  reg [63:0] _RAND_0;
  wire [63:0] ram_data__T_90_data;
  wire  ram_data__T_90_addr;
  wire [63:0] ram_data__T_71_data;
  wire  ram_data__T_71_addr;
  wire  ram_data__T_71_mask;
  wire  ram_data__T_71_en;
  reg  value;
  reg [31:0] _RAND_1;
  reg  value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_64;
  wire  _T_66;
  wire  _T_67;
  wire  _T_68;
  wire  _T_69;
  wire  do_enq;
  wire  _T_70;
  wire  do_deq;
  wire [1:0] _T_79;
  wire  _T_80;
  wire  _GEN_8;
  wire [1:0] _T_83;
  wire  _T_84;
  wire  _GEN_9;
  wire  _T_85;
  wire  _GEN_10;
  wire  _T_87;
  wire  _T_89;
  assign io_enq_ready = _T_89;
  assign io_deq_valid = _T_87;
  assign io_deq_bits_data = ram_data__T_90_data;
  assign ram_data__T_90_addr = value_1;
  assign ram_data__T_90_data = ram_data[ram_data__T_90_addr];
  assign ram_data__T_71_data = io_enq_bits_data;
  assign ram_data__T_71_addr = value;
  assign ram_data__T_71_mask = do_enq;
  assign ram_data__T_71_en = do_enq;
  assign _T_64 = value == value_1;
  assign _T_66 = maybe_full == 1'h0;
  assign _T_67 = _T_64 & _T_66;
  assign _T_68 = _T_64 & maybe_full;
  assign _T_69 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_69;
  assign _T_70 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_70;
  assign _T_79 = value + 1'h1;
  assign _T_80 = _T_79[0:0];
  assign _GEN_8 = do_enq ? _T_80 : value;
  assign _T_83 = value_1 + 1'h1;
  assign _T_84 = _T_83[0:0];
  assign _GEN_9 = do_deq ? _T_84 : value_1;
  assign _T_85 = do_enq != do_deq;
  assign _GEN_10 = _T_85 ? do_enq : maybe_full;
  assign _T_87 = _T_67 == 1'h0;
  assign _T_89 = _T_68 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {2{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_0[63:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value_1 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_data__T_71_en & ram_data__T_71_mask) begin
      ram_data[ram_data__T_71_addr] <= ram_data__T_71_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_80;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_84;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_85) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_9(
  input   clock,
  input   reset,
  output  io_enq_ready,
  input   io_enq_valid,
  output  io_deq_valid
);
  reg  value;
  reg [31:0] _RAND_0;
  reg  value_1;
  reg [31:0] _RAND_1;
  reg  maybe_full;
  reg [31:0] _RAND_2;
  wire  _T_50;
  wire  _T_52;
  wire  _T_53;
  wire  _T_54;
  wire  _T_55;
  wire  do_enq;
  wire  do_deq;
  wire [1:0] _T_63;
  wire  _T_64;
  wire  _GEN_6;
  wire [1:0] _T_67;
  wire  _T_68;
  wire  _GEN_7;
  wire  _T_69;
  wire  _GEN_8;
  wire  _T_71;
  wire  _T_73;
  assign io_enq_ready = _T_73;
  assign io_deq_valid = _T_71;
  assign _T_50 = value == value_1;
  assign _T_52 = maybe_full == 1'h0;
  assign _T_53 = _T_50 & _T_52;
  assign _T_54 = _T_50 & maybe_full;
  assign _T_55 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_55;
  assign do_deq = io_deq_valid;
  assign _T_63 = value + 1'h1;
  assign _T_64 = _T_63[0:0];
  assign _GEN_6 = do_enq ? _T_64 : value;
  assign _T_67 = value_1 + 1'h1;
  assign _T_68 = _T_67[0:0];
  assign _GEN_7 = do_deq ? _T_68 : value_1;
  assign _T_69 = do_enq != do_deq;
  assign _GEN_8 = _T_69 ? do_enq : maybe_full;
  assign _T_71 = _T_53 == 1'h0;
  assign _T_73 = _T_54 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  value = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value_1 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  maybe_full = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_64;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_68;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_69) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_11(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid
);
  reg  value;
  reg [31:0] _RAND_0;
  reg  value_1;
  reg [31:0] _RAND_1;
  reg  maybe_full;
  reg [31:0] _RAND_2;
  wire  _T_64;
  wire  _T_66;
  wire  _T_67;
  wire  _T_68;
  wire  _T_69;
  wire  do_enq;
  wire  _T_70;
  wire  do_deq;
  wire [1:0] _T_79;
  wire  _T_80;
  wire  _GEN_8;
  wire [1:0] _T_83;
  wire  _T_84;
  wire  _GEN_9;
  wire  _T_85;
  wire  _GEN_10;
  wire  _T_87;
  wire  _T_89;
  assign io_enq_ready = _T_89;
  assign io_deq_valid = _T_87;
  assign _T_64 = value == value_1;
  assign _T_66 = maybe_full == 1'h0;
  assign _T_67 = _T_64 & _T_66;
  assign _T_68 = _T_64 & maybe_full;
  assign _T_69 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_69;
  assign _T_70 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_70;
  assign _T_79 = value + 1'h1;
  assign _T_80 = _T_79[0:0];
  assign _GEN_8 = do_enq ? _T_80 : value;
  assign _T_83 = value_1 + 1'h1;
  assign _T_84 = _T_83[0:0];
  assign _GEN_9 = do_deq ? _T_84 : value_1;
  assign _T_85 = do_enq != do_deq;
  assign _GEN_10 = _T_85 ? do_enq : maybe_full;
  assign _T_87 = _T_67 == 1'h0;
  assign _T_89 = _T_68 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  value = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value_1 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  maybe_full = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_80;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_84;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_85) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_12(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input          io_enq_bits_isWrite,
  input  [63:0]  io_enq_bits_addr,
  input  [575:0] io_enq_bits_data,
  input          io_deq_ready,
  output         io_deq_valid,
  output         io_deq_bits_isWrite,
  output [63:0]  io_deq_bits_addr,
  output [575:0] io_deq_bits_data
);
  reg  ram_isWrite [0:1];
  reg [31:0] _RAND_0;
  wire  ram_isWrite__T_74_data;
  wire  ram_isWrite__T_74_addr;
  wire  ram_isWrite__T_57_data;
  wire  ram_isWrite__T_57_addr;
  wire  ram_isWrite__T_57_mask;
  wire  ram_isWrite__T_57_en;
  reg [63:0] ram_addr [0:1];
  reg [63:0] _RAND_1;
  wire [63:0] ram_addr__T_74_data;
  wire  ram_addr__T_74_addr;
  wire [63:0] ram_addr__T_57_data;
  wire  ram_addr__T_57_addr;
  wire  ram_addr__T_57_mask;
  wire  ram_addr__T_57_en;
  reg [575:0] ram_data [0:1];
  reg [575:0] _RAND_2;
  wire [575:0] ram_data__T_74_data;
  wire  ram_data__T_74_addr;
  wire [575:0] ram_data__T_57_data;
  wire  ram_data__T_57_addr;
  wire  ram_data__T_57_mask;
  wire  ram_data__T_57_en;
  reg  value;
  reg [31:0] _RAND_3;
  reg  value_1;
  reg [31:0] _RAND_4;
  reg  maybe_full;
  reg [31:0] _RAND_5;
  wire  _T_50;
  wire  _T_52;
  wire  _T_53;
  wire  _T_54;
  wire  _T_55;
  wire  do_enq;
  wire  _T_56;
  wire  do_deq;
  wire [1:0] _T_63;
  wire  _T_64;
  wire  _GEN_6;
  wire [1:0] _T_67;
  wire  _T_68;
  wire  _GEN_7;
  wire  _T_69;
  wire  _GEN_8;
  wire  _T_71;
  wire  _T_73;
  assign io_enq_ready = _T_73;
  assign io_deq_valid = _T_71;
  assign io_deq_bits_isWrite = ram_isWrite__T_74_data;
  assign io_deq_bits_addr = ram_addr__T_74_data;
  assign io_deq_bits_data = ram_data__T_74_data;
  assign ram_isWrite__T_74_addr = value_1;
  assign ram_isWrite__T_74_data = ram_isWrite[ram_isWrite__T_74_addr];
  assign ram_isWrite__T_57_data = io_enq_bits_isWrite;
  assign ram_isWrite__T_57_addr = value;
  assign ram_isWrite__T_57_mask = do_enq;
  assign ram_isWrite__T_57_en = do_enq;
  assign ram_addr__T_74_addr = value_1;
  assign ram_addr__T_74_data = ram_addr[ram_addr__T_74_addr];
  assign ram_addr__T_57_data = io_enq_bits_addr;
  assign ram_addr__T_57_addr = value;
  assign ram_addr__T_57_mask = do_enq;
  assign ram_addr__T_57_en = do_enq;
  assign ram_data__T_74_addr = value_1;
  assign ram_data__T_74_data = ram_data[ram_data__T_74_addr];
  assign ram_data__T_57_data = io_enq_bits_data;
  assign ram_data__T_57_addr = value;
  assign ram_data__T_57_mask = do_enq;
  assign ram_data__T_57_en = do_enq;
  assign _T_50 = value == value_1;
  assign _T_52 = maybe_full == 1'h0;
  assign _T_53 = _T_50 & _T_52;
  assign _T_54 = _T_50 & maybe_full;
  assign _T_55 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_55;
  assign _T_56 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_56;
  assign _T_63 = value + 1'h1;
  assign _T_64 = _T_63[0:0];
  assign _GEN_6 = do_enq ? _T_64 : value;
  assign _T_67 = value_1 + 1'h1;
  assign _T_68 = _T_67[0:0];
  assign _GEN_7 = do_deq ? _T_68 : value_1;
  assign _T_69 = do_enq != do_deq;
  assign _GEN_8 = _T_69 ? do_enq : maybe_full;
  assign _T_71 = _T_53 == 1'h0;
  assign _T_73 = _T_54 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_isWrite[initvar] = _RAND_0[0:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {2{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_addr[initvar] = _RAND_1[63:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_2 = {18{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[575:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  value = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  value_1 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  maybe_full = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_isWrite__T_57_en & ram_isWrite__T_57_mask) begin
      ram_isWrite[ram_isWrite__T_57_addr] <= ram_isWrite__T_57_data;
    end
    if(ram_addr__T_57_en & ram_addr__T_57_mask) begin
      ram_addr[ram_addr__T_57_addr] <= ram_addr__T_57_data;
    end
    if(ram_data__T_57_en & ram_data__T_57_mask) begin
      ram_data[ram_data__T_57_addr] <= ram_data__T_57_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_64;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_68;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_69) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_15(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [575:0] io_enq_bits_data,
  input          io_deq_ready,
  output         io_deq_valid,
  output [575:0] io_deq_bits_data
);
  reg [575:0] ram_data [0:1];
  reg [575:0] _RAND_0;
  wire [575:0] ram_data__T_58_data;
  wire  ram_data__T_58_addr;
  wire [575:0] ram_data__T_43_data;
  wire  ram_data__T_43_addr;
  wire  ram_data__T_43_mask;
  wire  ram_data__T_43_en;
  reg  value;
  reg [31:0] _RAND_1;
  reg  value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_36;
  wire  _T_38;
  wire  _T_39;
  wire  _T_40;
  wire  _T_41;
  wire  do_enq;
  wire  _T_42;
  wire  do_deq;
  wire [1:0] _T_47;
  wire  _T_48;
  wire  _GEN_4;
  wire [1:0] _T_51;
  wire  _T_52;
  wire  _GEN_5;
  wire  _T_53;
  wire  _GEN_6;
  wire  _T_55;
  wire  _T_57;
  assign io_enq_ready = _T_57;
  assign io_deq_valid = _T_55;
  assign io_deq_bits_data = ram_data__T_58_data;
  assign ram_data__T_58_addr = value_1;
  assign ram_data__T_58_data = ram_data[ram_data__T_58_addr];
  assign ram_data__T_43_data = io_enq_bits_data;
  assign ram_data__T_43_addr = value;
  assign ram_data__T_43_mask = do_enq;
  assign ram_data__T_43_en = do_enq;
  assign _T_36 = value == value_1;
  assign _T_38 = maybe_full == 1'h0;
  assign _T_39 = _T_36 & _T_38;
  assign _T_40 = _T_36 & maybe_full;
  assign _T_41 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_41;
  assign _T_42 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_42;
  assign _T_47 = value + 1'h1;
  assign _T_48 = _T_47[0:0];
  assign _GEN_4 = do_enq ? _T_48 : value;
  assign _T_51 = value_1 + 1'h1;
  assign _T_52 = _T_51[0:0];
  assign _GEN_5 = do_deq ? _T_52 : value_1;
  assign _T_53 = do_enq != do_deq;
  assign _GEN_6 = _T_53 ? do_enq : maybe_full;
  assign _T_55 = _T_39 == 1'h0;
  assign _T_57 = _T_40 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {18{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_0[575:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  value = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  value_1 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_data__T_43_en & ram_data__T_43_mask) begin
      ram_data[ram_data__T_43_addr] <= ram_data__T_43_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_48;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_52;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_53) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_16(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_len,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_len
);
  reg [31:0] ram_addr [0:9];
  reg [31:0] _RAND_0;
  wire [31:0] ram_addr__T_140_data;
  wire [3:0] ram_addr__T_140_addr;
  reg [31:0] _RAND_1;
  wire [31:0] ram_addr__T_113_data;
  wire [3:0] ram_addr__T_113_addr;
  wire  ram_addr__T_113_mask;
  wire  ram_addr__T_113_en;
  reg [7:0] ram_len [0:9];
  reg [31:0] _RAND_2;
  wire [7:0] ram_len__T_140_data;
  wire [3:0] ram_len__T_140_addr;
  reg [31:0] _RAND_3;
  wire [7:0] ram_len__T_113_data;
  wire [3:0] ram_len__T_113_addr;
  wire  ram_len__T_113_mask;
  wire  ram_len__T_113_en;
  reg [3:0] value;
  reg [31:0] _RAND_4;
  reg [3:0] value_1;
  reg [31:0] _RAND_5;
  reg  maybe_full;
  reg [31:0] _RAND_6;
  wire  _T_106;
  wire  _T_108;
  wire  _T_109;
  wire  _T_110;
  wire  _T_111;
  wire  do_enq;
  wire  _T_112;
  wire  do_deq;
  wire  wrap;
  wire [4:0] _T_127;
  wire [3:0] _T_128;
  wire [3:0] _GEN_0;
  wire [3:0] _GEN_15;
  wire  wrap_1;
  wire [4:0] _T_132;
  wire [3:0] _T_133;
  wire [3:0] _GEN_16;
  wire [3:0] _GEN_17;
  wire  _T_135;
  wire  _GEN_18;
  wire  _T_137;
  wire  _T_139;
  assign io_enq_ready = _T_139;
  assign io_deq_valid = _T_137;
  assign io_deq_bits_addr = ram_addr__T_140_data;
  assign io_deq_bits_len = ram_len__T_140_data;
  assign ram_addr__T_140_addr = value_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_addr__T_140_data = ram_addr[ram_addr__T_140_addr];
  `else
  assign ram_addr__T_140_data = ram_addr__T_140_addr >= 4'ha ? _RAND_1[31:0] : ram_addr[ram_addr__T_140_addr];
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_addr__T_113_data = io_enq_bits_addr;
  assign ram_addr__T_113_addr = value;
  assign ram_addr__T_113_mask = do_enq;
  assign ram_addr__T_113_en = do_enq;
  assign ram_len__T_140_addr = value_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_len__T_140_data = ram_len[ram_len__T_140_addr];
  `else
  assign ram_len__T_140_data = ram_len__T_140_addr >= 4'ha ? _RAND_3[7:0] : ram_len[ram_len__T_140_addr];
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_len__T_113_data = io_enq_bits_len;
  assign ram_len__T_113_addr = value;
  assign ram_len__T_113_mask = do_enq;
  assign ram_len__T_113_en = do_enq;
  assign _T_106 = value == value_1;
  assign _T_108 = maybe_full == 1'h0;
  assign _T_109 = _T_106 & _T_108;
  assign _T_110 = _T_106 & maybe_full;
  assign _T_111 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_111;
  assign _T_112 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_112;
  assign wrap = value == 4'h9;
  assign _T_127 = value + 4'h1;
  assign _T_128 = _T_127[3:0];
  assign _GEN_0 = wrap ? 4'h0 : _T_128;
  assign _GEN_15 = do_enq ? _GEN_0 : value;
  assign wrap_1 = value_1 == 4'h9;
  assign _T_132 = value_1 + 4'h1;
  assign _T_133 = _T_132[3:0];
  assign _GEN_16 = wrap_1 ? 4'h0 : _T_133;
  assign _GEN_17 = do_deq ? _GEN_16 : value_1;
  assign _T_135 = do_enq != do_deq;
  assign _GEN_18 = _T_135 ? do_enq : maybe_full;
  assign _T_137 = _T_109 == 1'h0;
  assign _T_139 = _T_110 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 10; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {1{$random}};
  _RAND_2 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 10; initvar = initvar+1)
    ram_len[initvar] = _RAND_2[7:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_3 = {1{$random}};
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  value = _RAND_4[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  value_1 = _RAND_5[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  maybe_full = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_addr__T_113_en & ram_addr__T_113_mask) begin
      ram_addr[ram_addr__T_113_addr] <= ram_addr__T_113_data;
    end
    if(ram_len__T_113_en & ram_len__T_113_mask) begin
      ram_len[ram_len__T_113_addr] <= ram_len__T_113_data;
    end
    if (reset) begin
      value <= 4'h0;
    end else begin
      if (do_enq) begin
        if (wrap) begin
          value <= 4'h0;
        end else begin
          value <= _T_128;
        end
      end
    end
    if (reset) begin
      value_1 <= 4'h0;
    end else begin
      if (do_deq) begin
        if (wrap_1) begin
          value_1 <= 4'h0;
        end else begin
          value_1 <= _T_133;
        end
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_135) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module NastiWriteRequestSplitter(
  input         clock,
  input         reset,
  output        io_write_requests_ready,
  input         io_write_requests_valid,
  input  [31:0] io_write_requests_bits_addr,
  input  [7:0]  io_write_requests_bits_len,
  input         io_split_write_requests_ready,
  output        io_split_write_requests_valid,
  output [31:0] io_split_write_requests_bits_addr,
  output [7:0]  io_split_write_requests_bits_len
);
  reg [31:0] splitcountReg;
  reg [31:0] _RAND_0;
  wire [31:0] _GEN_0;
  wire  splitcountRegLast;
  wire [34:0] _GEN_1;
  wire [34:0] _T_115;
  wire [34:0] _GEN_2;
  wire [35:0] _T_116;
  wire [34:0] _T_117;
  wire  _T_120;
  wire  _T_121;
  wire  _T_122;
  wire [32:0] _T_124;
  wire [31:0] _T_125;
  wire [31:0] incremented_or_plain;
  wire  _T_127;
  wire [31:0] _T_129;
  assign io_write_requests_ready = _T_121;
  assign io_split_write_requests_valid = io_write_requests_valid;
  assign io_split_write_requests_bits_addr = _T_117[31:0];
  assign io_split_write_requests_bits_len = {{7'd0}, _T_120};
  assign _GEN_0 = {{24'd0}, io_write_requests_bits_len};
  assign splitcountRegLast = _GEN_0 == splitcountReg;
  assign _GEN_1 = {{3'd0}, splitcountReg};
  assign _T_115 = _GEN_1 << 2'h3;
  assign _GEN_2 = {{3'd0}, io_write_requests_bits_addr};
  assign _T_116 = _GEN_2 + _T_115;
  assign _T_117 = _T_116[34:0];
  assign _T_120 = splitcountRegLast ? 1'h0 : 1'h1;
  assign _T_121 = io_split_write_requests_ready & splitcountRegLast;
  assign _T_122 = io_write_requests_valid & io_split_write_requests_ready;
  assign _T_124 = splitcountReg + 32'h1;
  assign _T_125 = _T_124[31:0];
  assign incremented_or_plain = _T_122 ? _T_125 : splitcountReg;
  assign _T_127 = _T_122 & splitcountRegLast;
  assign _T_129 = _T_127 ? 32'h0 : incremented_or_plain;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  splitcountReg = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      splitcountReg <= 32'h0;
    end else begin
      if (_T_127) begin
        splitcountReg <= 32'h0;
      end else begin
        if (_T_122) begin
          splitcountReg <= _T_125;
        end
      end
    end
  end
endmodule
module RRArbiter_1(
  input          clock,
  output         io_in_0_ready,
  input          io_in_0_valid,
  input          io_in_0_bits_isWrite,
  input  [63:0]  io_in_0_bits_addr,
  input  [575:0] io_in_0_bits_data,
  output         io_in_1_ready,
  input          io_in_1_valid,
  input          io_in_1_bits_isWrite,
  input  [63:0]  io_in_1_bits_addr,
  input  [575:0] io_in_1_bits_data,
  input          io_out_ready,
  output         io_out_valid,
  output         io_out_bits_isWrite,
  output [63:0]  io_out_bits_addr,
  output [575:0] io_out_bits_data,
  output         io_chosen
);
  wire  choice;
  wire  _GEN_0_valid;
  wire  _GEN_5;
  wire  _GEN_6;
  wire [63:0] _GEN_7;
  wire [575:0] _GEN_8;
  wire  _GEN_1_bits_isWrite;
  wire [63:0] _GEN_2_bits_addr;
  wire [575:0] _GEN_3_bits_data;
  wire  _T_197;
  reg  lastGrant;
  reg [31:0] _RAND_0;
  wire  _GEN_9;
  wire  grantMask_1;
  wire  validMask_1;
  wire  _T_202;
  wire  _T_206;
  wire  _T_208;
  wire  _T_212;
  wire  _T_213;
  wire  _T_214;
  wire  _GEN_10;
  wire  _GEN_11;
  assign io_in_0_ready = _T_213;
  assign io_in_1_ready = _T_214;
  assign io_out_valid = _GEN_0_valid;
  assign io_out_bits_isWrite = _GEN_1_bits_isWrite;
  assign io_out_bits_addr = _GEN_2_bits_addr;
  assign io_out_bits_data = _GEN_3_bits_data;
  assign io_chosen = choice;
  assign choice = _GEN_11;
  assign _GEN_0_valid = _GEN_5;
  assign _GEN_5 = io_chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_6 = io_chosen ? io_in_1_bits_isWrite : io_in_0_bits_isWrite;
  assign _GEN_7 = io_chosen ? io_in_1_bits_addr : io_in_0_bits_addr;
  assign _GEN_8 = io_chosen ? io_in_1_bits_data : io_in_0_bits_data;
  assign _GEN_1_bits_isWrite = _GEN_6;
  assign _GEN_2_bits_addr = _GEN_7;
  assign _GEN_3_bits_data = _GEN_8;
  assign _T_197 = io_out_ready & io_out_valid;
  assign _GEN_9 = _T_197 ? io_chosen : lastGrant;
  assign grantMask_1 = 1'h1 > lastGrant;
  assign validMask_1 = io_in_1_valid & grantMask_1;
  assign _T_202 = validMask_1 | io_in_0_valid;
  assign _T_206 = validMask_1 == 1'h0;
  assign _T_208 = _T_202 == 1'h0;
  assign _T_212 = grantMask_1 | _T_208;
  assign _T_213 = _T_206 & io_out_ready;
  assign _T_214 = _T_212 & io_out_ready;
  assign _GEN_10 = io_in_0_valid ? 1'h0 : 1'h1;
  assign _GEN_11 = validMask_1 ? 1'h1 : _GEN_10;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  lastGrant = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_197) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module Queue_17(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_len
);
  reg [31:0] ram_addr [0:19];
  reg [31:0] _RAND_0;
  wire [31:0] ram_addr__T_140_data;
  wire [4:0] ram_addr__T_140_addr;
  reg [31:0] _RAND_1;
  wire [31:0] ram_addr__T_113_data;
  wire [4:0] ram_addr__T_113_addr;
  wire  ram_addr__T_113_mask;
  wire  ram_addr__T_113_en;
  reg [7:0] ram_len [0:19];
  reg [31:0] _RAND_2;
  wire [7:0] ram_len__T_140_data;
  wire [4:0] ram_len__T_140_addr;
  reg [31:0] _RAND_3;
  wire [7:0] ram_len__T_113_data;
  wire [4:0] ram_len__T_113_addr;
  wire  ram_len__T_113_mask;
  wire  ram_len__T_113_en;
  reg [4:0] value;
  reg [31:0] _RAND_4;
  reg [4:0] value_1;
  reg [31:0] _RAND_5;
  reg  maybe_full;
  reg [31:0] _RAND_6;
  wire  _T_106;
  wire  _T_108;
  wire  _T_109;
  wire  _T_110;
  wire  _T_111;
  wire  do_enq;
  wire  _T_112;
  wire  do_deq;
  wire  wrap;
  wire [5:0] _T_127;
  wire [4:0] _T_128;
  wire [4:0] _GEN_0;
  wire [4:0] _GEN_15;
  wire  wrap_1;
  wire [5:0] _T_132;
  wire [4:0] _T_133;
  wire [4:0] _GEN_16;
  wire [4:0] _GEN_17;
  wire  _T_135;
  wire  _GEN_18;
  wire  _T_137;
  wire  _T_139;
  assign io_enq_ready = _T_139;
  assign io_deq_valid = _T_137;
  assign io_deq_bits_addr = ram_addr__T_140_data;
  assign io_deq_bits_len = ram_len__T_140_data;
  assign ram_addr__T_140_addr = value_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_addr__T_140_data = ram_addr[ram_addr__T_140_addr];
  `else
  assign ram_addr__T_140_data = ram_addr__T_140_addr >= 5'h14 ? _RAND_1[31:0] : ram_addr[ram_addr__T_140_addr];
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_addr__T_113_data = io_enq_bits_addr;
  assign ram_addr__T_113_addr = value;
  assign ram_addr__T_113_mask = do_enq;
  assign ram_addr__T_113_en = do_enq;
  assign ram_len__T_140_addr = value_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_len__T_140_data = ram_len[ram_len__T_140_addr];
  `else
  assign ram_len__T_140_data = ram_len__T_140_addr >= 5'h14 ? _RAND_3[7:0] : ram_len[ram_len__T_140_addr];
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_len__T_113_data = 8'h0;
  assign ram_len__T_113_addr = value;
  assign ram_len__T_113_mask = do_enq;
  assign ram_len__T_113_en = do_enq;
  assign _T_106 = value == value_1;
  assign _T_108 = maybe_full == 1'h0;
  assign _T_109 = _T_106 & _T_108;
  assign _T_110 = _T_106 & maybe_full;
  assign _T_111 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_111;
  assign _T_112 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_112;
  assign wrap = value == 5'h13;
  assign _T_127 = value + 5'h1;
  assign _T_128 = _T_127[4:0];
  assign _GEN_0 = wrap ? 5'h0 : _T_128;
  assign _GEN_15 = do_enq ? _GEN_0 : value;
  assign wrap_1 = value_1 == 5'h13;
  assign _T_132 = value_1 + 5'h1;
  assign _T_133 = _T_132[4:0];
  assign _GEN_16 = wrap_1 ? 5'h0 : _T_133;
  assign _GEN_17 = do_deq ? _GEN_16 : value_1;
  assign _T_135 = do_enq != do_deq;
  assign _GEN_18 = _T_135 ? do_enq : maybe_full;
  assign _T_137 = _T_109 == 1'h0;
  assign _T_139 = _T_110 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 20; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {1{$random}};
  _RAND_2 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 20; initvar = initvar+1)
    ram_len[initvar] = _RAND_2[7:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_3 = {1{$random}};
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  value = _RAND_4[4:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  value_1 = _RAND_5[4:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  maybe_full = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_addr__T_113_en & ram_addr__T_113_mask) begin
      ram_addr[ram_addr__T_113_addr] <= ram_addr__T_113_data;
    end
    if(ram_len__T_113_en & ram_len__T_113_mask) begin
      ram_len[ram_len__T_113_addr] <= ram_len__T_113_data;
    end
    if (reset) begin
      value <= 5'h0;
    end else begin
      if (do_enq) begin
        if (wrap) begin
          value <= 5'h0;
        end else begin
          value <= _T_128;
        end
      end
    end
    if (reset) begin
      value_1 <= 5'h0;
    end else begin
      if (do_deq) begin
        if (wrap_1) begin
          value_1 <= 5'h0;
        end else begin
          value_1 <= _T_133;
        end
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_135) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module NastiRequestSplitter(
  input         clock,
  input         reset,
  output        io_read_requests_ready,
  input         io_read_requests_valid,
  input  [31:0] io_read_requests_bits_addr,
  input  [7:0]  io_read_requests_bits_len,
  input         io_split_read_requests_ready,
  output        io_split_read_requests_valid,
  output [31:0] io_split_read_requests_bits_addr
);
  reg [31:0] splitcountReg;
  reg [31:0] _RAND_0;
  wire [31:0] _GEN_0;
  wire  splitcountRegLast;
  wire [34:0] _GEN_1;
  wire [34:0] _T_115;
  wire [34:0] _GEN_2;
  wire [35:0] _T_116;
  wire [34:0] _T_117;
  wire  _T_119;
  wire  _T_120;
  wire [32:0] _T_122;
  wire [31:0] _T_123;
  wire [31:0] incremented_or_plain;
  wire  _T_125;
  wire [31:0] _T_127;
  assign io_read_requests_ready = _T_119;
  assign io_split_read_requests_valid = io_read_requests_valid;
  assign io_split_read_requests_bits_addr = _T_117[31:0];
  assign _GEN_0 = {{24'd0}, io_read_requests_bits_len};
  assign splitcountRegLast = _GEN_0 == splitcountReg;
  assign _GEN_1 = {{3'd0}, splitcountReg};
  assign _T_115 = _GEN_1 << 2'h3;
  assign _GEN_2 = {{3'd0}, io_read_requests_bits_addr};
  assign _T_116 = _GEN_2 + _T_115;
  assign _T_117 = _T_116[34:0];
  assign _T_119 = io_split_read_requests_ready & splitcountRegLast;
  assign _T_120 = io_read_requests_valid & io_split_read_requests_ready;
  assign _T_122 = splitcountReg + 32'h1;
  assign _T_123 = _T_122[31:0];
  assign incremented_or_plain = _T_120 ? _T_123 : splitcountReg;
  assign _T_125 = _T_120 & splitcountRegLast;
  assign _T_127 = _T_125 ? 32'h0 : incremented_or_plain;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  splitcountReg = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      splitcountReg <= 32'h0;
    end else begin
      if (_T_125) begin
        splitcountReg <= 32'h0;
      end else begin
        if (_T_120) begin
          splitcountReg <= _T_123;
        end
      end
    end
  end
endmodule
module NastiUMIAdapter(
  input          clock,
  input          reset,
  output         io_nastimem_aw_ready,
  input          io_nastimem_aw_valid,
  input  [31:0]  io_nastimem_aw_bits_addr,
  output         io_nastimem_w_ready,
  input          io_nastimem_w_valid,
  input  [63:0]  io_nastimem_w_bits_data,
  output         io_nastimem_ar_ready,
  input          io_nastimem_ar_valid,
  input  [31:0]  io_nastimem_ar_bits_addr,
  input          io_nastimem_r_ready,
  output         io_nastimem_r_valid,
  input          io_umireq_ready,
  output         io_umireq_valid,
  output         io_umireq_bits_isWrite,
  output [63:0]  io_umireq_bits_addr,
  output [575:0] io_umireq_bits_data,
  output         io_umiresp_ready,
  input          io_umiresp_valid,
  input  [575:0] io_umiresp_bits_data
);
  wire  awQ_clock;
  wire  awQ_reset;
  wire  awQ_io_enq_ready;
  wire  awQ_io_enq_valid;
  wire [31:0] awQ_io_enq_bits_addr;
  wire  awQ_io_deq_ready;
  wire  awQ_io_deq_valid;
  wire [31:0] awQ_io_deq_bits_addr;
  wire [7:0] awQ_io_deq_bits_len;
  wire  wQ_clock;
  wire  wQ_reset;
  wire  wQ_io_enq_ready;
  wire  wQ_io_enq_valid;
  wire [63:0] wQ_io_enq_bits_data;
  wire  wQ_io_deq_ready;
  wire  wQ_io_deq_valid;
  wire [63:0] wQ_io_deq_bits_data;
  wire  bQ_clock;
  wire  bQ_reset;
  wire  bQ_io_enq_ready;
  wire  bQ_io_enq_valid;
  wire  bQ_io_deq_valid;
  wire  arQ_clock;
  wire  arQ_reset;
  wire  arQ_io_enq_ready;
  wire  arQ_io_enq_valid;
  wire [31:0] arQ_io_enq_bits_addr;
  wire  arQ_io_deq_ready;
  wire  arQ_io_deq_valid;
  wire [31:0] arQ_io_deq_bits_addr;
  wire [7:0] arQ_io_deq_bits_len;
  wire  rQ_clock;
  wire  rQ_reset;
  wire  rQ_io_enq_ready;
  wire  rQ_io_enq_valid;
  wire [63:0] rQ_io_enq_bits_data;
  wire  rQ_io_deq_ready;
  wire  rQ_io_deq_valid;
  wire  umireqQwrite_clock;
  wire  umireqQwrite_reset;
  wire  umireqQwrite_io_enq_ready;
  wire  umireqQwrite_io_enq_valid;
  wire  umireqQwrite_io_enq_bits_isWrite;
  wire [63:0] umireqQwrite_io_enq_bits_addr;
  wire [575:0] umireqQwrite_io_enq_bits_data;
  wire  umireqQwrite_io_deq_ready;
  wire  umireqQwrite_io_deq_valid;
  wire  umireqQwrite_io_deq_bits_isWrite;
  wire [63:0] umireqQwrite_io_deq_bits_addr;
  wire [575:0] umireqQwrite_io_deq_bits_data;
  wire  umireqQread_clock;
  wire  umireqQread_reset;
  wire  umireqQread_io_enq_ready;
  wire  umireqQread_io_enq_valid;
  wire  umireqQread_io_enq_bits_isWrite;
  wire [63:0] umireqQread_io_enq_bits_addr;
  wire [575:0] umireqQread_io_enq_bits_data;
  wire  umireqQread_io_deq_ready;
  wire  umireqQread_io_deq_valid;
  wire  umireqQread_io_deq_bits_isWrite;
  wire [63:0] umireqQread_io_deq_bits_addr;
  wire [575:0] umireqQread_io_deq_bits_data;
  wire  umireqQ_clock;
  wire  umireqQ_reset;
  wire  umireqQ_io_enq_ready;
  wire  umireqQ_io_enq_valid;
  wire  umireqQ_io_enq_bits_isWrite;
  wire [63:0] umireqQ_io_enq_bits_addr;
  wire [575:0] umireqQ_io_enq_bits_data;
  wire  umireqQ_io_deq_ready;
  wire  umireqQ_io_deq_valid;
  wire  umireqQ_io_deq_bits_isWrite;
  wire [63:0] umireqQ_io_deq_bits_addr;
  wire [575:0] umireqQ_io_deq_bits_data;
  wire  umirespQ_clock;
  wire  umirespQ_reset;
  wire  umirespQ_io_enq_ready;
  wire  umirespQ_io_enq_valid;
  wire [575:0] umirespQ_io_enq_bits_data;
  wire  umirespQ_io_deq_ready;
  wire  umirespQ_io_deq_valid;
  wire [575:0] umirespQ_io_deq_bits_data;
  wire  awQsplit_clock;
  wire  awQsplit_reset;
  wire  awQsplit_io_enq_ready;
  wire  awQsplit_io_enq_valid;
  wire [31:0] awQsplit_io_enq_bits_addr;
  wire [7:0] awQsplit_io_enq_bits_len;
  wire  awQsplit_io_deq_ready;
  wire  awQsplit_io_deq_valid;
  wire [31:0] awQsplit_io_deq_bits_addr;
  wire [7:0] awQsplit_io_deq_bits_len;
  wire  writeSplitter_clock;
  wire  writeSplitter_reset;
  wire  writeSplitter_io_write_requests_ready;
  wire  writeSplitter_io_write_requests_valid;
  wire [31:0] writeSplitter_io_write_requests_bits_addr;
  wire [7:0] writeSplitter_io_write_requests_bits_len;
  wire  writeSplitter_io_split_write_requests_ready;
  wire  writeSplitter_io_split_write_requests_valid;
  wire [31:0] writeSplitter_io_split_write_requests_bits_addr;
  wire [7:0] writeSplitter_io_split_write_requests_bits_len;
  wire  umirequestArbiter_clock;
  wire  umirequestArbiter_io_in_0_ready;
  wire  umirequestArbiter_io_in_0_valid;
  wire  umirequestArbiter_io_in_0_bits_isWrite;
  wire [63:0] umirequestArbiter_io_in_0_bits_addr;
  wire [575:0] umirequestArbiter_io_in_0_bits_data;
  wire  umirequestArbiter_io_in_1_ready;
  wire  umirequestArbiter_io_in_1_valid;
  wire  umirequestArbiter_io_in_1_bits_isWrite;
  wire [63:0] umirequestArbiter_io_in_1_bits_addr;
  wire [575:0] umirequestArbiter_io_in_1_bits_data;
  wire  umirequestArbiter_io_out_ready;
  wire  umirequestArbiter_io_out_valid;
  wire  umirequestArbiter_io_out_bits_isWrite;
  wire [63:0] umirequestArbiter_io_out_bits_addr;
  wire [575:0] umirequestArbiter_io_out_bits_data;
  wire  umirequestArbiter_io_chosen;
  wire  _T_461;
  wire  _T_462;
  wire  _T_463;
  wire  _T_465;
  wire  do_ack;
  wire  _T_467;
  wire  _T_468;
  wire  _T_469;
  wire  _T_470;
  wire  _T_472;
  wire  _T_473;
  wire [32:0] _T_476;
  wire [32:0] _T_477;
  wire [31:0] _T_478;
  wire [34:0] _GEN_0;
  wire [34:0] _T_480;
  wire  arsplitQ_clock;
  wire  arsplitQ_reset;
  wire  arsplitQ_io_enq_ready;
  wire  arsplitQ_io_enq_valid;
  wire [31:0] arsplitQ_io_enq_bits_addr;
  wire  arsplitQ_io_deq_ready;
  wire  arsplitQ_io_deq_valid;
  wire [31:0] arsplitQ_io_deq_bits_addr;
  wire [7:0] arsplitQ_io_deq_bits_len;
  wire  splitter_clock;
  wire  splitter_reset;
  wire  splitter_io_read_requests_ready;
  wire  splitter_io_read_requests_valid;
  wire [31:0] splitter_io_read_requests_bits_addr;
  wire [7:0] splitter_io_read_requests_bits_len;
  wire  splitter_io_split_read_requests_ready;
  wire  splitter_io_split_read_requests_valid;
  wire [31:0] splitter_io_split_read_requests_bits_addr;
  wire  readInFlightQ_clock;
  wire  readInFlightQ_reset;
  wire  readInFlightQ_io_enq_ready;
  wire  readInFlightQ_io_enq_valid;
  wire [31:0] readInFlightQ_io_enq_bits_addr;
  wire [7:0] readInFlightQ_io_enq_bits_len;
  wire  readInFlightQ_io_deq_ready;
  wire  readInFlightQ_io_deq_valid;
  wire [31:0] readInFlightQ_io_deq_bits_addr;
  wire [7:0] readInFlightQ_io_deq_bits_len;
  wire  _T_508;
  wire  _T_509;
  wire  _T_510;
  wire [32:0] _T_511;
  wire [32:0] _T_512;
  wire [31:0] _T_513;
  wire [34:0] _GEN_1;
  wire [34:0] _T_515;
  wire  _T_518;
  wire  _T_519;
  wire  _T_522;
  wire  _T_523;
  wire [63:0] _T_525;
  Queue_7 awQ (
    .clock(awQ_clock),
    .reset(awQ_reset),
    .io_enq_ready(awQ_io_enq_ready),
    .io_enq_valid(awQ_io_enq_valid),
    .io_enq_bits_addr(awQ_io_enq_bits_addr),
    .io_deq_ready(awQ_io_deq_ready),
    .io_deq_valid(awQ_io_deq_valid),
    .io_deq_bits_addr(awQ_io_deq_bits_addr),
    .io_deq_bits_len(awQ_io_deq_bits_len)
  );
  Queue_8 wQ (
    .clock(wQ_clock),
    .reset(wQ_reset),
    .io_enq_ready(wQ_io_enq_ready),
    .io_enq_valid(wQ_io_enq_valid),
    .io_enq_bits_data(wQ_io_enq_bits_data),
    .io_deq_ready(wQ_io_deq_ready),
    .io_deq_valid(wQ_io_deq_valid),
    .io_deq_bits_data(wQ_io_deq_bits_data)
  );
  Queue_9 bQ (
    .clock(bQ_clock),
    .reset(bQ_reset),
    .io_enq_ready(bQ_io_enq_ready),
    .io_enq_valid(bQ_io_enq_valid),
    .io_deq_valid(bQ_io_deq_valid)
  );
  Queue_7 arQ (
    .clock(arQ_clock),
    .reset(arQ_reset),
    .io_enq_ready(arQ_io_enq_ready),
    .io_enq_valid(arQ_io_enq_valid),
    .io_enq_bits_addr(arQ_io_enq_bits_addr),
    .io_deq_ready(arQ_io_deq_ready),
    .io_deq_valid(arQ_io_deq_valid),
    .io_deq_bits_addr(arQ_io_deq_bits_addr),
    .io_deq_bits_len(arQ_io_deq_bits_len)
  );
  Queue_11 rQ (
    .clock(rQ_clock),
    .reset(rQ_reset),
    .io_enq_ready(rQ_io_enq_ready),
    .io_enq_valid(rQ_io_enq_valid),
    .io_enq_bits_data(rQ_io_enq_bits_data),
    .io_deq_ready(rQ_io_deq_ready),
    .io_deq_valid(rQ_io_deq_valid)
  );
  Queue_12 umireqQwrite (
    .clock(umireqQwrite_clock),
    .reset(umireqQwrite_reset),
    .io_enq_ready(umireqQwrite_io_enq_ready),
    .io_enq_valid(umireqQwrite_io_enq_valid),
    .io_enq_bits_isWrite(umireqQwrite_io_enq_bits_isWrite),
    .io_enq_bits_addr(umireqQwrite_io_enq_bits_addr),
    .io_enq_bits_data(umireqQwrite_io_enq_bits_data),
    .io_deq_ready(umireqQwrite_io_deq_ready),
    .io_deq_valid(umireqQwrite_io_deq_valid),
    .io_deq_bits_isWrite(umireqQwrite_io_deq_bits_isWrite),
    .io_deq_bits_addr(umireqQwrite_io_deq_bits_addr),
    .io_deq_bits_data(umireqQwrite_io_deq_bits_data)
  );
  Queue_12 umireqQread (
    .clock(umireqQread_clock),
    .reset(umireqQread_reset),
    .io_enq_ready(umireqQread_io_enq_ready),
    .io_enq_valid(umireqQread_io_enq_valid),
    .io_enq_bits_isWrite(umireqQread_io_enq_bits_isWrite),
    .io_enq_bits_addr(umireqQread_io_enq_bits_addr),
    .io_enq_bits_data(umireqQread_io_enq_bits_data),
    .io_deq_ready(umireqQread_io_deq_ready),
    .io_deq_valid(umireqQread_io_deq_valid),
    .io_deq_bits_isWrite(umireqQread_io_deq_bits_isWrite),
    .io_deq_bits_addr(umireqQread_io_deq_bits_addr),
    .io_deq_bits_data(umireqQread_io_deq_bits_data)
  );
  Queue_12 umireqQ (
    .clock(umireqQ_clock),
    .reset(umireqQ_reset),
    .io_enq_ready(umireqQ_io_enq_ready),
    .io_enq_valid(umireqQ_io_enq_valid),
    .io_enq_bits_isWrite(umireqQ_io_enq_bits_isWrite),
    .io_enq_bits_addr(umireqQ_io_enq_bits_addr),
    .io_enq_bits_data(umireqQ_io_enq_bits_data),
    .io_deq_ready(umireqQ_io_deq_ready),
    .io_deq_valid(umireqQ_io_deq_valid),
    .io_deq_bits_isWrite(umireqQ_io_deq_bits_isWrite),
    .io_deq_bits_addr(umireqQ_io_deq_bits_addr),
    .io_deq_bits_data(umireqQ_io_deq_bits_data)
  );
  Queue_15 umirespQ (
    .clock(umirespQ_clock),
    .reset(umirespQ_reset),
    .io_enq_ready(umirespQ_io_enq_ready),
    .io_enq_valid(umirespQ_io_enq_valid),
    .io_enq_bits_data(umirespQ_io_enq_bits_data),
    .io_deq_ready(umirespQ_io_deq_ready),
    .io_deq_valid(umirespQ_io_deq_valid),
    .io_deq_bits_data(umirespQ_io_deq_bits_data)
  );
  Queue_16 awQsplit (
    .clock(awQsplit_clock),
    .reset(awQsplit_reset),
    .io_enq_ready(awQsplit_io_enq_ready),
    .io_enq_valid(awQsplit_io_enq_valid),
    .io_enq_bits_addr(awQsplit_io_enq_bits_addr),
    .io_enq_bits_len(awQsplit_io_enq_bits_len),
    .io_deq_ready(awQsplit_io_deq_ready),
    .io_deq_valid(awQsplit_io_deq_valid),
    .io_deq_bits_addr(awQsplit_io_deq_bits_addr),
    .io_deq_bits_len(awQsplit_io_deq_bits_len)
  );
  NastiWriteRequestSplitter writeSplitter (
    .clock(writeSplitter_clock),
    .reset(writeSplitter_reset),
    .io_write_requests_ready(writeSplitter_io_write_requests_ready),
    .io_write_requests_valid(writeSplitter_io_write_requests_valid),
    .io_write_requests_bits_addr(writeSplitter_io_write_requests_bits_addr),
    .io_write_requests_bits_len(writeSplitter_io_write_requests_bits_len),
    .io_split_write_requests_ready(writeSplitter_io_split_write_requests_ready),
    .io_split_write_requests_valid(writeSplitter_io_split_write_requests_valid),
    .io_split_write_requests_bits_addr(writeSplitter_io_split_write_requests_bits_addr),
    .io_split_write_requests_bits_len(writeSplitter_io_split_write_requests_bits_len)
  );
  RRArbiter_1 umirequestArbiter (
    .clock(umirequestArbiter_clock),
    .io_in_0_ready(umirequestArbiter_io_in_0_ready),
    .io_in_0_valid(umirequestArbiter_io_in_0_valid),
    .io_in_0_bits_isWrite(umirequestArbiter_io_in_0_bits_isWrite),
    .io_in_0_bits_addr(umirequestArbiter_io_in_0_bits_addr),
    .io_in_0_bits_data(umirequestArbiter_io_in_0_bits_data),
    .io_in_1_ready(umirequestArbiter_io_in_1_ready),
    .io_in_1_valid(umirequestArbiter_io_in_1_valid),
    .io_in_1_bits_isWrite(umirequestArbiter_io_in_1_bits_isWrite),
    .io_in_1_bits_addr(umirequestArbiter_io_in_1_bits_addr),
    .io_in_1_bits_data(umirequestArbiter_io_in_1_bits_data),
    .io_out_ready(umirequestArbiter_io_out_ready),
    .io_out_valid(umirequestArbiter_io_out_valid),
    .io_out_bits_isWrite(umirequestArbiter_io_out_bits_isWrite),
    .io_out_bits_addr(umirequestArbiter_io_out_bits_addr),
    .io_out_bits_data(umirequestArbiter_io_out_bits_data),
    .io_chosen(umirequestArbiter_io_chosen)
  );
  Queue_17 arsplitQ (
    .clock(arsplitQ_clock),
    .reset(arsplitQ_reset),
    .io_enq_ready(arsplitQ_io_enq_ready),
    .io_enq_valid(arsplitQ_io_enq_valid),
    .io_enq_bits_addr(arsplitQ_io_enq_bits_addr),
    .io_deq_ready(arsplitQ_io_deq_ready),
    .io_deq_valid(arsplitQ_io_deq_valid),
    .io_deq_bits_addr(arsplitQ_io_deq_bits_addr),
    .io_deq_bits_len(arsplitQ_io_deq_bits_len)
  );
  NastiRequestSplitter splitter (
    .clock(splitter_clock),
    .reset(splitter_reset),
    .io_read_requests_ready(splitter_io_read_requests_ready),
    .io_read_requests_valid(splitter_io_read_requests_valid),
    .io_read_requests_bits_addr(splitter_io_read_requests_bits_addr),
    .io_read_requests_bits_len(splitter_io_read_requests_bits_len),
    .io_split_read_requests_ready(splitter_io_split_read_requests_ready),
    .io_split_read_requests_valid(splitter_io_split_read_requests_valid),
    .io_split_read_requests_bits_addr(splitter_io_split_read_requests_bits_addr)
  );
  Queue_16 readInFlightQ (
    .clock(readInFlightQ_clock),
    .reset(readInFlightQ_reset),
    .io_enq_ready(readInFlightQ_io_enq_ready),
    .io_enq_valid(readInFlightQ_io_enq_valid),
    .io_enq_bits_addr(readInFlightQ_io_enq_bits_addr),
    .io_enq_bits_len(readInFlightQ_io_enq_bits_len),
    .io_deq_ready(readInFlightQ_io_deq_ready),
    .io_deq_valid(readInFlightQ_io_deq_valid),
    .io_deq_bits_addr(readInFlightQ_io_deq_bits_addr),
    .io_deq_bits_len(readInFlightQ_io_deq_bits_len)
  );
  assign io_nastimem_aw_ready = awQ_io_enq_ready;
  assign io_nastimem_w_ready = wQ_io_enq_ready;
  assign io_nastimem_ar_ready = arQ_io_enq_ready;
  assign io_nastimem_r_valid = rQ_io_deq_valid;
  assign io_umireq_valid = umireqQ_io_deq_valid;
  assign io_umireq_bits_isWrite = umireqQ_io_deq_bits_isWrite;
  assign io_umireq_bits_addr = umireqQ_io_deq_bits_addr;
  assign io_umireq_bits_data = umireqQ_io_deq_bits_data;
  assign io_umiresp_ready = umirespQ_io_enq_ready;
  assign awQ_clock = clock;
  assign awQ_reset = reset;
  assign awQ_io_enq_valid = io_nastimem_aw_valid;
  assign awQ_io_enq_bits_addr = io_nastimem_aw_bits_addr;
  assign awQ_io_deq_ready = writeSplitter_io_write_requests_ready;
  assign wQ_clock = clock;
  assign wQ_reset = reset;
  assign wQ_io_enq_valid = io_nastimem_w_valid;
  assign wQ_io_enq_bits_data = io_nastimem_w_bits_data;
  assign wQ_io_deq_ready = _T_470;
  assign bQ_clock = clock;
  assign bQ_reset = reset;
  assign bQ_io_enq_valid = _T_473;
  assign arQ_clock = clock;
  assign arQ_reset = reset;
  assign arQ_io_enq_valid = io_nastimem_ar_valid;
  assign arQ_io_enq_bits_addr = io_nastimem_ar_bits_addr;
  assign arQ_io_deq_ready = splitter_io_read_requests_ready;
  assign rQ_clock = clock;
  assign rQ_reset = reset;
  assign rQ_io_enq_valid = _T_523;
  assign rQ_io_enq_bits_data = _T_525;
  assign rQ_io_deq_ready = io_nastimem_r_ready;
  assign umireqQwrite_clock = clock;
  assign umireqQwrite_reset = reset;
  assign umireqQwrite_io_enq_valid = _T_462;
  assign umireqQwrite_io_enq_bits_isWrite = 1'h1;
  assign umireqQwrite_io_enq_bits_addr = {{29'd0}, _T_480};
  assign umireqQwrite_io_enq_bits_data = {{512'd0}, wQ_io_deq_bits_data};
  assign umireqQwrite_io_deq_ready = umirequestArbiter_io_in_0_ready;
  assign umireqQread_clock = clock;
  assign umireqQread_reset = reset;
  assign umireqQread_io_enq_valid = _T_510;
  assign umireqQread_io_enq_bits_isWrite = 1'h0;
  assign umireqQread_io_enq_bits_addr = {{29'd0}, _T_515};
  assign umireqQread_io_enq_bits_data = 576'h0;
  assign umireqQread_io_deq_ready = umirequestArbiter_io_in_1_ready;
  assign umireqQ_clock = clock;
  assign umireqQ_reset = reset;
  assign umireqQ_io_enq_valid = umirequestArbiter_io_out_valid;
  assign umireqQ_io_enq_bits_isWrite = umirequestArbiter_io_out_bits_isWrite;
  assign umireqQ_io_enq_bits_addr = umirequestArbiter_io_out_bits_addr;
  assign umireqQ_io_enq_bits_data = umirequestArbiter_io_out_bits_data;
  assign umireqQ_io_deq_ready = io_umireq_ready;
  assign umirespQ_clock = clock;
  assign umirespQ_reset = reset;
  assign umirespQ_io_enq_valid = io_umiresp_valid;
  assign umirespQ_io_enq_bits_data = io_umiresp_bits_data;
  assign umirespQ_io_deq_ready = _T_518;
  assign awQsplit_clock = clock;
  assign awQsplit_reset = reset;
  assign awQsplit_io_enq_valid = writeSplitter_io_split_write_requests_valid;
  assign awQsplit_io_enq_bits_addr = writeSplitter_io_split_write_requests_bits_addr;
  assign awQsplit_io_enq_bits_len = writeSplitter_io_split_write_requests_bits_len;
  assign awQsplit_io_deq_ready = _T_468;
  assign writeSplitter_clock = clock;
  assign writeSplitter_reset = reset;
  assign writeSplitter_io_write_requests_valid = awQ_io_deq_valid;
  assign writeSplitter_io_write_requests_bits_addr = awQ_io_deq_bits_addr;
  assign writeSplitter_io_write_requests_bits_len = awQ_io_deq_bits_len;
  assign writeSplitter_io_split_write_requests_ready = awQsplit_io_enq_ready;
  assign umirequestArbiter_clock = clock;
  assign umirequestArbiter_io_in_0_valid = umireqQwrite_io_deq_valid;
  assign umirequestArbiter_io_in_0_bits_isWrite = umireqQwrite_io_deq_bits_isWrite;
  assign umirequestArbiter_io_in_0_bits_addr = umireqQwrite_io_deq_bits_addr;
  assign umirequestArbiter_io_in_0_bits_data = umireqQwrite_io_deq_bits_data;
  assign umirequestArbiter_io_in_1_valid = umireqQread_io_deq_valid;
  assign umirequestArbiter_io_in_1_bits_isWrite = umireqQread_io_deq_bits_isWrite;
  assign umirequestArbiter_io_in_1_bits_addr = umireqQread_io_deq_bits_addr;
  assign umirequestArbiter_io_in_1_bits_data = umireqQread_io_deq_bits_data;
  assign umirequestArbiter_io_out_ready = umireqQ_io_enq_ready;
  assign _T_461 = awQsplit_io_deq_valid & wQ_io_deq_valid;
  assign _T_462 = _T_461 & bQ_io_enq_ready;
  assign _T_463 = _T_462 & umireqQwrite_io_enq_ready;
  assign _T_465 = reset == 1'h0;
  assign do_ack = awQsplit_io_deq_bits_len == 8'h0;
  assign _T_467 = wQ_io_deq_valid & bQ_io_enq_ready;
  assign _T_468 = _T_467 & umireqQwrite_io_enq_ready;
  assign _T_469 = awQsplit_io_deq_valid & bQ_io_enq_ready;
  assign _T_470 = _T_469 & umireqQwrite_io_enq_ready;
  assign _T_472 = _T_461 & umireqQwrite_io_enq_ready;
  assign _T_473 = _T_472 & do_ack;
  assign _T_476 = awQsplit_io_deq_bits_addr - 32'h80000000;
  assign _T_477 = $unsigned(_T_476);
  assign _T_478 = _T_477[31:0];
  assign _GEN_0 = {{3'd0}, _T_478};
  assign _T_480 = _GEN_0 << 2'h3;
  assign arsplitQ_clock = clock;
  assign arsplitQ_reset = reset;
  assign arsplitQ_io_enq_valid = splitter_io_split_read_requests_valid;
  assign arsplitQ_io_enq_bits_addr = splitter_io_split_read_requests_bits_addr;
  assign arsplitQ_io_deq_ready = _T_509;
  assign splitter_clock = clock;
  assign splitter_reset = reset;
  assign splitter_io_read_requests_valid = arQ_io_deq_valid;
  assign splitter_io_read_requests_bits_addr = arQ_io_deq_bits_addr;
  assign splitter_io_read_requests_bits_len = arQ_io_deq_bits_len;
  assign splitter_io_split_read_requests_ready = arsplitQ_io_enq_ready;
  assign readInFlightQ_clock = clock;
  assign readInFlightQ_reset = reset;
  assign readInFlightQ_io_enq_valid = _T_508;
  assign readInFlightQ_io_enq_bits_addr = arsplitQ_io_deq_bits_addr;
  assign readInFlightQ_io_enq_bits_len = arsplitQ_io_deq_bits_len;
  assign readInFlightQ_io_deq_ready = _T_522;
  assign _T_508 = arsplitQ_io_deq_valid & umireqQread_io_enq_ready;
  assign _T_509 = readInFlightQ_io_enq_ready & umireqQread_io_enq_ready;
  assign _T_510 = readInFlightQ_io_enq_ready & arsplitQ_io_deq_valid;
  assign _T_511 = arsplitQ_io_deq_bits_addr - 32'h80000000;
  assign _T_512 = $unsigned(_T_511);
  assign _T_513 = _T_512[31:0];
  assign _GEN_1 = {{3'd0}, _T_513};
  assign _T_515 = _GEN_1 << 2'h3;
  assign _T_518 = readInFlightQ_io_deq_valid & rQ_io_enq_ready;
  assign _T_519 = _T_518 & umirespQ_io_deq_valid;
  assign _T_522 = rQ_io_enq_ready & umirespQ_io_deq_valid;
  assign _T_523 = readInFlightQ_io_deq_valid & umirespQ_io_deq_valid;
  assign _T_525 = umirespQ_io_deq_bits_data[63:0];
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_463 & _T_465) begin
          $fwrite(32'h80000002,"got write value: %h from address 0x%h\n",wQ_io_deq_bits_data,awQsplit_io_deq_bits_addr);
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_519 & _T_465) begin
          $fwrite(32'h80000002,"got read value: %h from address 0x%h\n",rQ_io_enq_bits_data,readInFlightQ_io_deq_bits_addr);
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module CatapultShim(
  input          clock,
  input          reset,
  input          io_pcie_out_ready,
  output         io_pcie_out_valid,
  output [639:0] io_pcie_out_bits,
  output         io_pcie_in_ready,
  input          io_pcie_in_valid,
  input  [639:0] io_pcie_in_bits,
  output         io_softreg_req_ready,
  input          io_softreg_req_valid,
  input  [31:0]  io_softreg_req_bits_addr,
  input  [63:0]  io_softreg_req_bits_wdata,
  input          io_softreg_req_bits_wr,
  input          io_softreg_resp_ready,
  output         io_softreg_resp_valid,
  output [63:0]  io_softreg_resp_bits_rdata,
  input          io_umireq_ready,
  output         io_umireq_valid,
  output         io_umireq_bits_isWrite,
  output [63:0]  io_umireq_bits_addr,
  output [575:0] io_umireq_bits_data,
  output         io_umiresp_ready,
  input          io_umiresp_valid,
  input  [575:0] io_umiresp_bits_data
);
  wire  top_clock;
  wire  top_reset;
  wire  top_io_ctrl_aw_ready;
  wire  top_io_ctrl_aw_valid;
  wire [31:0] top_io_ctrl_aw_bits_addr;
  wire  top_io_ctrl_w_ready;
  wire  top_io_ctrl_w_valid;
  wire [63:0] top_io_ctrl_w_bits_data;
  wire  top_io_ctrl_b_ready;
  wire  top_io_ctrl_b_valid;
  wire  top_io_ctrl_ar_ready;
  wire  top_io_ctrl_ar_valid;
  wire [31:0] top_io_ctrl_ar_bits_addr;
  wire  top_io_ctrl_r_ready;
  wire  top_io_ctrl_r_valid;
  wire [63:0] top_io_ctrl_r_bits_data;
  wire  top_io_mem_aw_ready;
  wire  top_io_mem_aw_valid;
  wire [31:0] top_io_mem_aw_bits_addr;
  wire  top_io_mem_w_ready;
  wire  top_io_mem_w_valid;
  wire [63:0] top_io_mem_w_bits_data;
  wire  top_io_mem_ar_ready;
  wire  top_io_mem_ar_valid;
  wire [31:0] top_io_mem_ar_bits_addr;
  wire  top_io_mem_r_ready;
  wire  top_io_mem_r_valid;
  wire  nastiumi_clock;
  wire  nastiumi_reset;
  wire  nastiumi_io_nastimem_aw_ready;
  wire  nastiumi_io_nastimem_aw_valid;
  wire [31:0] nastiumi_io_nastimem_aw_bits_addr;
  wire  nastiumi_io_nastimem_w_ready;
  wire  nastiumi_io_nastimem_w_valid;
  wire [63:0] nastiumi_io_nastimem_w_bits_data;
  wire  nastiumi_io_nastimem_ar_ready;
  wire  nastiumi_io_nastimem_ar_valid;
  wire [31:0] nastiumi_io_nastimem_ar_bits_addr;
  wire  nastiumi_io_nastimem_r_ready;
  wire  nastiumi_io_nastimem_r_valid;
  wire  nastiumi_io_umireq_ready;
  wire  nastiumi_io_umireq_valid;
  wire  nastiumi_io_umireq_bits_isWrite;
  wire [63:0] nastiumi_io_umireq_bits_addr;
  wire [575:0] nastiumi_io_umireq_bits_data;
  wire  nastiumi_io_umiresp_ready;
  wire  nastiumi_io_umiresp_valid;
  wire [575:0] nastiumi_io_umiresp_bits_data;
  reg [1:0] state;
  reg [31:0] _RAND_0;
  wire [34:0] _GEN_9;
  wire [34:0] _T_107;
  wire [31:0] _T_122_addr;
  wire  _T_144;
  wire  _T_145;
  wire  _T_146;
  wire [31:0] _T_163_addr;
  wire  _T_186;
  wire  _T_187;
  wire  _T_189;
  wire [63:0] _T_198_data;
  wire  _T_210;
  wire  _T_211;
  wire  _T_212;
  wire  _T_213;
  wire  _T_214;
  wire  _T_215;
  wire  _T_216;
  wire  _T_217;
  wire [1:0] _GEN_0;
  wire  _T_219;
  wire  _T_221;
  wire  _T_222;
  wire [1:0] _GEN_1;
  wire [1:0] _GEN_2;
  wire  _T_223;
  wire  _T_224;
  wire [1:0] _GEN_3;
  wire [1:0] _GEN_4;
  wire  _T_225;
  wire [1:0] _GEN_5;
  wire [1:0] _GEN_6;
  wire  _T_227;
  wire  _T_228;
  wire [1:0] _GEN_7;
  wire [1:0] _GEN_8;
  FPGATop top (
    .clock(top_clock),
    .reset(top_reset),
    .io_ctrl_aw_ready(top_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(top_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(top_io_ctrl_aw_bits_addr),
    .io_ctrl_w_ready(top_io_ctrl_w_ready),
    .io_ctrl_w_valid(top_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(top_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(top_io_ctrl_b_ready),
    .io_ctrl_b_valid(top_io_ctrl_b_valid),
    .io_ctrl_ar_ready(top_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(top_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(top_io_ctrl_ar_bits_addr),
    .io_ctrl_r_ready(top_io_ctrl_r_ready),
    .io_ctrl_r_valid(top_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(top_io_ctrl_r_bits_data),
    .io_mem_aw_ready(top_io_mem_aw_ready),
    .io_mem_aw_valid(top_io_mem_aw_valid),
    .io_mem_aw_bits_addr(top_io_mem_aw_bits_addr),
    .io_mem_w_ready(top_io_mem_w_ready),
    .io_mem_w_valid(top_io_mem_w_valid),
    .io_mem_w_bits_data(top_io_mem_w_bits_data),
    .io_mem_ar_ready(top_io_mem_ar_ready),
    .io_mem_ar_valid(top_io_mem_ar_valid),
    .io_mem_ar_bits_addr(top_io_mem_ar_bits_addr),
    .io_mem_r_ready(top_io_mem_r_ready),
    .io_mem_r_valid(top_io_mem_r_valid)
  );
  NastiUMIAdapter nastiumi (
    .clock(nastiumi_clock),
    .reset(nastiumi_reset),
    .io_nastimem_aw_ready(nastiumi_io_nastimem_aw_ready),
    .io_nastimem_aw_valid(nastiumi_io_nastimem_aw_valid),
    .io_nastimem_aw_bits_addr(nastiumi_io_nastimem_aw_bits_addr),
    .io_nastimem_w_ready(nastiumi_io_nastimem_w_ready),
    .io_nastimem_w_valid(nastiumi_io_nastimem_w_valid),
    .io_nastimem_w_bits_data(nastiumi_io_nastimem_w_bits_data),
    .io_nastimem_ar_ready(nastiumi_io_nastimem_ar_ready),
    .io_nastimem_ar_valid(nastiumi_io_nastimem_ar_valid),
    .io_nastimem_ar_bits_addr(nastiumi_io_nastimem_ar_bits_addr),
    .io_nastimem_r_ready(nastiumi_io_nastimem_r_ready),
    .io_nastimem_r_valid(nastiumi_io_nastimem_r_valid),
    .io_umireq_ready(nastiumi_io_umireq_ready),
    .io_umireq_valid(nastiumi_io_umireq_valid),
    .io_umireq_bits_isWrite(nastiumi_io_umireq_bits_isWrite),
    .io_umireq_bits_addr(nastiumi_io_umireq_bits_addr),
    .io_umireq_bits_data(nastiumi_io_umireq_bits_data),
    .io_umiresp_ready(nastiumi_io_umiresp_ready),
    .io_umiresp_valid(nastiumi_io_umiresp_valid),
    .io_umiresp_bits_data(nastiumi_io_umiresp_bits_data)
  );
  assign io_pcie_out_valid = 1'h0;
  assign io_pcie_out_bits = 640'h0;
  assign io_pcie_in_ready = 1'h0;
  assign io_softreg_req_ready = _T_213;
  assign io_softreg_resp_valid = top_io_ctrl_r_valid;
  assign io_softreg_resp_bits_rdata = top_io_ctrl_r_bits_data;
  assign io_umireq_valid = nastiumi_io_umireq_valid;
  assign io_umireq_bits_isWrite = nastiumi_io_umireq_bits_isWrite;
  assign io_umireq_bits_addr = nastiumi_io_umireq_bits_addr;
  assign io_umireq_bits_data = nastiumi_io_umireq_bits_data;
  assign io_umiresp_ready = nastiumi_io_umiresp_ready;
  assign top_clock = clock;
  assign top_reset = reset;
  assign top_io_ctrl_aw_valid = _T_146;
  assign top_io_ctrl_aw_bits_addr = _T_122_addr;
  assign top_io_ctrl_w_valid = _T_210;
  assign top_io_ctrl_w_bits_data = _T_198_data;
  assign top_io_ctrl_b_ready = _T_216;
  assign top_io_ctrl_ar_valid = _T_189;
  assign top_io_ctrl_ar_bits_addr = _T_163_addr;
  assign top_io_ctrl_r_ready = _T_215;
  assign top_io_mem_aw_ready = nastiumi_io_nastimem_aw_ready;
  assign top_io_mem_w_ready = nastiumi_io_nastimem_w_ready;
  assign top_io_mem_ar_ready = nastiumi_io_nastimem_ar_ready;
  assign top_io_mem_r_valid = nastiumi_io_nastimem_r_valid;
  assign nastiumi_clock = clock;
  assign nastiumi_reset = reset;
  assign nastiumi_io_nastimem_aw_valid = top_io_mem_aw_valid;
  assign nastiumi_io_nastimem_aw_bits_addr = top_io_mem_aw_bits_addr;
  assign nastiumi_io_nastimem_w_valid = top_io_mem_w_valid;
  assign nastiumi_io_nastimem_w_bits_data = top_io_mem_w_bits_data;
  assign nastiumi_io_nastimem_ar_valid = top_io_mem_ar_valid;
  assign nastiumi_io_nastimem_ar_bits_addr = top_io_mem_ar_bits_addr;
  assign nastiumi_io_nastimem_r_ready = top_io_mem_r_ready;
  assign nastiumi_io_umireq_ready = io_umireq_ready;
  assign nastiumi_io_umiresp_valid = io_umiresp_valid;
  assign nastiumi_io_umiresp_bits_data = io_umiresp_bits_data;
  assign _GEN_9 = {{3'd0}, io_softreg_req_bits_addr};
  assign _T_107 = _GEN_9 << 2'h3;
  assign _T_122_addr = _T_107[31:0];
  assign _T_144 = io_softreg_req_valid & io_softreg_req_bits_wr;
  assign _T_145 = state == 2'h0;
  assign _T_146 = _T_144 & _T_145;
  assign _T_163_addr = _T_107[31:0];
  assign _T_186 = io_softreg_req_bits_wr == 1'h0;
  assign _T_187 = io_softreg_req_valid & _T_186;
  assign _T_189 = _T_187 & _T_145;
  assign _T_198_data = io_softreg_req_bits_wdata;
  assign _T_210 = state == 2'h2;
  assign _T_211 = top_io_ctrl_ar_ready & top_io_ctrl_ar_valid;
  assign _T_212 = top_io_ctrl_w_ready & top_io_ctrl_w_valid;
  assign _T_213 = _T_211 | _T_212;
  assign _T_214 = state == 2'h1;
  assign _T_215 = _T_214 & io_softreg_resp_ready;
  assign _T_216 = state == 2'h3;
  assign _T_217 = 2'h0 == state;
  assign _GEN_0 = _T_211 ? 2'h1 : state;
  assign _T_219 = top_io_ctrl_aw_ready & top_io_ctrl_aw_valid;
  assign _T_221 = _T_211 == 1'h0;
  assign _T_222 = _T_221 & _T_219;
  assign _GEN_1 = _T_222 ? 2'h2 : _GEN_0;
  assign _GEN_2 = _T_217 ? _GEN_1 : state;
  assign _T_223 = 2'h1 == state;
  assign _T_224 = top_io_ctrl_r_ready & top_io_ctrl_r_valid;
  assign _GEN_3 = _T_224 ? 2'h0 : _GEN_2;
  assign _GEN_4 = _T_223 ? _GEN_3 : _GEN_2;
  assign _T_225 = 2'h2 == state;
  assign _GEN_5 = _T_212 ? 2'h3 : _GEN_4;
  assign _GEN_6 = _T_225 ? _GEN_5 : _GEN_4;
  assign _T_227 = 2'h3 == state;
  assign _T_228 = top_io_ctrl_b_ready & top_io_ctrl_b_valid;
  assign _GEN_7 = _T_228 ? 2'h0 : _GEN_6;
  assign _GEN_8 = _T_227 ? _GEN_7 : _GEN_6;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else begin
      if (_T_227) begin
        if (_T_228) begin
          state <= 2'h0;
        end else begin
          if (_T_225) begin
            if (_T_212) begin
              state <= 2'h3;
            end else begin
              if (_T_223) begin
                if (_T_224) begin
                  state <= 2'h0;
                end else begin
                  if (_T_217) begin
                    if (_T_222) begin
                      state <= 2'h2;
                    end else begin
                      if (_T_211) begin
                        state <= 2'h1;
                      end
                    end
                  end
                end
              end else begin
                if (_T_217) begin
                  if (_T_222) begin
                    state <= 2'h2;
                  end else begin
                    if (_T_211) begin
                      state <= 2'h1;
                    end
                  end
                end
              end
            end
          end else begin
            if (_T_223) begin
              if (_T_224) begin
                state <= 2'h0;
              end else begin
                if (_T_217) begin
                  if (_T_222) begin
                    state <= 2'h2;
                  end else begin
                    if (_T_211) begin
                      state <= 2'h1;
                    end
                  end
                end
              end
            end else begin
              if (_T_217) begin
                if (_T_222) begin
                  state <= 2'h2;
                end else begin
                  if (_T_211) begin
                    state <= 2'h1;
                  end
                end
              end
            end
          end
        end
      end else begin
        if (_T_225) begin
          if (_T_212) begin
            state <= 2'h3;
          end else begin
            if (_T_223) begin
              if (_T_224) begin
                state <= 2'h0;
              end else begin
                state <= _GEN_2;
              end
            end else begin
              state <= _GEN_2;
            end
          end
        end else begin
          if (_T_223) begin
            if (_T_224) begin
              state <= 2'h0;
            end else begin
              state <= _GEN_2;
            end
          end else begin
            state <= _GEN_2;
          end
        end
      end
    end
  end
endmodule
