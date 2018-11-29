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
  input  [31:0] io_dataIo_in_bits,
  input         io_dataIo_out_ready,
  output        io_dataIo_out_valid,
  output [31:0] io_dataIo_out_bits,
  input  [31:0] io_dataIo_data_0,
  input         io_ctrlIo_copyCond,
  input         io_ctrlIo_readCond,
  input         io_ctrlIo_cntrNotZero,
  output        io_ctrlIo_outFire,
  output        io_ctrlIo_inValid
);
  reg [31:0] regs_0;
  reg [31:0] _RAND_0;
  wire  _T_60;
  wire  readCondAndOutFire;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_1;
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
  _RAND_0 = {1{$random}};
  regs_0 = _RAND_0[31:0];
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
  wire  _T_19;
  wire  _GEN_0;
  wire  _T_22;
  wire  _T_23;
  wire  _GEN_1;
  wire  _T_25;
  wire  _T_27;
  wire  _T_28;
  wire  _T_32;
  wire  _T_33;
  wire  _T_34;
  wire [1:0] _T_36;
  wire [1:0] _T_37;
  wire  _T_38;
  wire  _GEN_2;
  wire  _T_42;
  wire  _T_43;
  reg  _T_45;
  reg [31:0] _RAND_2;
  wire  _T_46;
  wire  _T_47;
  wire  _T_50;
  assign io_ctrlIo_copyCond = _T_46;
  assign io_ctrlIo_readCond = _T_50;
  assign io_ctrlIo_cntrNotZero = counter;
  assign _T_19 = io_stall == 1'h0;
  assign _GEN_0 = _T_19 ? 1'h0 : counter;
  assign _T_22 = _T_19 == 1'h0;
  assign _T_23 = _T_22 & io_ctrlIo_copyCond;
  assign _GEN_1 = _T_23 ? 1'h1 : _GEN_0;
  assign _T_25 = io_ctrlIo_readCond & io_ctrlIo_outFire;
  assign _T_27 = io_ctrlIo_inValid == 1'h0;
  assign _T_28 = _T_25 & _T_27;
  assign _T_32 = io_ctrlIo_copyCond == 1'h0;
  assign _T_33 = _T_22 & _T_32;
  assign _T_34 = _T_33 & _T_28;
  assign _T_36 = counter - 1'h1;
  assign _T_37 = $unsigned(_T_36);
  assign _T_38 = _T_37[0:0];
  assign _GEN_2 = _T_34 ? _T_38 : _GEN_1;
  assign _T_42 = copied == 1'h0;
  assign _T_43 = io_stall & _T_42;
  assign _T_46 = _T_43 | _T_45;
  assign _T_47 = io_stall & copied;
  assign _T_50 = _T_47 & counter;
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
  _T_45 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    copied <= io_stall;
    if (reset) begin
      counter <= 1'h0;
    end else begin
      if (_T_34) begin
        counter <= _T_38;
      end else begin
        if (_T_23) begin
          counter <= 1'h1;
        end else begin
          if (_T_19) begin
            counter <= 1'h0;
          end
        end
      end
    end
    _T_45 <= reset;
  end
endmodule
module RegChain(
  input         clock,
  input         reset,
  input         io_stall,
  output        io_dataIo_in_ready,
  input         io_dataIo_in_valid,
  input  [31:0] io_dataIo_in_bits,
  input         io_dataIo_out_ready,
  output        io_dataIo_out_valid,
  output [31:0] io_dataIo_out_bits,
  input  [31:0] io_dataIo_data_0
);
  wire  datapath_clock;
  wire  datapath_io_dataIo_in_ready;
  wire  datapath_io_dataIo_in_valid;
  wire [31:0] datapath_io_dataIo_in_bits;
  wire  datapath_io_dataIo_out_ready;
  wire  datapath_io_dataIo_out_valid;
  wire [31:0] datapath_io_dataIo_out_bits;
  wire [31:0] datapath_io_dataIo_data_0;
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
  input  [31:0] daisy_regs_0_in_bits,
  input         daisy_regs_0_out_ready,
  output        daisy_regs_0_out_valid,
  output [31:0] daisy_regs_0_out_bits
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
  wire [31:0] regs_0_io_dataIo_in_bits;
  wire  regs_0_io_dataIo_out_ready;
  wire  regs_0_io_dataIo_out_valid;
  wire [31:0] regs_0_io_dataIo_out_bits;
  wire [31:0] regs_0_io_dataIo_data_0;
  wire [28:0] _GEN_4;
  wire [1:0] _GEN_5;
  wire [29:0] _GEN_6;
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
  assign _GEN_4 = {r3,28'h0};
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
  wire  ram__T_55_data;
  wire [3:0] ram__T_55_addr;
  wire  ram__T_41_data;
  wire [3:0] ram__T_41_addr;
  wire  ram__T_41_mask;
  wire  ram__T_41_en;
  reg [3:0] value;
  reg [31:0] _RAND_1;
  reg [3:0] value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_32;
  wire  _T_34;
  wire  _T_35;
  wire  _T_36;
  wire  _T_37;
  wire  do_enq;
  wire  _T_39;
  wire  do_deq;
  wire [4:0] _T_44;
  wire [3:0] _T_45;
  wire [3:0] _GEN_4;
  wire [4:0] _T_48;
  wire [3:0] _T_49;
  wire [3:0] _GEN_5;
  wire  _T_50;
  wire  _GEN_6;
  wire  _T_52;
  wire  _T_54;
  assign io_enq_ready = _T_54;
  assign io_deq_valid = _T_52;
  assign io_deq_bits = ram__T_55_data;
  assign ram__T_55_addr = value_1;
  assign ram__T_55_data = ram[ram__T_55_addr];
  assign ram__T_41_data = io_enq_bits;
  assign ram__T_41_addr = value;
  assign ram__T_41_mask = do_enq;
  assign ram__T_41_en = do_enq;
  assign _T_32 = value == value_1;
  assign _T_34 = maybe_full == 1'h0;
  assign _T_35 = _T_32 & _T_34;
  assign _T_36 = _T_32 & maybe_full;
  assign _T_37 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_37;
  assign _T_39 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_39;
  assign _T_44 = value + 4'h1;
  assign _T_45 = _T_44[3:0];
  assign _GEN_4 = do_enq ? _T_45 : value;
  assign _T_48 = value_1 + 4'h1;
  assign _T_49 = _T_48[3:0];
  assign _GEN_5 = do_deq ? _T_49 : value_1;
  assign _T_50 = do_enq != do_deq;
  assign _GEN_6 = _T_50 ? do_enq : maybe_full;
  assign _T_52 = _T_35 == 1'h0;
  assign _T_54 = _T_36 == 1'h0;
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
    if(ram__T_41_en & ram__T_41_mask) begin
      ram[ram__T_41_addr] <= ram__T_41_data;
    end
    if (reset) begin
      value <= 4'h0;
    end else begin
      if (do_enq) begin
        value <= _T_45;
      end
    end
    if (reset) begin
      value_1 <= 4'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_49;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_50) begin
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
  wire [10:0] _T_41;
  wire [10:0] _T_42;
  wire [9:0] _T_43;
  wire  enq_wrap;
  wire  deq_wrap;
  wire [10:0] _T_50;
  wire [9:0] _T_51;
  wire [9:0] _T_52;
  wire [9:0] _GEN_0;
  wire [10:0] _T_55;
  wire [9:0] _T_56;
  wire [9:0] _T_57;
  wire [9:0] _GEN_1;
  wire  _T_58;
  wire  _GEN_2;
  wire  ptr_match;
  wire  _T_60;
  wire  empty;
  wire  full;
  wire [10:0] _T_61;
  wire [10:0] _T_62;
  wire [9:0] _T_63;
  wire  _T_65;
  wire  atLeastTwo;
  wire  _T_66;
  reg  ram [0:1023];
  reg [31:0] _RAND_3;
  wire  ram__T_89_data;
  wire [9:0] ram__T_89_addr;
  wire  ram__T_68_data;
  wire [9:0] ram__T_68_addr;
  wire  ram__T_68_mask;
  wire  ram__T_68_en;
  wire  _GEN_11;
  reg [9:0] ram__T_89_addr_pipe_0;
  reg [31:0] _RAND_4;
  wire  _T_70;
  wire  _T_72;
  wire  _T_73;
  wire  _T_74;
  wire  ren;
  reg  ram_out_valid;
  reg [31:0] _RAND_5;
  wire [9:0] raddr;
  wire  _T_82;
  wire  _T_83;
  wire [9:0] _T_85;
  wire  _T_90;
  assign io_enq_ready = _T_82;
  assign io_deq_valid = _T_83;
  assign io_deq_bits = _T_90;
  assign do_flow = _T_66;
  assign _T_28 = io_enq_ready & io_enq_valid;
  assign _T_30 = do_flow == 1'h0;
  assign do_enq = _T_28 & _T_30;
  assign _T_31 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_31 & _T_30;
  assign _T_41 = io_limit - 10'h2;
  assign _T_42 = $unsigned(_T_41);
  assign _T_43 = _T_42[9:0];
  assign enq_wrap = enq_ptr == _T_43;
  assign deq_wrap = deq_ptr == _T_43;
  assign _T_50 = enq_ptr + 10'h1;
  assign _T_51 = _T_50[9:0];
  assign _T_52 = enq_wrap ? 10'h0 : _T_51;
  assign _GEN_0 = do_enq ? _T_52 : enq_ptr;
  assign _T_55 = deq_ptr + 10'h1;
  assign _T_56 = _T_55[9:0];
  assign _T_57 = deq_wrap ? 10'h0 : _T_56;
  assign _GEN_1 = do_deq ? _T_57 : deq_ptr;
  assign _T_58 = do_enq != do_deq;
  assign _GEN_2 = _T_58 ? do_enq : maybe_full;
  assign ptr_match = enq_ptr == deq_ptr;
  assign _T_60 = maybe_full == 1'h0;
  assign empty = ptr_match & _T_60;
  assign full = ptr_match & maybe_full;
  assign _T_61 = enq_ptr - deq_ptr;
  assign _T_62 = $unsigned(_T_61);
  assign _T_63 = _T_62[9:0];
  assign _T_65 = _T_63 >= 10'h2;
  assign atLeastTwo = full | _T_65;
  assign _T_66 = empty & io_deq_ready;
  assign ram__T_89_addr = ram__T_89_addr_pipe_0;
  assign ram__T_89_data = ram[ram__T_89_addr];
  assign ram__T_68_data = io_enq_bits;
  assign ram__T_68_addr = enq_ptr;
  assign ram__T_68_mask = do_enq;
  assign ram__T_68_en = do_enq;
  assign _GEN_11 = ren;
  assign _T_70 = io_deq_valid == 1'h0;
  assign _T_72 = empty == 1'h0;
  assign _T_73 = _T_70 & _T_72;
  assign _T_74 = atLeastTwo | _T_73;
  assign ren = io_deq_ready & _T_74;
  assign raddr = io_deq_valid ? _T_57 : deq_ptr;
  assign _T_82 = full == 1'h0;
  assign _T_83 = empty ? io_enq_valid : ram_out_valid;
  assign _T_85 = raddr;
  assign _T_90 = empty ? io_enq_bits : ram__T_89_data;
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
  ram__T_89_addr_pipe_0 = _RAND_4[9:0];
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
      if (_T_58) begin
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
          enq_ptr <= _T_51;
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
          deq_ptr <= _T_56;
        end
      end
    end
    if(ram__T_68_en & ram__T_68_mask) begin
      ram[ram__T_68_addr] <= ram__T_68_data;
    end
    if (_GEN_11) begin
      ram__T_89_addr_pipe_0 <= _T_85;
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
  wire  ram__T_47_data;
  wire  ram__T_47_addr;
  wire  ram__T_38_data;
  wire  ram__T_38_addr;
  wire  ram__T_38_mask;
  wire  ram__T_38_en;
  reg  maybe_full;
  reg [31:0] _RAND_1;
  wire  _T_30;
  wire  _T_33;
  wire  do_enq;
  wire  _T_35;
  wire  do_deq;
  wire  _T_41;
  wire  _GEN_4;
  wire  _T_43;
  wire  _GEN_5;
  assign io_enq_ready = _GEN_5;
  assign io_deq_valid = _T_43;
  assign io_deq_bits = ram__T_47_data;
  assign ram__T_47_addr = 1'h0;
  assign ram__T_47_data = ram[ram__T_47_addr];
  assign ram__T_38_data = io_enq_bits;
  assign ram__T_38_addr = 1'h0;
  assign ram__T_38_mask = do_enq;
  assign ram__T_38_en = do_enq;
  assign _T_30 = maybe_full == 1'h0;
  assign _T_33 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_33;
  assign _T_35 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_35;
  assign _T_41 = do_enq != do_deq;
  assign _GEN_4 = _T_41 ? do_enq : maybe_full;
  assign _T_43 = _T_30 == 1'h0;
  assign _GEN_5 = io_deq_ready ? 1'h1 : _T_30;
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
    if(ram__T_38_en & ram__T_38_mask) begin
      ram[ram__T_38_addr] <= ram__T_38_data;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_41) begin
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
  input  [31:0] io_wireIns_0_bits,
  output        io_wireIns_1_ready,
  input         io_wireIns_1_valid,
  input  [31:0] io_wireIns_1_bits,
  input         io_wireOuts_0_ready,
  output        io_wireOuts_0_valid,
  output [31:0] io_wireOuts_0_bits,
  output        io_daisy_regs_0_in_ready,
  input         io_daisy_regs_0_in_valid,
  input  [31:0] io_daisy_regs_0_in_bits,
  input         io_daisy_regs_0_out_ready,
  output        io_daisy_regs_0_out_valid,
  output [31:0] io_daisy_regs_0_out_bits,
  input  [10:0] io_traceLen,
  input         io_wireInTraces_0_ready,
  output        io_wireInTraces_0_valid,
  output [31:0] io_wireInTraces_0_bits,
  input         io_wireInTraces_1_ready,
  output        io_wireInTraces_1_valid,
  output [31:0] io_wireInTraces_1_bits,
  input         io_wireOutTraces_0_ready,
  output        io_wireOutTraces_0_valid,
  output [31:0] io_wireOutTraces_0_bits
);
  wire  target_clock;
  wire  target_reset;
  wire  target_io_in;
  wire  target_io_out;
  wire  target_targetFire;
  wire  target_daisyReset;
  wire  target_daisy_regs_0_in_ready;
  wire  target_daisy_regs_0_in_valid;
  wire [31:0] target_daisy_regs_0_in_bits;
  wire  target_daisy_regs_0_out_ready;
  wire  target_daisy_regs_0_out_valid;
  wire [31:0] target_daisy_regs_0_out_bits;
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
  wire  _T_535;
  reg [63:0] cycles;
  reg [63:0] _RAND_1;
  wire [64:0] _T_539;
  wire [63:0] _T_540;
  wire [63:0] _T_541;
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
  assign io_wireOuts_0_bits = {{31'd0}, WireChannel_io_out_0_io_out_bits};
  assign io_daisy_regs_0_in_ready = target_daisy_regs_0_in_ready;
  assign io_daisy_regs_0_out_valid = target_daisy_regs_0_out_valid;
  assign io_daisy_regs_0_out_bits = target_daisy_regs_0_out_bits;
  assign io_wireInTraces_0_valid = WireChannel_reset_0_io_trace_valid;
  assign io_wireInTraces_0_bits = {{31'd0}, WireChannel_reset_0_io_trace_bits};
  assign io_wireInTraces_1_valid = WireChannel_io_in_0_io_trace_valid;
  assign io_wireInTraces_1_bits = {{31'd0}, WireChannel_io_in_0_io_trace_bits};
  assign io_wireOutTraces_0_valid = WireChannel_io_out_0_io_trace_valid;
  assign io_wireOutTraces_0_bits = {{31'd0}, WireChannel_io_out_0_io_trace_bits};
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
  assign WireChannel_io_out_0_io_in_valid = _T_535;
  assign WireChannel_io_out_0_io_in_bits = _T_523;
  assign WireChannel_io_out_0_io_out_ready = io_wireOuts_0_ready;
  assign WireChannel_io_out_0_io_trace_ready = io_wireOutTraces_0_ready;
  assign WireChannel_io_out_0_io_traceLen = io_traceLen;
  assign _T_523 = target_io_out;
  assign _T_525 = WireChannel_reset_0_io_out_valid;
  assign _T_526 = _T_525 & WireChannel_io_in_0_io_out_valid;
  assign _T_528 = WireChannel_io_out_0_io_in_ready;
  assign _T_529 = _T_526 & _T_528;
  assign _T_535 = fire | resetNext;
  assign _T_539 = cycles + 64'h1;
  assign _T_540 = _T_539[63:0];
  assign _T_541 = target_reset ? 64'h0 : _T_540;
  assign _GEN_0 = fire ? _T_541 : cycles;
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
        cycles <= _T_540;
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
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
  reg [31:0] ram [0:1];
  reg [31:0] _RAND_0;
  wire [31:0] ram__T_55_data;
  wire  ram__T_55_addr;
  wire [31:0] ram__T_41_data;
  wire  ram__T_41_addr;
  wire  ram__T_41_mask;
  wire  ram__T_41_en;
  reg  value;
  reg [31:0] _RAND_1;
  reg  value_1;
  reg [31:0] _RAND_2;
  reg  maybe_full;
  reg [31:0] _RAND_3;
  wire  _T_32;
  wire  _T_34;
  wire  _T_35;
  wire  _T_36;
  wire  _T_37;
  wire  do_enq;
  wire  _T_39;
  wire  do_deq;
  wire [1:0] _T_44;
  wire  _T_45;
  wire  _GEN_4;
  wire [1:0] _T_48;
  wire  _T_49;
  wire  _GEN_5;
  wire  _T_50;
  wire  _GEN_6;
  wire  _T_52;
  wire  _T_54;
  assign io_enq_ready = _T_54;
  assign io_deq_valid = _T_52;
  assign io_deq_bits = ram__T_55_data;
  assign ram__T_55_addr = value_1;
  assign ram__T_55_data = ram[ram__T_55_addr];
  assign ram__T_41_data = io_enq_bits;
  assign ram__T_41_addr = value;
  assign ram__T_41_mask = do_enq;
  assign ram__T_41_en = do_enq;
  assign _T_32 = value == value_1;
  assign _T_34 = maybe_full == 1'h0;
  assign _T_35 = _T_32 & _T_34;
  assign _T_36 = _T_32 & maybe_full;
  assign _T_37 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_37;
  assign _T_39 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_39;
  assign _T_44 = value + 1'h1;
  assign _T_45 = _T_44[0:0];
  assign _GEN_4 = do_enq ? _T_45 : value;
  assign _T_48 = value_1 + 1'h1;
  assign _T_49 = _T_48[0:0];
  assign _GEN_5 = do_deq ? _T_49 : value_1;
  assign _T_50 = do_enq != do_deq;
  assign _GEN_6 = _T_50 ? do_enq : maybe_full;
  assign _T_52 = _T_35 == 1'h0;
  assign _T_54 = _T_36 == 1'h0;
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
    if(ram__T_41_en & ram__T_41_mask) begin
      ram[ram__T_41_addr] <= ram__T_41_data;
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_45;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_49;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_50) begin
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
  input  [7:0]  io_nasti_aw_bits_len,
  input  [11:0] io_nasti_aw_bits_id,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [31:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output [1:0]  io_nasti_b_bits_resp,
  output [11:0] io_nasti_b_bits_id,
  output        io_nasti_b_bits_user,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input  [7:0]  io_nasti_ar_bits_len,
  input  [11:0] io_nasti_ar_bits_id,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [1:0]  io_nasti_r_bits_resp,
  output [31:0] io_nasti_r_bits_data,
  output        io_nasti_r_bits_last,
  output [11:0] io_nasti_r_bits_id,
  output        io_nasti_r_bits_user,
  input  [31:0] io_mcr_read_0_bits,
  output        io_mcr_read_1_ready,
  input         io_mcr_read_1_valid,
  input  [31:0] io_mcr_read_1_bits,
  input  [31:0] io_mcr_read_2_bits,
  output        io_mcr_write_0_valid,
  output [31:0] io_mcr_write_0_bits,
  input         io_mcr_write_1_ready,
  output        io_mcr_write_1_valid,
  output [31:0] io_mcr_write_1_bits,
  output        io_mcr_write_2_valid,
  output [31:0] io_mcr_write_2_bits
);
  reg  arFired;
  reg [31:0] _RAND_0;
  reg  awFired;
  reg [31:0] _RAND_1;
  reg  wFired;
  reg [31:0] _RAND_2;
  reg  wCommited;
  reg [31:0] _RAND_3;
  reg [11:0] bId;
  reg [31:0] _RAND_4;
  reg [11:0] rId;
  reg [31:0] _RAND_5;
  reg [31:0] wData;
  reg [31:0] _RAND_6;
  reg [1:0] wAddr;
  reg [31:0] _RAND_7;
  reg [1:0] rAddr;
  reg [31:0] _RAND_8;
  wire  _T_449;
  wire [29:0] _T_451;
  wire  _T_453;
  wire  _T_454;
  wire  _T_456;
  wire  _GEN_6;
  wire [29:0] _GEN_7;
  wire [11:0] _GEN_8;
  wire  _T_457;
  wire  _GEN_9;
  wire [31:0] _GEN_10;
  wire  _T_459;
  wire [29:0] _T_461;
  wire [1:0] _T_462;
  wire  _T_464;
  wire  _T_465;
  wire  _T_467;
  wire  _GEN_12;
  wire [1:0] _GEN_13;
  wire [11:0] _GEN_14;
  wire  _T_468;
  wire  _GEN_15;
  wire  _T_470;
  wire  _GEN_16;
  wire  _GEN_17;
  wire  _GEN_18;
  wire  _GEN_0_ready;
  wire  _GEN_19;
  wire  _GEN_20;
  wire  _GEN_22;
  wire  _GEN_23;
  wire  _GEN_1_valid;
  wire  _T_480;
  wire  _GEN_31;
  wire  _T_494;
  wire  _T_495;
  wire  _T_496;
  wire  _GEN_2;
  wire  _GEN_32;
  wire  _GEN_33;
  wire  _GEN_34;
  wire  _T_503;
  wire  _GEN_3;
  wire  _GEN_36;
  wire [31:0] _T_518_data;
  wire [11:0] _T_518_id;
  wire [31:0] _GEN_4_bits;
  wire  _GEN_39;
  wire [31:0] _GEN_40;
  wire  _GEN_42;
  wire [31:0] _GEN_43;
  wire  _GEN_5_valid;
  wire  _T_531;
  wire [11:0] _T_537_id;
  wire  _T_543;
  wire  _T_544;
  wire  _T_545;
  wire  _T_546;
  assign io_nasti_aw_ready = _T_545;
  assign io_nasti_w_ready = _T_546;
  assign io_nasti_b_valid = _T_543;
  assign io_nasti_b_bits_resp = 2'h0;
  assign io_nasti_b_bits_id = _T_537_id;
  assign io_nasti_b_bits_user = 1'h0;
  assign io_nasti_ar_ready = _T_544;
  assign io_nasti_r_valid = _T_531;
  assign io_nasti_r_bits_resp = 2'h0;
  assign io_nasti_r_bits_data = _T_518_data;
  assign io_nasti_r_bits_last = 1'h1;
  assign io_nasti_r_bits_id = _T_518_id;
  assign io_nasti_r_bits_user = 1'h0;
  assign io_mcr_read_1_ready = _GEN_36;
  assign io_mcr_write_0_valid = _GEN_32;
  assign io_mcr_write_0_bits = wData;
  assign io_mcr_write_1_valid = _GEN_33;
  assign io_mcr_write_1_bits = wData;
  assign io_mcr_write_2_valid = _GEN_34;
  assign io_mcr_write_2_bits = wData;
  assign _T_449 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_451 = io_nasti_aw_bits_addr[31:2];
  assign _T_453 = io_nasti_aw_bits_len == 8'h0;
  assign _T_454 = _T_453 | reset;
  assign _T_456 = _T_454 == 1'h0;
  assign _GEN_6 = _T_449 ? 1'h1 : awFired;
  assign _GEN_7 = _T_449 ? _T_451 : {{28'd0}, wAddr};
  assign _GEN_8 = _T_449 ? io_nasti_aw_bits_id : bId;
  assign _T_457 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_457 ? 1'h1 : wFired;
  assign _GEN_10 = _T_457 ? io_nasti_w_bits_data : wData;
  assign _T_459 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_461 = io_nasti_ar_bits_addr[31:2];
  assign _T_462 = _T_461[1:0];
  assign _T_464 = io_nasti_ar_bits_len == 8'h0;
  assign _T_465 = _T_464 | reset;
  assign _T_467 = _T_465 == 1'h0;
  assign _GEN_12 = _T_459 ? 1'h1 : arFired;
  assign _GEN_13 = _T_459 ? _T_462 : rAddr;
  assign _GEN_14 = _T_459 ? io_nasti_ar_bits_id : rId;
  assign _T_468 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_468 ? 1'h0 : _GEN_12;
  assign _T_470 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_470 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_470 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_470 ? 1'h0 : wCommited;
  assign _GEN_0_ready = _GEN_22;
  assign _GEN_19 = 2'h1 == wAddr ? io_mcr_write_1_ready : 1'h1;
  assign _GEN_20 = 2'h1 == wAddr ? io_mcr_write_1_valid : io_mcr_write_0_valid;
  assign _GEN_22 = 2'h2 == wAddr ? 1'h1 : _GEN_19;
  assign _GEN_23 = 2'h2 == wAddr ? io_mcr_write_2_valid : _GEN_20;
  assign _GEN_1_valid = _GEN_23;
  assign _T_480 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_31 = _T_480 ? 1'h1 : _GEN_18;
  assign _T_494 = awFired & wFired;
  assign _T_495 = ~ wCommited;
  assign _T_496 = _T_494 & _T_495;
  assign _GEN_2 = _T_496;
  assign _GEN_32 = 2'h0 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_33 = 2'h1 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_34 = 2'h2 == wAddr ? _GEN_2 : 1'h0;
  assign _T_503 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_503;
  assign _GEN_36 = 2'h1 == rAddr ? _GEN_3 : 1'h0;
  assign _T_518_data = _GEN_4_bits;
  assign _T_518_id = rId;
  assign _GEN_4_bits = _GEN_43;
  assign _GEN_39 = 2'h1 == rAddr ? io_mcr_read_1_valid : 1'h1;
  assign _GEN_40 = 2'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_42 = 2'h2 == rAddr ? 1'h1 : _GEN_39;
  assign _GEN_43 = 2'h2 == rAddr ? io_mcr_read_2_bits : _GEN_40;
  assign _GEN_5_valid = _GEN_42;
  assign _T_531 = arFired & _GEN_5_valid;
  assign _T_537_id = bId;
  assign _T_543 = _T_494 & wCommited;
  assign _T_544 = ~ arFired;
  assign _T_545 = ~ awFired;
  assign _T_546 = ~ wFired;
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
  _RAND_4 = {1{$random}};
  bId = _RAND_4[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  rId = _RAND_5[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  wData = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{$random}};
  wAddr = _RAND_7[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{$random}};
  rAddr = _RAND_8[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_468) begin
        arFired <= 1'h0;
      end else begin
        if (_T_459) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_470) begin
        awFired <= 1'h0;
      end else begin
        if (_T_449) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_470) begin
        wFired <= 1'h0;
      end else begin
        if (_T_457) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_480) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_470) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_449) begin
      bId <= io_nasti_aw_bits_id;
    end
    if (_T_459) begin
      rId <= io_nasti_ar_bits_id;
    end
    if (_T_457) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[1:0];
    if (_T_459) begin
      rAddr <= _T_462;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_449 & _T_456) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:317 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_449 & _T_456) begin
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
        if (_T_459 & _T_467) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:330 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_459 & _T_467) begin
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
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [1:0]  io_ctrl_b_bits_resp,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_b_bits_user,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [1:0]  io_ctrl_r_bits_resp,
  output [31:0] io_ctrl_r_bits_data,
  output        io_ctrl_r_bits_last,
  output [11:0] io_ctrl_r_bits_id,
  output        io_ctrl_r_bits_user,
  output        io_simReset,
  input         io_done,
  input         io_step_ready,
  output        io_step_valid,
  output [31:0] io_step_bits
);
  reg  SIM_RESET;
  reg [31:0] _RAND_0;
  reg [1:0] value;
  reg [31:0] _RAND_1;
  wire  _T_371;
  wire [2:0] _T_373;
  wire [1:0] _T_374;
  wire [1:0] _GEN_0;
  wire  _GEN_1;
  wire [1:0] _GEN_2;
  wire  _T_386_ready;
  wire  _T_386_valid;
  wire [31:0] _T_386_bits;
  wire  Queue_clock;
  wire  Queue_reset;
  wire  Queue_io_enq_ready;
  wire  Queue_io_enq_valid;
  wire [31:0] Queue_io_enq_bits;
  wire  Queue_io_deq_ready;
  wire  Queue_io_deq_valid;
  wire [31:0] Queue_io_deq_bits;
  wire  _T_394;
  wire  _T_395;
  reg [31:0] DONE;
  reg [31:0] _RAND_2;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire [7:0] MCRFile_io_nasti_aw_bits_len;
  wire [11:0] MCRFile_io_nasti_aw_bits_id;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [31:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire [1:0] MCRFile_io_nasti_b_bits_resp;
  wire [11:0] MCRFile_io_nasti_b_bits_id;
  wire  MCRFile_io_nasti_b_bits_user;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire [7:0] MCRFile_io_nasti_ar_bits_len;
  wire [11:0] MCRFile_io_nasti_ar_bits_id;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [1:0] MCRFile_io_nasti_r_bits_resp;
  wire [31:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [11:0] MCRFile_io_nasti_r_bits_id;
  wire  MCRFile_io_nasti_r_bits_user;
  wire [31:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [31:0] MCRFile_io_mcr_read_1_bits;
  wire [31:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [31:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [31:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [31:0] MCRFile_io_mcr_write_2_bits;
  wire [31:0] _GEN_3;
  wire  _T_401;
  wire  _T_402;
  wire  _T_404;
  wire [31:0] _GEN_4;
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
    .io_nasti_aw_bits_len(MCRFile_io_nasti_aw_bits_len),
    .io_nasti_aw_bits_id(MCRFile_io_nasti_aw_bits_id),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_b_bits_resp(MCRFile_io_nasti_b_bits_resp),
    .io_nasti_b_bits_id(MCRFile_io_nasti_b_bits_id),
    .io_nasti_b_bits_user(MCRFile_io_nasti_b_bits_user),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_ar_bits_len(MCRFile_io_nasti_ar_bits_len),
    .io_nasti_ar_bits_id(MCRFile_io_nasti_ar_bits_id),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_resp(MCRFile_io_nasti_r_bits_resp),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_nasti_r_bits_id(MCRFile_io_nasti_r_bits_id),
    .io_nasti_r_bits_user(MCRFile_io_nasti_r_bits_user),
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
  assign io_ctrl_b_bits_resp = MCRFile_io_nasti_b_bits_resp;
  assign io_ctrl_b_bits_id = MCRFile_io_nasti_b_bits_id;
  assign io_ctrl_b_bits_user = MCRFile_io_nasti_b_bits_user;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_resp = MCRFile_io_nasti_r_bits_resp;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_last = MCRFile_io_nasti_r_bits_last;
  assign io_ctrl_r_bits_id = MCRFile_io_nasti_r_bits_id;
  assign io_ctrl_r_bits_user = MCRFile_io_nasti_r_bits_user;
  assign io_simReset = SIM_RESET;
  assign io_step_valid = Queue_io_deq_valid;
  assign io_step_bits = Queue_io_deq_bits;
  assign _T_371 = value == 2'h3;
  assign _T_373 = value + 2'h1;
  assign _T_374 = _T_373[1:0];
  assign _GEN_0 = SIM_RESET ? _T_374 : value;
  assign _GEN_1 = _T_371 ? 1'h0 : SIM_RESET;
  assign _GEN_2 = _T_371 ? 2'h0 : _GEN_0;
  assign _T_386_ready = Queue_io_enq_ready;
  assign _T_386_valid = MCRFile_io_mcr_write_1_valid;
  assign _T_386_bits = MCRFile_io_mcr_write_1_bits;
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = _T_386_valid;
  assign Queue_io_enq_bits = _T_386_bits;
  assign Queue_io_deq_ready = io_step_ready;
  assign _T_394 = ~ io_simReset;
  assign _T_395 = io_done & _T_394;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_aw_bits_len = io_ctrl_aw_bits_len;
  assign MCRFile_io_nasti_aw_bits_id = io_ctrl_aw_bits_id;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_ar_bits_len = io_ctrl_ar_bits_len;
  assign MCRFile_io_nasti_ar_bits_id = io_ctrl_ar_bits_id;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_bits = {{31'd0}, SIM_RESET};
  assign MCRFile_io_mcr_read_1_valid = 1'h0;
  assign MCRFile_io_mcr_read_1_bits = 32'h0;
  assign MCRFile_io_mcr_read_2_bits = DONE;
  assign MCRFile_io_mcr_write_1_ready = _T_386_ready;
  assign _GEN_3 = MCRFile_io_mcr_write_0_valid ? MCRFile_io_mcr_write_0_bits : {{31'd0}, _GEN_1};
  assign _T_401 = MCRFile_io_mcr_read_1_ready == 1'h0;
  assign _T_402 = _T_401 | reset;
  assign _T_404 = _T_402 == 1'h0;
  assign _GEN_4 = MCRFile_io_mcr_write_2_valid ? MCRFile_io_mcr_write_2_bits : {{31'd0}, _T_395};
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
  _RAND_2 = {1{$random}};
  DONE = _RAND_2[31:0];
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
      if (_T_371) begin
        value <= 2'h0;
      end else begin
        if (SIM_RESET) begin
          value <= _T_374;
        end
      end
    end
    if (reset) begin
      DONE <= 32'h0;
    end else begin
      if (MCRFile_io_mcr_write_2_valid) begin
        DONE <= MCRFile_io_mcr_write_2_bits;
      end else begin
        DONE <= {{31'd0}, _T_395};
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_404) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_404) begin
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
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [31:0] io_ctrl_r_bits_data,
  output [11:0] io_ctrl_r_bits_id,
  input         io_ins_0_ready,
  output        io_ins_0_valid,
  output [31:0] io_ins_0_bits,
  input         io_ins_1_ready,
  output        io_ins_1_valid,
  output [31:0] io_ins_1_bits,
  output        io_outs_0_ready,
  input         io_outs_0_valid,
  input  [31:0] io_outs_0_bits,
  output        io_step_ready,
  input         io_step_valid,
  input  [31:0] io_step_bits,
  output        io_idle
);
  reg [31:0] iTokensAvailable;
  reg [31:0] _RAND_0;
  reg [31:0] oTokensPending;
  reg [31:0] _RAND_1;
  wire  fromHostReady;
  wire  _T_463;
  wire  _T_465;
  wire  _T_466;
  reg [31:0] target_reset;
  reg [31:0] _RAND_2;
  wire  _T_468;
  wire  _T_469;
  reg [31:0] target_io_in;
  reg [31:0] _RAND_3;
  wire  _T_473;
  reg [31:0] target_io_out;
  reg [31:0] _RAND_4;
  wire [31:0] _GEN_0;
  wire  _T_476;
  wire  _T_477;
  wire [32:0] _T_482;
  wire [32:0] _T_483;
  wire [31:0] _T_484;
  wire [31:0] _GEN_1;
  wire [32:0] _T_489;
  wire [32:0] _T_490;
  wire [31:0] _T_491;
  wire [31:0] _GEN_2;
  wire  _T_492;
  wire [31:0] _GEN_3;
  wire [31:0] _GEN_4;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire [7:0] MCRFile_io_nasti_aw_bits_len;
  wire [11:0] MCRFile_io_nasti_aw_bits_id;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [31:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire [1:0] MCRFile_io_nasti_b_bits_resp;
  wire [11:0] MCRFile_io_nasti_b_bits_id;
  wire  MCRFile_io_nasti_b_bits_user;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire [7:0] MCRFile_io_nasti_ar_bits_len;
  wire [11:0] MCRFile_io_nasti_ar_bits_id;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [1:0] MCRFile_io_nasti_r_bits_resp;
  wire [31:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [11:0] MCRFile_io_nasti_r_bits_id;
  wire  MCRFile_io_nasti_r_bits_user;
  wire [31:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [31:0] MCRFile_io_mcr_read_1_bits;
  wire [31:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [31:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [31:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [31:0] MCRFile_io_mcr_write_2_bits;
  wire [31:0] _GEN_5;
  wire [31:0] _GEN_6;
  wire [31:0] _GEN_7;
  MCRFile MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_aw_bits_len(MCRFile_io_nasti_aw_bits_len),
    .io_nasti_aw_bits_id(MCRFile_io_nasti_aw_bits_id),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_b_bits_resp(MCRFile_io_nasti_b_bits_resp),
    .io_nasti_b_bits_id(MCRFile_io_nasti_b_bits_id),
    .io_nasti_b_bits_user(MCRFile_io_nasti_b_bits_user),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_ar_bits_len(MCRFile_io_nasti_ar_bits_len),
    .io_nasti_ar_bits_id(MCRFile_io_nasti_ar_bits_id),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_resp(MCRFile_io_nasti_r_bits_resp),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_nasti_r_bits_id(MCRFile_io_nasti_r_bits_id),
    .io_nasti_r_bits_user(MCRFile_io_nasti_r_bits_user),
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
  assign io_ctrl_b_bits_id = MCRFile_io_nasti_b_bits_id;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_id = MCRFile_io_nasti_r_bits_id;
  assign io_ins_0_valid = _T_469;
  assign io_ins_0_bits = target_reset;
  assign io_ins_1_valid = _T_469;
  assign io_ins_1_bits = target_io_in;
  assign io_outs_0_ready = _T_477;
  assign io_step_ready = io_idle;
  assign io_idle = _T_466;
  assign fromHostReady = io_ins_0_ready & io_ins_1_ready;
  assign _T_463 = iTokensAvailable == 32'h0;
  assign _T_465 = oTokensPending == 32'h0;
  assign _T_466 = _T_463 & _T_465;
  assign _T_468 = iTokensAvailable != 32'h0;
  assign _T_469 = _T_468 & fromHostReady;
  assign _T_473 = io_outs_0_ready & io_outs_0_valid;
  assign _GEN_0 = _T_473 ? io_outs_0_bits : target_io_out;
  assign _T_476 = oTokensPending != 32'h0;
  assign _T_477 = _T_476 & io_outs_0_valid;
  assign _T_482 = iTokensAvailable - 32'h1;
  assign _T_483 = $unsigned(_T_482);
  assign _T_484 = _T_483[31:0];
  assign _GEN_1 = _T_469 ? _T_484 : iTokensAvailable;
  assign _T_489 = oTokensPending - 32'h1;
  assign _T_490 = $unsigned(_T_489);
  assign _T_491 = _T_490[31:0];
  assign _GEN_2 = _T_477 ? _T_491 : oTokensPending;
  assign _T_492 = io_step_ready & io_step_valid;
  assign _GEN_3 = _T_492 ? io_step_bits : _GEN_1;
  assign _GEN_4 = _T_492 ? io_step_bits : _GEN_2;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_aw_bits_len = io_ctrl_aw_bits_len;
  assign MCRFile_io_nasti_aw_bits_id = io_ctrl_aw_bits_id;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_ar_bits_len = io_ctrl_ar_bits_len;
  assign MCRFile_io_nasti_ar_bits_id = io_ctrl_ar_bits_id;
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
  _RAND_0 = {1{$random}};
  iTokensAvailable = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  oTokensPending = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  target_reset = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  target_io_in = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  target_io_out = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      iTokensAvailable <= 32'h0;
    end else begin
      if (_T_492) begin
        iTokensAvailable <= io_step_bits;
      end else begin
        if (_T_469) begin
          iTokensAvailable <= _T_484;
        end
      end
    end
    if (reset) begin
      oTokensPending <= 32'h1;
    end else begin
      if (_T_492) begin
        oTokensPending <= io_step_bits;
      end else begin
        if (_T_477) begin
          oTokensPending <= _T_491;
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
      if (_T_473) begin
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
  input  [7:0]  io_nasti_aw_bits_len,
  input  [11:0] io_nasti_aw_bits_id,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [31:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output [11:0] io_nasti_b_bits_id,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input  [7:0]  io_nasti_ar_bits_len,
  input  [11:0] io_nasti_ar_bits_id,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [31:0] io_nasti_r_bits_data,
  output [11:0] io_nasti_r_bits_id,
  input  [31:0] io_mcr_read_0_bits,
  input  [31:0] io_mcr_read_1_bits,
  output        io_mcr_read_2_ready,
  output        io_mcr_read_4_ready,
  output        io_mcr_read_5_ready,
  input         io_mcr_read_5_valid,
  input  [31:0] io_mcr_read_5_bits,
  output        io_mcr_read_6_ready,
  output        io_mcr_read_8_ready,
  output        io_mcr_read_10_ready,
  output        io_mcr_write_0_valid,
  output [31:0] io_mcr_write_0_bits,
  output        io_mcr_write_1_valid,
  output [31:0] io_mcr_write_1_bits,
  output        io_mcr_write_2_valid,
  output        io_mcr_write_3_valid,
  input         io_mcr_write_4_ready,
  output        io_mcr_write_4_valid,
  output [31:0] io_mcr_write_4_bits,
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
  reg [11:0] bId;
  reg [31:0] _RAND_4;
  reg [11:0] rId;
  reg [31:0] _RAND_5;
  reg [31:0] wData;
  reg [31:0] _RAND_6;
  reg [3:0] wAddr;
  reg [31:0] _RAND_7;
  reg [3:0] rAddr;
  reg [31:0] _RAND_8;
  wire  _T_557;
  wire [29:0] _T_559;
  wire  _T_561;
  wire  _T_562;
  wire  _T_564;
  wire  _GEN_6;
  wire [29:0] _GEN_7;
  wire [11:0] _GEN_8;
  wire  _T_565;
  wire  _GEN_9;
  wire [31:0] _GEN_10;
  wire  _T_567;
  wire [29:0] _T_569;
  wire [3:0] _T_570;
  wire  _T_572;
  wire  _T_573;
  wire  _T_575;
  wire  _GEN_12;
  wire [3:0] _GEN_13;
  wire [11:0] _GEN_14;
  wire  _T_576;
  wire  _GEN_15;
  wire  _T_578;
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
  wire  _T_588;
  wire  _GEN_85;
  wire  _T_620;
  wire  _T_621;
  wire  _T_622;
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
  wire  _T_629;
  wire  _GEN_3;
  wire  _GEN_100;
  wire  _GEN_102;
  wire  _GEN_103;
  wire  _GEN_104;
  wire  _GEN_106;
  wire  _GEN_108;
  wire [31:0] _T_644_data;
  wire [11:0] _T_644_id;
  wire [31:0] _GEN_4_bits;
  wire [31:0] _GEN_112;
  wire  _GEN_114;
  wire [31:0] _GEN_115;
  wire  _GEN_117;
  wire [31:0] _GEN_118;
  wire  _GEN_120;
  wire [31:0] _GEN_121;
  wire  _GEN_123;
  wire [31:0] _GEN_124;
  wire  _GEN_126;
  wire [31:0] _GEN_127;
  wire  _GEN_129;
  wire [31:0] _GEN_130;
  wire  _GEN_132;
  wire [31:0] _GEN_133;
  wire  _GEN_135;
  wire [31:0] _GEN_136;
  wire  _GEN_138;
  wire [31:0] _GEN_139;
  wire  _GEN_141;
  wire [31:0] _GEN_142;
  wire  _GEN_5_valid;
  wire  _T_657;
  wire [11:0] _T_663_id;
  wire  _T_669;
  wire  _T_670;
  wire  _T_671;
  wire  _T_672;
  assign io_nasti_aw_ready = _T_671;
  assign io_nasti_w_ready = _T_672;
  assign io_nasti_b_valid = _T_669;
  assign io_nasti_b_bits_id = _T_663_id;
  assign io_nasti_ar_ready = _T_670;
  assign io_nasti_r_valid = _T_657;
  assign io_nasti_r_bits_data = _T_644_data;
  assign io_nasti_r_bits_id = _T_644_id;
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
  assign _T_557 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_559 = io_nasti_aw_bits_addr[31:2];
  assign _T_561 = io_nasti_aw_bits_len == 8'h0;
  assign _T_562 = _T_561 | reset;
  assign _T_564 = _T_562 == 1'h0;
  assign _GEN_6 = _T_557 ? 1'h1 : awFired;
  assign _GEN_7 = _T_557 ? _T_559 : {{26'd0}, wAddr};
  assign _GEN_8 = _T_557 ? io_nasti_aw_bits_id : bId;
  assign _T_565 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_565 ? 1'h1 : wFired;
  assign _GEN_10 = _T_565 ? io_nasti_w_bits_data : wData;
  assign _T_567 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_569 = io_nasti_ar_bits_addr[31:2];
  assign _T_570 = _T_569[3:0];
  assign _T_572 = io_nasti_ar_bits_len == 8'h0;
  assign _T_573 = _T_572 | reset;
  assign _T_575 = _T_573 == 1'h0;
  assign _GEN_12 = _T_567 ? 1'h1 : arFired;
  assign _GEN_13 = _T_567 ? _T_570 : rAddr;
  assign _GEN_14 = _T_567 ? io_nasti_ar_bits_id : rId;
  assign _T_576 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_576 ? 1'h0 : _GEN_12;
  assign _T_578 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_578 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_578 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_578 ? 1'h0 : wCommited;
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
  assign _T_588 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_85 = _T_588 ? 1'h1 : _GEN_18;
  assign _T_620 = awFired & wFired;
  assign _T_621 = ~ wCommited;
  assign _T_622 = _T_620 & _T_621;
  assign _GEN_2 = _T_622;
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
  assign _T_629 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_629;
  assign _GEN_100 = 4'h2 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_102 = 4'h4 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_103 = 4'h5 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_104 = 4'h6 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_106 = 4'h8 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_108 = 4'ha == rAddr ? _GEN_3 : 1'h0;
  assign _T_644_data = _GEN_4_bits;
  assign _T_644_id = rId;
  assign _GEN_4_bits = _GEN_142;
  assign _GEN_112 = 4'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_114 = 4'h2 == rAddr ? 1'h0 : 1'h1;
  assign _GEN_115 = 4'h2 == rAddr ? 32'h0 : _GEN_112;
  assign _GEN_117 = 4'h3 == rAddr ? 1'h0 : _GEN_114;
  assign _GEN_118 = 4'h3 == rAddr ? 32'h0 : _GEN_115;
  assign _GEN_120 = 4'h4 == rAddr ? 1'h0 : _GEN_117;
  assign _GEN_121 = 4'h4 == rAddr ? 32'h0 : _GEN_118;
  assign _GEN_123 = 4'h5 == rAddr ? io_mcr_read_5_valid : _GEN_120;
  assign _GEN_124 = 4'h5 == rAddr ? io_mcr_read_5_bits : _GEN_121;
  assign _GEN_126 = 4'h6 == rAddr ? 1'h0 : _GEN_123;
  assign _GEN_127 = 4'h6 == rAddr ? 32'h0 : _GEN_124;
  assign _GEN_129 = 4'h7 == rAddr ? 1'h0 : _GEN_126;
  assign _GEN_130 = 4'h7 == rAddr ? 32'h0 : _GEN_127;
  assign _GEN_132 = 4'h8 == rAddr ? 1'h0 : _GEN_129;
  assign _GEN_133 = 4'h8 == rAddr ? 32'h0 : _GEN_130;
  assign _GEN_135 = 4'h9 == rAddr ? 1'h0 : _GEN_132;
  assign _GEN_136 = 4'h9 == rAddr ? 32'h0 : _GEN_133;
  assign _GEN_138 = 4'ha == rAddr ? 1'h0 : _GEN_135;
  assign _GEN_139 = 4'ha == rAddr ? 32'h0 : _GEN_136;
  assign _GEN_141 = 4'hb == rAddr ? 1'h0 : _GEN_138;
  assign _GEN_142 = 4'hb == rAddr ? 32'h0 : _GEN_139;
  assign _GEN_5_valid = _GEN_141;
  assign _T_657 = arFired & _GEN_5_valid;
  assign _T_663_id = bId;
  assign _T_669 = _T_620 & wCommited;
  assign _T_670 = ~ arFired;
  assign _T_671 = ~ awFired;
  assign _T_672 = ~ wFired;
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
  _RAND_4 = {1{$random}};
  bId = _RAND_4[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  rId = _RAND_5[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  wData = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{$random}};
  wAddr = _RAND_7[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{$random}};
  rAddr = _RAND_8[3:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_576) begin
        arFired <= 1'h0;
      end else begin
        if (_T_567) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_578) begin
        awFired <= 1'h0;
      end else begin
        if (_T_557) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_578) begin
        wFired <= 1'h0;
      end else begin
        if (_T_565) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_588) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_578) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_557) begin
      bId <= io_nasti_aw_bits_id;
    end
    if (_T_567) begin
      rId <= io_nasti_ar_bits_id;
    end
    if (_T_565) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[3:0];
    if (_T_567) begin
      rAddr <= _T_570;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_557 & _T_564) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:317 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_557 & _T_564) begin
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
        if (_T_567 & _T_575) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:330 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_567 & _T_575) begin
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
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [31:0] io_ctrl_r_bits_data,
  output [11:0] io_ctrl_r_bits_id,
  input         io_daisy_regs_0_in_ready,
  output        io_daisy_regs_0_in_valid,
  output [31:0] io_daisy_regs_0_in_bits,
  output        io_daisy_regs_0_out_ready,
  input         io_daisy_regs_0_out_valid,
  input  [31:0] io_daisy_regs_0_out_bits
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
  wire [7:0] MCRFile_io_nasti_aw_bits_len;
  wire [11:0] MCRFile_io_nasti_aw_bits_id;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [31:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire [11:0] MCRFile_io_nasti_b_bits_id;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire [7:0] MCRFile_io_nasti_ar_bits_len;
  wire [11:0] MCRFile_io_nasti_ar_bits_id;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [31:0] MCRFile_io_nasti_r_bits_data;
  wire [11:0] MCRFile_io_nasti_r_bits_id;
  wire [31:0] MCRFile_io_mcr_read_0_bits;
  wire [31:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_4_ready;
  wire  MCRFile_io_mcr_read_5_ready;
  wire  MCRFile_io_mcr_read_5_valid;
  wire [31:0] MCRFile_io_mcr_read_5_bits;
  wire  MCRFile_io_mcr_read_6_ready;
  wire  MCRFile_io_mcr_read_8_ready;
  wire  MCRFile_io_mcr_read_10_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [31:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [31:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_valid;
  wire  MCRFile_io_mcr_write_3_valid;
  wire  MCRFile_io_mcr_write_4_ready;
  wire  MCRFile_io_mcr_write_4_valid;
  wire [31:0] MCRFile_io_mcr_write_4_bits;
  wire  MCRFile_io_mcr_write_5_valid;
  wire  MCRFile_io_mcr_write_6_valid;
  wire  MCRFile_io_mcr_write_7_valid;
  wire  MCRFile_io_mcr_write_8_valid;
  wire  MCRFile_io_mcr_write_9_valid;
  wire  MCRFile_io_mcr_write_10_valid;
  wire  MCRFile_io_mcr_write_11_valid;
  wire [31:0] _GEN_2;
  wire [31:0] _GEN_3;
  wire  _T_1111;
  wire  _T_1112;
  wire  _T_1114;
  wire  _T_1116;
  wire  _T_1117;
  wire  _T_1119;
  wire  _T_1121;
  wire  _T_1122;
  wire  _T_1124;
  wire  _T_1126;
  wire  _T_1127;
  wire  _T_1129;
  wire  _T_1131;
  wire  _T_1132;
  wire  _T_1134;
  wire  _T_1136;
  wire  _T_1137;
  wire  _T_1139;
  wire  _T_1141;
  wire  _T_1142;
  wire  _T_1144;
  wire  _T_1146;
  wire  _T_1147;
  wire  _T_1149;
  wire  _T_1151;
  wire  _T_1152;
  wire  _T_1154;
  wire  _T_1156;
  wire  _T_1157;
  wire  _T_1159;
  MCRFile_2 MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_aw_bits_len(MCRFile_io_nasti_aw_bits_len),
    .io_nasti_aw_bits_id(MCRFile_io_nasti_aw_bits_id),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_b_bits_id(MCRFile_io_nasti_b_bits_id),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_ar_bits_len(MCRFile_io_nasti_ar_bits_len),
    .io_nasti_ar_bits_id(MCRFile_io_nasti_ar_bits_id),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_id(MCRFile_io_nasti_r_bits_id),
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
  assign io_ctrl_b_bits_id = MCRFile_io_nasti_b_bits_id;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_id = MCRFile_io_nasti_r_bits_id;
  assign io_daisy_regs_0_in_valid = MCRFile_io_mcr_write_4_valid;
  assign io_daisy_regs_0_in_bits = MCRFile_io_mcr_write_4_bits;
  assign io_daisy_regs_0_out_ready = MCRFile_io_mcr_read_5_ready;
  assign _GEN_0 = SRAM_RESTART_0 ? 1'h0 : SRAM_RESTART_0;
  assign _GEN_1 = REGFILE_RESTART_0 ? 1'h0 : REGFILE_RESTART_0;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_aw_bits_len = io_ctrl_aw_bits_len;
  assign MCRFile_io_nasti_aw_bits_id = io_ctrl_aw_bits_id;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_ar_bits_len = io_ctrl_ar_bits_len;
  assign MCRFile_io_nasti_ar_bits_id = io_ctrl_ar_bits_id;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_bits = {{31'd0}, SRAM_RESTART_0};
  assign MCRFile_io_mcr_read_1_bits = {{31'd0}, REGFILE_RESTART_0};
  assign MCRFile_io_mcr_read_5_valid = io_daisy_regs_0_out_valid;
  assign MCRFile_io_mcr_read_5_bits = io_daisy_regs_0_out_bits;
  assign MCRFile_io_mcr_write_4_ready = io_daisy_regs_0_in_ready;
  assign _GEN_2 = MCRFile_io_mcr_write_0_valid ? MCRFile_io_mcr_write_0_bits : {{31'd0}, _GEN_0};
  assign _GEN_3 = MCRFile_io_mcr_write_1_valid ? MCRFile_io_mcr_write_1_bits : {{31'd0}, _GEN_1};
  assign _T_1111 = MCRFile_io_mcr_read_2_ready == 1'h0;
  assign _T_1112 = _T_1111 | reset;
  assign _T_1114 = _T_1112 == 1'h0;
  assign _T_1116 = MCRFile_io_mcr_write_3_valid != 1'h1;
  assign _T_1117 = _T_1116 | reset;
  assign _T_1119 = _T_1117 == 1'h0;
  assign _T_1121 = MCRFile_io_mcr_read_4_ready == 1'h0;
  assign _T_1122 = _T_1121 | reset;
  assign _T_1124 = _T_1122 == 1'h0;
  assign _T_1126 = MCRFile_io_mcr_write_5_valid != 1'h1;
  assign _T_1127 = _T_1126 | reset;
  assign _T_1129 = _T_1127 == 1'h0;
  assign _T_1131 = MCRFile_io_mcr_read_6_ready == 1'h0;
  assign _T_1132 = _T_1131 | reset;
  assign _T_1134 = _T_1132 == 1'h0;
  assign _T_1136 = MCRFile_io_mcr_write_7_valid != 1'h1;
  assign _T_1137 = _T_1136 | reset;
  assign _T_1139 = _T_1137 == 1'h0;
  assign _T_1141 = MCRFile_io_mcr_read_8_ready == 1'h0;
  assign _T_1142 = _T_1141 | reset;
  assign _T_1144 = _T_1142 == 1'h0;
  assign _T_1146 = MCRFile_io_mcr_write_9_valid != 1'h1;
  assign _T_1147 = _T_1146 | reset;
  assign _T_1149 = _T_1147 == 1'h0;
  assign _T_1151 = MCRFile_io_mcr_read_10_ready == 1'h0;
  assign _T_1152 = _T_1151 | reset;
  assign _T_1154 = _T_1152 == 1'h0;
  assign _T_1156 = MCRFile_io_mcr_write_11_valid != 1'h1;
  assign _T_1157 = _T_1156 | reset;
  assign _T_1159 = _T_1157 == 1'h0;
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
        if (_T_1114) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1114) begin
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
        if (_T_1119) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1119) begin
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
        if (_T_1124) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1124) begin
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
        if (_T_1129) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1129) begin
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
        if (_T_1134) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1134) begin
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
        if (_T_1139) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1139) begin
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
        if (_T_1144) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1144) begin
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
        if (_T_1149) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1149) begin
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
        if (_T_1154) begin
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1154) begin
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
        if (_T_1159) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_1159) begin
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
  input  [7:0]  io_nasti_aw_bits_len,
  input  [11:0] io_nasti_aw_bits_id,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [31:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output [1:0]  io_nasti_b_bits_resp,
  output [11:0] io_nasti_b_bits_id,
  output        io_nasti_b_bits_user,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input  [7:0]  io_nasti_ar_bits_len,
  input  [11:0] io_nasti_ar_bits_id,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [1:0]  io_nasti_r_bits_resp,
  output [31:0] io_nasti_r_bits_data,
  output        io_nasti_r_bits_last,
  output [11:0] io_nasti_r_bits_id,
  output        io_nasti_r_bits_user,
  output        io_mcr_read_0_ready,
  input         io_mcr_read_0_valid,
  input  [31:0] io_mcr_read_0_bits,
  output        io_mcr_read_1_ready,
  input         io_mcr_read_1_valid,
  input  [31:0] io_mcr_read_1_bits,
  output        io_mcr_read_2_ready,
  input         io_mcr_read_2_valid,
  input  [31:0] io_mcr_read_2_bits,
  output        io_mcr_read_3_ready,
  input         io_mcr_read_3_valid,
  input  [31:0] io_mcr_read_3_bits,
  input         io_mcr_write_0_ready,
  output        io_mcr_write_0_valid,
  output [31:0] io_mcr_write_0_bits,
  input         io_mcr_write_1_ready,
  output        io_mcr_write_1_valid,
  output [31:0] io_mcr_write_1_bits,
  input         io_mcr_write_2_ready,
  output        io_mcr_write_2_valid,
  output [31:0] io_mcr_write_2_bits,
  input         io_mcr_write_3_ready,
  output        io_mcr_write_3_valid,
  output [31:0] io_mcr_write_3_bits
);
  reg  arFired;
  reg [31:0] _RAND_0;
  reg  awFired;
  reg [31:0] _RAND_1;
  reg  wFired;
  reg [31:0] _RAND_2;
  reg  wCommited;
  reg [31:0] _RAND_3;
  reg [11:0] bId;
  reg [31:0] _RAND_4;
  reg [11:0] rId;
  reg [31:0] _RAND_5;
  reg [31:0] wData;
  reg [31:0] _RAND_6;
  reg [1:0] wAddr;
  reg [31:0] _RAND_7;
  reg [1:0] rAddr;
  reg [31:0] _RAND_8;
  wire  _T_461;
  wire [29:0] _T_463;
  wire  _T_465;
  wire  _T_466;
  wire  _T_468;
  wire  _GEN_6;
  wire [29:0] _GEN_7;
  wire [11:0] _GEN_8;
  wire  _T_469;
  wire  _GEN_9;
  wire [31:0] _GEN_10;
  wire  _T_471;
  wire [29:0] _T_473;
  wire [1:0] _T_474;
  wire  _T_476;
  wire  _T_477;
  wire  _T_479;
  wire  _GEN_12;
  wire [1:0] _GEN_13;
  wire [11:0] _GEN_14;
  wire  _T_480;
  wire  _GEN_15;
  wire  _T_482;
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
  wire  _T_492;
  wire  _GEN_37;
  wire  _T_508;
  wire  _T_509;
  wire  _T_510;
  wire  _GEN_2;
  wire  _GEN_38;
  wire  _GEN_39;
  wire  _GEN_40;
  wire  _GEN_41;
  wire  _T_517;
  wire  _GEN_3;
  wire  _GEN_42;
  wire  _GEN_43;
  wire  _GEN_44;
  wire  _GEN_45;
  wire [31:0] _T_532_data;
  wire [11:0] _T_532_id;
  wire [31:0] _GEN_4_bits;
  wire  _GEN_47;
  wire [31:0] _GEN_48;
  wire  _GEN_50;
  wire [31:0] _GEN_51;
  wire  _GEN_53;
  wire [31:0] _GEN_54;
  wire  _GEN_5_valid;
  wire  _T_545;
  wire [11:0] _T_551_id;
  wire  _T_557;
  wire  _T_558;
  wire  _T_559;
  wire  _T_560;
  assign io_nasti_aw_ready = _T_559;
  assign io_nasti_w_ready = _T_560;
  assign io_nasti_b_valid = _T_557;
  assign io_nasti_b_bits_resp = 2'h0;
  assign io_nasti_b_bits_id = _T_551_id;
  assign io_nasti_b_bits_user = 1'h0;
  assign io_nasti_ar_ready = _T_558;
  assign io_nasti_r_valid = _T_545;
  assign io_nasti_r_bits_resp = 2'h0;
  assign io_nasti_r_bits_data = _T_532_data;
  assign io_nasti_r_bits_last = 1'h1;
  assign io_nasti_r_bits_id = _T_532_id;
  assign io_nasti_r_bits_user = 1'h0;
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
  assign _T_461 = io_nasti_aw_ready & io_nasti_aw_valid;
  assign _T_463 = io_nasti_aw_bits_addr[31:2];
  assign _T_465 = io_nasti_aw_bits_len == 8'h0;
  assign _T_466 = _T_465 | reset;
  assign _T_468 = _T_466 == 1'h0;
  assign _GEN_6 = _T_461 ? 1'h1 : awFired;
  assign _GEN_7 = _T_461 ? _T_463 : {{28'd0}, wAddr};
  assign _GEN_8 = _T_461 ? io_nasti_aw_bits_id : bId;
  assign _T_469 = io_nasti_w_ready & io_nasti_w_valid;
  assign _GEN_9 = _T_469 ? 1'h1 : wFired;
  assign _GEN_10 = _T_469 ? io_nasti_w_bits_data : wData;
  assign _T_471 = io_nasti_ar_ready & io_nasti_ar_valid;
  assign _T_473 = io_nasti_ar_bits_addr[31:2];
  assign _T_474 = _T_473[1:0];
  assign _T_476 = io_nasti_ar_bits_len == 8'h0;
  assign _T_477 = _T_476 | reset;
  assign _T_479 = _T_477 == 1'h0;
  assign _GEN_12 = _T_471 ? 1'h1 : arFired;
  assign _GEN_13 = _T_471 ? _T_474 : rAddr;
  assign _GEN_14 = _T_471 ? io_nasti_ar_bits_id : rId;
  assign _T_480 = io_nasti_r_ready & io_nasti_r_valid;
  assign _GEN_15 = _T_480 ? 1'h0 : _GEN_12;
  assign _T_482 = io_nasti_b_ready & io_nasti_b_valid;
  assign _GEN_16 = _T_482 ? 1'h0 : _GEN_6;
  assign _GEN_17 = _T_482 ? 1'h0 : _GEN_9;
  assign _GEN_18 = _T_482 ? 1'h0 : wCommited;
  assign _GEN_0_ready = _GEN_25;
  assign _GEN_19 = 2'h1 == wAddr ? io_mcr_write_1_ready : io_mcr_write_0_ready;
  assign _GEN_20 = 2'h1 == wAddr ? io_mcr_write_1_valid : io_mcr_write_0_valid;
  assign _GEN_22 = 2'h2 == wAddr ? io_mcr_write_2_ready : _GEN_19;
  assign _GEN_23 = 2'h2 == wAddr ? io_mcr_write_2_valid : _GEN_20;
  assign _GEN_25 = 2'h3 == wAddr ? io_mcr_write_3_ready : _GEN_22;
  assign _GEN_26 = 2'h3 == wAddr ? io_mcr_write_3_valid : _GEN_23;
  assign _GEN_1_valid = _GEN_26;
  assign _T_492 = _GEN_0_ready & _GEN_1_valid;
  assign _GEN_37 = _T_492 ? 1'h1 : _GEN_18;
  assign _T_508 = awFired & wFired;
  assign _T_509 = ~ wCommited;
  assign _T_510 = _T_508 & _T_509;
  assign _GEN_2 = _T_510;
  assign _GEN_38 = 2'h0 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_39 = 2'h1 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_40 = 2'h2 == wAddr ? _GEN_2 : 1'h0;
  assign _GEN_41 = 2'h3 == wAddr ? _GEN_2 : 1'h0;
  assign _T_517 = arFired & io_nasti_r_ready;
  assign _GEN_3 = _T_517;
  assign _GEN_42 = 2'h0 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_43 = 2'h1 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_44 = 2'h2 == rAddr ? _GEN_3 : 1'h0;
  assign _GEN_45 = 2'h3 == rAddr ? _GEN_3 : 1'h0;
  assign _T_532_data = _GEN_4_bits;
  assign _T_532_id = rId;
  assign _GEN_4_bits = _GEN_54;
  assign _GEN_47 = 2'h1 == rAddr ? io_mcr_read_1_valid : io_mcr_read_0_valid;
  assign _GEN_48 = 2'h1 == rAddr ? io_mcr_read_1_bits : io_mcr_read_0_bits;
  assign _GEN_50 = 2'h2 == rAddr ? io_mcr_read_2_valid : _GEN_47;
  assign _GEN_51 = 2'h2 == rAddr ? io_mcr_read_2_bits : _GEN_48;
  assign _GEN_53 = 2'h3 == rAddr ? io_mcr_read_3_valid : _GEN_50;
  assign _GEN_54 = 2'h3 == rAddr ? io_mcr_read_3_bits : _GEN_51;
  assign _GEN_5_valid = _GEN_53;
  assign _T_545 = arFired & _GEN_5_valid;
  assign _T_551_id = bId;
  assign _T_557 = _T_508 & wCommited;
  assign _T_558 = ~ arFired;
  assign _T_559 = ~ awFired;
  assign _T_560 = ~ wFired;
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
  _RAND_4 = {1{$random}};
  bId = _RAND_4[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  rId = _RAND_5[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  wData = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{$random}};
  wAddr = _RAND_7[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{$random}};
  rAddr = _RAND_8[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      arFired <= 1'h0;
    end else begin
      if (_T_480) begin
        arFired <= 1'h0;
      end else begin
        if (_T_471) begin
          arFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      awFired <= 1'h0;
    end else begin
      if (_T_482) begin
        awFired <= 1'h0;
      end else begin
        if (_T_461) begin
          awFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wFired <= 1'h0;
    end else begin
      if (_T_482) begin
        wFired <= 1'h0;
      end else begin
        if (_T_469) begin
          wFired <= 1'h1;
        end
      end
    end
    if (reset) begin
      wCommited <= 1'h0;
    end else begin
      if (_T_492) begin
        wCommited <= 1'h1;
      end else begin
        if (_T_482) begin
          wCommited <= 1'h0;
        end
      end
    end
    if (_T_461) begin
      bId <= io_nasti_aw_bits_id;
    end
    if (_T_471) begin
      rId <= io_nasti_ar_bits_id;
    end
    if (_T_469) begin
      wData <= io_nasti_w_bits_data;
    end
    wAddr <= _GEN_7[1:0];
    if (_T_471) begin
      rAddr <= _T_474;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_461 & _T_468) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Lib.scala:317 assert(io.nasti.aw.bits.len === 0.U)\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_461 & _T_468) begin
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
        if (_T_471 & _T_479) begin
          $fwrite(32'h80000002,"Assertion failed: MCRFile only support single beat reads\n    at Lib.scala:330 assert(io.nasti.ar.bits.len === 0.U, \"MCRFile only support single beat reads\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_471 & _T_479) begin
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
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [1:0]  io_ctrl_b_bits_resp,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_b_bits_user,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [1:0]  io_ctrl_r_bits_resp,
  output [31:0] io_ctrl_r_bits_data,
  output        io_ctrl_r_bits_last,
  output [11:0] io_ctrl_r_bits_id,
  output        io_ctrl_r_bits_user,
  output [31:0] io_traceLen,
  output        io_wireIns_0_ready,
  input         io_wireIns_0_valid,
  input  [31:0] io_wireIns_0_bits,
  output        io_wireIns_1_ready,
  input         io_wireIns_1_valid,
  input  [31:0] io_wireIns_1_bits,
  output        io_wireOuts_0_ready,
  input         io_wireOuts_0_valid,
  input  [31:0] io_wireOuts_0_bits
);
  reg [31:0] traceLen;
  reg [31:0] _RAND_0;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire [7:0] MCRFile_io_nasti_aw_bits_len;
  wire [11:0] MCRFile_io_nasti_aw_bits_id;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [31:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire [1:0] MCRFile_io_nasti_b_bits_resp;
  wire [11:0] MCRFile_io_nasti_b_bits_id;
  wire  MCRFile_io_nasti_b_bits_user;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire [7:0] MCRFile_io_nasti_ar_bits_len;
  wire [11:0] MCRFile_io_nasti_ar_bits_id;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [1:0] MCRFile_io_nasti_r_bits_resp;
  wire [31:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [11:0] MCRFile_io_nasti_r_bits_id;
  wire  MCRFile_io_nasti_r_bits_user;
  wire  MCRFile_io_mcr_read_0_ready;
  wire  MCRFile_io_mcr_read_0_valid;
  wire [31:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [31:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_2_valid;
  wire [31:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_read_3_ready;
  wire  MCRFile_io_mcr_read_3_valid;
  wire [31:0] MCRFile_io_mcr_read_3_bits;
  wire  MCRFile_io_mcr_write_0_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [31:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [31:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_ready;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [31:0] MCRFile_io_mcr_write_2_bits;
  wire  MCRFile_io_mcr_write_3_ready;
  wire  MCRFile_io_mcr_write_3_valid;
  wire [31:0] MCRFile_io_mcr_write_3_bits;
  wire  _T_482;
  wire  _T_483;
  wire  _T_485;
  wire  _T_487;
  wire  _T_488;
  wire  _T_490;
  wire  _T_492;
  wire  _T_493;
  wire  _T_495;
  wire [31:0] _GEN_0;
  MCRFile_3 MCRFile (
    .clock(MCRFile_clock),
    .reset(MCRFile_reset),
    .io_nasti_aw_ready(MCRFile_io_nasti_aw_ready),
    .io_nasti_aw_valid(MCRFile_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(MCRFile_io_nasti_aw_bits_addr),
    .io_nasti_aw_bits_len(MCRFile_io_nasti_aw_bits_len),
    .io_nasti_aw_bits_id(MCRFile_io_nasti_aw_bits_id),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_b_bits_resp(MCRFile_io_nasti_b_bits_resp),
    .io_nasti_b_bits_id(MCRFile_io_nasti_b_bits_id),
    .io_nasti_b_bits_user(MCRFile_io_nasti_b_bits_user),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_ar_bits_len(MCRFile_io_nasti_ar_bits_len),
    .io_nasti_ar_bits_id(MCRFile_io_nasti_ar_bits_id),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_resp(MCRFile_io_nasti_r_bits_resp),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_nasti_r_bits_id(MCRFile_io_nasti_r_bits_id),
    .io_nasti_r_bits_user(MCRFile_io_nasti_r_bits_user),
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
  assign io_ctrl_b_bits_resp = MCRFile_io_nasti_b_bits_resp;
  assign io_ctrl_b_bits_id = MCRFile_io_nasti_b_bits_id;
  assign io_ctrl_b_bits_user = MCRFile_io_nasti_b_bits_user;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_resp = MCRFile_io_nasti_r_bits_resp;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_last = MCRFile_io_nasti_r_bits_last;
  assign io_ctrl_r_bits_id = MCRFile_io_nasti_r_bits_id;
  assign io_ctrl_r_bits_user = MCRFile_io_nasti_r_bits_user;
  assign io_traceLen = traceLen;
  assign io_wireIns_0_ready = MCRFile_io_mcr_read_0_ready;
  assign io_wireIns_1_ready = MCRFile_io_mcr_read_1_ready;
  assign io_wireOuts_0_ready = MCRFile_io_mcr_read_2_ready;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_aw_bits_len = io_ctrl_aw_bits_len;
  assign MCRFile_io_nasti_aw_bits_id = io_ctrl_aw_bits_id;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_ar_bits_len = io_ctrl_ar_bits_len;
  assign MCRFile_io_nasti_ar_bits_id = io_ctrl_ar_bits_id;
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
  assign _T_482 = MCRFile_io_mcr_write_0_valid != 1'h1;
  assign _T_483 = _T_482 | reset;
  assign _T_485 = _T_483 == 1'h0;
  assign _T_487 = MCRFile_io_mcr_write_1_valid != 1'h1;
  assign _T_488 = _T_487 | reset;
  assign _T_490 = _T_488 == 1'h0;
  assign _T_492 = MCRFile_io_mcr_write_2_valid != 1'h1;
  assign _T_493 = _T_492 | reset;
  assign _T_495 = _T_493 == 1'h0;
  assign _GEN_0 = MCRFile_io_mcr_write_3_valid ? MCRFile_io_mcr_write_3_bits : traceLen;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  traceLen = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      traceLen <= 32'h80;
    end else begin
      if (MCRFile_io_mcr_write_3_valid) begin
        traceLen <= MCRFile_io_mcr_write_3_bits;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_485) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_485) begin
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
        if (_T_490) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_490) begin
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
        if (_T_495) begin
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_495) begin
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
module MultiWidthFifo(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits,
  output [1:0]  io_count
);
  reg [31:0] _T_30_0;
  reg [31:0] _RAND_0;
  reg [31:0] _T_30_1;
  reg [31:0] _RAND_1;
  reg [31:0] _T_30_2;
  reg [31:0] _RAND_2;
  reg [31:0] _T_30_3;
  reg [31:0] _RAND_3;
  wire [63:0] _T_37;
  wire [63:0] _T_38;
  wire [63:0] _T_41_0;
  wire [63:0] _T_41_1;
  reg [1:0] _T_48;
  reg [31:0] _RAND_4;
  reg  _T_51;
  reg [31:0] _RAND_5;
  reg [2:0] _T_54;
  reg [31:0] _RAND_6;
  wire  _T_55;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_2;
  wire [31:0] _GEN_3;
  wire [31:0] _GEN_4;
  wire [31:0] _GEN_5;
  wire [2:0] _T_58;
  wire [1:0] _T_59;
  wire [31:0] _GEN_6;
  wire [31:0] _GEN_7;
  wire [31:0] _GEN_8;
  wire [31:0] _GEN_9;
  wire [1:0] _GEN_10;
  wire  _T_60;
  wire [1:0] _T_62;
  wire  _T_63;
  wire  _GEN_11;
  wire  _T_66;
  wire [3:0] _T_68;
  wire [3:0] _T_69;
  wire [2:0] _T_70;
  wire [3:0] _T_73;
  wire [2:0] _T_74;
  wire [3:0] _T_77;
  wire [3:0] _T_78;
  wire [2:0] _T_79;
  wire [2:0] _T_80;
  wire [2:0] _T_81;
  wire [2:0] _T_82;
  wire [2:0] _T_84;
  wire  _T_86;
  wire [63:0] _GEN_1;
  wire [63:0] _GEN_12;
  wire  _T_89;
  assign io_in_ready = _T_89;
  assign io_out_valid = _T_86;
  assign io_out_bits = _GEN_1;
  assign io_count = _T_84[1:0];
  assign _T_37 = {_T_30_1,_T_30_0};
  assign _T_38 = {_T_30_3,_T_30_2};
  assign _T_41_0 = _T_37;
  assign _T_41_1 = _T_38;
  assign _T_55 = io_in_ready & io_in_valid;
  assign _GEN_0 = io_in_bits;
  assign _GEN_2 = 2'h0 == _T_48 ? _GEN_0 : _T_30_0;
  assign _GEN_3 = 2'h1 == _T_48 ? _GEN_0 : _T_30_1;
  assign _GEN_4 = 2'h2 == _T_48 ? _GEN_0 : _T_30_2;
  assign _GEN_5 = 2'h3 == _T_48 ? _GEN_0 : _T_30_3;
  assign _T_58 = _T_48 + 2'h1;
  assign _T_59 = _T_58[1:0];
  assign _GEN_6 = _T_55 ? _GEN_2 : _T_30_0;
  assign _GEN_7 = _T_55 ? _GEN_3 : _T_30_1;
  assign _GEN_8 = _T_55 ? _GEN_4 : _T_30_2;
  assign _GEN_9 = _T_55 ? _GEN_5 : _T_30_3;
  assign _GEN_10 = _T_55 ? _T_59 : _T_48;
  assign _T_60 = io_out_ready & io_out_valid;
  assign _T_62 = _T_51 + 1'h1;
  assign _T_63 = _T_62[0:0];
  assign _GEN_11 = _T_60 ? _T_63 : _T_51;
  assign _T_66 = _T_55 & _T_60;
  assign _T_68 = _T_54 - 3'h1;
  assign _T_69 = $unsigned(_T_68);
  assign _T_70 = _T_69[2:0];
  assign _T_73 = _T_54 + 3'h1;
  assign _T_74 = _T_73[2:0];
  assign _T_77 = _T_54 - 3'h2;
  assign _T_78 = $unsigned(_T_77);
  assign _T_79 = _T_78[2:0];
  assign _T_80 = _T_60 ? _T_79 : _T_54;
  assign _T_81 = _T_55 ? _T_74 : _T_80;
  assign _T_82 = _T_66 ? _T_70 : _T_81;
  assign _T_84 = _T_54 >> 1'h1;
  assign _T_86 = io_count > 2'h0;
  assign _GEN_1 = _GEN_12;
  assign _GEN_12 = _T_51 ? _T_41_1 : _T_41_0;
  assign _T_89 = _T_54 < 3'h4;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  _T_30_0 = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  _T_30_1 = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  _T_30_2 = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  _T_30_3 = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  _T_48 = _RAND_4[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{$random}};
  _T_51 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{$random}};
  _T_54 = _RAND_6[2:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_55) begin
      if (2'h0 == _T_48) begin
        _T_30_0 <= _GEN_0;
      end
    end
    if (_T_55) begin
      if (2'h1 == _T_48) begin
        _T_30_1 <= _GEN_0;
      end
    end
    if (_T_55) begin
      if (2'h2 == _T_48) begin
        _T_30_2 <= _GEN_0;
      end
    end
    if (_T_55) begin
      if (2'h3 == _T_48) begin
        _T_30_3 <= _GEN_0;
      end
    end
    if (reset) begin
      _T_48 <= 2'h0;
    end else begin
      if (_T_55) begin
        _T_48 <= _T_59;
      end
    end
    if (reset) begin
      _T_51 <= 1'h0;
    end else begin
      if (_T_60) begin
        _T_51 <= _T_63;
      end
    end
    if (reset) begin
      _T_54 <= 3'h0;
    end else begin
      if (_T_66) begin
        _T_54 <= _T_70;
      end else begin
        if (_T_55) begin
          _T_54 <= _T_74;
        end else begin
          if (_T_60) begin
            _T_54 <= _T_79;
          end
        end
      end
    end
  end
endmodule
module MultiWidthFifo_1(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits
);
  reg [63:0] _T_30_0;
  reg [63:0] _RAND_0;
  wire [31:0] _T_34;
  wire [31:0] _T_35;
  wire [31:0] _T_38_0;
  wire [31:0] _T_38_1;
  reg  _T_48;
  reg [31:0] _RAND_1;
  reg [1:0] _T_51;
  reg [31:0] _RAND_2;
  wire  _T_52;
  wire [63:0] _GEN_1;
  wire  _T_58;
  wire [1:0] _T_60;
  wire  _T_61;
  wire  _GEN_3;
  wire  _T_64;
  wire [2:0] _T_66;
  wire [1:0] _T_67;
  wire [2:0] _T_70;
  wire [1:0] _T_71;
  wire [2:0] _T_74;
  wire [2:0] _T_75;
  wire [1:0] _T_76;
  wire [1:0] _T_77;
  wire [1:0] _T_78;
  wire [1:0] _T_79;
  wire  _T_81;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_4;
  wire  _T_84;
  assign io_in_ready = _T_84;
  assign io_out_valid = _T_81;
  assign io_out_bits = _GEN_0;
  assign _T_34 = _T_30_0[31:0];
  assign _T_35 = _T_30_0[63:32];
  assign _T_38_0 = _T_34;
  assign _T_38_1 = _T_35;
  assign _T_52 = io_in_ready & io_in_valid;
  assign _GEN_1 = _T_52 ? 64'h0 : _T_30_0;
  assign _T_58 = io_out_ready & io_out_valid;
  assign _T_60 = _T_48 + 1'h1;
  assign _T_61 = _T_60[0:0];
  assign _GEN_3 = _T_58 ? _T_61 : _T_48;
  assign _T_64 = _T_52 & _T_58;
  assign _T_66 = _T_51 + 2'h1;
  assign _T_67 = _T_66[1:0];
  assign _T_70 = _T_51 + 2'h2;
  assign _T_71 = _T_70[1:0];
  assign _T_74 = _T_51 - 2'h1;
  assign _T_75 = $unsigned(_T_74);
  assign _T_76 = _T_75[1:0];
  assign _T_77 = _T_58 ? _T_76 : _T_51;
  assign _T_78 = _T_52 ? _T_71 : _T_77;
  assign _T_79 = _T_64 ? _T_67 : _T_78;
  assign _T_81 = _T_51 > 2'h0;
  assign _GEN_0 = _GEN_4;
  assign _GEN_4 = _T_48 ? _T_38_1 : _T_38_0;
  assign _T_84 = _T_51 < 2'h2;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{$random}};
  _T_30_0 = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  _T_48 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  _T_51 = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_52) begin
      _T_30_0 <= 64'h0;
    end
    if (reset) begin
      _T_48 <= 1'h0;
    end else begin
      if (_T_58) begin
        _T_48 <= _T_61;
      end
    end
    if (reset) begin
      _T_51 <= 2'h0;
    end else begin
      if (_T_64) begin
        _T_51 <= _T_67;
      end else begin
        if (_T_52) begin
          _T_51 <= _T_71;
        end else begin
          if (_T_58) begin
            _T_51 <= _T_76;
          end
        end
      end
    end
  end
endmodule
module LoadMemWidget(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [31:0] io_ctrl_r_bits_data,
  output [11:0] io_ctrl_r_bits_id,
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
  wire [31:0] wDataQ_io_in_bits;
  wire  wDataQ_io_out_ready;
  wire  wDataQ_io_out_valid;
  wire [63:0] wDataQ_io_out_bits;
  wire [1:0] wDataQ_io_count;
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
  wire  rDataQ_io_out_ready;
  wire  rDataQ_io_out_valid;
  wire [31:0] rDataQ_io_out_bits;
  wire  MCRFile_clock;
  wire  MCRFile_reset;
  wire  MCRFile_io_nasti_aw_ready;
  wire  MCRFile_io_nasti_aw_valid;
  wire [31:0] MCRFile_io_nasti_aw_bits_addr;
  wire [7:0] MCRFile_io_nasti_aw_bits_len;
  wire [11:0] MCRFile_io_nasti_aw_bits_id;
  wire  MCRFile_io_nasti_w_ready;
  wire  MCRFile_io_nasti_w_valid;
  wire [31:0] MCRFile_io_nasti_w_bits_data;
  wire  MCRFile_io_nasti_b_ready;
  wire  MCRFile_io_nasti_b_valid;
  wire [1:0] MCRFile_io_nasti_b_bits_resp;
  wire [11:0] MCRFile_io_nasti_b_bits_id;
  wire  MCRFile_io_nasti_b_bits_user;
  wire  MCRFile_io_nasti_ar_ready;
  wire  MCRFile_io_nasti_ar_valid;
  wire [31:0] MCRFile_io_nasti_ar_bits_addr;
  wire [7:0] MCRFile_io_nasti_ar_bits_len;
  wire [11:0] MCRFile_io_nasti_ar_bits_id;
  wire  MCRFile_io_nasti_r_ready;
  wire  MCRFile_io_nasti_r_valid;
  wire [1:0] MCRFile_io_nasti_r_bits_resp;
  wire [31:0] MCRFile_io_nasti_r_bits_data;
  wire  MCRFile_io_nasti_r_bits_last;
  wire [11:0] MCRFile_io_nasti_r_bits_id;
  wire  MCRFile_io_nasti_r_bits_user;
  wire  MCRFile_io_mcr_read_0_ready;
  wire  MCRFile_io_mcr_read_0_valid;
  wire [31:0] MCRFile_io_mcr_read_0_bits;
  wire  MCRFile_io_mcr_read_1_ready;
  wire  MCRFile_io_mcr_read_1_valid;
  wire [31:0] MCRFile_io_mcr_read_1_bits;
  wire  MCRFile_io_mcr_read_2_ready;
  wire  MCRFile_io_mcr_read_2_valid;
  wire [31:0] MCRFile_io_mcr_read_2_bits;
  wire  MCRFile_io_mcr_read_3_ready;
  wire  MCRFile_io_mcr_read_3_valid;
  wire [31:0] MCRFile_io_mcr_read_3_bits;
  wire  MCRFile_io_mcr_write_0_ready;
  wire  MCRFile_io_mcr_write_0_valid;
  wire [31:0] MCRFile_io_mcr_write_0_bits;
  wire  MCRFile_io_mcr_write_1_ready;
  wire  MCRFile_io_mcr_write_1_valid;
  wire [31:0] MCRFile_io_mcr_write_1_bits;
  wire  MCRFile_io_mcr_write_2_ready;
  wire  MCRFile_io_mcr_write_2_valid;
  wire [31:0] MCRFile_io_mcr_write_2_bits;
  wire  MCRFile_io_mcr_write_3_ready;
  wire  MCRFile_io_mcr_write_3_valid;
  wire [31:0] MCRFile_io_mcr_write_3_bits;
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
  MultiWidthFifo wDataQ (
    .clock(wDataQ_clock),
    .reset(wDataQ_reset),
    .io_in_ready(wDataQ_io_in_ready),
    .io_in_valid(wDataQ_io_in_valid),
    .io_in_bits(wDataQ_io_in_bits),
    .io_out_ready(wDataQ_io_out_ready),
    .io_out_valid(wDataQ_io_out_valid),
    .io_out_bits(wDataQ_io_out_bits),
    .io_count(wDataQ_io_count)
  );
  Queue_0 Queue_1 (
    .clock(Queue_1_clock),
    .reset(Queue_1_reset),
    .io_enq_ready(Queue_1_io_enq_ready),
    .io_enq_valid(Queue_1_io_enq_valid),
    .io_enq_bits(Queue_1_io_enq_bits),
    .io_deq_ready(Queue_1_io_deq_ready),
    .io_deq_valid(Queue_1_io_deq_valid),
    .io_deq_bits(Queue_1_io_deq_bits)
  );
  MultiWidthFifo_1 rDataQ (
    .clock(rDataQ_clock),
    .reset(rDataQ_reset),
    .io_in_ready(rDataQ_io_in_ready),
    .io_in_valid(rDataQ_io_in_valid),
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
    .io_nasti_aw_bits_len(MCRFile_io_nasti_aw_bits_len),
    .io_nasti_aw_bits_id(MCRFile_io_nasti_aw_bits_id),
    .io_nasti_w_ready(MCRFile_io_nasti_w_ready),
    .io_nasti_w_valid(MCRFile_io_nasti_w_valid),
    .io_nasti_w_bits_data(MCRFile_io_nasti_w_bits_data),
    .io_nasti_b_ready(MCRFile_io_nasti_b_ready),
    .io_nasti_b_valid(MCRFile_io_nasti_b_valid),
    .io_nasti_b_bits_resp(MCRFile_io_nasti_b_bits_resp),
    .io_nasti_b_bits_id(MCRFile_io_nasti_b_bits_id),
    .io_nasti_b_bits_user(MCRFile_io_nasti_b_bits_user),
    .io_nasti_ar_ready(MCRFile_io_nasti_ar_ready),
    .io_nasti_ar_valid(MCRFile_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(MCRFile_io_nasti_ar_bits_addr),
    .io_nasti_ar_bits_len(MCRFile_io_nasti_ar_bits_len),
    .io_nasti_ar_bits_id(MCRFile_io_nasti_ar_bits_id),
    .io_nasti_r_ready(MCRFile_io_nasti_r_ready),
    .io_nasti_r_valid(MCRFile_io_nasti_r_valid),
    .io_nasti_r_bits_resp(MCRFile_io_nasti_r_bits_resp),
    .io_nasti_r_bits_data(MCRFile_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(MCRFile_io_nasti_r_bits_last),
    .io_nasti_r_bits_id(MCRFile_io_nasti_r_bits_id),
    .io_nasti_r_bits_user(MCRFile_io_nasti_r_bits_user),
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
  assign io_ctrl_b_bits_id = MCRFile_io_nasti_b_bits_id;
  assign io_ctrl_ar_ready = MCRFile_io_nasti_ar_ready;
  assign io_ctrl_r_valid = MCRFile_io_nasti_r_valid;
  assign io_ctrl_r_bits_data = MCRFile_io_nasti_r_bits_data;
  assign io_ctrl_r_bits_id = MCRFile_io_nasti_r_bits_id;
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
  assign _T_584_bits = MCRFile_io_mcr_write_0_bits;
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
  assign _T_671_bits = MCRFile_io_mcr_write_2_bits;
  assign Queue_1_clock = clock;
  assign Queue_1_reset = reset;
  assign Queue_1_io_enq_valid = _T_671_valid;
  assign Queue_1_io_enq_bits = _T_671_bits;
  assign Queue_1_io_deq_ready = rAddrQ_ready;
  assign _T_694_addr = rAddrQ_bits;
  assign rDataQ_clock = clock;
  assign rDataQ_reset = reset;
  assign rDataQ_io_in_valid = io_toSlaveMem_r_valid;
  assign rDataQ_io_out_ready = MCRFile_io_mcr_read_3_ready;
  assign MCRFile_clock = clock;
  assign MCRFile_reset = reset;
  assign MCRFile_io_nasti_aw_valid = io_ctrl_aw_valid;
  assign MCRFile_io_nasti_aw_bits_addr = io_ctrl_aw_bits_addr;
  assign MCRFile_io_nasti_aw_bits_len = io_ctrl_aw_bits_len;
  assign MCRFile_io_nasti_aw_bits_id = io_ctrl_aw_bits_id;
  assign MCRFile_io_nasti_w_valid = io_ctrl_w_valid;
  assign MCRFile_io_nasti_w_bits_data = io_ctrl_w_bits_data;
  assign MCRFile_io_nasti_b_ready = io_ctrl_b_ready;
  assign MCRFile_io_nasti_ar_valid = io_ctrl_ar_valid;
  assign MCRFile_io_nasti_ar_bits_addr = io_ctrl_ar_bits_addr;
  assign MCRFile_io_nasti_ar_bits_len = io_ctrl_ar_bits_len;
  assign MCRFile_io_nasti_ar_bits_id = io_ctrl_ar_bits_id;
  assign MCRFile_io_nasti_r_ready = io_ctrl_r_ready;
  assign MCRFile_io_mcr_read_0_valid = 1'h0;
  assign MCRFile_io_mcr_read_0_bits = 32'h0;
  assign MCRFile_io_mcr_read_1_valid = 1'h0;
  assign MCRFile_io_mcr_read_1_bits = 32'h0;
  assign MCRFile_io_mcr_read_2_valid = 1'h0;
  assign MCRFile_io_mcr_read_2_bits = 32'h0;
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
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
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
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
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
          $fwrite(32'h80000002,"Assertion failed: Can only write to this decoupled sink\n    at Lib.scala:283 assert(read(addr).ready === false.B, \"Can only write to this decoupled sink\")\n");
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
          $fwrite(32'h80000002,"Assertion failed: Can only read from this decoupled source\n    at Lib.scala:288 assert(write(addr).valid =/= true.B, \"Can only read from this decoupled source\")\n");
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
module Queue_3(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [7:0]  io_enq_bits_len,
  input  [11:0] io_enq_bits_id,
  input         io_deq_ready,
  output        io_deq_valid,
  output [7:0]  io_deq_bits_len,
  output [11:0] io_deq_bits_id
);
  reg [7:0] ram_len [0:0];
  reg [31:0] _RAND_0;
  wire [7:0] ram_len__T_135_data;
  wire  ram_len__T_135_addr;
  wire [7:0] ram_len__T_115_data;
  wire  ram_len__T_115_addr;
  wire  ram_len__T_115_mask;
  wire  ram_len__T_115_en;
  reg [11:0] ram_id [0:0];
  reg [31:0] _RAND_1;
  wire [11:0] ram_id__T_135_data;
  wire  ram_id__T_135_addr;
  wire [11:0] ram_id__T_115_data;
  wire  ram_id__T_115_addr;
  wire  ram_id__T_115_mask;
  wire  ram_id__T_115_en;
  reg  maybe_full;
  reg [31:0] _RAND_2;
  wire  _T_107;
  wire  _T_110;
  wire  do_enq;
  wire  _T_112;
  wire  do_deq;
  wire  _T_129;
  wire  _GEN_14;
  wire  _T_131;
  assign io_enq_ready = _T_107;
  assign io_deq_valid = _T_131;
  assign io_deq_bits_len = ram_len__T_135_data;
  assign io_deq_bits_id = ram_id__T_135_data;
  assign ram_len__T_135_addr = 1'h0;
  assign ram_len__T_135_data = ram_len[ram_len__T_135_addr];
  assign ram_len__T_115_data = io_enq_bits_len;
  assign ram_len__T_115_addr = 1'h0;
  assign ram_len__T_115_mask = do_enq;
  assign ram_len__T_115_en = do_enq;
  assign ram_id__T_135_addr = 1'h0;
  assign ram_id__T_135_data = ram_id[ram_id__T_135_addr];
  assign ram_id__T_115_data = io_enq_bits_id;
  assign ram_id__T_115_addr = 1'h0;
  assign ram_id__T_115_mask = do_enq;
  assign ram_id__T_115_en = do_enq;
  assign _T_107 = maybe_full == 1'h0;
  assign _T_110 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_110;
  assign _T_112 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_112;
  assign _T_129 = do_enq != do_deq;
  assign _GEN_14 = _T_129 ? do_enq : maybe_full;
  assign _T_131 = _T_107 == 1'h0;
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
  _RAND_1 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_id[initvar] = _RAND_1[11:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  maybe_full = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram_len__T_115_en & ram_len__T_115_mask) begin
      ram_len[ram_len__T_115_addr] <= ram_len__T_115_data;
    end
    if(ram_id__T_115_en & ram_id__T_115_mask) begin
      ram_id[ram_id__T_115_addr] <= ram_id__T_115_data;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_129) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module Queue_4(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [11:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [11:0] io_deq_bits
);
  reg [11:0] ram [0:0];
  reg [31:0] _RAND_0;
  wire [11:0] ram__T_47_data;
  wire  ram__T_47_addr;
  wire [11:0] ram__T_38_data;
  wire  ram__T_38_addr;
  wire  ram__T_38_mask;
  wire  ram__T_38_en;
  reg  maybe_full;
  reg [31:0] _RAND_1;
  wire  _T_30;
  wire  _T_33;
  wire  do_enq;
  wire  _T_35;
  wire  do_deq;
  wire  _T_41;
  wire  _GEN_4;
  wire  _T_43;
  assign io_enq_ready = _T_30;
  assign io_deq_valid = _T_43;
  assign io_deq_bits = ram__T_47_data;
  assign ram__T_47_addr = 1'h0;
  assign ram__T_47_data = ram[ram__T_47_addr];
  assign ram__T_38_data = io_enq_bits;
  assign ram__T_38_addr = 1'h0;
  assign ram__T_38_mask = do_enq;
  assign ram__T_38_en = do_enq;
  assign _T_30 = maybe_full == 1'h0;
  assign _T_33 = io_enq_ready & io_enq_valid;
  assign do_enq = _T_33;
  assign _T_35 = io_deq_ready & io_deq_valid;
  assign do_deq = _T_35;
  assign _T_41 = do_enq != do_deq;
  assign _GEN_4 = _T_41 ? do_enq : maybe_full;
  assign _T_43 = _T_30 == 1'h0;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  _RAND_0 = {1{$random}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram[initvar] = _RAND_0[11:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  maybe_full = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_38_en & ram__T_38_mask) begin
      ram[ram__T_38_addr] <= ram__T_38_data;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_41) begin
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
  input  [11:0] io_aw_bits_id,
  output        io_w_ready,
  input         io_w_valid,
  input         io_w_bits_last,
  input         io_b_ready,
  output        io_b_valid,
  output [11:0] io_b_bits_id,
  output        io_ar_ready,
  input         io_ar_valid,
  input  [31:0] io_ar_bits_addr,
  input  [7:0]  io_ar_bits_len,
  input  [11:0] io_ar_bits_id,
  input         io_r_ready,
  output        io_r_valid,
  output        io_r_bits_last,
  output [11:0] io_r_bits_id
);
  wire  _T_353;
  wire  _T_355;
  wire  _T_356;
  wire  r_queue_clock;
  wire  r_queue_reset;
  wire  r_queue_io_enq_ready;
  wire  r_queue_io_enq_valid;
  wire [7:0] r_queue_io_enq_bits_len;
  wire [11:0] r_queue_io_enq_bits_id;
  wire  r_queue_io_deq_ready;
  wire  r_queue_io_deq_valid;
  wire [7:0] r_queue_io_deq_bits_len;
  wire [11:0] r_queue_io_deq_bits_id;
  reg  responding;
  reg [31:0] _RAND_0;
  reg [7:0] beats_left;
  reg [31:0] _RAND_1;
  wire  _T_376;
  wire  _T_377;
  wire  _GEN_0;
  wire [7:0] _GEN_1;
  wire  _T_379;
  wire  _T_383;
  wire  _T_384;
  wire  _T_385;
  wire  _GEN_2;
  wire  _T_391;
  wire [8:0] _T_393;
  wire [8:0] _T_394;
  wire [7:0] _T_395;
  wire [7:0] _GEN_3;
  wire  _GEN_4;
  wire [7:0] _GEN_5;
  reg  draining;
  reg [31:0] _RAND_2;
  wire  _GEN_6;
  wire  _T_400;
  wire  _T_401;
  wire  _GEN_7;
  wire  b_queue_clock;
  wire  b_queue_reset;
  wire  b_queue_io_enq_ready;
  wire  b_queue_io_enq_valid;
  wire [11:0] b_queue_io_enq_bits;
  wire  b_queue_io_deq_ready;
  wire  b_queue_io_deq_valid;
  wire [11:0] b_queue_io_deq_bits;
  wire  _T_405;
  wire  _T_406;
  wire  _T_409;
  wire  _T_412;
  wire  _T_416;
  Queue_3 r_queue (
    .clock(r_queue_clock),
    .reset(r_queue_reset),
    .io_enq_ready(r_queue_io_enq_ready),
    .io_enq_valid(r_queue_io_enq_valid),
    .io_enq_bits_len(r_queue_io_enq_bits_len),
    .io_enq_bits_id(r_queue_io_enq_bits_id),
    .io_deq_ready(r_queue_io_deq_ready),
    .io_deq_valid(r_queue_io_deq_valid),
    .io_deq_bits_len(r_queue_io_deq_bits_len),
    .io_deq_bits_id(r_queue_io_deq_bits_id)
  );
  Queue_4 b_queue (
    .clock(b_queue_clock),
    .reset(b_queue_reset),
    .io_enq_ready(b_queue_io_enq_ready),
    .io_enq_valid(b_queue_io_enq_valid),
    .io_enq_bits(b_queue_io_enq_bits),
    .io_deq_ready(b_queue_io_deq_ready),
    .io_deq_valid(b_queue_io_deq_valid),
    .io_deq_bits(b_queue_io_deq_bits)
  );
  assign io_aw_ready = _T_409;
  assign io_w_ready = draining;
  assign io_b_valid = _T_412;
  assign io_b_bits_id = b_queue_io_deq_bits;
  assign io_ar_ready = r_queue_io_enq_ready;
  assign io_r_valid = _T_379;
  assign io_r_bits_last = _T_383;
  assign io_r_bits_id = r_queue_io_deq_bits_id;
  assign _T_353 = io_ar_ready & io_ar_valid;
  assign _T_355 = reset == 1'h0;
  assign _T_356 = io_aw_ready & io_aw_valid;
  assign r_queue_clock = clock;
  assign r_queue_reset = reset;
  assign r_queue_io_enq_valid = io_ar_valid;
  assign r_queue_io_enq_bits_len = io_ar_bits_len;
  assign r_queue_io_enq_bits_id = io_ar_bits_id;
  assign r_queue_io_deq_ready = _T_385;
  assign _T_376 = responding == 1'h0;
  assign _T_377 = _T_376 & r_queue_io_deq_valid;
  assign _GEN_0 = _T_377 ? 1'h1 : responding;
  assign _GEN_1 = _T_377 ? r_queue_io_deq_bits_len : beats_left;
  assign _T_379 = r_queue_io_deq_valid & responding;
  assign _T_383 = beats_left == 8'h0;
  assign _T_384 = io_r_ready & io_r_valid;
  assign _T_385 = _T_384 & io_r_bits_last;
  assign _GEN_2 = _T_383 ? 1'h0 : _GEN_0;
  assign _T_391 = _T_383 == 1'h0;
  assign _T_393 = beats_left - 8'h1;
  assign _T_394 = $unsigned(_T_393);
  assign _T_395 = _T_394[7:0];
  assign _GEN_3 = _T_391 ? _T_395 : _GEN_1;
  assign _GEN_4 = _T_384 ? _GEN_2 : _GEN_0;
  assign _GEN_5 = _T_384 ? _GEN_3 : _GEN_1;
  assign _GEN_6 = _T_356 ? 1'h1 : draining;
  assign _T_400 = io_w_ready & io_w_valid;
  assign _T_401 = _T_400 & io_w_bits_last;
  assign _GEN_7 = _T_401 ? 1'h0 : _GEN_6;
  assign b_queue_clock = clock;
  assign b_queue_reset = reset;
  assign b_queue_io_enq_valid = _T_406;
  assign b_queue_io_enq_bits = io_aw_bits_id;
  assign b_queue_io_deq_ready = _T_416;
  assign _T_405 = draining == 1'h0;
  assign _T_406 = io_aw_valid & _T_405;
  assign _T_409 = b_queue_io_enq_ready & _T_405;
  assign _T_412 = b_queue_io_deq_valid & _T_405;
  assign _T_416 = io_b_ready & _T_405;
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
      if (_T_384) begin
        if (_T_383) begin
          responding <= 1'h0;
        end else begin
          if (_T_377) begin
            responding <= 1'h1;
          end
        end
      end else begin
        if (_T_377) begin
          responding <= 1'h1;
        end
      end
    end
    if (reset) begin
      beats_left <= 8'h0;
    end else begin
      if (_T_384) begin
        if (_T_391) begin
          beats_left <= _T_395;
        end else begin
          if (_T_377) begin
            beats_left <= r_queue_io_deq_bits_len;
          end
        end
      end else begin
        if (_T_377) begin
          beats_left <= r_queue_io_deq_bits_len;
        end
      end
    end
    if (reset) begin
      draining <= 1'h0;
    end else begin
      if (_T_401) begin
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
  input         clock,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [11:0] io_in_0_bits_id,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [1:0]  io_in_1_bits_resp,
  input  [11:0] io_in_1_bits_id,
  input         io_in_1_bits_user,
  output        io_in_2_ready,
  input         io_in_2_valid,
  input  [11:0] io_in_2_bits_id,
  output        io_in_3_ready,
  input         io_in_3_valid,
  input  [1:0]  io_in_3_bits_resp,
  input  [11:0] io_in_3_bits_id,
  input         io_in_3_bits_user,
  output        io_in_4_ready,
  input         io_in_4_valid,
  input  [11:0] io_in_4_bits_id,
  output        io_in_5_ready,
  input         io_in_5_valid,
  input  [11:0] io_in_5_bits_id,
  input         io_out_ready,
  output        io_out_valid,
  output [1:0]  io_out_bits_resp,
  output [11:0] io_out_bits_id,
  output        io_out_bits_user,
  output [2:0]  io_chosen
);
  wire [2:0] choice;
  wire  _GEN_0_valid;
  wire  _GEN_5;
  wire [1:0] _GEN_6;
  wire [11:0] _GEN_7;
  wire  _GEN_8;
  wire  _GEN_10;
  wire [1:0] _GEN_11;
  wire [11:0] _GEN_12;
  wire  _GEN_13;
  wire  _GEN_15;
  wire [1:0] _GEN_16;
  wire [11:0] _GEN_17;
  wire  _GEN_18;
  wire  _GEN_20;
  wire [1:0] _GEN_21;
  wire [11:0] _GEN_22;
  wire  _GEN_23;
  wire  _GEN_25;
  wire [1:0] _GEN_26;
  wire [11:0] _GEN_27;
  wire  _GEN_28;
  wire [1:0] _GEN_1_bits_resp;
  wire [11:0] _GEN_2_bits_id;
  wire  _GEN_3_bits_user;
  wire  _T_346;
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
  wire  _T_355;
  wire  _T_356;
  wire  _T_357;
  wire  _T_358;
  wire  _T_359;
  wire  _T_360;
  wire  _T_361;
  wire  _T_362;
  wire  _T_363;
  wire  _T_367;
  wire  _T_369;
  wire  _T_371;
  wire  _T_373;
  wire  _T_375;
  wire  _T_377;
  wire  _T_379;
  wire  _T_381;
  wire  _T_383;
  wire  _T_385;
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
  wire  _T_403;
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
  assign io_in_0_ready = _T_398;
  assign io_in_1_ready = _T_399;
  assign io_in_2_ready = _T_400;
  assign io_in_3_ready = _T_401;
  assign io_in_4_ready = _T_402;
  assign io_in_5_ready = _T_403;
  assign io_out_valid = _GEN_0_valid;
  assign io_out_bits_resp = _GEN_1_bits_resp;
  assign io_out_bits_id = _GEN_2_bits_id;
  assign io_out_bits_user = _GEN_3_bits_user;
  assign io_chosen = choice;
  assign choice = _GEN_39;
  assign _GEN_0_valid = _GEN_25;
  assign _GEN_5 = 3'h1 == io_chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_6 = 3'h1 == io_chosen ? io_in_1_bits_resp : 2'h0;
  assign _GEN_7 = 3'h1 == io_chosen ? io_in_1_bits_id : io_in_0_bits_id;
  assign _GEN_8 = 3'h1 == io_chosen ? io_in_1_bits_user : 1'h0;
  assign _GEN_10 = 3'h2 == io_chosen ? io_in_2_valid : _GEN_5;
  assign _GEN_11 = 3'h2 == io_chosen ? 2'h0 : _GEN_6;
  assign _GEN_12 = 3'h2 == io_chosen ? io_in_2_bits_id : _GEN_7;
  assign _GEN_13 = 3'h2 == io_chosen ? 1'h0 : _GEN_8;
  assign _GEN_15 = 3'h3 == io_chosen ? io_in_3_valid : _GEN_10;
  assign _GEN_16 = 3'h3 == io_chosen ? io_in_3_bits_resp : _GEN_11;
  assign _GEN_17 = 3'h3 == io_chosen ? io_in_3_bits_id : _GEN_12;
  assign _GEN_18 = 3'h3 == io_chosen ? io_in_3_bits_user : _GEN_13;
  assign _GEN_20 = 3'h4 == io_chosen ? io_in_4_valid : _GEN_15;
  assign _GEN_21 = 3'h4 == io_chosen ? 2'h0 : _GEN_16;
  assign _GEN_22 = 3'h4 == io_chosen ? io_in_4_bits_id : _GEN_17;
  assign _GEN_23 = 3'h4 == io_chosen ? 1'h0 : _GEN_18;
  assign _GEN_25 = 3'h5 == io_chosen ? io_in_5_valid : _GEN_20;
  assign _GEN_26 = 3'h5 == io_chosen ? 2'h3 : _GEN_21;
  assign _GEN_27 = 3'h5 == io_chosen ? io_in_5_bits_id : _GEN_22;
  assign _GEN_28 = 3'h5 == io_chosen ? 1'h0 : _GEN_23;
  assign _GEN_1_bits_resp = _GEN_26;
  assign _GEN_2_bits_id = _GEN_27;
  assign _GEN_3_bits_user = _GEN_28;
  assign _T_346 = io_out_ready & io_out_valid;
  assign _GEN_29 = _T_346 ? io_chosen : lastGrant;
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
  assign _T_355 = validMask_1 | validMask_2;
  assign _T_356 = _T_355 | validMask_3;
  assign _T_357 = _T_356 | validMask_4;
  assign _T_358 = _T_357 | validMask_5;
  assign _T_359 = _T_358 | io_in_0_valid;
  assign _T_360 = _T_359 | io_in_1_valid;
  assign _T_361 = _T_360 | io_in_2_valid;
  assign _T_362 = _T_361 | io_in_3_valid;
  assign _T_363 = _T_362 | io_in_4_valid;
  assign _T_367 = validMask_1 == 1'h0;
  assign _T_369 = _T_355 == 1'h0;
  assign _T_371 = _T_356 == 1'h0;
  assign _T_373 = _T_357 == 1'h0;
  assign _T_375 = _T_358 == 1'h0;
  assign _T_377 = _T_359 == 1'h0;
  assign _T_379 = _T_360 == 1'h0;
  assign _T_381 = _T_361 == 1'h0;
  assign _T_383 = _T_362 == 1'h0;
  assign _T_385 = _T_363 == 1'h0;
  assign _T_389 = grantMask_1 | _T_377;
  assign _T_390 = _T_367 & grantMask_2;
  assign _T_391 = _T_390 | _T_379;
  assign _T_392 = _T_369 & grantMask_3;
  assign _T_393 = _T_392 | _T_381;
  assign _T_394 = _T_371 & grantMask_4;
  assign _T_395 = _T_394 | _T_383;
  assign _T_396 = _T_373 & grantMask_5;
  assign _T_397 = _T_396 | _T_385;
  assign _T_398 = _T_375 & io_out_ready;
  assign _T_399 = _T_389 & io_out_ready;
  assign _T_400 = _T_391 & io_out_ready;
  assign _T_401 = _T_393 & io_out_ready;
  assign _T_402 = _T_395 & io_out_ready;
  assign _T_403 = _T_397 & io_out_ready;
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
    if (_T_346) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module HellaPeekingArbiter(
  input         clock,
  input         reset,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_data,
  input  [11:0] io_in_0_bits_id,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [1:0]  io_in_1_bits_resp,
  input  [31:0] io_in_1_bits_data,
  input         io_in_1_bits_last,
  input  [11:0] io_in_1_bits_id,
  input         io_in_1_bits_user,
  output        io_in_2_ready,
  input         io_in_2_valid,
  input  [31:0] io_in_2_bits_data,
  input  [11:0] io_in_2_bits_id,
  output        io_in_3_ready,
  input         io_in_3_valid,
  input  [1:0]  io_in_3_bits_resp,
  input  [31:0] io_in_3_bits_data,
  input         io_in_3_bits_last,
  input  [11:0] io_in_3_bits_id,
  input         io_in_3_bits_user,
  output        io_in_4_ready,
  input         io_in_4_valid,
  input  [31:0] io_in_4_bits_data,
  input  [11:0] io_in_4_bits_id,
  output        io_in_5_ready,
  input         io_in_5_valid,
  input         io_in_5_bits_last,
  input  [11:0] io_in_5_bits_id,
  input         io_out_ready,
  output        io_out_valid,
  output [1:0]  io_out_bits_resp,
  output [31:0] io_out_bits_data,
  output        io_out_bits_last,
  output [11:0] io_out_bits_id,
  output        io_out_bits_user
);
  reg [2:0] lockIdx;
  reg [31:0] _RAND_0;
  reg  locked;
  reg [31:0] _RAND_1;
  wire [2:0] _T_405;
  wire [2:0] _T_406;
  wire [2:0] _T_407;
  wire [2:0] _T_408;
  wire [2:0] choice;
  wire [2:0] chosen;
  wire  _T_410;
  wire  _T_411;
  wire  _T_413;
  wire  _T_414;
  wire  _T_416;
  wire  _T_417;
  wire  _T_419;
  wire  _T_420;
  wire  _T_422;
  wire  _T_423;
  wire  _T_425;
  wire  _T_426;
  wire  _GEN_0_valid;
  wire  _GEN_7;
  wire [1:0] _GEN_8;
  wire [31:0] _GEN_9;
  wire  _GEN_10;
  wire [11:0] _GEN_11;
  wire  _GEN_12;
  wire  _GEN_14;
  wire [1:0] _GEN_15;
  wire [31:0] _GEN_16;
  wire  _GEN_17;
  wire [11:0] _GEN_18;
  wire  _GEN_19;
  wire  _GEN_21;
  wire [1:0] _GEN_22;
  wire [31:0] _GEN_23;
  wire  _GEN_24;
  wire [11:0] _GEN_25;
  wire  _GEN_26;
  wire  _GEN_28;
  wire [1:0] _GEN_29;
  wire [31:0] _GEN_30;
  wire  _GEN_31;
  wire [11:0] _GEN_32;
  wire  _GEN_33;
  wire  _GEN_35;
  wire [1:0] _GEN_36;
  wire [31:0] _GEN_37;
  wire  _GEN_38;
  wire [11:0] _GEN_39;
  wire  _GEN_40;
  wire [1:0] _GEN_1_bits_resp;
  wire [31:0] _GEN_2_bits_data;
  wire  _GEN_3_bits_last;
  wire [11:0] _GEN_4_bits_id;
  wire  _GEN_5_bits_user;
  wire  _T_493;
  wire  _T_495;
  wire [2:0] _GEN_41;
  wire  _GEN_42;
  wire  _GEN_43;
  wire [2:0] _GEN_44;
  wire  _GEN_45;
  assign io_in_0_ready = _T_411;
  assign io_in_1_ready = _T_414;
  assign io_in_2_ready = _T_417;
  assign io_in_3_ready = _T_420;
  assign io_in_4_ready = _T_423;
  assign io_in_5_ready = _T_426;
  assign io_out_valid = _GEN_0_valid;
  assign io_out_bits_resp = _GEN_1_bits_resp;
  assign io_out_bits_data = _GEN_2_bits_data;
  assign io_out_bits_last = _GEN_3_bits_last;
  assign io_out_bits_id = _GEN_4_bits_id;
  assign io_out_bits_user = _GEN_5_bits_user;
  assign _T_405 = io_in_4_valid ? 3'h4 : 3'h5;
  assign _T_406 = io_in_3_valid ? 3'h3 : _T_405;
  assign _T_407 = io_in_2_valid ? 3'h2 : _T_406;
  assign _T_408 = io_in_1_valid ? 3'h1 : _T_407;
  assign choice = io_in_0_valid ? 3'h0 : _T_408;
  assign chosen = locked ? lockIdx : choice;
  assign _T_410 = chosen == 3'h0;
  assign _T_411 = io_out_ready & _T_410;
  assign _T_413 = chosen == 3'h1;
  assign _T_414 = io_out_ready & _T_413;
  assign _T_416 = chosen == 3'h2;
  assign _T_417 = io_out_ready & _T_416;
  assign _T_419 = chosen == 3'h3;
  assign _T_420 = io_out_ready & _T_419;
  assign _T_422 = chosen == 3'h4;
  assign _T_423 = io_out_ready & _T_422;
  assign _T_425 = chosen == 3'h5;
  assign _T_426 = io_out_ready & _T_425;
  assign _GEN_0_valid = _GEN_35;
  assign _GEN_7 = 3'h1 == chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_8 = 3'h1 == chosen ? io_in_1_bits_resp : 2'h0;
  assign _GEN_9 = 3'h1 == chosen ? io_in_1_bits_data : io_in_0_bits_data;
  assign _GEN_10 = 3'h1 == chosen ? io_in_1_bits_last : 1'h1;
  assign _GEN_11 = 3'h1 == chosen ? io_in_1_bits_id : io_in_0_bits_id;
  assign _GEN_12 = 3'h1 == chosen ? io_in_1_bits_user : 1'h0;
  assign _GEN_14 = 3'h2 == chosen ? io_in_2_valid : _GEN_7;
  assign _GEN_15 = 3'h2 == chosen ? 2'h0 : _GEN_8;
  assign _GEN_16 = 3'h2 == chosen ? io_in_2_bits_data : _GEN_9;
  assign _GEN_17 = 3'h2 == chosen ? 1'h1 : _GEN_10;
  assign _GEN_18 = 3'h2 == chosen ? io_in_2_bits_id : _GEN_11;
  assign _GEN_19 = 3'h2 == chosen ? 1'h0 : _GEN_12;
  assign _GEN_21 = 3'h3 == chosen ? io_in_3_valid : _GEN_14;
  assign _GEN_22 = 3'h3 == chosen ? io_in_3_bits_resp : _GEN_15;
  assign _GEN_23 = 3'h3 == chosen ? io_in_3_bits_data : _GEN_16;
  assign _GEN_24 = 3'h3 == chosen ? io_in_3_bits_last : _GEN_17;
  assign _GEN_25 = 3'h3 == chosen ? io_in_3_bits_id : _GEN_18;
  assign _GEN_26 = 3'h3 == chosen ? io_in_3_bits_user : _GEN_19;
  assign _GEN_28 = 3'h4 == chosen ? io_in_4_valid : _GEN_21;
  assign _GEN_29 = 3'h4 == chosen ? 2'h0 : _GEN_22;
  assign _GEN_30 = 3'h4 == chosen ? io_in_4_bits_data : _GEN_23;
  assign _GEN_31 = 3'h4 == chosen ? 1'h1 : _GEN_24;
  assign _GEN_32 = 3'h4 == chosen ? io_in_4_bits_id : _GEN_25;
  assign _GEN_33 = 3'h4 == chosen ? 1'h0 : _GEN_26;
  assign _GEN_35 = 3'h5 == chosen ? io_in_5_valid : _GEN_28;
  assign _GEN_36 = 3'h5 == chosen ? 2'h3 : _GEN_29;
  assign _GEN_37 = 3'h5 == chosen ? 32'h0 : _GEN_30;
  assign _GEN_38 = 3'h5 == chosen ? io_in_5_bits_last : _GEN_31;
  assign _GEN_39 = 3'h5 == chosen ? io_in_5_bits_id : _GEN_32;
  assign _GEN_40 = 3'h5 == chosen ? 1'h0 : _GEN_33;
  assign _GEN_1_bits_resp = _GEN_36;
  assign _GEN_2_bits_data = _GEN_37;
  assign _GEN_3_bits_last = _GEN_38;
  assign _GEN_4_bits_id = _GEN_39;
  assign _GEN_5_bits_user = _GEN_40;
  assign _T_493 = io_out_ready & io_out_valid;
  assign _T_495 = locked == 1'h0;
  assign _GEN_41 = _T_495 ? choice : lockIdx;
  assign _GEN_42 = _T_495 ? 1'h1 : locked;
  assign _GEN_43 = io_out_bits_last ? 1'h0 : _GEN_42;
  assign _GEN_44 = _T_493 ? _GEN_41 : lockIdx;
  assign _GEN_45 = _T_493 ? _GEN_43 : locked;
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
      if (_T_493) begin
        if (_T_495) begin
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
      if (_T_493) begin
        if (io_out_bits_last) begin
          locked <= 1'h0;
        end else begin
          if (_T_495) begin
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
  input  [7:0]  io_master_aw_bits_len,
  input  [11:0] io_master_aw_bits_id,
  output        io_master_w_ready,
  input         io_master_w_valid,
  input  [31:0] io_master_w_bits_data,
  input         io_master_w_bits_last,
  input         io_master_b_ready,
  output        io_master_b_valid,
  output [1:0]  io_master_b_bits_resp,
  output [11:0] io_master_b_bits_id,
  output        io_master_b_bits_user,
  output        io_master_ar_ready,
  input         io_master_ar_valid,
  input  [31:0] io_master_ar_bits_addr,
  input  [7:0]  io_master_ar_bits_len,
  input  [11:0] io_master_ar_bits_id,
  input         io_master_r_ready,
  output        io_master_r_valid,
  output [1:0]  io_master_r_bits_resp,
  output [31:0] io_master_r_bits_data,
  output        io_master_r_bits_last,
  output [11:0] io_master_r_bits_id,
  output        io_master_r_bits_user,
  input         io_slave_0_aw_ready,
  output        io_slave_0_aw_valid,
  output [31:0] io_slave_0_aw_bits_addr,
  output [7:0]  io_slave_0_aw_bits_len,
  output [11:0] io_slave_0_aw_bits_id,
  input         io_slave_0_w_ready,
  output        io_slave_0_w_valid,
  output [31:0] io_slave_0_w_bits_data,
  output        io_slave_0_w_bits_last,
  output        io_slave_0_b_ready,
  input         io_slave_0_b_valid,
  input  [11:0] io_slave_0_b_bits_id,
  input         io_slave_0_ar_ready,
  output        io_slave_0_ar_valid,
  output [31:0] io_slave_0_ar_bits_addr,
  output [7:0]  io_slave_0_ar_bits_len,
  output [11:0] io_slave_0_ar_bits_id,
  output        io_slave_0_r_ready,
  input         io_slave_0_r_valid,
  input  [31:0] io_slave_0_r_bits_data,
  input  [11:0] io_slave_0_r_bits_id,
  input         io_slave_1_aw_ready,
  output        io_slave_1_aw_valid,
  output [31:0] io_slave_1_aw_bits_addr,
  output [7:0]  io_slave_1_aw_bits_len,
  output [11:0] io_slave_1_aw_bits_id,
  input         io_slave_1_w_ready,
  output        io_slave_1_w_valid,
  output [31:0] io_slave_1_w_bits_data,
  output        io_slave_1_w_bits_last,
  output        io_slave_1_b_ready,
  input         io_slave_1_b_valid,
  input  [1:0]  io_slave_1_b_bits_resp,
  input  [11:0] io_slave_1_b_bits_id,
  input         io_slave_1_b_bits_user,
  input         io_slave_1_ar_ready,
  output        io_slave_1_ar_valid,
  output [31:0] io_slave_1_ar_bits_addr,
  output [7:0]  io_slave_1_ar_bits_len,
  output [11:0] io_slave_1_ar_bits_id,
  output        io_slave_1_r_ready,
  input         io_slave_1_r_valid,
  input  [1:0]  io_slave_1_r_bits_resp,
  input  [31:0] io_slave_1_r_bits_data,
  input         io_slave_1_r_bits_last,
  input  [11:0] io_slave_1_r_bits_id,
  input         io_slave_1_r_bits_user,
  input         io_slave_2_aw_ready,
  output        io_slave_2_aw_valid,
  output [31:0] io_slave_2_aw_bits_addr,
  output [7:0]  io_slave_2_aw_bits_len,
  output [11:0] io_slave_2_aw_bits_id,
  input         io_slave_2_w_ready,
  output        io_slave_2_w_valid,
  output [31:0] io_slave_2_w_bits_data,
  output        io_slave_2_w_bits_last,
  output        io_slave_2_b_ready,
  input         io_slave_2_b_valid,
  input  [11:0] io_slave_2_b_bits_id,
  input         io_slave_2_ar_ready,
  output        io_slave_2_ar_valid,
  output [31:0] io_slave_2_ar_bits_addr,
  output [7:0]  io_slave_2_ar_bits_len,
  output [11:0] io_slave_2_ar_bits_id,
  output        io_slave_2_r_ready,
  input         io_slave_2_r_valid,
  input  [31:0] io_slave_2_r_bits_data,
  input  [11:0] io_slave_2_r_bits_id,
  input         io_slave_3_aw_ready,
  output        io_slave_3_aw_valid,
  output [31:0] io_slave_3_aw_bits_addr,
  output [7:0]  io_slave_3_aw_bits_len,
  output [11:0] io_slave_3_aw_bits_id,
  input         io_slave_3_w_ready,
  output        io_slave_3_w_valid,
  output [31:0] io_slave_3_w_bits_data,
  output        io_slave_3_w_bits_last,
  output        io_slave_3_b_ready,
  input         io_slave_3_b_valid,
  input  [1:0]  io_slave_3_b_bits_resp,
  input  [11:0] io_slave_3_b_bits_id,
  input         io_slave_3_b_bits_user,
  input         io_slave_3_ar_ready,
  output        io_slave_3_ar_valid,
  output [31:0] io_slave_3_ar_bits_addr,
  output [7:0]  io_slave_3_ar_bits_len,
  output [11:0] io_slave_3_ar_bits_id,
  output        io_slave_3_r_ready,
  input         io_slave_3_r_valid,
  input  [1:0]  io_slave_3_r_bits_resp,
  input  [31:0] io_slave_3_r_bits_data,
  input         io_slave_3_r_bits_last,
  input  [11:0] io_slave_3_r_bits_id,
  input         io_slave_3_r_bits_user,
  input         io_slave_4_aw_ready,
  output        io_slave_4_aw_valid,
  output [31:0] io_slave_4_aw_bits_addr,
  output [7:0]  io_slave_4_aw_bits_len,
  output [11:0] io_slave_4_aw_bits_id,
  input         io_slave_4_w_ready,
  output        io_slave_4_w_valid,
  output [31:0] io_slave_4_w_bits_data,
  output        io_slave_4_w_bits_last,
  output        io_slave_4_b_ready,
  input         io_slave_4_b_valid,
  input  [11:0] io_slave_4_b_bits_id,
  input         io_slave_4_ar_ready,
  output        io_slave_4_ar_valid,
  output [31:0] io_slave_4_ar_bits_addr,
  output [7:0]  io_slave_4_ar_bits_len,
  output [11:0] io_slave_4_ar_bits_id,
  output        io_slave_4_r_ready,
  input         io_slave_4_r_valid,
  input  [31:0] io_slave_4_r_bits_data,
  input  [11:0] io_slave_4_r_bits_id
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
  reg  _T_1653;
  reg [31:0] _RAND_0;
  wire  _T_1654;
  wire  _T_1655;
  wire  _GEN_0;
  wire  _T_1657;
  wire  _GEN_1;
  wire  _T_1659;
  wire  _T_1660;
  wire  _T_1662;
  wire  _T_1663;
  wire  _T_1665;
  wire  _T_1666;
  wire  _T_1667;
  wire  _T_1668;
  wire  _T_1670;
  wire  _T_1671;
  reg  _T_1674;
  reg [31:0] _RAND_1;
  wire  _T_1675;
  wire  _T_1676;
  wire  _GEN_2;
  wire  _T_1678;
  wire  _GEN_3;
  wire  _T_1680;
  wire  _T_1681;
  wire  _T_1682;
  wire  _T_1683;
  wire  _T_1684;
  wire  _T_1686;
  wire  _T_1687;
  wire  _T_1688;
  wire  _T_1689;
  wire  _T_1691;
  wire  _T_1692;
  reg  _T_1695;
  reg [31:0] _RAND_2;
  wire  _T_1696;
  wire  _T_1697;
  wire  _GEN_4;
  wire  _T_1699;
  wire  _GEN_5;
  wire  _T_1701;
  wire  _T_1702;
  wire  _T_1703;
  wire  _T_1704;
  wire  _T_1705;
  wire  _T_1707;
  wire  _T_1708;
  wire  _T_1709;
  wire  _T_1710;
  wire  _T_1712;
  wire  _T_1713;
  reg  _T_1716;
  reg [31:0] _RAND_3;
  wire  _T_1717;
  wire  _T_1718;
  wire  _GEN_6;
  wire  _T_1720;
  wire  _GEN_7;
  wire  _T_1722;
  wire  _T_1723;
  wire  _T_1724;
  wire  _T_1725;
  wire  _T_1726;
  wire  _T_1728;
  wire  ar_ready;
  wire  _T_1729;
  wire  _T_1730;
  wire  _T_1732;
  wire  aw_ready;
  reg  _T_1735;
  reg [31:0] _RAND_4;
  wire  _T_1736;
  wire  _T_1737;
  wire  _GEN_8;
  wire  _T_1739;
  wire  _GEN_9;
  wire  _T_1741;
  wire  _T_1742;
  wire  w_ready;
  wire  _T_1744;
  wire  r_invalid;
  wire  _T_1747;
  wire  w_invalid;
  wire  err_slave_clock;
  wire  err_slave_reset;
  wire  err_slave_io_aw_ready;
  wire  err_slave_io_aw_valid;
  wire [31:0] err_slave_io_aw_bits_addr;
  wire [11:0] err_slave_io_aw_bits_id;
  wire  err_slave_io_w_ready;
  wire  err_slave_io_w_valid;
  wire  err_slave_io_w_bits_last;
  wire  err_slave_io_b_ready;
  wire  err_slave_io_b_valid;
  wire [11:0] err_slave_io_b_bits_id;
  wire  err_slave_io_ar_ready;
  wire  err_slave_io_ar_valid;
  wire [31:0] err_slave_io_ar_bits_addr;
  wire [7:0] err_slave_io_ar_bits_len;
  wire [11:0] err_slave_io_ar_bits_id;
  wire  err_slave_io_r_ready;
  wire  err_slave_io_r_valid;
  wire  err_slave_io_r_bits_last;
  wire [11:0] err_slave_io_r_bits_id;
  wire  _T_1749;
  wire  _T_1750;
  wire  _T_1751;
  wire  _T_1752;
  wire  _T_1753;
  wire  _T_1754;
  wire  _T_1755;
  wire  b_arb_clock;
  wire  b_arb_io_in_0_ready;
  wire  b_arb_io_in_0_valid;
  wire [11:0] b_arb_io_in_0_bits_id;
  wire  b_arb_io_in_1_ready;
  wire  b_arb_io_in_1_valid;
  wire [1:0] b_arb_io_in_1_bits_resp;
  wire [11:0] b_arb_io_in_1_bits_id;
  wire  b_arb_io_in_1_bits_user;
  wire  b_arb_io_in_2_ready;
  wire  b_arb_io_in_2_valid;
  wire [11:0] b_arb_io_in_2_bits_id;
  wire  b_arb_io_in_3_ready;
  wire  b_arb_io_in_3_valid;
  wire [1:0] b_arb_io_in_3_bits_resp;
  wire [11:0] b_arb_io_in_3_bits_id;
  wire  b_arb_io_in_3_bits_user;
  wire  b_arb_io_in_4_ready;
  wire  b_arb_io_in_4_valid;
  wire [11:0] b_arb_io_in_4_bits_id;
  wire  b_arb_io_in_5_ready;
  wire  b_arb_io_in_5_valid;
  wire [11:0] b_arb_io_in_5_bits_id;
  wire  b_arb_io_out_ready;
  wire  b_arb_io_out_valid;
  wire [1:0] b_arb_io_out_bits_resp;
  wire [11:0] b_arb_io_out_bits_id;
  wire  b_arb_io_out_bits_user;
  wire [2:0] b_arb_io_chosen;
  wire  r_arb_clock;
  wire  r_arb_reset;
  wire  r_arb_io_in_0_ready;
  wire  r_arb_io_in_0_valid;
  wire [31:0] r_arb_io_in_0_bits_data;
  wire [11:0] r_arb_io_in_0_bits_id;
  wire  r_arb_io_in_1_ready;
  wire  r_arb_io_in_1_valid;
  wire [1:0] r_arb_io_in_1_bits_resp;
  wire [31:0] r_arb_io_in_1_bits_data;
  wire  r_arb_io_in_1_bits_last;
  wire [11:0] r_arb_io_in_1_bits_id;
  wire  r_arb_io_in_1_bits_user;
  wire  r_arb_io_in_2_ready;
  wire  r_arb_io_in_2_valid;
  wire [31:0] r_arb_io_in_2_bits_data;
  wire [11:0] r_arb_io_in_2_bits_id;
  wire  r_arb_io_in_3_ready;
  wire  r_arb_io_in_3_valid;
  wire [1:0] r_arb_io_in_3_bits_resp;
  wire [31:0] r_arb_io_in_3_bits_data;
  wire  r_arb_io_in_3_bits_last;
  wire [11:0] r_arb_io_in_3_bits_id;
  wire  r_arb_io_in_3_bits_user;
  wire  r_arb_io_in_4_ready;
  wire  r_arb_io_in_4_valid;
  wire [31:0] r_arb_io_in_4_bits_data;
  wire [11:0] r_arb_io_in_4_bits_id;
  wire  r_arb_io_in_5_ready;
  wire  r_arb_io_in_5_valid;
  wire  r_arb_io_in_5_bits_last;
  wire [11:0] r_arb_io_in_5_bits_id;
  wire  r_arb_io_out_ready;
  wire  r_arb_io_out_valid;
  wire [1:0] r_arb_io_out_bits_resp;
  wire [31:0] r_arb_io_out_bits_data;
  wire  r_arb_io_out_bits_last;
  wire [11:0] r_arb_io_out_bits_id;
  wire  r_arb_io_out_bits_user;
  NastiErrorSlave err_slave (
    .clock(err_slave_clock),
    .reset(err_slave_reset),
    .io_aw_ready(err_slave_io_aw_ready),
    .io_aw_valid(err_slave_io_aw_valid),
    .io_aw_bits_addr(err_slave_io_aw_bits_addr),
    .io_aw_bits_id(err_slave_io_aw_bits_id),
    .io_w_ready(err_slave_io_w_ready),
    .io_w_valid(err_slave_io_w_valid),
    .io_w_bits_last(err_slave_io_w_bits_last),
    .io_b_ready(err_slave_io_b_ready),
    .io_b_valid(err_slave_io_b_valid),
    .io_b_bits_id(err_slave_io_b_bits_id),
    .io_ar_ready(err_slave_io_ar_ready),
    .io_ar_valid(err_slave_io_ar_valid),
    .io_ar_bits_addr(err_slave_io_ar_bits_addr),
    .io_ar_bits_len(err_slave_io_ar_bits_len),
    .io_ar_bits_id(err_slave_io_ar_bits_id),
    .io_r_ready(err_slave_io_r_ready),
    .io_r_valid(err_slave_io_r_valid),
    .io_r_bits_last(err_slave_io_r_bits_last),
    .io_r_bits_id(err_slave_io_r_bits_id)
  );
  RRArbiter b_arb (
    .clock(b_arb_clock),
    .io_in_0_ready(b_arb_io_in_0_ready),
    .io_in_0_valid(b_arb_io_in_0_valid),
    .io_in_0_bits_id(b_arb_io_in_0_bits_id),
    .io_in_1_ready(b_arb_io_in_1_ready),
    .io_in_1_valid(b_arb_io_in_1_valid),
    .io_in_1_bits_resp(b_arb_io_in_1_bits_resp),
    .io_in_1_bits_id(b_arb_io_in_1_bits_id),
    .io_in_1_bits_user(b_arb_io_in_1_bits_user),
    .io_in_2_ready(b_arb_io_in_2_ready),
    .io_in_2_valid(b_arb_io_in_2_valid),
    .io_in_2_bits_id(b_arb_io_in_2_bits_id),
    .io_in_3_ready(b_arb_io_in_3_ready),
    .io_in_3_valid(b_arb_io_in_3_valid),
    .io_in_3_bits_resp(b_arb_io_in_3_bits_resp),
    .io_in_3_bits_id(b_arb_io_in_3_bits_id),
    .io_in_3_bits_user(b_arb_io_in_3_bits_user),
    .io_in_4_ready(b_arb_io_in_4_ready),
    .io_in_4_valid(b_arb_io_in_4_valid),
    .io_in_4_bits_id(b_arb_io_in_4_bits_id),
    .io_in_5_ready(b_arb_io_in_5_ready),
    .io_in_5_valid(b_arb_io_in_5_valid),
    .io_in_5_bits_id(b_arb_io_in_5_bits_id),
    .io_out_ready(b_arb_io_out_ready),
    .io_out_valid(b_arb_io_out_valid),
    .io_out_bits_resp(b_arb_io_out_bits_resp),
    .io_out_bits_id(b_arb_io_out_bits_id),
    .io_out_bits_user(b_arb_io_out_bits_user),
    .io_chosen(b_arb_io_chosen)
  );
  HellaPeekingArbiter r_arb (
    .clock(r_arb_clock),
    .reset(r_arb_reset),
    .io_in_0_ready(r_arb_io_in_0_ready),
    .io_in_0_valid(r_arb_io_in_0_valid),
    .io_in_0_bits_data(r_arb_io_in_0_bits_data),
    .io_in_0_bits_id(r_arb_io_in_0_bits_id),
    .io_in_1_ready(r_arb_io_in_1_ready),
    .io_in_1_valid(r_arb_io_in_1_valid),
    .io_in_1_bits_resp(r_arb_io_in_1_bits_resp),
    .io_in_1_bits_data(r_arb_io_in_1_bits_data),
    .io_in_1_bits_last(r_arb_io_in_1_bits_last),
    .io_in_1_bits_id(r_arb_io_in_1_bits_id),
    .io_in_1_bits_user(r_arb_io_in_1_bits_user),
    .io_in_2_ready(r_arb_io_in_2_ready),
    .io_in_2_valid(r_arb_io_in_2_valid),
    .io_in_2_bits_data(r_arb_io_in_2_bits_data),
    .io_in_2_bits_id(r_arb_io_in_2_bits_id),
    .io_in_3_ready(r_arb_io_in_3_ready),
    .io_in_3_valid(r_arb_io_in_3_valid),
    .io_in_3_bits_resp(r_arb_io_in_3_bits_resp),
    .io_in_3_bits_data(r_arb_io_in_3_bits_data),
    .io_in_3_bits_last(r_arb_io_in_3_bits_last),
    .io_in_3_bits_id(r_arb_io_in_3_bits_id),
    .io_in_3_bits_user(r_arb_io_in_3_bits_user),
    .io_in_4_ready(r_arb_io_in_4_ready),
    .io_in_4_valid(r_arb_io_in_4_valid),
    .io_in_4_bits_data(r_arb_io_in_4_bits_data),
    .io_in_4_bits_id(r_arb_io_in_4_bits_id),
    .io_in_5_ready(r_arb_io_in_5_ready),
    .io_in_5_valid(r_arb_io_in_5_valid),
    .io_in_5_bits_last(r_arb_io_in_5_bits_last),
    .io_in_5_bits_id(r_arb_io_in_5_bits_id),
    .io_out_ready(r_arb_io_out_ready),
    .io_out_valid(r_arb_io_out_valid),
    .io_out_bits_resp(r_arb_io_out_bits_resp),
    .io_out_bits_data(r_arb_io_out_bits_data),
    .io_out_bits_last(r_arb_io_out_bits_last),
    .io_out_bits_id(r_arb_io_out_bits_id),
    .io_out_bits_user(r_arb_io_out_bits_user)
  );
  assign io_master_aw_ready = _T_1754;
  assign io_master_w_ready = _T_1755;
  assign io_master_b_valid = b_arb_io_out_valid;
  assign io_master_b_bits_resp = b_arb_io_out_bits_resp;
  assign io_master_b_bits_id = b_arb_io_out_bits_id;
  assign io_master_b_bits_user = b_arb_io_out_bits_user;
  assign io_master_ar_ready = _T_1752;
  assign io_master_r_valid = r_arb_io_out_valid;
  assign io_master_r_bits_resp = r_arb_io_out_bits_resp;
  assign io_master_r_bits_data = r_arb_io_out_bits_data;
  assign io_master_r_bits_last = r_arb_io_out_bits_last;
  assign io_master_r_bits_id = r_arb_io_out_bits_id;
  assign io_master_r_bits_user = r_arb_io_out_bits_user;
  assign io_slave_0_aw_valid = _T_1647;
  assign io_slave_0_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_0_aw_bits_len = io_master_aw_bits_len;
  assign io_slave_0_aw_bits_id = io_master_aw_bits_id;
  assign io_slave_0_w_valid = _T_1659;
  assign io_slave_0_w_bits_data = io_master_w_bits_data;
  assign io_slave_0_w_bits_last = io_master_w_bits_last;
  assign io_slave_0_b_ready = b_arb_io_in_0_ready;
  assign io_slave_0_ar_valid = _T_1642;
  assign io_slave_0_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_0_ar_bits_len = io_master_ar_bits_len;
  assign io_slave_0_ar_bits_id = io_master_ar_bits_id;
  assign io_slave_0_r_ready = r_arb_io_in_0_ready;
  assign io_slave_1_aw_valid = _T_1668;
  assign io_slave_1_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_1_aw_bits_len = io_master_aw_bits_len;
  assign io_slave_1_aw_bits_id = io_master_aw_bits_id;
  assign io_slave_1_w_valid = _T_1680;
  assign io_slave_1_w_bits_data = io_master_w_bits_data;
  assign io_slave_1_w_bits_last = io_master_w_bits_last;
  assign io_slave_1_b_ready = b_arb_io_in_1_ready;
  assign io_slave_1_ar_valid = _T_1663;
  assign io_slave_1_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_1_ar_bits_len = io_master_ar_bits_len;
  assign io_slave_1_ar_bits_id = io_master_ar_bits_id;
  assign io_slave_1_r_ready = r_arb_io_in_1_ready;
  assign io_slave_2_aw_valid = _T_1689;
  assign io_slave_2_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_2_aw_bits_len = io_master_aw_bits_len;
  assign io_slave_2_aw_bits_id = io_master_aw_bits_id;
  assign io_slave_2_w_valid = _T_1701;
  assign io_slave_2_w_bits_data = io_master_w_bits_data;
  assign io_slave_2_w_bits_last = io_master_w_bits_last;
  assign io_slave_2_b_ready = b_arb_io_in_2_ready;
  assign io_slave_2_ar_valid = _T_1684;
  assign io_slave_2_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_2_ar_bits_len = io_master_ar_bits_len;
  assign io_slave_2_ar_bits_id = io_master_ar_bits_id;
  assign io_slave_2_r_ready = r_arb_io_in_2_ready;
  assign io_slave_3_aw_valid = _T_1710;
  assign io_slave_3_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_3_aw_bits_len = io_master_aw_bits_len;
  assign io_slave_3_aw_bits_id = io_master_aw_bits_id;
  assign io_slave_3_w_valid = _T_1722;
  assign io_slave_3_w_bits_data = io_master_w_bits_data;
  assign io_slave_3_w_bits_last = io_master_w_bits_last;
  assign io_slave_3_b_ready = b_arb_io_in_3_ready;
  assign io_slave_3_ar_valid = _T_1705;
  assign io_slave_3_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_3_ar_bits_len = io_master_ar_bits_len;
  assign io_slave_3_ar_bits_id = io_master_ar_bits_id;
  assign io_slave_3_r_ready = r_arb_io_in_3_ready;
  assign io_slave_4_aw_valid = _T_1730;
  assign io_slave_4_aw_bits_addr = io_master_aw_bits_addr;
  assign io_slave_4_aw_bits_len = io_master_aw_bits_len;
  assign io_slave_4_aw_bits_id = io_master_aw_bits_id;
  assign io_slave_4_w_valid = _T_1741;
  assign io_slave_4_w_bits_data = io_master_w_bits_data;
  assign io_slave_4_w_bits_last = io_master_w_bits_last;
  assign io_slave_4_b_ready = b_arb_io_in_4_ready;
  assign io_slave_4_ar_valid = _T_1726;
  assign io_slave_4_ar_bits_addr = io_master_ar_bits_addr;
  assign io_slave_4_ar_bits_len = io_master_ar_bits_len;
  assign io_slave_4_ar_bits_id = io_master_ar_bits_id;
  assign io_slave_4_r_ready = r_arb_io_in_4_ready;
  assign _T_1585 = io_master_ar_bits_addr < 32'h40;
  assign _T_1588 = 32'h40 <= io_master_ar_bits_addr;
  assign _T_1590 = io_master_ar_bits_addr < 32'h50;
  assign _T_1591 = _T_1588 & _T_1590;
  assign _T_1593 = 32'h50 <= io_master_ar_bits_addr;
  assign _T_1595 = io_master_ar_bits_addr < 32'h60;
  assign _T_1596 = _T_1593 & _T_1595;
  assign _T_1598 = 32'h60 <= io_master_ar_bits_addr;
  assign _T_1600 = io_master_ar_bits_addr < 32'h70;
  assign _T_1601 = _T_1598 & _T_1600;
  assign _T_1603 = 32'h70 <= io_master_ar_bits_addr;
  assign _T_1605 = io_master_ar_bits_addr < 32'h80;
  assign _T_1606 = _T_1603 & _T_1605;
  assign _T_1607 = {_T_1591,_T_1585};
  assign _T_1608 = {_T_1606,_T_1601};
  assign _T_1609 = {_T_1608,_T_1596};
  assign ar_route = {_T_1609,_T_1607};
  assign _T_1613 = io_master_aw_bits_addr < 32'h40;
  assign _T_1616 = 32'h40 <= io_master_aw_bits_addr;
  assign _T_1618 = io_master_aw_bits_addr < 32'h50;
  assign _T_1619 = _T_1616 & _T_1618;
  assign _T_1621 = 32'h50 <= io_master_aw_bits_addr;
  assign _T_1623 = io_master_aw_bits_addr < 32'h60;
  assign _T_1624 = _T_1621 & _T_1623;
  assign _T_1626 = 32'h60 <= io_master_aw_bits_addr;
  assign _T_1628 = io_master_aw_bits_addr < 32'h70;
  assign _T_1629 = _T_1626 & _T_1628;
  assign _T_1631 = 32'h70 <= io_master_aw_bits_addr;
  assign _T_1633 = io_master_aw_bits_addr < 32'h80;
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
  assign _T_1654 = io_slave_0_w_ready & io_slave_0_w_valid;
  assign _T_1655 = _T_1654 & io_slave_0_w_bits_last;
  assign _GEN_0 = _T_1655 ? 1'h0 : _T_1653;
  assign _T_1657 = io_slave_0_aw_ready & io_slave_0_aw_valid;
  assign _GEN_1 = _T_1657 ? 1'h1 : _GEN_0;
  assign _T_1659 = io_master_w_valid & _T_1653;
  assign _T_1660 = io_slave_0_w_ready & _T_1653;
  assign _T_1662 = ar_route[1];
  assign _T_1663 = io_master_ar_valid & _T_1662;
  assign _T_1665 = io_slave_1_ar_ready & _T_1662;
  assign _T_1666 = _T_1644 | _T_1665;
  assign _T_1667 = aw_route[1];
  assign _T_1668 = io_master_aw_valid & _T_1667;
  assign _T_1670 = io_slave_1_aw_ready & _T_1667;
  assign _T_1671 = _T_1649 | _T_1670;
  assign _T_1675 = io_slave_1_w_ready & io_slave_1_w_valid;
  assign _T_1676 = _T_1675 & io_slave_1_w_bits_last;
  assign _GEN_2 = _T_1676 ? 1'h0 : _T_1674;
  assign _T_1678 = io_slave_1_aw_ready & io_slave_1_aw_valid;
  assign _GEN_3 = _T_1678 ? 1'h1 : _GEN_2;
  assign _T_1680 = io_master_w_valid & _T_1674;
  assign _T_1681 = io_slave_1_w_ready & _T_1674;
  assign _T_1682 = _T_1660 | _T_1681;
  assign _T_1683 = ar_route[2];
  assign _T_1684 = io_master_ar_valid & _T_1683;
  assign _T_1686 = io_slave_2_ar_ready & _T_1683;
  assign _T_1687 = _T_1666 | _T_1686;
  assign _T_1688 = aw_route[2];
  assign _T_1689 = io_master_aw_valid & _T_1688;
  assign _T_1691 = io_slave_2_aw_ready & _T_1688;
  assign _T_1692 = _T_1671 | _T_1691;
  assign _T_1696 = io_slave_2_w_ready & io_slave_2_w_valid;
  assign _T_1697 = _T_1696 & io_slave_2_w_bits_last;
  assign _GEN_4 = _T_1697 ? 1'h0 : _T_1695;
  assign _T_1699 = io_slave_2_aw_ready & io_slave_2_aw_valid;
  assign _GEN_5 = _T_1699 ? 1'h1 : _GEN_4;
  assign _T_1701 = io_master_w_valid & _T_1695;
  assign _T_1702 = io_slave_2_w_ready & _T_1695;
  assign _T_1703 = _T_1682 | _T_1702;
  assign _T_1704 = ar_route[3];
  assign _T_1705 = io_master_ar_valid & _T_1704;
  assign _T_1707 = io_slave_3_ar_ready & _T_1704;
  assign _T_1708 = _T_1687 | _T_1707;
  assign _T_1709 = aw_route[3];
  assign _T_1710 = io_master_aw_valid & _T_1709;
  assign _T_1712 = io_slave_3_aw_ready & _T_1709;
  assign _T_1713 = _T_1692 | _T_1712;
  assign _T_1717 = io_slave_3_w_ready & io_slave_3_w_valid;
  assign _T_1718 = _T_1717 & io_slave_3_w_bits_last;
  assign _GEN_6 = _T_1718 ? 1'h0 : _T_1716;
  assign _T_1720 = io_slave_3_aw_ready & io_slave_3_aw_valid;
  assign _GEN_7 = _T_1720 ? 1'h1 : _GEN_6;
  assign _T_1722 = io_master_w_valid & _T_1716;
  assign _T_1723 = io_slave_3_w_ready & _T_1716;
  assign _T_1724 = _T_1703 | _T_1723;
  assign _T_1725 = ar_route[4];
  assign _T_1726 = io_master_ar_valid & _T_1725;
  assign _T_1728 = io_slave_4_ar_ready & _T_1725;
  assign ar_ready = _T_1708 | _T_1728;
  assign _T_1729 = aw_route[4];
  assign _T_1730 = io_master_aw_valid & _T_1729;
  assign _T_1732 = io_slave_4_aw_ready & _T_1729;
  assign aw_ready = _T_1713 | _T_1732;
  assign _T_1736 = io_slave_4_w_ready & io_slave_4_w_valid;
  assign _T_1737 = _T_1736 & io_slave_4_w_bits_last;
  assign _GEN_8 = _T_1737 ? 1'h0 : _T_1735;
  assign _T_1739 = io_slave_4_aw_ready & io_slave_4_aw_valid;
  assign _GEN_9 = _T_1739 ? 1'h1 : _GEN_8;
  assign _T_1741 = io_master_w_valid & _T_1735;
  assign _T_1742 = io_slave_4_w_ready & _T_1735;
  assign w_ready = _T_1724 | _T_1742;
  assign _T_1744 = ar_route != 5'h0;
  assign r_invalid = _T_1744 == 1'h0;
  assign _T_1747 = aw_route != 5'h0;
  assign w_invalid = _T_1747 == 1'h0;
  assign err_slave_clock = clock;
  assign err_slave_reset = reset;
  assign err_slave_io_aw_valid = _T_1750;
  assign err_slave_io_aw_bits_addr = io_master_aw_bits_addr;
  assign err_slave_io_aw_bits_id = io_master_aw_bits_id;
  assign err_slave_io_w_valid = io_master_w_valid;
  assign err_slave_io_w_bits_last = io_master_w_bits_last;
  assign err_slave_io_b_ready = b_arb_io_in_5_ready;
  assign err_slave_io_ar_valid = _T_1749;
  assign err_slave_io_ar_bits_addr = io_master_ar_bits_addr;
  assign err_slave_io_ar_bits_len = io_master_ar_bits_len;
  assign err_slave_io_ar_bits_id = io_master_ar_bits_id;
  assign err_slave_io_r_ready = r_arb_io_in_5_ready;
  assign _T_1749 = r_invalid & io_master_ar_valid;
  assign _T_1750 = w_invalid & io_master_aw_valid;
  assign _T_1751 = r_invalid & err_slave_io_ar_ready;
  assign _T_1752 = ar_ready | _T_1751;
  assign _T_1753 = w_invalid & err_slave_io_aw_ready;
  assign _T_1754 = aw_ready | _T_1753;
  assign _T_1755 = w_ready | err_slave_io_w_ready;
  assign b_arb_clock = clock;
  assign b_arb_io_in_0_valid = io_slave_0_b_valid;
  assign b_arb_io_in_0_bits_id = io_slave_0_b_bits_id;
  assign b_arb_io_in_1_valid = io_slave_1_b_valid;
  assign b_arb_io_in_1_bits_resp = io_slave_1_b_bits_resp;
  assign b_arb_io_in_1_bits_id = io_slave_1_b_bits_id;
  assign b_arb_io_in_1_bits_user = io_slave_1_b_bits_user;
  assign b_arb_io_in_2_valid = io_slave_2_b_valid;
  assign b_arb_io_in_2_bits_id = io_slave_2_b_bits_id;
  assign b_arb_io_in_3_valid = io_slave_3_b_valid;
  assign b_arb_io_in_3_bits_resp = io_slave_3_b_bits_resp;
  assign b_arb_io_in_3_bits_id = io_slave_3_b_bits_id;
  assign b_arb_io_in_3_bits_user = io_slave_3_b_bits_user;
  assign b_arb_io_in_4_valid = io_slave_4_b_valid;
  assign b_arb_io_in_4_bits_id = io_slave_4_b_bits_id;
  assign b_arb_io_in_5_valid = err_slave_io_b_valid;
  assign b_arb_io_in_5_bits_id = err_slave_io_b_bits_id;
  assign b_arb_io_out_ready = io_master_b_ready;
  assign r_arb_clock = clock;
  assign r_arb_reset = reset;
  assign r_arb_io_in_0_valid = io_slave_0_r_valid;
  assign r_arb_io_in_0_bits_data = io_slave_0_r_bits_data;
  assign r_arb_io_in_0_bits_id = io_slave_0_r_bits_id;
  assign r_arb_io_in_1_valid = io_slave_1_r_valid;
  assign r_arb_io_in_1_bits_resp = io_slave_1_r_bits_resp;
  assign r_arb_io_in_1_bits_data = io_slave_1_r_bits_data;
  assign r_arb_io_in_1_bits_last = io_slave_1_r_bits_last;
  assign r_arb_io_in_1_bits_id = io_slave_1_r_bits_id;
  assign r_arb_io_in_1_bits_user = io_slave_1_r_bits_user;
  assign r_arb_io_in_2_valid = io_slave_2_r_valid;
  assign r_arb_io_in_2_bits_data = io_slave_2_r_bits_data;
  assign r_arb_io_in_2_bits_id = io_slave_2_r_bits_id;
  assign r_arb_io_in_3_valid = io_slave_3_r_valid;
  assign r_arb_io_in_3_bits_resp = io_slave_3_r_bits_resp;
  assign r_arb_io_in_3_bits_data = io_slave_3_r_bits_data;
  assign r_arb_io_in_3_bits_last = io_slave_3_r_bits_last;
  assign r_arb_io_in_3_bits_id = io_slave_3_r_bits_id;
  assign r_arb_io_in_3_bits_user = io_slave_3_r_bits_user;
  assign r_arb_io_in_4_valid = io_slave_4_r_valid;
  assign r_arb_io_in_4_bits_data = io_slave_4_r_bits_data;
  assign r_arb_io_in_4_bits_id = io_slave_4_r_bits_id;
  assign r_arb_io_in_5_valid = err_slave_io_r_valid;
  assign r_arb_io_in_5_bits_last = err_slave_io_r_bits_last;
  assign r_arb_io_in_5_bits_id = err_slave_io_r_bits_id;
  assign r_arb_io_out_ready = io_master_r_ready;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  _T_1653 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  _T_1674 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  _T_1695 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{$random}};
  _T_1716 = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{$random}};
  _T_1735 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      _T_1653 <= 1'h0;
    end else begin
      if (_T_1657) begin
        _T_1653 <= 1'h1;
      end else begin
        if (_T_1655) begin
          _T_1653 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1674 <= 1'h0;
    end else begin
      if (_T_1678) begin
        _T_1674 <= 1'h1;
      end else begin
        if (_T_1676) begin
          _T_1674 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1695 <= 1'h0;
    end else begin
      if (_T_1699) begin
        _T_1695 <= 1'h1;
      end else begin
        if (_T_1697) begin
          _T_1695 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1716 <= 1'h0;
    end else begin
      if (_T_1720) begin
        _T_1716 <= 1'h1;
      end else begin
        if (_T_1718) begin
          _T_1716 <= 1'h0;
        end
      end
    end
    if (reset) begin
      _T_1735 <= 1'h0;
    end else begin
      if (_T_1739) begin
        _T_1735 <= 1'h1;
      end else begin
        if (_T_1737) begin
          _T_1735 <= 1'h0;
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
  input  [7:0]  io_masters_0_aw_bits_len,
  input  [11:0] io_masters_0_aw_bits_id,
  output        io_masters_0_w_ready,
  input         io_masters_0_w_valid,
  input  [31:0] io_masters_0_w_bits_data,
  input         io_masters_0_w_bits_last,
  input         io_masters_0_b_ready,
  output        io_masters_0_b_valid,
  output [1:0]  io_masters_0_b_bits_resp,
  output [11:0] io_masters_0_b_bits_id,
  output        io_masters_0_b_bits_user,
  output        io_masters_0_ar_ready,
  input         io_masters_0_ar_valid,
  input  [31:0] io_masters_0_ar_bits_addr,
  input  [7:0]  io_masters_0_ar_bits_len,
  input  [11:0] io_masters_0_ar_bits_id,
  input         io_masters_0_r_ready,
  output        io_masters_0_r_valid,
  output [1:0]  io_masters_0_r_bits_resp,
  output [31:0] io_masters_0_r_bits_data,
  output        io_masters_0_r_bits_last,
  output [11:0] io_masters_0_r_bits_id,
  output        io_masters_0_r_bits_user,
  input         io_slaves_0_aw_ready,
  output        io_slaves_0_aw_valid,
  output [31:0] io_slaves_0_aw_bits_addr,
  output [7:0]  io_slaves_0_aw_bits_len,
  output [11:0] io_slaves_0_aw_bits_id,
  input         io_slaves_0_w_ready,
  output        io_slaves_0_w_valid,
  output [31:0] io_slaves_0_w_bits_data,
  output        io_slaves_0_b_ready,
  input         io_slaves_0_b_valid,
  input  [11:0] io_slaves_0_b_bits_id,
  input         io_slaves_0_ar_ready,
  output        io_slaves_0_ar_valid,
  output [31:0] io_slaves_0_ar_bits_addr,
  output [7:0]  io_slaves_0_ar_bits_len,
  output [11:0] io_slaves_0_ar_bits_id,
  output        io_slaves_0_r_ready,
  input         io_slaves_0_r_valid,
  input  [31:0] io_slaves_0_r_bits_data,
  input  [11:0] io_slaves_0_r_bits_id,
  input         io_slaves_1_aw_ready,
  output        io_slaves_1_aw_valid,
  output [31:0] io_slaves_1_aw_bits_addr,
  output [7:0]  io_slaves_1_aw_bits_len,
  output [11:0] io_slaves_1_aw_bits_id,
  input         io_slaves_1_w_ready,
  output        io_slaves_1_w_valid,
  output [31:0] io_slaves_1_w_bits_data,
  output        io_slaves_1_b_ready,
  input         io_slaves_1_b_valid,
  input  [1:0]  io_slaves_1_b_bits_resp,
  input  [11:0] io_slaves_1_b_bits_id,
  input         io_slaves_1_b_bits_user,
  input         io_slaves_1_ar_ready,
  output        io_slaves_1_ar_valid,
  output [31:0] io_slaves_1_ar_bits_addr,
  output [7:0]  io_slaves_1_ar_bits_len,
  output [11:0] io_slaves_1_ar_bits_id,
  output        io_slaves_1_r_ready,
  input         io_slaves_1_r_valid,
  input  [1:0]  io_slaves_1_r_bits_resp,
  input  [31:0] io_slaves_1_r_bits_data,
  input         io_slaves_1_r_bits_last,
  input  [11:0] io_slaves_1_r_bits_id,
  input         io_slaves_1_r_bits_user,
  input         io_slaves_2_aw_ready,
  output        io_slaves_2_aw_valid,
  output [31:0] io_slaves_2_aw_bits_addr,
  output [7:0]  io_slaves_2_aw_bits_len,
  output [11:0] io_slaves_2_aw_bits_id,
  input         io_slaves_2_w_ready,
  output        io_slaves_2_w_valid,
  output [31:0] io_slaves_2_w_bits_data,
  output        io_slaves_2_b_ready,
  input         io_slaves_2_b_valid,
  input  [11:0] io_slaves_2_b_bits_id,
  input         io_slaves_2_ar_ready,
  output        io_slaves_2_ar_valid,
  output [31:0] io_slaves_2_ar_bits_addr,
  output [7:0]  io_slaves_2_ar_bits_len,
  output [11:0] io_slaves_2_ar_bits_id,
  output        io_slaves_2_r_ready,
  input         io_slaves_2_r_valid,
  input  [31:0] io_slaves_2_r_bits_data,
  input  [11:0] io_slaves_2_r_bits_id,
  input         io_slaves_3_aw_ready,
  output        io_slaves_3_aw_valid,
  output [31:0] io_slaves_3_aw_bits_addr,
  output [7:0]  io_slaves_3_aw_bits_len,
  output [11:0] io_slaves_3_aw_bits_id,
  input         io_slaves_3_w_ready,
  output        io_slaves_3_w_valid,
  output [31:0] io_slaves_3_w_bits_data,
  output        io_slaves_3_b_ready,
  input         io_slaves_3_b_valid,
  input  [1:0]  io_slaves_3_b_bits_resp,
  input  [11:0] io_slaves_3_b_bits_id,
  input         io_slaves_3_b_bits_user,
  input         io_slaves_3_ar_ready,
  output        io_slaves_3_ar_valid,
  output [31:0] io_slaves_3_ar_bits_addr,
  output [7:0]  io_slaves_3_ar_bits_len,
  output [11:0] io_slaves_3_ar_bits_id,
  output        io_slaves_3_r_ready,
  input         io_slaves_3_r_valid,
  input  [1:0]  io_slaves_3_r_bits_resp,
  input  [31:0] io_slaves_3_r_bits_data,
  input         io_slaves_3_r_bits_last,
  input  [11:0] io_slaves_3_r_bits_id,
  input         io_slaves_3_r_bits_user,
  input         io_slaves_4_aw_ready,
  output        io_slaves_4_aw_valid,
  output [31:0] io_slaves_4_aw_bits_addr,
  output [7:0]  io_slaves_4_aw_bits_len,
  output [11:0] io_slaves_4_aw_bits_id,
  input         io_slaves_4_w_ready,
  output        io_slaves_4_w_valid,
  output [31:0] io_slaves_4_w_bits_data,
  output        io_slaves_4_b_ready,
  input         io_slaves_4_b_valid,
  input  [11:0] io_slaves_4_b_bits_id,
  input         io_slaves_4_ar_ready,
  output        io_slaves_4_ar_valid,
  output [31:0] io_slaves_4_ar_bits_addr,
  output [7:0]  io_slaves_4_ar_bits_len,
  output [11:0] io_slaves_4_ar_bits_id,
  output        io_slaves_4_r_ready,
  input         io_slaves_4_r_valid,
  input  [31:0] io_slaves_4_r_bits_data,
  input  [11:0] io_slaves_4_r_bits_id
);
  wire  NastiRouter_clock;
  wire  NastiRouter_reset;
  wire  NastiRouter_io_master_aw_ready;
  wire  NastiRouter_io_master_aw_valid;
  wire [31:0] NastiRouter_io_master_aw_bits_addr;
  wire [7:0] NastiRouter_io_master_aw_bits_len;
  wire [11:0] NastiRouter_io_master_aw_bits_id;
  wire  NastiRouter_io_master_w_ready;
  wire  NastiRouter_io_master_w_valid;
  wire [31:0] NastiRouter_io_master_w_bits_data;
  wire  NastiRouter_io_master_w_bits_last;
  wire  NastiRouter_io_master_b_ready;
  wire  NastiRouter_io_master_b_valid;
  wire [1:0] NastiRouter_io_master_b_bits_resp;
  wire [11:0] NastiRouter_io_master_b_bits_id;
  wire  NastiRouter_io_master_b_bits_user;
  wire  NastiRouter_io_master_ar_ready;
  wire  NastiRouter_io_master_ar_valid;
  wire [31:0] NastiRouter_io_master_ar_bits_addr;
  wire [7:0] NastiRouter_io_master_ar_bits_len;
  wire [11:0] NastiRouter_io_master_ar_bits_id;
  wire  NastiRouter_io_master_r_ready;
  wire  NastiRouter_io_master_r_valid;
  wire [1:0] NastiRouter_io_master_r_bits_resp;
  wire [31:0] NastiRouter_io_master_r_bits_data;
  wire  NastiRouter_io_master_r_bits_last;
  wire [11:0] NastiRouter_io_master_r_bits_id;
  wire  NastiRouter_io_master_r_bits_user;
  wire  NastiRouter_io_slave_0_aw_ready;
  wire  NastiRouter_io_slave_0_aw_valid;
  wire [31:0] NastiRouter_io_slave_0_aw_bits_addr;
  wire [7:0] NastiRouter_io_slave_0_aw_bits_len;
  wire [11:0] NastiRouter_io_slave_0_aw_bits_id;
  wire  NastiRouter_io_slave_0_w_ready;
  wire  NastiRouter_io_slave_0_w_valid;
  wire [31:0] NastiRouter_io_slave_0_w_bits_data;
  wire  NastiRouter_io_slave_0_w_bits_last;
  wire  NastiRouter_io_slave_0_b_ready;
  wire  NastiRouter_io_slave_0_b_valid;
  wire [11:0] NastiRouter_io_slave_0_b_bits_id;
  wire  NastiRouter_io_slave_0_ar_ready;
  wire  NastiRouter_io_slave_0_ar_valid;
  wire [31:0] NastiRouter_io_slave_0_ar_bits_addr;
  wire [7:0] NastiRouter_io_slave_0_ar_bits_len;
  wire [11:0] NastiRouter_io_slave_0_ar_bits_id;
  wire  NastiRouter_io_slave_0_r_ready;
  wire  NastiRouter_io_slave_0_r_valid;
  wire [31:0] NastiRouter_io_slave_0_r_bits_data;
  wire [11:0] NastiRouter_io_slave_0_r_bits_id;
  wire  NastiRouter_io_slave_1_aw_ready;
  wire  NastiRouter_io_slave_1_aw_valid;
  wire [31:0] NastiRouter_io_slave_1_aw_bits_addr;
  wire [7:0] NastiRouter_io_slave_1_aw_bits_len;
  wire [11:0] NastiRouter_io_slave_1_aw_bits_id;
  wire  NastiRouter_io_slave_1_w_ready;
  wire  NastiRouter_io_slave_1_w_valid;
  wire [31:0] NastiRouter_io_slave_1_w_bits_data;
  wire  NastiRouter_io_slave_1_w_bits_last;
  wire  NastiRouter_io_slave_1_b_ready;
  wire  NastiRouter_io_slave_1_b_valid;
  wire [1:0] NastiRouter_io_slave_1_b_bits_resp;
  wire [11:0] NastiRouter_io_slave_1_b_bits_id;
  wire  NastiRouter_io_slave_1_b_bits_user;
  wire  NastiRouter_io_slave_1_ar_ready;
  wire  NastiRouter_io_slave_1_ar_valid;
  wire [31:0] NastiRouter_io_slave_1_ar_bits_addr;
  wire [7:0] NastiRouter_io_slave_1_ar_bits_len;
  wire [11:0] NastiRouter_io_slave_1_ar_bits_id;
  wire  NastiRouter_io_slave_1_r_ready;
  wire  NastiRouter_io_slave_1_r_valid;
  wire [1:0] NastiRouter_io_slave_1_r_bits_resp;
  wire [31:0] NastiRouter_io_slave_1_r_bits_data;
  wire  NastiRouter_io_slave_1_r_bits_last;
  wire [11:0] NastiRouter_io_slave_1_r_bits_id;
  wire  NastiRouter_io_slave_1_r_bits_user;
  wire  NastiRouter_io_slave_2_aw_ready;
  wire  NastiRouter_io_slave_2_aw_valid;
  wire [31:0] NastiRouter_io_slave_2_aw_bits_addr;
  wire [7:0] NastiRouter_io_slave_2_aw_bits_len;
  wire [11:0] NastiRouter_io_slave_2_aw_bits_id;
  wire  NastiRouter_io_slave_2_w_ready;
  wire  NastiRouter_io_slave_2_w_valid;
  wire [31:0] NastiRouter_io_slave_2_w_bits_data;
  wire  NastiRouter_io_slave_2_w_bits_last;
  wire  NastiRouter_io_slave_2_b_ready;
  wire  NastiRouter_io_slave_2_b_valid;
  wire [11:0] NastiRouter_io_slave_2_b_bits_id;
  wire  NastiRouter_io_slave_2_ar_ready;
  wire  NastiRouter_io_slave_2_ar_valid;
  wire [31:0] NastiRouter_io_slave_2_ar_bits_addr;
  wire [7:0] NastiRouter_io_slave_2_ar_bits_len;
  wire [11:0] NastiRouter_io_slave_2_ar_bits_id;
  wire  NastiRouter_io_slave_2_r_ready;
  wire  NastiRouter_io_slave_2_r_valid;
  wire [31:0] NastiRouter_io_slave_2_r_bits_data;
  wire [11:0] NastiRouter_io_slave_2_r_bits_id;
  wire  NastiRouter_io_slave_3_aw_ready;
  wire  NastiRouter_io_slave_3_aw_valid;
  wire [31:0] NastiRouter_io_slave_3_aw_bits_addr;
  wire [7:0] NastiRouter_io_slave_3_aw_bits_len;
  wire [11:0] NastiRouter_io_slave_3_aw_bits_id;
  wire  NastiRouter_io_slave_3_w_ready;
  wire  NastiRouter_io_slave_3_w_valid;
  wire [31:0] NastiRouter_io_slave_3_w_bits_data;
  wire  NastiRouter_io_slave_3_w_bits_last;
  wire  NastiRouter_io_slave_3_b_ready;
  wire  NastiRouter_io_slave_3_b_valid;
  wire [1:0] NastiRouter_io_slave_3_b_bits_resp;
  wire [11:0] NastiRouter_io_slave_3_b_bits_id;
  wire  NastiRouter_io_slave_3_b_bits_user;
  wire  NastiRouter_io_slave_3_ar_ready;
  wire  NastiRouter_io_slave_3_ar_valid;
  wire [31:0] NastiRouter_io_slave_3_ar_bits_addr;
  wire [7:0] NastiRouter_io_slave_3_ar_bits_len;
  wire [11:0] NastiRouter_io_slave_3_ar_bits_id;
  wire  NastiRouter_io_slave_3_r_ready;
  wire  NastiRouter_io_slave_3_r_valid;
  wire [1:0] NastiRouter_io_slave_3_r_bits_resp;
  wire [31:0] NastiRouter_io_slave_3_r_bits_data;
  wire  NastiRouter_io_slave_3_r_bits_last;
  wire [11:0] NastiRouter_io_slave_3_r_bits_id;
  wire  NastiRouter_io_slave_3_r_bits_user;
  wire  NastiRouter_io_slave_4_aw_ready;
  wire  NastiRouter_io_slave_4_aw_valid;
  wire [31:0] NastiRouter_io_slave_4_aw_bits_addr;
  wire [7:0] NastiRouter_io_slave_4_aw_bits_len;
  wire [11:0] NastiRouter_io_slave_4_aw_bits_id;
  wire  NastiRouter_io_slave_4_w_ready;
  wire  NastiRouter_io_slave_4_w_valid;
  wire [31:0] NastiRouter_io_slave_4_w_bits_data;
  wire  NastiRouter_io_slave_4_w_bits_last;
  wire  NastiRouter_io_slave_4_b_ready;
  wire  NastiRouter_io_slave_4_b_valid;
  wire [11:0] NastiRouter_io_slave_4_b_bits_id;
  wire  NastiRouter_io_slave_4_ar_ready;
  wire  NastiRouter_io_slave_4_ar_valid;
  wire [31:0] NastiRouter_io_slave_4_ar_bits_addr;
  wire [7:0] NastiRouter_io_slave_4_ar_bits_len;
  wire [11:0] NastiRouter_io_slave_4_ar_bits_id;
  wire  NastiRouter_io_slave_4_r_ready;
  wire  NastiRouter_io_slave_4_r_valid;
  wire [31:0] NastiRouter_io_slave_4_r_bits_data;
  wire [11:0] NastiRouter_io_slave_4_r_bits_id;
  NastiRouter NastiRouter (
    .clock(NastiRouter_clock),
    .reset(NastiRouter_reset),
    .io_master_aw_ready(NastiRouter_io_master_aw_ready),
    .io_master_aw_valid(NastiRouter_io_master_aw_valid),
    .io_master_aw_bits_addr(NastiRouter_io_master_aw_bits_addr),
    .io_master_aw_bits_len(NastiRouter_io_master_aw_bits_len),
    .io_master_aw_bits_id(NastiRouter_io_master_aw_bits_id),
    .io_master_w_ready(NastiRouter_io_master_w_ready),
    .io_master_w_valid(NastiRouter_io_master_w_valid),
    .io_master_w_bits_data(NastiRouter_io_master_w_bits_data),
    .io_master_w_bits_last(NastiRouter_io_master_w_bits_last),
    .io_master_b_ready(NastiRouter_io_master_b_ready),
    .io_master_b_valid(NastiRouter_io_master_b_valid),
    .io_master_b_bits_resp(NastiRouter_io_master_b_bits_resp),
    .io_master_b_bits_id(NastiRouter_io_master_b_bits_id),
    .io_master_b_bits_user(NastiRouter_io_master_b_bits_user),
    .io_master_ar_ready(NastiRouter_io_master_ar_ready),
    .io_master_ar_valid(NastiRouter_io_master_ar_valid),
    .io_master_ar_bits_addr(NastiRouter_io_master_ar_bits_addr),
    .io_master_ar_bits_len(NastiRouter_io_master_ar_bits_len),
    .io_master_ar_bits_id(NastiRouter_io_master_ar_bits_id),
    .io_master_r_ready(NastiRouter_io_master_r_ready),
    .io_master_r_valid(NastiRouter_io_master_r_valid),
    .io_master_r_bits_resp(NastiRouter_io_master_r_bits_resp),
    .io_master_r_bits_data(NastiRouter_io_master_r_bits_data),
    .io_master_r_bits_last(NastiRouter_io_master_r_bits_last),
    .io_master_r_bits_id(NastiRouter_io_master_r_bits_id),
    .io_master_r_bits_user(NastiRouter_io_master_r_bits_user),
    .io_slave_0_aw_ready(NastiRouter_io_slave_0_aw_ready),
    .io_slave_0_aw_valid(NastiRouter_io_slave_0_aw_valid),
    .io_slave_0_aw_bits_addr(NastiRouter_io_slave_0_aw_bits_addr),
    .io_slave_0_aw_bits_len(NastiRouter_io_slave_0_aw_bits_len),
    .io_slave_0_aw_bits_id(NastiRouter_io_slave_0_aw_bits_id),
    .io_slave_0_w_ready(NastiRouter_io_slave_0_w_ready),
    .io_slave_0_w_valid(NastiRouter_io_slave_0_w_valid),
    .io_slave_0_w_bits_data(NastiRouter_io_slave_0_w_bits_data),
    .io_slave_0_w_bits_last(NastiRouter_io_slave_0_w_bits_last),
    .io_slave_0_b_ready(NastiRouter_io_slave_0_b_ready),
    .io_slave_0_b_valid(NastiRouter_io_slave_0_b_valid),
    .io_slave_0_b_bits_id(NastiRouter_io_slave_0_b_bits_id),
    .io_slave_0_ar_ready(NastiRouter_io_slave_0_ar_ready),
    .io_slave_0_ar_valid(NastiRouter_io_slave_0_ar_valid),
    .io_slave_0_ar_bits_addr(NastiRouter_io_slave_0_ar_bits_addr),
    .io_slave_0_ar_bits_len(NastiRouter_io_slave_0_ar_bits_len),
    .io_slave_0_ar_bits_id(NastiRouter_io_slave_0_ar_bits_id),
    .io_slave_0_r_ready(NastiRouter_io_slave_0_r_ready),
    .io_slave_0_r_valid(NastiRouter_io_slave_0_r_valid),
    .io_slave_0_r_bits_data(NastiRouter_io_slave_0_r_bits_data),
    .io_slave_0_r_bits_id(NastiRouter_io_slave_0_r_bits_id),
    .io_slave_1_aw_ready(NastiRouter_io_slave_1_aw_ready),
    .io_slave_1_aw_valid(NastiRouter_io_slave_1_aw_valid),
    .io_slave_1_aw_bits_addr(NastiRouter_io_slave_1_aw_bits_addr),
    .io_slave_1_aw_bits_len(NastiRouter_io_slave_1_aw_bits_len),
    .io_slave_1_aw_bits_id(NastiRouter_io_slave_1_aw_bits_id),
    .io_slave_1_w_ready(NastiRouter_io_slave_1_w_ready),
    .io_slave_1_w_valid(NastiRouter_io_slave_1_w_valid),
    .io_slave_1_w_bits_data(NastiRouter_io_slave_1_w_bits_data),
    .io_slave_1_w_bits_last(NastiRouter_io_slave_1_w_bits_last),
    .io_slave_1_b_ready(NastiRouter_io_slave_1_b_ready),
    .io_slave_1_b_valid(NastiRouter_io_slave_1_b_valid),
    .io_slave_1_b_bits_resp(NastiRouter_io_slave_1_b_bits_resp),
    .io_slave_1_b_bits_id(NastiRouter_io_slave_1_b_bits_id),
    .io_slave_1_b_bits_user(NastiRouter_io_slave_1_b_bits_user),
    .io_slave_1_ar_ready(NastiRouter_io_slave_1_ar_ready),
    .io_slave_1_ar_valid(NastiRouter_io_slave_1_ar_valid),
    .io_slave_1_ar_bits_addr(NastiRouter_io_slave_1_ar_bits_addr),
    .io_slave_1_ar_bits_len(NastiRouter_io_slave_1_ar_bits_len),
    .io_slave_1_ar_bits_id(NastiRouter_io_slave_1_ar_bits_id),
    .io_slave_1_r_ready(NastiRouter_io_slave_1_r_ready),
    .io_slave_1_r_valid(NastiRouter_io_slave_1_r_valid),
    .io_slave_1_r_bits_resp(NastiRouter_io_slave_1_r_bits_resp),
    .io_slave_1_r_bits_data(NastiRouter_io_slave_1_r_bits_data),
    .io_slave_1_r_bits_last(NastiRouter_io_slave_1_r_bits_last),
    .io_slave_1_r_bits_id(NastiRouter_io_slave_1_r_bits_id),
    .io_slave_1_r_bits_user(NastiRouter_io_slave_1_r_bits_user),
    .io_slave_2_aw_ready(NastiRouter_io_slave_2_aw_ready),
    .io_slave_2_aw_valid(NastiRouter_io_slave_2_aw_valid),
    .io_slave_2_aw_bits_addr(NastiRouter_io_slave_2_aw_bits_addr),
    .io_slave_2_aw_bits_len(NastiRouter_io_slave_2_aw_bits_len),
    .io_slave_2_aw_bits_id(NastiRouter_io_slave_2_aw_bits_id),
    .io_slave_2_w_ready(NastiRouter_io_slave_2_w_ready),
    .io_slave_2_w_valid(NastiRouter_io_slave_2_w_valid),
    .io_slave_2_w_bits_data(NastiRouter_io_slave_2_w_bits_data),
    .io_slave_2_w_bits_last(NastiRouter_io_slave_2_w_bits_last),
    .io_slave_2_b_ready(NastiRouter_io_slave_2_b_ready),
    .io_slave_2_b_valid(NastiRouter_io_slave_2_b_valid),
    .io_slave_2_b_bits_id(NastiRouter_io_slave_2_b_bits_id),
    .io_slave_2_ar_ready(NastiRouter_io_slave_2_ar_ready),
    .io_slave_2_ar_valid(NastiRouter_io_slave_2_ar_valid),
    .io_slave_2_ar_bits_addr(NastiRouter_io_slave_2_ar_bits_addr),
    .io_slave_2_ar_bits_len(NastiRouter_io_slave_2_ar_bits_len),
    .io_slave_2_ar_bits_id(NastiRouter_io_slave_2_ar_bits_id),
    .io_slave_2_r_ready(NastiRouter_io_slave_2_r_ready),
    .io_slave_2_r_valid(NastiRouter_io_slave_2_r_valid),
    .io_slave_2_r_bits_data(NastiRouter_io_slave_2_r_bits_data),
    .io_slave_2_r_bits_id(NastiRouter_io_slave_2_r_bits_id),
    .io_slave_3_aw_ready(NastiRouter_io_slave_3_aw_ready),
    .io_slave_3_aw_valid(NastiRouter_io_slave_3_aw_valid),
    .io_slave_3_aw_bits_addr(NastiRouter_io_slave_3_aw_bits_addr),
    .io_slave_3_aw_bits_len(NastiRouter_io_slave_3_aw_bits_len),
    .io_slave_3_aw_bits_id(NastiRouter_io_slave_3_aw_bits_id),
    .io_slave_3_w_ready(NastiRouter_io_slave_3_w_ready),
    .io_slave_3_w_valid(NastiRouter_io_slave_3_w_valid),
    .io_slave_3_w_bits_data(NastiRouter_io_slave_3_w_bits_data),
    .io_slave_3_w_bits_last(NastiRouter_io_slave_3_w_bits_last),
    .io_slave_3_b_ready(NastiRouter_io_slave_3_b_ready),
    .io_slave_3_b_valid(NastiRouter_io_slave_3_b_valid),
    .io_slave_3_b_bits_resp(NastiRouter_io_slave_3_b_bits_resp),
    .io_slave_3_b_bits_id(NastiRouter_io_slave_3_b_bits_id),
    .io_slave_3_b_bits_user(NastiRouter_io_slave_3_b_bits_user),
    .io_slave_3_ar_ready(NastiRouter_io_slave_3_ar_ready),
    .io_slave_3_ar_valid(NastiRouter_io_slave_3_ar_valid),
    .io_slave_3_ar_bits_addr(NastiRouter_io_slave_3_ar_bits_addr),
    .io_slave_3_ar_bits_len(NastiRouter_io_slave_3_ar_bits_len),
    .io_slave_3_ar_bits_id(NastiRouter_io_slave_3_ar_bits_id),
    .io_slave_3_r_ready(NastiRouter_io_slave_3_r_ready),
    .io_slave_3_r_valid(NastiRouter_io_slave_3_r_valid),
    .io_slave_3_r_bits_resp(NastiRouter_io_slave_3_r_bits_resp),
    .io_slave_3_r_bits_data(NastiRouter_io_slave_3_r_bits_data),
    .io_slave_3_r_bits_last(NastiRouter_io_slave_3_r_bits_last),
    .io_slave_3_r_bits_id(NastiRouter_io_slave_3_r_bits_id),
    .io_slave_3_r_bits_user(NastiRouter_io_slave_3_r_bits_user),
    .io_slave_4_aw_ready(NastiRouter_io_slave_4_aw_ready),
    .io_slave_4_aw_valid(NastiRouter_io_slave_4_aw_valid),
    .io_slave_4_aw_bits_addr(NastiRouter_io_slave_4_aw_bits_addr),
    .io_slave_4_aw_bits_len(NastiRouter_io_slave_4_aw_bits_len),
    .io_slave_4_aw_bits_id(NastiRouter_io_slave_4_aw_bits_id),
    .io_slave_4_w_ready(NastiRouter_io_slave_4_w_ready),
    .io_slave_4_w_valid(NastiRouter_io_slave_4_w_valid),
    .io_slave_4_w_bits_data(NastiRouter_io_slave_4_w_bits_data),
    .io_slave_4_w_bits_last(NastiRouter_io_slave_4_w_bits_last),
    .io_slave_4_b_ready(NastiRouter_io_slave_4_b_ready),
    .io_slave_4_b_valid(NastiRouter_io_slave_4_b_valid),
    .io_slave_4_b_bits_id(NastiRouter_io_slave_4_b_bits_id),
    .io_slave_4_ar_ready(NastiRouter_io_slave_4_ar_ready),
    .io_slave_4_ar_valid(NastiRouter_io_slave_4_ar_valid),
    .io_slave_4_ar_bits_addr(NastiRouter_io_slave_4_ar_bits_addr),
    .io_slave_4_ar_bits_len(NastiRouter_io_slave_4_ar_bits_len),
    .io_slave_4_ar_bits_id(NastiRouter_io_slave_4_ar_bits_id),
    .io_slave_4_r_ready(NastiRouter_io_slave_4_r_ready),
    .io_slave_4_r_valid(NastiRouter_io_slave_4_r_valid),
    .io_slave_4_r_bits_data(NastiRouter_io_slave_4_r_bits_data),
    .io_slave_4_r_bits_id(NastiRouter_io_slave_4_r_bits_id)
  );
  assign io_masters_0_aw_ready = NastiRouter_io_master_aw_ready;
  assign io_masters_0_w_ready = NastiRouter_io_master_w_ready;
  assign io_masters_0_b_valid = NastiRouter_io_master_b_valid;
  assign io_masters_0_b_bits_resp = NastiRouter_io_master_b_bits_resp;
  assign io_masters_0_b_bits_id = NastiRouter_io_master_b_bits_id;
  assign io_masters_0_b_bits_user = NastiRouter_io_master_b_bits_user;
  assign io_masters_0_ar_ready = NastiRouter_io_master_ar_ready;
  assign io_masters_0_r_valid = NastiRouter_io_master_r_valid;
  assign io_masters_0_r_bits_resp = NastiRouter_io_master_r_bits_resp;
  assign io_masters_0_r_bits_data = NastiRouter_io_master_r_bits_data;
  assign io_masters_0_r_bits_last = NastiRouter_io_master_r_bits_last;
  assign io_masters_0_r_bits_id = NastiRouter_io_master_r_bits_id;
  assign io_masters_0_r_bits_user = NastiRouter_io_master_r_bits_user;
  assign io_slaves_0_aw_valid = NastiRouter_io_slave_0_aw_valid;
  assign io_slaves_0_aw_bits_addr = NastiRouter_io_slave_0_aw_bits_addr;
  assign io_slaves_0_aw_bits_len = NastiRouter_io_slave_0_aw_bits_len;
  assign io_slaves_0_aw_bits_id = NastiRouter_io_slave_0_aw_bits_id;
  assign io_slaves_0_w_valid = NastiRouter_io_slave_0_w_valid;
  assign io_slaves_0_w_bits_data = NastiRouter_io_slave_0_w_bits_data;
  assign io_slaves_0_b_ready = NastiRouter_io_slave_0_b_ready;
  assign io_slaves_0_ar_valid = NastiRouter_io_slave_0_ar_valid;
  assign io_slaves_0_ar_bits_addr = NastiRouter_io_slave_0_ar_bits_addr;
  assign io_slaves_0_ar_bits_len = NastiRouter_io_slave_0_ar_bits_len;
  assign io_slaves_0_ar_bits_id = NastiRouter_io_slave_0_ar_bits_id;
  assign io_slaves_0_r_ready = NastiRouter_io_slave_0_r_ready;
  assign io_slaves_1_aw_valid = NastiRouter_io_slave_1_aw_valid;
  assign io_slaves_1_aw_bits_addr = NastiRouter_io_slave_1_aw_bits_addr;
  assign io_slaves_1_aw_bits_len = NastiRouter_io_slave_1_aw_bits_len;
  assign io_slaves_1_aw_bits_id = NastiRouter_io_slave_1_aw_bits_id;
  assign io_slaves_1_w_valid = NastiRouter_io_slave_1_w_valid;
  assign io_slaves_1_w_bits_data = NastiRouter_io_slave_1_w_bits_data;
  assign io_slaves_1_b_ready = NastiRouter_io_slave_1_b_ready;
  assign io_slaves_1_ar_valid = NastiRouter_io_slave_1_ar_valid;
  assign io_slaves_1_ar_bits_addr = NastiRouter_io_slave_1_ar_bits_addr;
  assign io_slaves_1_ar_bits_len = NastiRouter_io_slave_1_ar_bits_len;
  assign io_slaves_1_ar_bits_id = NastiRouter_io_slave_1_ar_bits_id;
  assign io_slaves_1_r_ready = NastiRouter_io_slave_1_r_ready;
  assign io_slaves_2_aw_valid = NastiRouter_io_slave_2_aw_valid;
  assign io_slaves_2_aw_bits_addr = NastiRouter_io_slave_2_aw_bits_addr;
  assign io_slaves_2_aw_bits_len = NastiRouter_io_slave_2_aw_bits_len;
  assign io_slaves_2_aw_bits_id = NastiRouter_io_slave_2_aw_bits_id;
  assign io_slaves_2_w_valid = NastiRouter_io_slave_2_w_valid;
  assign io_slaves_2_w_bits_data = NastiRouter_io_slave_2_w_bits_data;
  assign io_slaves_2_b_ready = NastiRouter_io_slave_2_b_ready;
  assign io_slaves_2_ar_valid = NastiRouter_io_slave_2_ar_valid;
  assign io_slaves_2_ar_bits_addr = NastiRouter_io_slave_2_ar_bits_addr;
  assign io_slaves_2_ar_bits_len = NastiRouter_io_slave_2_ar_bits_len;
  assign io_slaves_2_ar_bits_id = NastiRouter_io_slave_2_ar_bits_id;
  assign io_slaves_2_r_ready = NastiRouter_io_slave_2_r_ready;
  assign io_slaves_3_aw_valid = NastiRouter_io_slave_3_aw_valid;
  assign io_slaves_3_aw_bits_addr = NastiRouter_io_slave_3_aw_bits_addr;
  assign io_slaves_3_aw_bits_len = NastiRouter_io_slave_3_aw_bits_len;
  assign io_slaves_3_aw_bits_id = NastiRouter_io_slave_3_aw_bits_id;
  assign io_slaves_3_w_valid = NastiRouter_io_slave_3_w_valid;
  assign io_slaves_3_w_bits_data = NastiRouter_io_slave_3_w_bits_data;
  assign io_slaves_3_b_ready = NastiRouter_io_slave_3_b_ready;
  assign io_slaves_3_ar_valid = NastiRouter_io_slave_3_ar_valid;
  assign io_slaves_3_ar_bits_addr = NastiRouter_io_slave_3_ar_bits_addr;
  assign io_slaves_3_ar_bits_len = NastiRouter_io_slave_3_ar_bits_len;
  assign io_slaves_3_ar_bits_id = NastiRouter_io_slave_3_ar_bits_id;
  assign io_slaves_3_r_ready = NastiRouter_io_slave_3_r_ready;
  assign io_slaves_4_aw_valid = NastiRouter_io_slave_4_aw_valid;
  assign io_slaves_4_aw_bits_addr = NastiRouter_io_slave_4_aw_bits_addr;
  assign io_slaves_4_aw_bits_len = NastiRouter_io_slave_4_aw_bits_len;
  assign io_slaves_4_aw_bits_id = NastiRouter_io_slave_4_aw_bits_id;
  assign io_slaves_4_w_valid = NastiRouter_io_slave_4_w_valid;
  assign io_slaves_4_w_bits_data = NastiRouter_io_slave_4_w_bits_data;
  assign io_slaves_4_b_ready = NastiRouter_io_slave_4_b_ready;
  assign io_slaves_4_ar_valid = NastiRouter_io_slave_4_ar_valid;
  assign io_slaves_4_ar_bits_addr = NastiRouter_io_slave_4_ar_bits_addr;
  assign io_slaves_4_ar_bits_len = NastiRouter_io_slave_4_ar_bits_len;
  assign io_slaves_4_ar_bits_id = NastiRouter_io_slave_4_ar_bits_id;
  assign io_slaves_4_r_ready = NastiRouter_io_slave_4_r_ready;
  assign NastiRouter_clock = clock;
  assign NastiRouter_reset = reset;
  assign NastiRouter_io_master_aw_valid = io_masters_0_aw_valid;
  assign NastiRouter_io_master_aw_bits_addr = io_masters_0_aw_bits_addr;
  assign NastiRouter_io_master_aw_bits_len = io_masters_0_aw_bits_len;
  assign NastiRouter_io_master_aw_bits_id = io_masters_0_aw_bits_id;
  assign NastiRouter_io_master_w_valid = io_masters_0_w_valid;
  assign NastiRouter_io_master_w_bits_data = io_masters_0_w_bits_data;
  assign NastiRouter_io_master_w_bits_last = io_masters_0_w_bits_last;
  assign NastiRouter_io_master_b_ready = io_masters_0_b_ready;
  assign NastiRouter_io_master_ar_valid = io_masters_0_ar_valid;
  assign NastiRouter_io_master_ar_bits_addr = io_masters_0_ar_bits_addr;
  assign NastiRouter_io_master_ar_bits_len = io_masters_0_ar_bits_len;
  assign NastiRouter_io_master_ar_bits_id = io_masters_0_ar_bits_id;
  assign NastiRouter_io_master_r_ready = io_masters_0_r_ready;
  assign NastiRouter_io_slave_0_aw_ready = io_slaves_0_aw_ready;
  assign NastiRouter_io_slave_0_w_ready = io_slaves_0_w_ready;
  assign NastiRouter_io_slave_0_b_valid = io_slaves_0_b_valid;
  assign NastiRouter_io_slave_0_b_bits_id = io_slaves_0_b_bits_id;
  assign NastiRouter_io_slave_0_ar_ready = io_slaves_0_ar_ready;
  assign NastiRouter_io_slave_0_r_valid = io_slaves_0_r_valid;
  assign NastiRouter_io_slave_0_r_bits_data = io_slaves_0_r_bits_data;
  assign NastiRouter_io_slave_0_r_bits_id = io_slaves_0_r_bits_id;
  assign NastiRouter_io_slave_1_aw_ready = io_slaves_1_aw_ready;
  assign NastiRouter_io_slave_1_w_ready = io_slaves_1_w_ready;
  assign NastiRouter_io_slave_1_b_valid = io_slaves_1_b_valid;
  assign NastiRouter_io_slave_1_b_bits_resp = io_slaves_1_b_bits_resp;
  assign NastiRouter_io_slave_1_b_bits_id = io_slaves_1_b_bits_id;
  assign NastiRouter_io_slave_1_b_bits_user = io_slaves_1_b_bits_user;
  assign NastiRouter_io_slave_1_ar_ready = io_slaves_1_ar_ready;
  assign NastiRouter_io_slave_1_r_valid = io_slaves_1_r_valid;
  assign NastiRouter_io_slave_1_r_bits_resp = io_slaves_1_r_bits_resp;
  assign NastiRouter_io_slave_1_r_bits_data = io_slaves_1_r_bits_data;
  assign NastiRouter_io_slave_1_r_bits_last = io_slaves_1_r_bits_last;
  assign NastiRouter_io_slave_1_r_bits_id = io_slaves_1_r_bits_id;
  assign NastiRouter_io_slave_1_r_bits_user = io_slaves_1_r_bits_user;
  assign NastiRouter_io_slave_2_aw_ready = io_slaves_2_aw_ready;
  assign NastiRouter_io_slave_2_w_ready = io_slaves_2_w_ready;
  assign NastiRouter_io_slave_2_b_valid = io_slaves_2_b_valid;
  assign NastiRouter_io_slave_2_b_bits_id = io_slaves_2_b_bits_id;
  assign NastiRouter_io_slave_2_ar_ready = io_slaves_2_ar_ready;
  assign NastiRouter_io_slave_2_r_valid = io_slaves_2_r_valid;
  assign NastiRouter_io_slave_2_r_bits_data = io_slaves_2_r_bits_data;
  assign NastiRouter_io_slave_2_r_bits_id = io_slaves_2_r_bits_id;
  assign NastiRouter_io_slave_3_aw_ready = io_slaves_3_aw_ready;
  assign NastiRouter_io_slave_3_w_ready = io_slaves_3_w_ready;
  assign NastiRouter_io_slave_3_b_valid = io_slaves_3_b_valid;
  assign NastiRouter_io_slave_3_b_bits_resp = io_slaves_3_b_bits_resp;
  assign NastiRouter_io_slave_3_b_bits_id = io_slaves_3_b_bits_id;
  assign NastiRouter_io_slave_3_b_bits_user = io_slaves_3_b_bits_user;
  assign NastiRouter_io_slave_3_ar_ready = io_slaves_3_ar_ready;
  assign NastiRouter_io_slave_3_r_valid = io_slaves_3_r_valid;
  assign NastiRouter_io_slave_3_r_bits_resp = io_slaves_3_r_bits_resp;
  assign NastiRouter_io_slave_3_r_bits_data = io_slaves_3_r_bits_data;
  assign NastiRouter_io_slave_3_r_bits_last = io_slaves_3_r_bits_last;
  assign NastiRouter_io_slave_3_r_bits_id = io_slaves_3_r_bits_id;
  assign NastiRouter_io_slave_3_r_bits_user = io_slaves_3_r_bits_user;
  assign NastiRouter_io_slave_4_aw_ready = io_slaves_4_aw_ready;
  assign NastiRouter_io_slave_4_w_ready = io_slaves_4_w_ready;
  assign NastiRouter_io_slave_4_b_valid = io_slaves_4_b_valid;
  assign NastiRouter_io_slave_4_b_bits_id = io_slaves_4_b_bits_id;
  assign NastiRouter_io_slave_4_ar_ready = io_slaves_4_ar_ready;
  assign NastiRouter_io_slave_4_r_valid = io_slaves_4_r_valid;
  assign NastiRouter_io_slave_4_r_bits_data = io_slaves_4_r_bits_data;
  assign NastiRouter_io_slave_4_r_bits_id = io_slaves_4_r_bits_id;
endmodule
module NastiRecursiveInterconnect(
  input         clock,
  input         reset,
  output        io_masters_0_aw_ready,
  input         io_masters_0_aw_valid,
  input  [31:0] io_masters_0_aw_bits_addr,
  input  [7:0]  io_masters_0_aw_bits_len,
  input  [11:0] io_masters_0_aw_bits_id,
  output        io_masters_0_w_ready,
  input         io_masters_0_w_valid,
  input  [31:0] io_masters_0_w_bits_data,
  input         io_masters_0_w_bits_last,
  input         io_masters_0_b_ready,
  output        io_masters_0_b_valid,
  output [1:0]  io_masters_0_b_bits_resp,
  output [11:0] io_masters_0_b_bits_id,
  output        io_masters_0_b_bits_user,
  output        io_masters_0_ar_ready,
  input         io_masters_0_ar_valid,
  input  [31:0] io_masters_0_ar_bits_addr,
  input  [7:0]  io_masters_0_ar_bits_len,
  input  [11:0] io_masters_0_ar_bits_id,
  input         io_masters_0_r_ready,
  output        io_masters_0_r_valid,
  output [1:0]  io_masters_0_r_bits_resp,
  output [31:0] io_masters_0_r_bits_data,
  output        io_masters_0_r_bits_last,
  output [11:0] io_masters_0_r_bits_id,
  output        io_masters_0_r_bits_user,
  input         io_slaves_0_aw_ready,
  output        io_slaves_0_aw_valid,
  output [31:0] io_slaves_0_aw_bits_addr,
  output [7:0]  io_slaves_0_aw_bits_len,
  output [11:0] io_slaves_0_aw_bits_id,
  input         io_slaves_0_w_ready,
  output        io_slaves_0_w_valid,
  output [31:0] io_slaves_0_w_bits_data,
  output        io_slaves_0_b_ready,
  input         io_slaves_0_b_valid,
  input  [11:0] io_slaves_0_b_bits_id,
  input         io_slaves_0_ar_ready,
  output        io_slaves_0_ar_valid,
  output [31:0] io_slaves_0_ar_bits_addr,
  output [7:0]  io_slaves_0_ar_bits_len,
  output [11:0] io_slaves_0_ar_bits_id,
  output        io_slaves_0_r_ready,
  input         io_slaves_0_r_valid,
  input  [31:0] io_slaves_0_r_bits_data,
  input  [11:0] io_slaves_0_r_bits_id,
  input         io_slaves_1_aw_ready,
  output        io_slaves_1_aw_valid,
  output [31:0] io_slaves_1_aw_bits_addr,
  output [7:0]  io_slaves_1_aw_bits_len,
  output [11:0] io_slaves_1_aw_bits_id,
  input         io_slaves_1_w_ready,
  output        io_slaves_1_w_valid,
  output [31:0] io_slaves_1_w_bits_data,
  output        io_slaves_1_b_ready,
  input         io_slaves_1_b_valid,
  input  [1:0]  io_slaves_1_b_bits_resp,
  input  [11:0] io_slaves_1_b_bits_id,
  input         io_slaves_1_b_bits_user,
  input         io_slaves_1_ar_ready,
  output        io_slaves_1_ar_valid,
  output [31:0] io_slaves_1_ar_bits_addr,
  output [7:0]  io_slaves_1_ar_bits_len,
  output [11:0] io_slaves_1_ar_bits_id,
  output        io_slaves_1_r_ready,
  input         io_slaves_1_r_valid,
  input  [1:0]  io_slaves_1_r_bits_resp,
  input  [31:0] io_slaves_1_r_bits_data,
  input         io_slaves_1_r_bits_last,
  input  [11:0] io_slaves_1_r_bits_id,
  input         io_slaves_1_r_bits_user,
  input         io_slaves_2_aw_ready,
  output        io_slaves_2_aw_valid,
  output [31:0] io_slaves_2_aw_bits_addr,
  output [7:0]  io_slaves_2_aw_bits_len,
  output [11:0] io_slaves_2_aw_bits_id,
  input         io_slaves_2_w_ready,
  output        io_slaves_2_w_valid,
  output [31:0] io_slaves_2_w_bits_data,
  output        io_slaves_2_b_ready,
  input         io_slaves_2_b_valid,
  input  [11:0] io_slaves_2_b_bits_id,
  input         io_slaves_2_ar_ready,
  output        io_slaves_2_ar_valid,
  output [31:0] io_slaves_2_ar_bits_addr,
  output [7:0]  io_slaves_2_ar_bits_len,
  output [11:0] io_slaves_2_ar_bits_id,
  output        io_slaves_2_r_ready,
  input         io_slaves_2_r_valid,
  input  [31:0] io_slaves_2_r_bits_data,
  input  [11:0] io_slaves_2_r_bits_id,
  input         io_slaves_3_aw_ready,
  output        io_slaves_3_aw_valid,
  output [31:0] io_slaves_3_aw_bits_addr,
  output [7:0]  io_slaves_3_aw_bits_len,
  output [11:0] io_slaves_3_aw_bits_id,
  input         io_slaves_3_w_ready,
  output        io_slaves_3_w_valid,
  output [31:0] io_slaves_3_w_bits_data,
  output        io_slaves_3_b_ready,
  input         io_slaves_3_b_valid,
  input  [1:0]  io_slaves_3_b_bits_resp,
  input  [11:0] io_slaves_3_b_bits_id,
  input         io_slaves_3_b_bits_user,
  input         io_slaves_3_ar_ready,
  output        io_slaves_3_ar_valid,
  output [31:0] io_slaves_3_ar_bits_addr,
  output [7:0]  io_slaves_3_ar_bits_len,
  output [11:0] io_slaves_3_ar_bits_id,
  output        io_slaves_3_r_ready,
  input         io_slaves_3_r_valid,
  input  [1:0]  io_slaves_3_r_bits_resp,
  input  [31:0] io_slaves_3_r_bits_data,
  input         io_slaves_3_r_bits_last,
  input  [11:0] io_slaves_3_r_bits_id,
  input         io_slaves_3_r_bits_user,
  input         io_slaves_4_aw_ready,
  output        io_slaves_4_aw_valid,
  output [31:0] io_slaves_4_aw_bits_addr,
  output [7:0]  io_slaves_4_aw_bits_len,
  output [11:0] io_slaves_4_aw_bits_id,
  input         io_slaves_4_w_ready,
  output        io_slaves_4_w_valid,
  output [31:0] io_slaves_4_w_bits_data,
  output        io_slaves_4_b_ready,
  input         io_slaves_4_b_valid,
  input  [11:0] io_slaves_4_b_bits_id,
  input         io_slaves_4_ar_ready,
  output        io_slaves_4_ar_valid,
  output [31:0] io_slaves_4_ar_bits_addr,
  output [7:0]  io_slaves_4_ar_bits_len,
  output [11:0] io_slaves_4_ar_bits_id,
  output        io_slaves_4_r_ready,
  input         io_slaves_4_r_valid,
  input  [31:0] io_slaves_4_r_bits_data,
  input  [11:0] io_slaves_4_r_bits_id
);
  wire  xbar_clock;
  wire  xbar_reset;
  wire  xbar_io_masters_0_aw_ready;
  wire  xbar_io_masters_0_aw_valid;
  wire [31:0] xbar_io_masters_0_aw_bits_addr;
  wire [7:0] xbar_io_masters_0_aw_bits_len;
  wire [11:0] xbar_io_masters_0_aw_bits_id;
  wire  xbar_io_masters_0_w_ready;
  wire  xbar_io_masters_0_w_valid;
  wire [31:0] xbar_io_masters_0_w_bits_data;
  wire  xbar_io_masters_0_w_bits_last;
  wire  xbar_io_masters_0_b_ready;
  wire  xbar_io_masters_0_b_valid;
  wire [1:0] xbar_io_masters_0_b_bits_resp;
  wire [11:0] xbar_io_masters_0_b_bits_id;
  wire  xbar_io_masters_0_b_bits_user;
  wire  xbar_io_masters_0_ar_ready;
  wire  xbar_io_masters_0_ar_valid;
  wire [31:0] xbar_io_masters_0_ar_bits_addr;
  wire [7:0] xbar_io_masters_0_ar_bits_len;
  wire [11:0] xbar_io_masters_0_ar_bits_id;
  wire  xbar_io_masters_0_r_ready;
  wire  xbar_io_masters_0_r_valid;
  wire [1:0] xbar_io_masters_0_r_bits_resp;
  wire [31:0] xbar_io_masters_0_r_bits_data;
  wire  xbar_io_masters_0_r_bits_last;
  wire [11:0] xbar_io_masters_0_r_bits_id;
  wire  xbar_io_masters_0_r_bits_user;
  wire  xbar_io_slaves_0_aw_ready;
  wire  xbar_io_slaves_0_aw_valid;
  wire [31:0] xbar_io_slaves_0_aw_bits_addr;
  wire [7:0] xbar_io_slaves_0_aw_bits_len;
  wire [11:0] xbar_io_slaves_0_aw_bits_id;
  wire  xbar_io_slaves_0_w_ready;
  wire  xbar_io_slaves_0_w_valid;
  wire [31:0] xbar_io_slaves_0_w_bits_data;
  wire  xbar_io_slaves_0_b_ready;
  wire  xbar_io_slaves_0_b_valid;
  wire [11:0] xbar_io_slaves_0_b_bits_id;
  wire  xbar_io_slaves_0_ar_ready;
  wire  xbar_io_slaves_0_ar_valid;
  wire [31:0] xbar_io_slaves_0_ar_bits_addr;
  wire [7:0] xbar_io_slaves_0_ar_bits_len;
  wire [11:0] xbar_io_slaves_0_ar_bits_id;
  wire  xbar_io_slaves_0_r_ready;
  wire  xbar_io_slaves_0_r_valid;
  wire [31:0] xbar_io_slaves_0_r_bits_data;
  wire [11:0] xbar_io_slaves_0_r_bits_id;
  wire  xbar_io_slaves_1_aw_ready;
  wire  xbar_io_slaves_1_aw_valid;
  wire [31:0] xbar_io_slaves_1_aw_bits_addr;
  wire [7:0] xbar_io_slaves_1_aw_bits_len;
  wire [11:0] xbar_io_slaves_1_aw_bits_id;
  wire  xbar_io_slaves_1_w_ready;
  wire  xbar_io_slaves_1_w_valid;
  wire [31:0] xbar_io_slaves_1_w_bits_data;
  wire  xbar_io_slaves_1_b_ready;
  wire  xbar_io_slaves_1_b_valid;
  wire [1:0] xbar_io_slaves_1_b_bits_resp;
  wire [11:0] xbar_io_slaves_1_b_bits_id;
  wire  xbar_io_slaves_1_b_bits_user;
  wire  xbar_io_slaves_1_ar_ready;
  wire  xbar_io_slaves_1_ar_valid;
  wire [31:0] xbar_io_slaves_1_ar_bits_addr;
  wire [7:0] xbar_io_slaves_1_ar_bits_len;
  wire [11:0] xbar_io_slaves_1_ar_bits_id;
  wire  xbar_io_slaves_1_r_ready;
  wire  xbar_io_slaves_1_r_valid;
  wire [1:0] xbar_io_slaves_1_r_bits_resp;
  wire [31:0] xbar_io_slaves_1_r_bits_data;
  wire  xbar_io_slaves_1_r_bits_last;
  wire [11:0] xbar_io_slaves_1_r_bits_id;
  wire  xbar_io_slaves_1_r_bits_user;
  wire  xbar_io_slaves_2_aw_ready;
  wire  xbar_io_slaves_2_aw_valid;
  wire [31:0] xbar_io_slaves_2_aw_bits_addr;
  wire [7:0] xbar_io_slaves_2_aw_bits_len;
  wire [11:0] xbar_io_slaves_2_aw_bits_id;
  wire  xbar_io_slaves_2_w_ready;
  wire  xbar_io_slaves_2_w_valid;
  wire [31:0] xbar_io_slaves_2_w_bits_data;
  wire  xbar_io_slaves_2_b_ready;
  wire  xbar_io_slaves_2_b_valid;
  wire [11:0] xbar_io_slaves_2_b_bits_id;
  wire  xbar_io_slaves_2_ar_ready;
  wire  xbar_io_slaves_2_ar_valid;
  wire [31:0] xbar_io_slaves_2_ar_bits_addr;
  wire [7:0] xbar_io_slaves_2_ar_bits_len;
  wire [11:0] xbar_io_slaves_2_ar_bits_id;
  wire  xbar_io_slaves_2_r_ready;
  wire  xbar_io_slaves_2_r_valid;
  wire [31:0] xbar_io_slaves_2_r_bits_data;
  wire [11:0] xbar_io_slaves_2_r_bits_id;
  wire  xbar_io_slaves_3_aw_ready;
  wire  xbar_io_slaves_3_aw_valid;
  wire [31:0] xbar_io_slaves_3_aw_bits_addr;
  wire [7:0] xbar_io_slaves_3_aw_bits_len;
  wire [11:0] xbar_io_slaves_3_aw_bits_id;
  wire  xbar_io_slaves_3_w_ready;
  wire  xbar_io_slaves_3_w_valid;
  wire [31:0] xbar_io_slaves_3_w_bits_data;
  wire  xbar_io_slaves_3_b_ready;
  wire  xbar_io_slaves_3_b_valid;
  wire [1:0] xbar_io_slaves_3_b_bits_resp;
  wire [11:0] xbar_io_slaves_3_b_bits_id;
  wire  xbar_io_slaves_3_b_bits_user;
  wire  xbar_io_slaves_3_ar_ready;
  wire  xbar_io_slaves_3_ar_valid;
  wire [31:0] xbar_io_slaves_3_ar_bits_addr;
  wire [7:0] xbar_io_slaves_3_ar_bits_len;
  wire [11:0] xbar_io_slaves_3_ar_bits_id;
  wire  xbar_io_slaves_3_r_ready;
  wire  xbar_io_slaves_3_r_valid;
  wire [1:0] xbar_io_slaves_3_r_bits_resp;
  wire [31:0] xbar_io_slaves_3_r_bits_data;
  wire  xbar_io_slaves_3_r_bits_last;
  wire [11:0] xbar_io_slaves_3_r_bits_id;
  wire  xbar_io_slaves_3_r_bits_user;
  wire  xbar_io_slaves_4_aw_ready;
  wire  xbar_io_slaves_4_aw_valid;
  wire [31:0] xbar_io_slaves_4_aw_bits_addr;
  wire [7:0] xbar_io_slaves_4_aw_bits_len;
  wire [11:0] xbar_io_slaves_4_aw_bits_id;
  wire  xbar_io_slaves_4_w_ready;
  wire  xbar_io_slaves_4_w_valid;
  wire [31:0] xbar_io_slaves_4_w_bits_data;
  wire  xbar_io_slaves_4_b_ready;
  wire  xbar_io_slaves_4_b_valid;
  wire [11:0] xbar_io_slaves_4_b_bits_id;
  wire  xbar_io_slaves_4_ar_ready;
  wire  xbar_io_slaves_4_ar_valid;
  wire [31:0] xbar_io_slaves_4_ar_bits_addr;
  wire [7:0] xbar_io_slaves_4_ar_bits_len;
  wire [11:0] xbar_io_slaves_4_ar_bits_id;
  wire  xbar_io_slaves_4_r_ready;
  wire  xbar_io_slaves_4_r_valid;
  wire [31:0] xbar_io_slaves_4_r_bits_data;
  wire [11:0] xbar_io_slaves_4_r_bits_id;
  NastiCrossbar xbar (
    .clock(xbar_clock),
    .reset(xbar_reset),
    .io_masters_0_aw_ready(xbar_io_masters_0_aw_ready),
    .io_masters_0_aw_valid(xbar_io_masters_0_aw_valid),
    .io_masters_0_aw_bits_addr(xbar_io_masters_0_aw_bits_addr),
    .io_masters_0_aw_bits_len(xbar_io_masters_0_aw_bits_len),
    .io_masters_0_aw_bits_id(xbar_io_masters_0_aw_bits_id),
    .io_masters_0_w_ready(xbar_io_masters_0_w_ready),
    .io_masters_0_w_valid(xbar_io_masters_0_w_valid),
    .io_masters_0_w_bits_data(xbar_io_masters_0_w_bits_data),
    .io_masters_0_w_bits_last(xbar_io_masters_0_w_bits_last),
    .io_masters_0_b_ready(xbar_io_masters_0_b_ready),
    .io_masters_0_b_valid(xbar_io_masters_0_b_valid),
    .io_masters_0_b_bits_resp(xbar_io_masters_0_b_bits_resp),
    .io_masters_0_b_bits_id(xbar_io_masters_0_b_bits_id),
    .io_masters_0_b_bits_user(xbar_io_masters_0_b_bits_user),
    .io_masters_0_ar_ready(xbar_io_masters_0_ar_ready),
    .io_masters_0_ar_valid(xbar_io_masters_0_ar_valid),
    .io_masters_0_ar_bits_addr(xbar_io_masters_0_ar_bits_addr),
    .io_masters_0_ar_bits_len(xbar_io_masters_0_ar_bits_len),
    .io_masters_0_ar_bits_id(xbar_io_masters_0_ar_bits_id),
    .io_masters_0_r_ready(xbar_io_masters_0_r_ready),
    .io_masters_0_r_valid(xbar_io_masters_0_r_valid),
    .io_masters_0_r_bits_resp(xbar_io_masters_0_r_bits_resp),
    .io_masters_0_r_bits_data(xbar_io_masters_0_r_bits_data),
    .io_masters_0_r_bits_last(xbar_io_masters_0_r_bits_last),
    .io_masters_0_r_bits_id(xbar_io_masters_0_r_bits_id),
    .io_masters_0_r_bits_user(xbar_io_masters_0_r_bits_user),
    .io_slaves_0_aw_ready(xbar_io_slaves_0_aw_ready),
    .io_slaves_0_aw_valid(xbar_io_slaves_0_aw_valid),
    .io_slaves_0_aw_bits_addr(xbar_io_slaves_0_aw_bits_addr),
    .io_slaves_0_aw_bits_len(xbar_io_slaves_0_aw_bits_len),
    .io_slaves_0_aw_bits_id(xbar_io_slaves_0_aw_bits_id),
    .io_slaves_0_w_ready(xbar_io_slaves_0_w_ready),
    .io_slaves_0_w_valid(xbar_io_slaves_0_w_valid),
    .io_slaves_0_w_bits_data(xbar_io_slaves_0_w_bits_data),
    .io_slaves_0_b_ready(xbar_io_slaves_0_b_ready),
    .io_slaves_0_b_valid(xbar_io_slaves_0_b_valid),
    .io_slaves_0_b_bits_id(xbar_io_slaves_0_b_bits_id),
    .io_slaves_0_ar_ready(xbar_io_slaves_0_ar_ready),
    .io_slaves_0_ar_valid(xbar_io_slaves_0_ar_valid),
    .io_slaves_0_ar_bits_addr(xbar_io_slaves_0_ar_bits_addr),
    .io_slaves_0_ar_bits_len(xbar_io_slaves_0_ar_bits_len),
    .io_slaves_0_ar_bits_id(xbar_io_slaves_0_ar_bits_id),
    .io_slaves_0_r_ready(xbar_io_slaves_0_r_ready),
    .io_slaves_0_r_valid(xbar_io_slaves_0_r_valid),
    .io_slaves_0_r_bits_data(xbar_io_slaves_0_r_bits_data),
    .io_slaves_0_r_bits_id(xbar_io_slaves_0_r_bits_id),
    .io_slaves_1_aw_ready(xbar_io_slaves_1_aw_ready),
    .io_slaves_1_aw_valid(xbar_io_slaves_1_aw_valid),
    .io_slaves_1_aw_bits_addr(xbar_io_slaves_1_aw_bits_addr),
    .io_slaves_1_aw_bits_len(xbar_io_slaves_1_aw_bits_len),
    .io_slaves_1_aw_bits_id(xbar_io_slaves_1_aw_bits_id),
    .io_slaves_1_w_ready(xbar_io_slaves_1_w_ready),
    .io_slaves_1_w_valid(xbar_io_slaves_1_w_valid),
    .io_slaves_1_w_bits_data(xbar_io_slaves_1_w_bits_data),
    .io_slaves_1_b_ready(xbar_io_slaves_1_b_ready),
    .io_slaves_1_b_valid(xbar_io_slaves_1_b_valid),
    .io_slaves_1_b_bits_resp(xbar_io_slaves_1_b_bits_resp),
    .io_slaves_1_b_bits_id(xbar_io_slaves_1_b_bits_id),
    .io_slaves_1_b_bits_user(xbar_io_slaves_1_b_bits_user),
    .io_slaves_1_ar_ready(xbar_io_slaves_1_ar_ready),
    .io_slaves_1_ar_valid(xbar_io_slaves_1_ar_valid),
    .io_slaves_1_ar_bits_addr(xbar_io_slaves_1_ar_bits_addr),
    .io_slaves_1_ar_bits_len(xbar_io_slaves_1_ar_bits_len),
    .io_slaves_1_ar_bits_id(xbar_io_slaves_1_ar_bits_id),
    .io_slaves_1_r_ready(xbar_io_slaves_1_r_ready),
    .io_slaves_1_r_valid(xbar_io_slaves_1_r_valid),
    .io_slaves_1_r_bits_resp(xbar_io_slaves_1_r_bits_resp),
    .io_slaves_1_r_bits_data(xbar_io_slaves_1_r_bits_data),
    .io_slaves_1_r_bits_last(xbar_io_slaves_1_r_bits_last),
    .io_slaves_1_r_bits_id(xbar_io_slaves_1_r_bits_id),
    .io_slaves_1_r_bits_user(xbar_io_slaves_1_r_bits_user),
    .io_slaves_2_aw_ready(xbar_io_slaves_2_aw_ready),
    .io_slaves_2_aw_valid(xbar_io_slaves_2_aw_valid),
    .io_slaves_2_aw_bits_addr(xbar_io_slaves_2_aw_bits_addr),
    .io_slaves_2_aw_bits_len(xbar_io_slaves_2_aw_bits_len),
    .io_slaves_2_aw_bits_id(xbar_io_slaves_2_aw_bits_id),
    .io_slaves_2_w_ready(xbar_io_slaves_2_w_ready),
    .io_slaves_2_w_valid(xbar_io_slaves_2_w_valid),
    .io_slaves_2_w_bits_data(xbar_io_slaves_2_w_bits_data),
    .io_slaves_2_b_ready(xbar_io_slaves_2_b_ready),
    .io_slaves_2_b_valid(xbar_io_slaves_2_b_valid),
    .io_slaves_2_b_bits_id(xbar_io_slaves_2_b_bits_id),
    .io_slaves_2_ar_ready(xbar_io_slaves_2_ar_ready),
    .io_slaves_2_ar_valid(xbar_io_slaves_2_ar_valid),
    .io_slaves_2_ar_bits_addr(xbar_io_slaves_2_ar_bits_addr),
    .io_slaves_2_ar_bits_len(xbar_io_slaves_2_ar_bits_len),
    .io_slaves_2_ar_bits_id(xbar_io_slaves_2_ar_bits_id),
    .io_slaves_2_r_ready(xbar_io_slaves_2_r_ready),
    .io_slaves_2_r_valid(xbar_io_slaves_2_r_valid),
    .io_slaves_2_r_bits_data(xbar_io_slaves_2_r_bits_data),
    .io_slaves_2_r_bits_id(xbar_io_slaves_2_r_bits_id),
    .io_slaves_3_aw_ready(xbar_io_slaves_3_aw_ready),
    .io_slaves_3_aw_valid(xbar_io_slaves_3_aw_valid),
    .io_slaves_3_aw_bits_addr(xbar_io_slaves_3_aw_bits_addr),
    .io_slaves_3_aw_bits_len(xbar_io_slaves_3_aw_bits_len),
    .io_slaves_3_aw_bits_id(xbar_io_slaves_3_aw_bits_id),
    .io_slaves_3_w_ready(xbar_io_slaves_3_w_ready),
    .io_slaves_3_w_valid(xbar_io_slaves_3_w_valid),
    .io_slaves_3_w_bits_data(xbar_io_slaves_3_w_bits_data),
    .io_slaves_3_b_ready(xbar_io_slaves_3_b_ready),
    .io_slaves_3_b_valid(xbar_io_slaves_3_b_valid),
    .io_slaves_3_b_bits_resp(xbar_io_slaves_3_b_bits_resp),
    .io_slaves_3_b_bits_id(xbar_io_slaves_3_b_bits_id),
    .io_slaves_3_b_bits_user(xbar_io_slaves_3_b_bits_user),
    .io_slaves_3_ar_ready(xbar_io_slaves_3_ar_ready),
    .io_slaves_3_ar_valid(xbar_io_slaves_3_ar_valid),
    .io_slaves_3_ar_bits_addr(xbar_io_slaves_3_ar_bits_addr),
    .io_slaves_3_ar_bits_len(xbar_io_slaves_3_ar_bits_len),
    .io_slaves_3_ar_bits_id(xbar_io_slaves_3_ar_bits_id),
    .io_slaves_3_r_ready(xbar_io_slaves_3_r_ready),
    .io_slaves_3_r_valid(xbar_io_slaves_3_r_valid),
    .io_slaves_3_r_bits_resp(xbar_io_slaves_3_r_bits_resp),
    .io_slaves_3_r_bits_data(xbar_io_slaves_3_r_bits_data),
    .io_slaves_3_r_bits_last(xbar_io_slaves_3_r_bits_last),
    .io_slaves_3_r_bits_id(xbar_io_slaves_3_r_bits_id),
    .io_slaves_3_r_bits_user(xbar_io_slaves_3_r_bits_user),
    .io_slaves_4_aw_ready(xbar_io_slaves_4_aw_ready),
    .io_slaves_4_aw_valid(xbar_io_slaves_4_aw_valid),
    .io_slaves_4_aw_bits_addr(xbar_io_slaves_4_aw_bits_addr),
    .io_slaves_4_aw_bits_len(xbar_io_slaves_4_aw_bits_len),
    .io_slaves_4_aw_bits_id(xbar_io_slaves_4_aw_bits_id),
    .io_slaves_4_w_ready(xbar_io_slaves_4_w_ready),
    .io_slaves_4_w_valid(xbar_io_slaves_4_w_valid),
    .io_slaves_4_w_bits_data(xbar_io_slaves_4_w_bits_data),
    .io_slaves_4_b_ready(xbar_io_slaves_4_b_ready),
    .io_slaves_4_b_valid(xbar_io_slaves_4_b_valid),
    .io_slaves_4_b_bits_id(xbar_io_slaves_4_b_bits_id),
    .io_slaves_4_ar_ready(xbar_io_slaves_4_ar_ready),
    .io_slaves_4_ar_valid(xbar_io_slaves_4_ar_valid),
    .io_slaves_4_ar_bits_addr(xbar_io_slaves_4_ar_bits_addr),
    .io_slaves_4_ar_bits_len(xbar_io_slaves_4_ar_bits_len),
    .io_slaves_4_ar_bits_id(xbar_io_slaves_4_ar_bits_id),
    .io_slaves_4_r_ready(xbar_io_slaves_4_r_ready),
    .io_slaves_4_r_valid(xbar_io_slaves_4_r_valid),
    .io_slaves_4_r_bits_data(xbar_io_slaves_4_r_bits_data),
    .io_slaves_4_r_bits_id(xbar_io_slaves_4_r_bits_id)
  );
  assign io_masters_0_aw_ready = xbar_io_masters_0_aw_ready;
  assign io_masters_0_w_ready = xbar_io_masters_0_w_ready;
  assign io_masters_0_b_valid = xbar_io_masters_0_b_valid;
  assign io_masters_0_b_bits_resp = xbar_io_masters_0_b_bits_resp;
  assign io_masters_0_b_bits_id = xbar_io_masters_0_b_bits_id;
  assign io_masters_0_b_bits_user = xbar_io_masters_0_b_bits_user;
  assign io_masters_0_ar_ready = xbar_io_masters_0_ar_ready;
  assign io_masters_0_r_valid = xbar_io_masters_0_r_valid;
  assign io_masters_0_r_bits_resp = xbar_io_masters_0_r_bits_resp;
  assign io_masters_0_r_bits_data = xbar_io_masters_0_r_bits_data;
  assign io_masters_0_r_bits_last = xbar_io_masters_0_r_bits_last;
  assign io_masters_0_r_bits_id = xbar_io_masters_0_r_bits_id;
  assign io_masters_0_r_bits_user = xbar_io_masters_0_r_bits_user;
  assign io_slaves_0_aw_valid = xbar_io_slaves_0_aw_valid;
  assign io_slaves_0_aw_bits_addr = xbar_io_slaves_0_aw_bits_addr;
  assign io_slaves_0_aw_bits_len = xbar_io_slaves_0_aw_bits_len;
  assign io_slaves_0_aw_bits_id = xbar_io_slaves_0_aw_bits_id;
  assign io_slaves_0_w_valid = xbar_io_slaves_0_w_valid;
  assign io_slaves_0_w_bits_data = xbar_io_slaves_0_w_bits_data;
  assign io_slaves_0_b_ready = xbar_io_slaves_0_b_ready;
  assign io_slaves_0_ar_valid = xbar_io_slaves_0_ar_valid;
  assign io_slaves_0_ar_bits_addr = xbar_io_slaves_0_ar_bits_addr;
  assign io_slaves_0_ar_bits_len = xbar_io_slaves_0_ar_bits_len;
  assign io_slaves_0_ar_bits_id = xbar_io_slaves_0_ar_bits_id;
  assign io_slaves_0_r_ready = xbar_io_slaves_0_r_ready;
  assign io_slaves_1_aw_valid = xbar_io_slaves_1_aw_valid;
  assign io_slaves_1_aw_bits_addr = xbar_io_slaves_1_aw_bits_addr;
  assign io_slaves_1_aw_bits_len = xbar_io_slaves_1_aw_bits_len;
  assign io_slaves_1_aw_bits_id = xbar_io_slaves_1_aw_bits_id;
  assign io_slaves_1_w_valid = xbar_io_slaves_1_w_valid;
  assign io_slaves_1_w_bits_data = xbar_io_slaves_1_w_bits_data;
  assign io_slaves_1_b_ready = xbar_io_slaves_1_b_ready;
  assign io_slaves_1_ar_valid = xbar_io_slaves_1_ar_valid;
  assign io_slaves_1_ar_bits_addr = xbar_io_slaves_1_ar_bits_addr;
  assign io_slaves_1_ar_bits_len = xbar_io_slaves_1_ar_bits_len;
  assign io_slaves_1_ar_bits_id = xbar_io_slaves_1_ar_bits_id;
  assign io_slaves_1_r_ready = xbar_io_slaves_1_r_ready;
  assign io_slaves_2_aw_valid = xbar_io_slaves_2_aw_valid;
  assign io_slaves_2_aw_bits_addr = xbar_io_slaves_2_aw_bits_addr;
  assign io_slaves_2_aw_bits_len = xbar_io_slaves_2_aw_bits_len;
  assign io_slaves_2_aw_bits_id = xbar_io_slaves_2_aw_bits_id;
  assign io_slaves_2_w_valid = xbar_io_slaves_2_w_valid;
  assign io_slaves_2_w_bits_data = xbar_io_slaves_2_w_bits_data;
  assign io_slaves_2_b_ready = xbar_io_slaves_2_b_ready;
  assign io_slaves_2_ar_valid = xbar_io_slaves_2_ar_valid;
  assign io_slaves_2_ar_bits_addr = xbar_io_slaves_2_ar_bits_addr;
  assign io_slaves_2_ar_bits_len = xbar_io_slaves_2_ar_bits_len;
  assign io_slaves_2_ar_bits_id = xbar_io_slaves_2_ar_bits_id;
  assign io_slaves_2_r_ready = xbar_io_slaves_2_r_ready;
  assign io_slaves_3_aw_valid = xbar_io_slaves_3_aw_valid;
  assign io_slaves_3_aw_bits_addr = xbar_io_slaves_3_aw_bits_addr;
  assign io_slaves_3_aw_bits_len = xbar_io_slaves_3_aw_bits_len;
  assign io_slaves_3_aw_bits_id = xbar_io_slaves_3_aw_bits_id;
  assign io_slaves_3_w_valid = xbar_io_slaves_3_w_valid;
  assign io_slaves_3_w_bits_data = xbar_io_slaves_3_w_bits_data;
  assign io_slaves_3_b_ready = xbar_io_slaves_3_b_ready;
  assign io_slaves_3_ar_valid = xbar_io_slaves_3_ar_valid;
  assign io_slaves_3_ar_bits_addr = xbar_io_slaves_3_ar_bits_addr;
  assign io_slaves_3_ar_bits_len = xbar_io_slaves_3_ar_bits_len;
  assign io_slaves_3_ar_bits_id = xbar_io_slaves_3_ar_bits_id;
  assign io_slaves_3_r_ready = xbar_io_slaves_3_r_ready;
  assign io_slaves_4_aw_valid = xbar_io_slaves_4_aw_valid;
  assign io_slaves_4_aw_bits_addr = xbar_io_slaves_4_aw_bits_addr;
  assign io_slaves_4_aw_bits_len = xbar_io_slaves_4_aw_bits_len;
  assign io_slaves_4_aw_bits_id = xbar_io_slaves_4_aw_bits_id;
  assign io_slaves_4_w_valid = xbar_io_slaves_4_w_valid;
  assign io_slaves_4_w_bits_data = xbar_io_slaves_4_w_bits_data;
  assign io_slaves_4_b_ready = xbar_io_slaves_4_b_ready;
  assign io_slaves_4_ar_valid = xbar_io_slaves_4_ar_valid;
  assign io_slaves_4_ar_bits_addr = xbar_io_slaves_4_ar_bits_addr;
  assign io_slaves_4_ar_bits_len = xbar_io_slaves_4_ar_bits_len;
  assign io_slaves_4_ar_bits_id = xbar_io_slaves_4_ar_bits_id;
  assign io_slaves_4_r_ready = xbar_io_slaves_4_r_ready;
  assign xbar_clock = clock;
  assign xbar_reset = reset;
  assign xbar_io_masters_0_aw_valid = io_masters_0_aw_valid;
  assign xbar_io_masters_0_aw_bits_addr = io_masters_0_aw_bits_addr;
  assign xbar_io_masters_0_aw_bits_len = io_masters_0_aw_bits_len;
  assign xbar_io_masters_0_aw_bits_id = io_masters_0_aw_bits_id;
  assign xbar_io_masters_0_w_valid = io_masters_0_w_valid;
  assign xbar_io_masters_0_w_bits_data = io_masters_0_w_bits_data;
  assign xbar_io_masters_0_w_bits_last = io_masters_0_w_bits_last;
  assign xbar_io_masters_0_b_ready = io_masters_0_b_ready;
  assign xbar_io_masters_0_ar_valid = io_masters_0_ar_valid;
  assign xbar_io_masters_0_ar_bits_addr = io_masters_0_ar_bits_addr;
  assign xbar_io_masters_0_ar_bits_len = io_masters_0_ar_bits_len;
  assign xbar_io_masters_0_ar_bits_id = io_masters_0_ar_bits_id;
  assign xbar_io_masters_0_r_ready = io_masters_0_r_ready;
  assign xbar_io_slaves_0_aw_ready = io_slaves_0_aw_ready;
  assign xbar_io_slaves_0_w_ready = io_slaves_0_w_ready;
  assign xbar_io_slaves_0_b_valid = io_slaves_0_b_valid;
  assign xbar_io_slaves_0_b_bits_id = io_slaves_0_b_bits_id;
  assign xbar_io_slaves_0_ar_ready = io_slaves_0_ar_ready;
  assign xbar_io_slaves_0_r_valid = io_slaves_0_r_valid;
  assign xbar_io_slaves_0_r_bits_data = io_slaves_0_r_bits_data;
  assign xbar_io_slaves_0_r_bits_id = io_slaves_0_r_bits_id;
  assign xbar_io_slaves_1_aw_ready = io_slaves_1_aw_ready;
  assign xbar_io_slaves_1_w_ready = io_slaves_1_w_ready;
  assign xbar_io_slaves_1_b_valid = io_slaves_1_b_valid;
  assign xbar_io_slaves_1_b_bits_resp = io_slaves_1_b_bits_resp;
  assign xbar_io_slaves_1_b_bits_id = io_slaves_1_b_bits_id;
  assign xbar_io_slaves_1_b_bits_user = io_slaves_1_b_bits_user;
  assign xbar_io_slaves_1_ar_ready = io_slaves_1_ar_ready;
  assign xbar_io_slaves_1_r_valid = io_slaves_1_r_valid;
  assign xbar_io_slaves_1_r_bits_resp = io_slaves_1_r_bits_resp;
  assign xbar_io_slaves_1_r_bits_data = io_slaves_1_r_bits_data;
  assign xbar_io_slaves_1_r_bits_last = io_slaves_1_r_bits_last;
  assign xbar_io_slaves_1_r_bits_id = io_slaves_1_r_bits_id;
  assign xbar_io_slaves_1_r_bits_user = io_slaves_1_r_bits_user;
  assign xbar_io_slaves_2_aw_ready = io_slaves_2_aw_ready;
  assign xbar_io_slaves_2_w_ready = io_slaves_2_w_ready;
  assign xbar_io_slaves_2_b_valid = io_slaves_2_b_valid;
  assign xbar_io_slaves_2_b_bits_id = io_slaves_2_b_bits_id;
  assign xbar_io_slaves_2_ar_ready = io_slaves_2_ar_ready;
  assign xbar_io_slaves_2_r_valid = io_slaves_2_r_valid;
  assign xbar_io_slaves_2_r_bits_data = io_slaves_2_r_bits_data;
  assign xbar_io_slaves_2_r_bits_id = io_slaves_2_r_bits_id;
  assign xbar_io_slaves_3_aw_ready = io_slaves_3_aw_ready;
  assign xbar_io_slaves_3_w_ready = io_slaves_3_w_ready;
  assign xbar_io_slaves_3_b_valid = io_slaves_3_b_valid;
  assign xbar_io_slaves_3_b_bits_resp = io_slaves_3_b_bits_resp;
  assign xbar_io_slaves_3_b_bits_id = io_slaves_3_b_bits_id;
  assign xbar_io_slaves_3_b_bits_user = io_slaves_3_b_bits_user;
  assign xbar_io_slaves_3_ar_ready = io_slaves_3_ar_ready;
  assign xbar_io_slaves_3_r_valid = io_slaves_3_r_valid;
  assign xbar_io_slaves_3_r_bits_resp = io_slaves_3_r_bits_resp;
  assign xbar_io_slaves_3_r_bits_data = io_slaves_3_r_bits_data;
  assign xbar_io_slaves_3_r_bits_last = io_slaves_3_r_bits_last;
  assign xbar_io_slaves_3_r_bits_id = io_slaves_3_r_bits_id;
  assign xbar_io_slaves_3_r_bits_user = io_slaves_3_r_bits_user;
  assign xbar_io_slaves_4_aw_ready = io_slaves_4_aw_ready;
  assign xbar_io_slaves_4_w_ready = io_slaves_4_w_ready;
  assign xbar_io_slaves_4_b_valid = io_slaves_4_b_valid;
  assign xbar_io_slaves_4_b_bits_id = io_slaves_4_b_bits_id;
  assign xbar_io_slaves_4_ar_ready = io_slaves_4_ar_ready;
  assign xbar_io_slaves_4_r_valid = io_slaves_4_r_valid;
  assign xbar_io_slaves_4_r_bits_data = io_slaves_4_r_bits_data;
  assign xbar_io_slaves_4_r_bits_id = io_slaves_4_r_bits_id;
endmodule
module FPGATop(
  input         clock,
  input         reset,
  output        io_ctrl_aw_ready,
  input         io_ctrl_aw_valid,
  input  [31:0] io_ctrl_aw_bits_addr,
  input  [7:0]  io_ctrl_aw_bits_len,
  input  [11:0] io_ctrl_aw_bits_id,
  output        io_ctrl_w_ready,
  input         io_ctrl_w_valid,
  input  [31:0] io_ctrl_w_bits_data,
  input         io_ctrl_w_bits_last,
  input         io_ctrl_b_ready,
  output        io_ctrl_b_valid,
  output [1:0]  io_ctrl_b_bits_resp,
  output [11:0] io_ctrl_b_bits_id,
  output        io_ctrl_b_bits_user,
  output        io_ctrl_ar_ready,
  input         io_ctrl_ar_valid,
  input  [31:0] io_ctrl_ar_bits_addr,
  input  [7:0]  io_ctrl_ar_bits_len,
  input  [11:0] io_ctrl_ar_bits_id,
  input         io_ctrl_r_ready,
  output        io_ctrl_r_valid,
  output [1:0]  io_ctrl_r_bits_resp,
  output [31:0] io_ctrl_r_bits_data,
  output        io_ctrl_r_bits_last,
  output [11:0] io_ctrl_r_bits_id,
  output        io_ctrl_r_bits_user,
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
  wire [31:0] sim_io_wireIns_0_bits;
  wire  sim_io_wireIns_1_ready;
  wire  sim_io_wireIns_1_valid;
  wire [31:0] sim_io_wireIns_1_bits;
  wire  sim_io_wireOuts_0_ready;
  wire  sim_io_wireOuts_0_valid;
  wire [31:0] sim_io_wireOuts_0_bits;
  wire  sim_io_daisy_regs_0_in_ready;
  wire  sim_io_daisy_regs_0_in_valid;
  wire [31:0] sim_io_daisy_regs_0_in_bits;
  wire  sim_io_daisy_regs_0_out_ready;
  wire  sim_io_daisy_regs_0_out_valid;
  wire [31:0] sim_io_daisy_regs_0_out_bits;
  wire [10:0] sim_io_traceLen;
  wire  sim_io_wireInTraces_0_ready;
  wire  sim_io_wireInTraces_0_valid;
  wire [31:0] sim_io_wireInTraces_0_bits;
  wire  sim_io_wireInTraces_1_ready;
  wire  sim_io_wireInTraces_1_valid;
  wire [31:0] sim_io_wireInTraces_1_bits;
  wire  sim_io_wireOutTraces_0_ready;
  wire  sim_io_wireOutTraces_0_valid;
  wire [31:0] sim_io_wireOutTraces_0_bits;
  wire  simReset;
  wire  _T_531;
  wire  Master_clock;
  wire  Master_reset;
  wire  Master_io_ctrl_aw_ready;
  wire  Master_io_ctrl_aw_valid;
  wire [31:0] Master_io_ctrl_aw_bits_addr;
  wire [7:0] Master_io_ctrl_aw_bits_len;
  wire [11:0] Master_io_ctrl_aw_bits_id;
  wire  Master_io_ctrl_w_ready;
  wire  Master_io_ctrl_w_valid;
  wire [31:0] Master_io_ctrl_w_bits_data;
  wire  Master_io_ctrl_b_ready;
  wire  Master_io_ctrl_b_valid;
  wire [1:0] Master_io_ctrl_b_bits_resp;
  wire [11:0] Master_io_ctrl_b_bits_id;
  wire  Master_io_ctrl_b_bits_user;
  wire  Master_io_ctrl_ar_ready;
  wire  Master_io_ctrl_ar_valid;
  wire [31:0] Master_io_ctrl_ar_bits_addr;
  wire [7:0] Master_io_ctrl_ar_bits_len;
  wire [11:0] Master_io_ctrl_ar_bits_id;
  wire  Master_io_ctrl_r_ready;
  wire  Master_io_ctrl_r_valid;
  wire [1:0] Master_io_ctrl_r_bits_resp;
  wire [31:0] Master_io_ctrl_r_bits_data;
  wire  Master_io_ctrl_r_bits_last;
  wire [11:0] Master_io_ctrl_r_bits_id;
  wire  Master_io_ctrl_r_bits_user;
  wire  Master_io_simReset;
  wire  Master_io_done;
  wire  Master_io_step_ready;
  wire  Master_io_step_valid;
  wire [31:0] Master_io_step_bits;
  wire  DefaultIOWidget_clock;
  wire  DefaultIOWidget_reset;
  wire  DefaultIOWidget_io_ctrl_aw_ready;
  wire  DefaultIOWidget_io_ctrl_aw_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_aw_bits_addr;
  wire [7:0] DefaultIOWidget_io_ctrl_aw_bits_len;
  wire [11:0] DefaultIOWidget_io_ctrl_aw_bits_id;
  wire  DefaultIOWidget_io_ctrl_w_ready;
  wire  DefaultIOWidget_io_ctrl_w_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_w_bits_data;
  wire  DefaultIOWidget_io_ctrl_b_ready;
  wire  DefaultIOWidget_io_ctrl_b_valid;
  wire [11:0] DefaultIOWidget_io_ctrl_b_bits_id;
  wire  DefaultIOWidget_io_ctrl_ar_ready;
  wire  DefaultIOWidget_io_ctrl_ar_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_ar_bits_addr;
  wire [7:0] DefaultIOWidget_io_ctrl_ar_bits_len;
  wire [11:0] DefaultIOWidget_io_ctrl_ar_bits_id;
  wire  DefaultIOWidget_io_ctrl_r_ready;
  wire  DefaultIOWidget_io_ctrl_r_valid;
  wire [31:0] DefaultIOWidget_io_ctrl_r_bits_data;
  wire [11:0] DefaultIOWidget_io_ctrl_r_bits_id;
  wire  DefaultIOWidget_io_ins_0_ready;
  wire  DefaultIOWidget_io_ins_0_valid;
  wire [31:0] DefaultIOWidget_io_ins_0_bits;
  wire  DefaultIOWidget_io_ins_1_ready;
  wire  DefaultIOWidget_io_ins_1_valid;
  wire [31:0] DefaultIOWidget_io_ins_1_bits;
  wire  DefaultIOWidget_io_outs_0_ready;
  wire  DefaultIOWidget_io_outs_0_valid;
  wire [31:0] DefaultIOWidget_io_outs_0_bits;
  wire  DefaultIOWidget_io_step_ready;
  wire  DefaultIOWidget_io_step_valid;
  wire [31:0] DefaultIOWidget_io_step_bits;
  wire  DefaultIOWidget_io_idle;
  wire  DaisyChainController_clock;
  wire  DaisyChainController_reset;
  wire  DaisyChainController_io_ctrl_aw_ready;
  wire  DaisyChainController_io_ctrl_aw_valid;
  wire [31:0] DaisyChainController_io_ctrl_aw_bits_addr;
  wire [7:0] DaisyChainController_io_ctrl_aw_bits_len;
  wire [11:0] DaisyChainController_io_ctrl_aw_bits_id;
  wire  DaisyChainController_io_ctrl_w_ready;
  wire  DaisyChainController_io_ctrl_w_valid;
  wire [31:0] DaisyChainController_io_ctrl_w_bits_data;
  wire  DaisyChainController_io_ctrl_b_ready;
  wire  DaisyChainController_io_ctrl_b_valid;
  wire [11:0] DaisyChainController_io_ctrl_b_bits_id;
  wire  DaisyChainController_io_ctrl_ar_ready;
  wire  DaisyChainController_io_ctrl_ar_valid;
  wire [31:0] DaisyChainController_io_ctrl_ar_bits_addr;
  wire [7:0] DaisyChainController_io_ctrl_ar_bits_len;
  wire [11:0] DaisyChainController_io_ctrl_ar_bits_id;
  wire  DaisyChainController_io_ctrl_r_ready;
  wire  DaisyChainController_io_ctrl_r_valid;
  wire [31:0] DaisyChainController_io_ctrl_r_bits_data;
  wire [11:0] DaisyChainController_io_ctrl_r_bits_id;
  wire  DaisyChainController_io_daisy_regs_0_in_ready;
  wire  DaisyChainController_io_daisy_regs_0_in_valid;
  wire [31:0] DaisyChainController_io_daisy_regs_0_in_bits;
  wire  DaisyChainController_io_daisy_regs_0_out_ready;
  wire  DaisyChainController_io_daisy_regs_0_out_valid;
  wire [31:0] DaisyChainController_io_daisy_regs_0_out_bits;
  wire  IOTraces_clock;
  wire  IOTraces_reset;
  wire  IOTraces_io_ctrl_aw_ready;
  wire  IOTraces_io_ctrl_aw_valid;
  wire [31:0] IOTraces_io_ctrl_aw_bits_addr;
  wire [7:0] IOTraces_io_ctrl_aw_bits_len;
  wire [11:0] IOTraces_io_ctrl_aw_bits_id;
  wire  IOTraces_io_ctrl_w_ready;
  wire  IOTraces_io_ctrl_w_valid;
  wire [31:0] IOTraces_io_ctrl_w_bits_data;
  wire  IOTraces_io_ctrl_b_ready;
  wire  IOTraces_io_ctrl_b_valid;
  wire [1:0] IOTraces_io_ctrl_b_bits_resp;
  wire [11:0] IOTraces_io_ctrl_b_bits_id;
  wire  IOTraces_io_ctrl_b_bits_user;
  wire  IOTraces_io_ctrl_ar_ready;
  wire  IOTraces_io_ctrl_ar_valid;
  wire [31:0] IOTraces_io_ctrl_ar_bits_addr;
  wire [7:0] IOTraces_io_ctrl_ar_bits_len;
  wire [11:0] IOTraces_io_ctrl_ar_bits_id;
  wire  IOTraces_io_ctrl_r_ready;
  wire  IOTraces_io_ctrl_r_valid;
  wire [1:0] IOTraces_io_ctrl_r_bits_resp;
  wire [31:0] IOTraces_io_ctrl_r_bits_data;
  wire  IOTraces_io_ctrl_r_bits_last;
  wire [11:0] IOTraces_io_ctrl_r_bits_id;
  wire  IOTraces_io_ctrl_r_bits_user;
  wire [31:0] IOTraces_io_traceLen;
  wire  IOTraces_io_wireIns_0_ready;
  wire  IOTraces_io_wireIns_0_valid;
  wire [31:0] IOTraces_io_wireIns_0_bits;
  wire  IOTraces_io_wireIns_1_ready;
  wire  IOTraces_io_wireIns_1_valid;
  wire [31:0] IOTraces_io_wireIns_1_bits;
  wire  IOTraces_io_wireOuts_0_ready;
  wire  IOTraces_io_wireOuts_0_valid;
  wire [31:0] IOTraces_io_wireOuts_0_bits;
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
  wire [7:0] LOADMEM_io_ctrl_aw_bits_len;
  wire [11:0] LOADMEM_io_ctrl_aw_bits_id;
  wire  LOADMEM_io_ctrl_w_ready;
  wire  LOADMEM_io_ctrl_w_valid;
  wire [31:0] LOADMEM_io_ctrl_w_bits_data;
  wire  LOADMEM_io_ctrl_b_ready;
  wire  LOADMEM_io_ctrl_b_valid;
  wire [11:0] LOADMEM_io_ctrl_b_bits_id;
  wire  LOADMEM_io_ctrl_ar_ready;
  wire  LOADMEM_io_ctrl_ar_valid;
  wire [31:0] LOADMEM_io_ctrl_ar_bits_addr;
  wire [7:0] LOADMEM_io_ctrl_ar_bits_len;
  wire [11:0] LOADMEM_io_ctrl_ar_bits_id;
  wire  LOADMEM_io_ctrl_r_ready;
  wire  LOADMEM_io_ctrl_r_valid;
  wire [31:0] LOADMEM_io_ctrl_r_bits_data;
  wire [11:0] LOADMEM_io_ctrl_r_bits_id;
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
  wire [7:0] NastiRecursiveInterconnect_io_masters_0_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_masters_0_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_masters_0_w_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_masters_0_w_bits_data;
  wire  NastiRecursiveInterconnect_io_masters_0_w_bits_last;
  wire  NastiRecursiveInterconnect_io_masters_0_b_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_b_valid;
  wire [1:0] NastiRecursiveInterconnect_io_masters_0_b_bits_resp;
  wire [11:0] NastiRecursiveInterconnect_io_masters_0_b_bits_id;
  wire  NastiRecursiveInterconnect_io_masters_0_b_bits_user;
  wire  NastiRecursiveInterconnect_io_masters_0_ar_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_masters_0_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_masters_0_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_masters_0_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_masters_0_r_ready;
  wire  NastiRecursiveInterconnect_io_masters_0_r_valid;
  wire [1:0] NastiRecursiveInterconnect_io_masters_0_r_bits_resp;
  wire [31:0] NastiRecursiveInterconnect_io_masters_0_r_bits_data;
  wire  NastiRecursiveInterconnect_io_masters_0_r_bits_last;
  wire [11:0] NastiRecursiveInterconnect_io_masters_0_r_bits_id;
  wire  NastiRecursiveInterconnect_io_masters_0_r_bits_user;
  wire  NastiRecursiveInterconnect_io_slaves_0_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_aw_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_0_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_0_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_0_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_0_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_b_valid;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_0_b_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_0_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_0_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_0_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_0_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_0_r_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_0_r_bits_data;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_0_r_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_1_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_aw_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_1_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_1_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_1_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_1_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_b_valid;
  wire [1:0] NastiRecursiveInterconnect_io_slaves_1_b_bits_resp;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_1_b_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_1_b_bits_user;
  wire  NastiRecursiveInterconnect_io_slaves_1_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_1_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_1_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_valid;
  wire [1:0] NastiRecursiveInterconnect_io_slaves_1_r_bits_resp;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_1_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_bits_last;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_1_r_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_1_r_bits_user;
  wire  NastiRecursiveInterconnect_io_slaves_2_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_2_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_2_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_2_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_2_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_b_valid;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_2_b_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_2_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_2_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_2_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_2_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_2_r_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_2_r_bits_data;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_2_r_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_3_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_3_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_3_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_3_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_3_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_b_valid;
  wire [1:0] NastiRecursiveInterconnect_io_slaves_3_b_bits_resp;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_3_b_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_3_b_bits_user;
  wire  NastiRecursiveInterconnect_io_slaves_3_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_3_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_3_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_valid;
  wire [1:0] NastiRecursiveInterconnect_io_slaves_3_r_bits_resp;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_3_r_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_bits_last;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_3_r_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_3_r_bits_user;
  wire  NastiRecursiveInterconnect_io_slaves_4_aw_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_aw_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_aw_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_4_aw_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_4_aw_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_4_w_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_w_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_w_bits_data;
  wire  NastiRecursiveInterconnect_io_slaves_4_b_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_b_valid;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_4_b_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_4_ar_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_ar_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr;
  wire [7:0] NastiRecursiveInterconnect_io_slaves_4_ar_bits_len;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_4_ar_bits_id;
  wire  NastiRecursiveInterconnect_io_slaves_4_r_ready;
  wire  NastiRecursiveInterconnect_io_slaves_4_r_valid;
  wire [31:0] NastiRecursiveInterconnect_io_slaves_4_r_bits_data;
  wire [11:0] NastiRecursiveInterconnect_io_slaves_4_r_bits_id;
  wire [12:0] _T_538;
  wire [12:0] _T_539;
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
    .io_ctrl_aw_bits_len(Master_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(Master_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(Master_io_ctrl_w_ready),
    .io_ctrl_w_valid(Master_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(Master_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(Master_io_ctrl_b_ready),
    .io_ctrl_b_valid(Master_io_ctrl_b_valid),
    .io_ctrl_b_bits_resp(Master_io_ctrl_b_bits_resp),
    .io_ctrl_b_bits_id(Master_io_ctrl_b_bits_id),
    .io_ctrl_b_bits_user(Master_io_ctrl_b_bits_user),
    .io_ctrl_ar_ready(Master_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(Master_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(Master_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(Master_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(Master_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(Master_io_ctrl_r_ready),
    .io_ctrl_r_valid(Master_io_ctrl_r_valid),
    .io_ctrl_r_bits_resp(Master_io_ctrl_r_bits_resp),
    .io_ctrl_r_bits_data(Master_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_last(Master_io_ctrl_r_bits_last),
    .io_ctrl_r_bits_id(Master_io_ctrl_r_bits_id),
    .io_ctrl_r_bits_user(Master_io_ctrl_r_bits_user),
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
    .io_ctrl_aw_bits_len(DefaultIOWidget_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(DefaultIOWidget_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(DefaultIOWidget_io_ctrl_w_ready),
    .io_ctrl_w_valid(DefaultIOWidget_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(DefaultIOWidget_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(DefaultIOWidget_io_ctrl_b_ready),
    .io_ctrl_b_valid(DefaultIOWidget_io_ctrl_b_valid),
    .io_ctrl_b_bits_id(DefaultIOWidget_io_ctrl_b_bits_id),
    .io_ctrl_ar_ready(DefaultIOWidget_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(DefaultIOWidget_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(DefaultIOWidget_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(DefaultIOWidget_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(DefaultIOWidget_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(DefaultIOWidget_io_ctrl_r_ready),
    .io_ctrl_r_valid(DefaultIOWidget_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(DefaultIOWidget_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_id(DefaultIOWidget_io_ctrl_r_bits_id),
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
    .io_ctrl_aw_bits_len(DaisyChainController_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(DaisyChainController_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(DaisyChainController_io_ctrl_w_ready),
    .io_ctrl_w_valid(DaisyChainController_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(DaisyChainController_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(DaisyChainController_io_ctrl_b_ready),
    .io_ctrl_b_valid(DaisyChainController_io_ctrl_b_valid),
    .io_ctrl_b_bits_id(DaisyChainController_io_ctrl_b_bits_id),
    .io_ctrl_ar_ready(DaisyChainController_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(DaisyChainController_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(DaisyChainController_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(DaisyChainController_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(DaisyChainController_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(DaisyChainController_io_ctrl_r_ready),
    .io_ctrl_r_valid(DaisyChainController_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(DaisyChainController_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_id(DaisyChainController_io_ctrl_r_bits_id),
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
    .io_ctrl_aw_bits_len(IOTraces_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(IOTraces_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(IOTraces_io_ctrl_w_ready),
    .io_ctrl_w_valid(IOTraces_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(IOTraces_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(IOTraces_io_ctrl_b_ready),
    .io_ctrl_b_valid(IOTraces_io_ctrl_b_valid),
    .io_ctrl_b_bits_resp(IOTraces_io_ctrl_b_bits_resp),
    .io_ctrl_b_bits_id(IOTraces_io_ctrl_b_bits_id),
    .io_ctrl_b_bits_user(IOTraces_io_ctrl_b_bits_user),
    .io_ctrl_ar_ready(IOTraces_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(IOTraces_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(IOTraces_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(IOTraces_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(IOTraces_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(IOTraces_io_ctrl_r_ready),
    .io_ctrl_r_valid(IOTraces_io_ctrl_r_valid),
    .io_ctrl_r_bits_resp(IOTraces_io_ctrl_r_bits_resp),
    .io_ctrl_r_bits_data(IOTraces_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_last(IOTraces_io_ctrl_r_bits_last),
    .io_ctrl_r_bits_id(IOTraces_io_ctrl_r_bits_id),
    .io_ctrl_r_bits_user(IOTraces_io_ctrl_r_bits_user),
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
    .io_ctrl_aw_bits_len(LOADMEM_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(LOADMEM_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(LOADMEM_io_ctrl_w_ready),
    .io_ctrl_w_valid(LOADMEM_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(LOADMEM_io_ctrl_w_bits_data),
    .io_ctrl_b_ready(LOADMEM_io_ctrl_b_ready),
    .io_ctrl_b_valid(LOADMEM_io_ctrl_b_valid),
    .io_ctrl_b_bits_id(LOADMEM_io_ctrl_b_bits_id),
    .io_ctrl_ar_ready(LOADMEM_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(LOADMEM_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(LOADMEM_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(LOADMEM_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(LOADMEM_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(LOADMEM_io_ctrl_r_ready),
    .io_ctrl_r_valid(LOADMEM_io_ctrl_r_valid),
    .io_ctrl_r_bits_data(LOADMEM_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_id(LOADMEM_io_ctrl_r_bits_id),
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
    .io_masters_0_aw_bits_len(NastiRecursiveInterconnect_io_masters_0_aw_bits_len),
    .io_masters_0_aw_bits_id(NastiRecursiveInterconnect_io_masters_0_aw_bits_id),
    .io_masters_0_w_ready(NastiRecursiveInterconnect_io_masters_0_w_ready),
    .io_masters_0_w_valid(NastiRecursiveInterconnect_io_masters_0_w_valid),
    .io_masters_0_w_bits_data(NastiRecursiveInterconnect_io_masters_0_w_bits_data),
    .io_masters_0_w_bits_last(NastiRecursiveInterconnect_io_masters_0_w_bits_last),
    .io_masters_0_b_ready(NastiRecursiveInterconnect_io_masters_0_b_ready),
    .io_masters_0_b_valid(NastiRecursiveInterconnect_io_masters_0_b_valid),
    .io_masters_0_b_bits_resp(NastiRecursiveInterconnect_io_masters_0_b_bits_resp),
    .io_masters_0_b_bits_id(NastiRecursiveInterconnect_io_masters_0_b_bits_id),
    .io_masters_0_b_bits_user(NastiRecursiveInterconnect_io_masters_0_b_bits_user),
    .io_masters_0_ar_ready(NastiRecursiveInterconnect_io_masters_0_ar_ready),
    .io_masters_0_ar_valid(NastiRecursiveInterconnect_io_masters_0_ar_valid),
    .io_masters_0_ar_bits_addr(NastiRecursiveInterconnect_io_masters_0_ar_bits_addr),
    .io_masters_0_ar_bits_len(NastiRecursiveInterconnect_io_masters_0_ar_bits_len),
    .io_masters_0_ar_bits_id(NastiRecursiveInterconnect_io_masters_0_ar_bits_id),
    .io_masters_0_r_ready(NastiRecursiveInterconnect_io_masters_0_r_ready),
    .io_masters_0_r_valid(NastiRecursiveInterconnect_io_masters_0_r_valid),
    .io_masters_0_r_bits_resp(NastiRecursiveInterconnect_io_masters_0_r_bits_resp),
    .io_masters_0_r_bits_data(NastiRecursiveInterconnect_io_masters_0_r_bits_data),
    .io_masters_0_r_bits_last(NastiRecursiveInterconnect_io_masters_0_r_bits_last),
    .io_masters_0_r_bits_id(NastiRecursiveInterconnect_io_masters_0_r_bits_id),
    .io_masters_0_r_bits_user(NastiRecursiveInterconnect_io_masters_0_r_bits_user),
    .io_slaves_0_aw_ready(NastiRecursiveInterconnect_io_slaves_0_aw_ready),
    .io_slaves_0_aw_valid(NastiRecursiveInterconnect_io_slaves_0_aw_valid),
    .io_slaves_0_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_0_aw_bits_addr),
    .io_slaves_0_aw_bits_len(NastiRecursiveInterconnect_io_slaves_0_aw_bits_len),
    .io_slaves_0_aw_bits_id(NastiRecursiveInterconnect_io_slaves_0_aw_bits_id),
    .io_slaves_0_w_ready(NastiRecursiveInterconnect_io_slaves_0_w_ready),
    .io_slaves_0_w_valid(NastiRecursiveInterconnect_io_slaves_0_w_valid),
    .io_slaves_0_w_bits_data(NastiRecursiveInterconnect_io_slaves_0_w_bits_data),
    .io_slaves_0_b_ready(NastiRecursiveInterconnect_io_slaves_0_b_ready),
    .io_slaves_0_b_valid(NastiRecursiveInterconnect_io_slaves_0_b_valid),
    .io_slaves_0_b_bits_id(NastiRecursiveInterconnect_io_slaves_0_b_bits_id),
    .io_slaves_0_ar_ready(NastiRecursiveInterconnect_io_slaves_0_ar_ready),
    .io_slaves_0_ar_valid(NastiRecursiveInterconnect_io_slaves_0_ar_valid),
    .io_slaves_0_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr),
    .io_slaves_0_ar_bits_len(NastiRecursiveInterconnect_io_slaves_0_ar_bits_len),
    .io_slaves_0_ar_bits_id(NastiRecursiveInterconnect_io_slaves_0_ar_bits_id),
    .io_slaves_0_r_ready(NastiRecursiveInterconnect_io_slaves_0_r_ready),
    .io_slaves_0_r_valid(NastiRecursiveInterconnect_io_slaves_0_r_valid),
    .io_slaves_0_r_bits_data(NastiRecursiveInterconnect_io_slaves_0_r_bits_data),
    .io_slaves_0_r_bits_id(NastiRecursiveInterconnect_io_slaves_0_r_bits_id),
    .io_slaves_1_aw_ready(NastiRecursiveInterconnect_io_slaves_1_aw_ready),
    .io_slaves_1_aw_valid(NastiRecursiveInterconnect_io_slaves_1_aw_valid),
    .io_slaves_1_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_1_aw_bits_addr),
    .io_slaves_1_aw_bits_len(NastiRecursiveInterconnect_io_slaves_1_aw_bits_len),
    .io_slaves_1_aw_bits_id(NastiRecursiveInterconnect_io_slaves_1_aw_bits_id),
    .io_slaves_1_w_ready(NastiRecursiveInterconnect_io_slaves_1_w_ready),
    .io_slaves_1_w_valid(NastiRecursiveInterconnect_io_slaves_1_w_valid),
    .io_slaves_1_w_bits_data(NastiRecursiveInterconnect_io_slaves_1_w_bits_data),
    .io_slaves_1_b_ready(NastiRecursiveInterconnect_io_slaves_1_b_ready),
    .io_slaves_1_b_valid(NastiRecursiveInterconnect_io_slaves_1_b_valid),
    .io_slaves_1_b_bits_resp(NastiRecursiveInterconnect_io_slaves_1_b_bits_resp),
    .io_slaves_1_b_bits_id(NastiRecursiveInterconnect_io_slaves_1_b_bits_id),
    .io_slaves_1_b_bits_user(NastiRecursiveInterconnect_io_slaves_1_b_bits_user),
    .io_slaves_1_ar_ready(NastiRecursiveInterconnect_io_slaves_1_ar_ready),
    .io_slaves_1_ar_valid(NastiRecursiveInterconnect_io_slaves_1_ar_valid),
    .io_slaves_1_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr),
    .io_slaves_1_ar_bits_len(NastiRecursiveInterconnect_io_slaves_1_ar_bits_len),
    .io_slaves_1_ar_bits_id(NastiRecursiveInterconnect_io_slaves_1_ar_bits_id),
    .io_slaves_1_r_ready(NastiRecursiveInterconnect_io_slaves_1_r_ready),
    .io_slaves_1_r_valid(NastiRecursiveInterconnect_io_slaves_1_r_valid),
    .io_slaves_1_r_bits_resp(NastiRecursiveInterconnect_io_slaves_1_r_bits_resp),
    .io_slaves_1_r_bits_data(NastiRecursiveInterconnect_io_slaves_1_r_bits_data),
    .io_slaves_1_r_bits_last(NastiRecursiveInterconnect_io_slaves_1_r_bits_last),
    .io_slaves_1_r_bits_id(NastiRecursiveInterconnect_io_slaves_1_r_bits_id),
    .io_slaves_1_r_bits_user(NastiRecursiveInterconnect_io_slaves_1_r_bits_user),
    .io_slaves_2_aw_ready(NastiRecursiveInterconnect_io_slaves_2_aw_ready),
    .io_slaves_2_aw_valid(NastiRecursiveInterconnect_io_slaves_2_aw_valid),
    .io_slaves_2_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr),
    .io_slaves_2_aw_bits_len(NastiRecursiveInterconnect_io_slaves_2_aw_bits_len),
    .io_slaves_2_aw_bits_id(NastiRecursiveInterconnect_io_slaves_2_aw_bits_id),
    .io_slaves_2_w_ready(NastiRecursiveInterconnect_io_slaves_2_w_ready),
    .io_slaves_2_w_valid(NastiRecursiveInterconnect_io_slaves_2_w_valid),
    .io_slaves_2_w_bits_data(NastiRecursiveInterconnect_io_slaves_2_w_bits_data),
    .io_slaves_2_b_ready(NastiRecursiveInterconnect_io_slaves_2_b_ready),
    .io_slaves_2_b_valid(NastiRecursiveInterconnect_io_slaves_2_b_valid),
    .io_slaves_2_b_bits_id(NastiRecursiveInterconnect_io_slaves_2_b_bits_id),
    .io_slaves_2_ar_ready(NastiRecursiveInterconnect_io_slaves_2_ar_ready),
    .io_slaves_2_ar_valid(NastiRecursiveInterconnect_io_slaves_2_ar_valid),
    .io_slaves_2_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr),
    .io_slaves_2_ar_bits_len(NastiRecursiveInterconnect_io_slaves_2_ar_bits_len),
    .io_slaves_2_ar_bits_id(NastiRecursiveInterconnect_io_slaves_2_ar_bits_id),
    .io_slaves_2_r_ready(NastiRecursiveInterconnect_io_slaves_2_r_ready),
    .io_slaves_2_r_valid(NastiRecursiveInterconnect_io_slaves_2_r_valid),
    .io_slaves_2_r_bits_data(NastiRecursiveInterconnect_io_slaves_2_r_bits_data),
    .io_slaves_2_r_bits_id(NastiRecursiveInterconnect_io_slaves_2_r_bits_id),
    .io_slaves_3_aw_ready(NastiRecursiveInterconnect_io_slaves_3_aw_ready),
    .io_slaves_3_aw_valid(NastiRecursiveInterconnect_io_slaves_3_aw_valid),
    .io_slaves_3_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr),
    .io_slaves_3_aw_bits_len(NastiRecursiveInterconnect_io_slaves_3_aw_bits_len),
    .io_slaves_3_aw_bits_id(NastiRecursiveInterconnect_io_slaves_3_aw_bits_id),
    .io_slaves_3_w_ready(NastiRecursiveInterconnect_io_slaves_3_w_ready),
    .io_slaves_3_w_valid(NastiRecursiveInterconnect_io_slaves_3_w_valid),
    .io_slaves_3_w_bits_data(NastiRecursiveInterconnect_io_slaves_3_w_bits_data),
    .io_slaves_3_b_ready(NastiRecursiveInterconnect_io_slaves_3_b_ready),
    .io_slaves_3_b_valid(NastiRecursiveInterconnect_io_slaves_3_b_valid),
    .io_slaves_3_b_bits_resp(NastiRecursiveInterconnect_io_slaves_3_b_bits_resp),
    .io_slaves_3_b_bits_id(NastiRecursiveInterconnect_io_slaves_3_b_bits_id),
    .io_slaves_3_b_bits_user(NastiRecursiveInterconnect_io_slaves_3_b_bits_user),
    .io_slaves_3_ar_ready(NastiRecursiveInterconnect_io_slaves_3_ar_ready),
    .io_slaves_3_ar_valid(NastiRecursiveInterconnect_io_slaves_3_ar_valid),
    .io_slaves_3_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr),
    .io_slaves_3_ar_bits_len(NastiRecursiveInterconnect_io_slaves_3_ar_bits_len),
    .io_slaves_3_ar_bits_id(NastiRecursiveInterconnect_io_slaves_3_ar_bits_id),
    .io_slaves_3_r_ready(NastiRecursiveInterconnect_io_slaves_3_r_ready),
    .io_slaves_3_r_valid(NastiRecursiveInterconnect_io_slaves_3_r_valid),
    .io_slaves_3_r_bits_resp(NastiRecursiveInterconnect_io_slaves_3_r_bits_resp),
    .io_slaves_3_r_bits_data(NastiRecursiveInterconnect_io_slaves_3_r_bits_data),
    .io_slaves_3_r_bits_last(NastiRecursiveInterconnect_io_slaves_3_r_bits_last),
    .io_slaves_3_r_bits_id(NastiRecursiveInterconnect_io_slaves_3_r_bits_id),
    .io_slaves_3_r_bits_user(NastiRecursiveInterconnect_io_slaves_3_r_bits_user),
    .io_slaves_4_aw_ready(NastiRecursiveInterconnect_io_slaves_4_aw_ready),
    .io_slaves_4_aw_valid(NastiRecursiveInterconnect_io_slaves_4_aw_valid),
    .io_slaves_4_aw_bits_addr(NastiRecursiveInterconnect_io_slaves_4_aw_bits_addr),
    .io_slaves_4_aw_bits_len(NastiRecursiveInterconnect_io_slaves_4_aw_bits_len),
    .io_slaves_4_aw_bits_id(NastiRecursiveInterconnect_io_slaves_4_aw_bits_id),
    .io_slaves_4_w_ready(NastiRecursiveInterconnect_io_slaves_4_w_ready),
    .io_slaves_4_w_valid(NastiRecursiveInterconnect_io_slaves_4_w_valid),
    .io_slaves_4_w_bits_data(NastiRecursiveInterconnect_io_slaves_4_w_bits_data),
    .io_slaves_4_b_ready(NastiRecursiveInterconnect_io_slaves_4_b_ready),
    .io_slaves_4_b_valid(NastiRecursiveInterconnect_io_slaves_4_b_valid),
    .io_slaves_4_b_bits_id(NastiRecursiveInterconnect_io_slaves_4_b_bits_id),
    .io_slaves_4_ar_ready(NastiRecursiveInterconnect_io_slaves_4_ar_ready),
    .io_slaves_4_ar_valid(NastiRecursiveInterconnect_io_slaves_4_ar_valid),
    .io_slaves_4_ar_bits_addr(NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr),
    .io_slaves_4_ar_bits_len(NastiRecursiveInterconnect_io_slaves_4_ar_bits_len),
    .io_slaves_4_ar_bits_id(NastiRecursiveInterconnect_io_slaves_4_ar_bits_id),
    .io_slaves_4_r_ready(NastiRecursiveInterconnect_io_slaves_4_r_ready),
    .io_slaves_4_r_valid(NastiRecursiveInterconnect_io_slaves_4_r_valid),
    .io_slaves_4_r_bits_data(NastiRecursiveInterconnect_io_slaves_4_r_bits_data),
    .io_slaves_4_r_bits_id(NastiRecursiveInterconnect_io_slaves_4_r_bits_id)
  );
  assign io_ctrl_aw_ready = NastiRecursiveInterconnect_io_masters_0_aw_ready;
  assign io_ctrl_w_ready = NastiRecursiveInterconnect_io_masters_0_w_ready;
  assign io_ctrl_b_valid = NastiRecursiveInterconnect_io_masters_0_b_valid;
  assign io_ctrl_b_bits_resp = NastiRecursiveInterconnect_io_masters_0_b_bits_resp;
  assign io_ctrl_b_bits_id = NastiRecursiveInterconnect_io_masters_0_b_bits_id;
  assign io_ctrl_b_bits_user = NastiRecursiveInterconnect_io_masters_0_b_bits_user;
  assign io_ctrl_ar_ready = NastiRecursiveInterconnect_io_masters_0_ar_ready;
  assign io_ctrl_r_valid = NastiRecursiveInterconnect_io_masters_0_r_valid;
  assign io_ctrl_r_bits_resp = NastiRecursiveInterconnect_io_masters_0_r_bits_resp;
  assign io_ctrl_r_bits_data = NastiRecursiveInterconnect_io_masters_0_r_bits_data;
  assign io_ctrl_r_bits_last = NastiRecursiveInterconnect_io_masters_0_r_bits_last;
  assign io_ctrl_r_bits_id = NastiRecursiveInterconnect_io_masters_0_r_bits_id;
  assign io_ctrl_r_bits_user = NastiRecursiveInterconnect_io_masters_0_r_bits_user;
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
  assign Master_io_ctrl_aw_bits_len = NastiRecursiveInterconnect_io_slaves_1_aw_bits_len;
  assign Master_io_ctrl_aw_bits_id = NastiRecursiveInterconnect_io_slaves_1_aw_bits_id;
  assign Master_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_1_w_valid;
  assign Master_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_1_w_bits_data;
  assign Master_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_1_b_ready;
  assign Master_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_1_ar_valid;
  assign Master_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_1_ar_bits_addr;
  assign Master_io_ctrl_ar_bits_len = NastiRecursiveInterconnect_io_slaves_1_ar_bits_len;
  assign Master_io_ctrl_ar_bits_id = NastiRecursiveInterconnect_io_slaves_1_ar_bits_id;
  assign Master_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_1_r_ready;
  assign Master_io_done = DefaultIOWidget_io_idle;
  assign Master_io_step_ready = DefaultIOWidget_io_step_ready;
  assign DefaultIOWidget_clock = clock;
  assign DefaultIOWidget_reset = _T_531;
  assign DefaultIOWidget_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_2_aw_valid;
  assign DefaultIOWidget_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_2_aw_bits_addr;
  assign DefaultIOWidget_io_ctrl_aw_bits_len = NastiRecursiveInterconnect_io_slaves_2_aw_bits_len;
  assign DefaultIOWidget_io_ctrl_aw_bits_id = NastiRecursiveInterconnect_io_slaves_2_aw_bits_id;
  assign DefaultIOWidget_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_2_w_valid;
  assign DefaultIOWidget_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_2_w_bits_data;
  assign DefaultIOWidget_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_2_b_ready;
  assign DefaultIOWidget_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_2_ar_valid;
  assign DefaultIOWidget_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_2_ar_bits_addr;
  assign DefaultIOWidget_io_ctrl_ar_bits_len = NastiRecursiveInterconnect_io_slaves_2_ar_bits_len;
  assign DefaultIOWidget_io_ctrl_ar_bits_id = NastiRecursiveInterconnect_io_slaves_2_ar_bits_id;
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
  assign DaisyChainController_io_ctrl_aw_bits_len = NastiRecursiveInterconnect_io_slaves_0_aw_bits_len;
  assign DaisyChainController_io_ctrl_aw_bits_id = NastiRecursiveInterconnect_io_slaves_0_aw_bits_id;
  assign DaisyChainController_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_0_w_valid;
  assign DaisyChainController_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_0_w_bits_data;
  assign DaisyChainController_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_0_b_ready;
  assign DaisyChainController_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_0_ar_valid;
  assign DaisyChainController_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_0_ar_bits_addr;
  assign DaisyChainController_io_ctrl_ar_bits_len = NastiRecursiveInterconnect_io_slaves_0_ar_bits_len;
  assign DaisyChainController_io_ctrl_ar_bits_id = NastiRecursiveInterconnect_io_slaves_0_ar_bits_id;
  assign DaisyChainController_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_0_r_ready;
  assign DaisyChainController_io_daisy_regs_0_in_ready = sim_io_daisy_regs_0_in_ready;
  assign DaisyChainController_io_daisy_regs_0_out_valid = sim_io_daisy_regs_0_out_valid;
  assign DaisyChainController_io_daisy_regs_0_out_bits = sim_io_daisy_regs_0_out_bits;
  assign IOTraces_clock = clock;
  assign IOTraces_reset = _T_531;
  assign IOTraces_io_ctrl_aw_valid = NastiRecursiveInterconnect_io_slaves_3_aw_valid;
  assign IOTraces_io_ctrl_aw_bits_addr = NastiRecursiveInterconnect_io_slaves_3_aw_bits_addr;
  assign IOTraces_io_ctrl_aw_bits_len = NastiRecursiveInterconnect_io_slaves_3_aw_bits_len;
  assign IOTraces_io_ctrl_aw_bits_id = NastiRecursiveInterconnect_io_slaves_3_aw_bits_id;
  assign IOTraces_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_3_w_valid;
  assign IOTraces_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_3_w_bits_data;
  assign IOTraces_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_3_b_ready;
  assign IOTraces_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_3_ar_valid;
  assign IOTraces_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_3_ar_bits_addr;
  assign IOTraces_io_ctrl_ar_bits_len = NastiRecursiveInterconnect_io_slaves_3_ar_bits_len;
  assign IOTraces_io_ctrl_ar_bits_id = NastiRecursiveInterconnect_io_slaves_3_ar_bits_id;
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
  assign LOADMEM_io_ctrl_aw_bits_len = NastiRecursiveInterconnect_io_slaves_4_aw_bits_len;
  assign LOADMEM_io_ctrl_aw_bits_id = NastiRecursiveInterconnect_io_slaves_4_aw_bits_id;
  assign LOADMEM_io_ctrl_w_valid = NastiRecursiveInterconnect_io_slaves_4_w_valid;
  assign LOADMEM_io_ctrl_w_bits_data = NastiRecursiveInterconnect_io_slaves_4_w_bits_data;
  assign LOADMEM_io_ctrl_b_ready = NastiRecursiveInterconnect_io_slaves_4_b_ready;
  assign LOADMEM_io_ctrl_ar_valid = NastiRecursiveInterconnect_io_slaves_4_ar_valid;
  assign LOADMEM_io_ctrl_ar_bits_addr = NastiRecursiveInterconnect_io_slaves_4_ar_bits_addr;
  assign LOADMEM_io_ctrl_ar_bits_len = NastiRecursiveInterconnect_io_slaves_4_ar_bits_len;
  assign LOADMEM_io_ctrl_ar_bits_id = NastiRecursiveInterconnect_io_slaves_4_ar_bits_id;
  assign LOADMEM_io_ctrl_r_ready = NastiRecursiveInterconnect_io_slaves_4_r_ready;
  assign LOADMEM_io_toSlaveMem_aw_ready = arb_io_master_0_aw_ready;
  assign LOADMEM_io_toSlaveMem_w_ready = arb_io_master_0_w_ready;
  assign LOADMEM_io_toSlaveMem_ar_ready = arb_io_master_0_ar_ready;
  assign LOADMEM_io_toSlaveMem_r_valid = arb_io_master_0_r_valid;
  assign NastiRecursiveInterconnect_clock = clock;
  assign NastiRecursiveInterconnect_reset = reset;
  assign NastiRecursiveInterconnect_io_masters_0_aw_valid = io_ctrl_aw_valid;
  assign NastiRecursiveInterconnect_io_masters_0_aw_bits_addr = {{19'd0}, _T_538};
  assign NastiRecursiveInterconnect_io_masters_0_aw_bits_len = io_ctrl_aw_bits_len;
  assign NastiRecursiveInterconnect_io_masters_0_aw_bits_id = io_ctrl_aw_bits_id;
  assign NastiRecursiveInterconnect_io_masters_0_w_valid = io_ctrl_w_valid;
  assign NastiRecursiveInterconnect_io_masters_0_w_bits_data = io_ctrl_w_bits_data;
  assign NastiRecursiveInterconnect_io_masters_0_w_bits_last = io_ctrl_w_bits_last;
  assign NastiRecursiveInterconnect_io_masters_0_b_ready = io_ctrl_b_ready;
  assign NastiRecursiveInterconnect_io_masters_0_ar_valid = io_ctrl_ar_valid;
  assign NastiRecursiveInterconnect_io_masters_0_ar_bits_addr = {{19'd0}, _T_539};
  assign NastiRecursiveInterconnect_io_masters_0_ar_bits_len = io_ctrl_ar_bits_len;
  assign NastiRecursiveInterconnect_io_masters_0_ar_bits_id = io_ctrl_ar_bits_id;
  assign NastiRecursiveInterconnect_io_masters_0_r_ready = io_ctrl_r_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_aw_ready = DaisyChainController_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_w_ready = DaisyChainController_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_b_valid = DaisyChainController_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_0_b_bits_id = DaisyChainController_io_ctrl_b_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_0_ar_ready = DaisyChainController_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_0_r_valid = DaisyChainController_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_0_r_bits_data = DaisyChainController_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_0_r_bits_id = DaisyChainController_io_ctrl_r_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_1_aw_ready = Master_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_w_ready = Master_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_b_valid = Master_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_1_b_bits_resp = Master_io_ctrl_b_bits_resp;
  assign NastiRecursiveInterconnect_io_slaves_1_b_bits_id = Master_io_ctrl_b_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_1_b_bits_user = Master_io_ctrl_b_bits_user;
  assign NastiRecursiveInterconnect_io_slaves_1_ar_ready = Master_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_1_r_valid = Master_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_resp = Master_io_ctrl_r_bits_resp;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_data = Master_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_last = Master_io_ctrl_r_bits_last;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_id = Master_io_ctrl_r_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_1_r_bits_user = Master_io_ctrl_r_bits_user;
  assign NastiRecursiveInterconnect_io_slaves_2_aw_ready = DefaultIOWidget_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_w_ready = DefaultIOWidget_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_b_valid = DefaultIOWidget_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_2_b_bits_id = DefaultIOWidget_io_ctrl_b_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_2_ar_ready = DefaultIOWidget_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_2_r_valid = DefaultIOWidget_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_2_r_bits_data = DefaultIOWidget_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_2_r_bits_id = DefaultIOWidget_io_ctrl_r_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_3_aw_ready = IOTraces_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_w_ready = IOTraces_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_b_valid = IOTraces_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_3_b_bits_resp = IOTraces_io_ctrl_b_bits_resp;
  assign NastiRecursiveInterconnect_io_slaves_3_b_bits_id = IOTraces_io_ctrl_b_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_3_b_bits_user = IOTraces_io_ctrl_b_bits_user;
  assign NastiRecursiveInterconnect_io_slaves_3_ar_ready = IOTraces_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_3_r_valid = IOTraces_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_resp = IOTraces_io_ctrl_r_bits_resp;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_data = IOTraces_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_last = IOTraces_io_ctrl_r_bits_last;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_id = IOTraces_io_ctrl_r_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_3_r_bits_user = IOTraces_io_ctrl_r_bits_user;
  assign NastiRecursiveInterconnect_io_slaves_4_aw_ready = LOADMEM_io_ctrl_aw_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_w_ready = LOADMEM_io_ctrl_w_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_b_valid = LOADMEM_io_ctrl_b_valid;
  assign NastiRecursiveInterconnect_io_slaves_4_b_bits_id = LOADMEM_io_ctrl_b_bits_id;
  assign NastiRecursiveInterconnect_io_slaves_4_ar_ready = LOADMEM_io_ctrl_ar_ready;
  assign NastiRecursiveInterconnect_io_slaves_4_r_valid = LOADMEM_io_ctrl_r_valid;
  assign NastiRecursiveInterconnect_io_slaves_4_r_bits_data = LOADMEM_io_ctrl_r_bits_data;
  assign NastiRecursiveInterconnect_io_slaves_4_r_bits_id = LOADMEM_io_ctrl_r_bits_id;
  assign _T_538 = io_ctrl_aw_bits_addr[12:0];
  assign _T_539 = io_ctrl_ar_bits_addr[12:0];
endmodule
module ZynqShim(
  input         clock,
  input         reset,
  output        io_master_aw_ready,
  input         io_master_aw_valid,
  input  [31:0] io_master_aw_bits_addr,
  input  [7:0]  io_master_aw_bits_len,
  input  [2:0]  io_master_aw_bits_size,
  input  [1:0]  io_master_aw_bits_burst,
  input         io_master_aw_bits_lock,
  input  [3:0]  io_master_aw_bits_cache,
  input  [2:0]  io_master_aw_bits_prot,
  input  [3:0]  io_master_aw_bits_qos,
  input  [3:0]  io_master_aw_bits_region,
  input  [11:0] io_master_aw_bits_id,
  input         io_master_aw_bits_user,
  output        io_master_w_ready,
  input         io_master_w_valid,
  input  [31:0] io_master_w_bits_data,
  input         io_master_w_bits_last,
  input  [11:0] io_master_w_bits_id,
  input  [3:0]  io_master_w_bits_strb,
  input         io_master_w_bits_user,
  input         io_master_b_ready,
  output        io_master_b_valid,
  output [1:0]  io_master_b_bits_resp,
  output [11:0] io_master_b_bits_id,
  output        io_master_b_bits_user,
  output        io_master_ar_ready,
  input         io_master_ar_valid,
  input  [31:0] io_master_ar_bits_addr,
  input  [7:0]  io_master_ar_bits_len,
  input  [2:0]  io_master_ar_bits_size,
  input  [1:0]  io_master_ar_bits_burst,
  input         io_master_ar_bits_lock,
  input  [3:0]  io_master_ar_bits_cache,
  input  [2:0]  io_master_ar_bits_prot,
  input  [3:0]  io_master_ar_bits_qos,
  input  [3:0]  io_master_ar_bits_region,
  input  [11:0] io_master_ar_bits_id,
  input         io_master_ar_bits_user,
  input         io_master_r_ready,
  output        io_master_r_valid,
  output [1:0]  io_master_r_bits_resp,
  output [31:0] io_master_r_bits_data,
  output        io_master_r_bits_last,
  output [11:0] io_master_r_bits_id,
  output        io_master_r_bits_user,
  input         io_slave_aw_ready,
  output        io_slave_aw_valid,
  output [31:0] io_slave_aw_bits_addr,
  output [7:0]  io_slave_aw_bits_len,
  output [2:0]  io_slave_aw_bits_size,
  output [1:0]  io_slave_aw_bits_burst,
  output        io_slave_aw_bits_lock,
  output [3:0]  io_slave_aw_bits_cache,
  output [2:0]  io_slave_aw_bits_prot,
  output [3:0]  io_slave_aw_bits_qos,
  output [3:0]  io_slave_aw_bits_region,
  output [5:0]  io_slave_aw_bits_id,
  output        io_slave_aw_bits_user,
  input         io_slave_w_ready,
  output        io_slave_w_valid,
  output [63:0] io_slave_w_bits_data,
  output        io_slave_w_bits_last,
  output [5:0]  io_slave_w_bits_id,
  output [7:0]  io_slave_w_bits_strb,
  output        io_slave_w_bits_user,
  output        io_slave_b_ready,
  input         io_slave_b_valid,
  input  [1:0]  io_slave_b_bits_resp,
  input  [5:0]  io_slave_b_bits_id,
  input         io_slave_b_bits_user,
  input         io_slave_ar_ready,
  output        io_slave_ar_valid,
  output [31:0] io_slave_ar_bits_addr,
  output [7:0]  io_slave_ar_bits_len,
  output [2:0]  io_slave_ar_bits_size,
  output [1:0]  io_slave_ar_bits_burst,
  output        io_slave_ar_bits_lock,
  output [3:0]  io_slave_ar_bits_cache,
  output [2:0]  io_slave_ar_bits_prot,
  output [3:0]  io_slave_ar_bits_qos,
  output [3:0]  io_slave_ar_bits_region,
  output [5:0]  io_slave_ar_bits_id,
  output        io_slave_ar_bits_user,
  output        io_slave_r_ready,
  input         io_slave_r_valid,
  input  [1:0]  io_slave_r_bits_resp,
  input  [63:0] io_slave_r_bits_data,
  input         io_slave_r_bits_last,
  input  [5:0]  io_slave_r_bits_id,
  input         io_slave_r_bits_user
);
  wire  top_clock;
  wire  top_reset;
  wire  top_io_ctrl_aw_ready;
  wire  top_io_ctrl_aw_valid;
  wire [31:0] top_io_ctrl_aw_bits_addr;
  wire [7:0] top_io_ctrl_aw_bits_len;
  wire [11:0] top_io_ctrl_aw_bits_id;
  wire  top_io_ctrl_w_ready;
  wire  top_io_ctrl_w_valid;
  wire [31:0] top_io_ctrl_w_bits_data;
  wire  top_io_ctrl_w_bits_last;
  wire  top_io_ctrl_b_ready;
  wire  top_io_ctrl_b_valid;
  wire [1:0] top_io_ctrl_b_bits_resp;
  wire [11:0] top_io_ctrl_b_bits_id;
  wire  top_io_ctrl_b_bits_user;
  wire  top_io_ctrl_ar_ready;
  wire  top_io_ctrl_ar_valid;
  wire [31:0] top_io_ctrl_ar_bits_addr;
  wire [7:0] top_io_ctrl_ar_bits_len;
  wire [11:0] top_io_ctrl_ar_bits_id;
  wire  top_io_ctrl_r_ready;
  wire  top_io_ctrl_r_valid;
  wire [1:0] top_io_ctrl_r_bits_resp;
  wire [31:0] top_io_ctrl_r_bits_data;
  wire  top_io_ctrl_r_bits_last;
  wire [11:0] top_io_ctrl_r_bits_id;
  wire  top_io_ctrl_r_bits_user;
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
  FPGATop top (
    .clock(top_clock),
    .reset(top_reset),
    .io_ctrl_aw_ready(top_io_ctrl_aw_ready),
    .io_ctrl_aw_valid(top_io_ctrl_aw_valid),
    .io_ctrl_aw_bits_addr(top_io_ctrl_aw_bits_addr),
    .io_ctrl_aw_bits_len(top_io_ctrl_aw_bits_len),
    .io_ctrl_aw_bits_id(top_io_ctrl_aw_bits_id),
    .io_ctrl_w_ready(top_io_ctrl_w_ready),
    .io_ctrl_w_valid(top_io_ctrl_w_valid),
    .io_ctrl_w_bits_data(top_io_ctrl_w_bits_data),
    .io_ctrl_w_bits_last(top_io_ctrl_w_bits_last),
    .io_ctrl_b_ready(top_io_ctrl_b_ready),
    .io_ctrl_b_valid(top_io_ctrl_b_valid),
    .io_ctrl_b_bits_resp(top_io_ctrl_b_bits_resp),
    .io_ctrl_b_bits_id(top_io_ctrl_b_bits_id),
    .io_ctrl_b_bits_user(top_io_ctrl_b_bits_user),
    .io_ctrl_ar_ready(top_io_ctrl_ar_ready),
    .io_ctrl_ar_valid(top_io_ctrl_ar_valid),
    .io_ctrl_ar_bits_addr(top_io_ctrl_ar_bits_addr),
    .io_ctrl_ar_bits_len(top_io_ctrl_ar_bits_len),
    .io_ctrl_ar_bits_id(top_io_ctrl_ar_bits_id),
    .io_ctrl_r_ready(top_io_ctrl_r_ready),
    .io_ctrl_r_valid(top_io_ctrl_r_valid),
    .io_ctrl_r_bits_resp(top_io_ctrl_r_bits_resp),
    .io_ctrl_r_bits_data(top_io_ctrl_r_bits_data),
    .io_ctrl_r_bits_last(top_io_ctrl_r_bits_last),
    .io_ctrl_r_bits_id(top_io_ctrl_r_bits_id),
    .io_ctrl_r_bits_user(top_io_ctrl_r_bits_user),
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
  assign io_master_aw_ready = top_io_ctrl_aw_ready;
  assign io_master_w_ready = top_io_ctrl_w_ready;
  assign io_master_b_valid = top_io_ctrl_b_valid;
  assign io_master_b_bits_resp = top_io_ctrl_b_bits_resp;
  assign io_master_b_bits_id = top_io_ctrl_b_bits_id;
  assign io_master_b_bits_user = top_io_ctrl_b_bits_user;
  assign io_master_ar_ready = top_io_ctrl_ar_ready;
  assign io_master_r_valid = top_io_ctrl_r_valid;
  assign io_master_r_bits_resp = top_io_ctrl_r_bits_resp;
  assign io_master_r_bits_data = top_io_ctrl_r_bits_data;
  assign io_master_r_bits_last = top_io_ctrl_r_bits_last;
  assign io_master_r_bits_id = top_io_ctrl_r_bits_id;
  assign io_master_r_bits_user = top_io_ctrl_r_bits_user;
  assign io_slave_aw_valid = top_io_mem_aw_valid;
  assign io_slave_aw_bits_addr = top_io_mem_aw_bits_addr;
  assign io_slave_aw_bits_len = 8'h0;
  assign io_slave_aw_bits_size = 3'h3;
  assign io_slave_aw_bits_burst = 2'h1;
  assign io_slave_aw_bits_lock = 1'h0;
  assign io_slave_aw_bits_cache = 4'h0;
  assign io_slave_aw_bits_prot = 3'h0;
  assign io_slave_aw_bits_qos = 4'h0;
  assign io_slave_aw_bits_region = 4'h0;
  assign io_slave_aw_bits_id = 6'h0;
  assign io_slave_aw_bits_user = 1'h0;
  assign io_slave_w_valid = top_io_mem_w_valid;
  assign io_slave_w_bits_data = top_io_mem_w_bits_data;
  assign io_slave_w_bits_last = 1'h1;
  assign io_slave_w_bits_id = 6'h0;
  assign io_slave_w_bits_strb = 8'hff;
  assign io_slave_w_bits_user = 1'h0;
  assign io_slave_b_ready = 1'h1;
  assign io_slave_ar_valid = top_io_mem_ar_valid;
  assign io_slave_ar_bits_addr = top_io_mem_ar_bits_addr;
  assign io_slave_ar_bits_len = 8'h0;
  assign io_slave_ar_bits_size = 3'h3;
  assign io_slave_ar_bits_burst = 2'h1;
  assign io_slave_ar_bits_lock = 1'h0;
  assign io_slave_ar_bits_cache = 4'h0;
  assign io_slave_ar_bits_prot = 3'h0;
  assign io_slave_ar_bits_qos = 4'h0;
  assign io_slave_ar_bits_region = 4'h0;
  assign io_slave_ar_bits_id = 6'h0;
  assign io_slave_ar_bits_user = 1'h0;
  assign io_slave_r_ready = top_io_mem_r_ready;
  assign top_clock = clock;
  assign top_reset = reset;
  assign top_io_ctrl_aw_valid = io_master_aw_valid;
  assign top_io_ctrl_aw_bits_addr = io_master_aw_bits_addr;
  assign top_io_ctrl_aw_bits_len = io_master_aw_bits_len;
  assign top_io_ctrl_aw_bits_id = io_master_aw_bits_id;
  assign top_io_ctrl_w_valid = io_master_w_valid;
  assign top_io_ctrl_w_bits_data = io_master_w_bits_data;
  assign top_io_ctrl_w_bits_last = io_master_w_bits_last;
  assign top_io_ctrl_b_ready = io_master_b_ready;
  assign top_io_ctrl_ar_valid = io_master_ar_valid;
  assign top_io_ctrl_ar_bits_addr = io_master_ar_bits_addr;
  assign top_io_ctrl_ar_bits_len = io_master_ar_bits_len;
  assign top_io_ctrl_ar_bits_id = io_master_ar_bits_id;
  assign top_io_ctrl_r_ready = io_master_r_ready;
  assign top_io_mem_aw_ready = io_slave_aw_ready;
  assign top_io_mem_w_ready = io_slave_w_ready;
  assign top_io_mem_ar_ready = io_slave_ar_ready;
  assign top_io_mem_r_valid = io_slave_r_valid;
endmodule

// PCIe Soft Register Interface Adapter
// softreg_addr_in: 0            ~ NUM_WR_PORTS-1              will be used for driving inbound ports
//                  NUM_WR_PORTS ~ NUM_WR_PORTS+NUM_RD_PORTS-1 will be used for reading outbound ports
//                                 NUM_WR_PORTS+NUM_RD_PORTS   will be used for checking the success of last write
//                                                                  return 0 for success, 1 for fail
module softreg_adapter #(parameter NUM_WR_PORTS=4, NUM_RD_PORTS=5)
  (
   input  logic                           clock,
   input  logic                           reset,

   // Master side
   input  logic                           master_write_in,
   input  logic                           master_read_in,
   input  logic [31:0]                    master_addr_in,
   input  logic [63:0]                    master_data_in,
   output logic                           master_rdvalid_out,
   output logic [63:0]                    master_rddata_out,

   // Slave side
   output logic [NUM_WR_PORTS-1:0]        slave_wr_valid_out,     
   input  logic [NUM_WR_PORTS-1:0]        slave_wr_ready_in,     
   output logic [NUM_WR_PORTS-1:0][63:0]  slave_wr_data_out,     

   input  logic [NUM_RD_PORTS-1:0]        slave_rd_valid_in,     
   output logic [NUM_RD_PORTS-1:0]        slave_rd_ready_out,     
   input  logic [NUM_RD_PORTS-1:0][63:0]  slave_rd_data_in
   );

   logic            master_write_in_r;
   logic            master_read_in_r;
   logic [31:0]     master_addr_in_r;
   logic [63:0]     master_data_in_r;
   logic            master_rdvalid_out_r;
   logic [63:0]     master_rddata_out_r;

   logic            slave_wr_ready_mux;     
   logic            slave_rd_valid_mux;     
   logic [63:0]     slave_rd_data_mux;

   always begin
      slave_wr_ready_mux = '0;
      slave_rd_valid_mux = '0;
      slave_rd_data_mux = '0;

      for (int i=0; i<NUM_WR_PORTS; i++) begin
         if (master_addr_in_r == i) begin
            slave_wr_ready_mux = slave_wr_ready_in[i];
         end
      end
      for (int i=0; i<NUM_RD_PORTS; i++) begin
         if (master_addr_in_r == (i+NUM_WR_PORTS)) begin
            slave_rd_valid_mux = slave_rd_valid_in[i];
            slave_rd_data_mux  = slave_rd_data_in [i];
         end
      end
   end

   always begin
      slave_wr_valid_out = '0;
      slave_rd_ready_out = '0;

      for (int i=0; i<NUM_WR_PORTS; i++) begin
         slave_wr_valid_out[i] = master_write_in_r && master_addr_in_r == i;
      end
      for (int i=0; i<NUM_RD_PORTS; i++) begin
         slave_rd_ready_out[i] = master_read_in_r  && master_addr_in_r == (i+NUM_WR_PORTS);
      end
   end

   assign slave_wr_data_out  = {NUM_WR_PORTS{master_data_in_r}};

   always @(posedge clock or posedge reset) begin: g_registered_master_command
      if (reset) begin
         master_write_in_r    <= '0;
         master_read_in_r     <= '0;
         master_addr_in_r     <= '0;
         master_data_in_r     <= '0;
         master_rdvalid_out_r <= '0;
         master_rddata_out_r  <= '0;
      end else begin
         // Capture master commands when there's no pending write
         if (!master_write_in_r &&
             !master_read_in_r    ) begin
            master_write_in_r    <= master_write_in;
            master_read_in_r     <= master_read_in;
            master_addr_in_r     <= master_addr_in;
            master_data_in_r     <= master_data_in;
         end else
         // Allow pinging pending writes
         if ( master_write_in_r) begin
            master_write_in_r    <= !slave_wr_ready_mux;
            master_rdvalid_out_r <= master_read_in &&
                                    master_addr_in == 64'(NUM_WR_PORTS+NUM_RD_PORTS);
            master_rddata_out_r  <= 1'b1; // fail
         end else
         if ( master_read_in_r ) begin
            if (master_addr_in_r != 64'(NUM_WR_PORTS+NUM_RD_PORTS)) begin
               master_read_in_r     <= !slave_rd_valid_mux;
               master_rdvalid_out_r <=  slave_rd_valid_mux;
               master_rddata_out_r  <=  slave_rd_data_mux;
            end else begin
               master_read_in_r     <= 1'b0;
               master_rdvalid_out_r <= 1'b1;
               master_rddata_out_r  <= 1'b0; // success
            end
         end

         if (master_rdvalid_out) master_rdvalid_out_r <= 1'b0;
      end
   end

   assign master_rdvalid_out = master_rdvalid_out_r;
   assign master_rddata_out  = master_rddata_out_r;

endmodule // softreg_adapter


module interplay_top
  (
   input         clock,
   input         reset,

   input  logic        softreg_write_in,
   input  logic        softreg_read_in,
   input  logic [31:0] softreg_addr_in,
   input  logic [63:0] softreg_wrdata_in,
   output logic        softreg_rdvalid_out,
   output logic [63:0] softreg_rddata_out

   );

   // Slave side
   logic [3:0]        adapter_wr_valid_out;     
   logic [3:0]        adapter_wr_ready_in;     
   logic [3:0][63:0]  adapter_wr_data_out;     

   logic [4:0]        adapter_rd_valid_in;     
   logic [4:0]        adapter_rd_ready_out;     
   logic [4:0][63:0]  adapter_rd_data_in;

   softreg_adapter i_adapter
   (
      .clock             (clock               ),
      .reset             (reset               ),
      .master_write_in   (softreg_write_in    ),
      .master_read_in    (softreg_read_in     ),
      .master_addr_in    (softreg_addr_in     ),
      .master_data_in    (softreg_wrdata_in   ),
      .master_rdvalid_out(softreg_rdvalid_out ),
      .master_rddata_out (softreg_rddata_out  ),
      .slave_wr_valid_out(adapter_wr_valid_out),
      .slave_wr_ready_in (adapter_wr_ready_in ), 
      .slave_wr_data_out (adapter_wr_data_out ), 
      .slave_rd_valid_in (adapter_rd_valid_in ), 
      .slave_rd_ready_out(adapter_rd_ready_out),
      .slave_rd_data_in  (adapter_rd_data_in  )
   );

   FPGATop i_FPGATop (
      .clock               (clock),
      .reset               (reset),
      .io_ctrl_aw_ready    (adapter_wr_ready_in [0]       ),
      .io_ctrl_aw_valid    (adapter_wr_valid_out[0]       ),
      .io_ctrl_aw_bits_addr(adapter_wr_data_out [0][31: 0]),
      .io_ctrl_aw_bits_len (adapter_wr_data_out [0][39:32]),
      .io_ctrl_aw_bits_id  (adapter_wr_data_out [0][51:40]),
      .io_ctrl_w_ready     (adapter_wr_ready_in [1]       ),
      .io_ctrl_w_valid     (adapter_wr_valid_out[1]       ),
      .io_ctrl_w_bits_data (adapter_wr_data_out [1][31: 0]),
      .io_ctrl_w_bits_last (adapter_wr_data_out [1][   32]),
      .io_ctrl_b_ready     (adapter_rd_ready_out[0]       ),
      .io_ctrl_b_valid     (adapter_rd_valid_in [0]       ),
      .io_ctrl_b_bits_resp (adapter_rd_data_in  [0][ 1: 0]),
      .io_ctrl_b_bits_id   (adapter_rd_data_in  [0][13: 2]),
      .io_ctrl_b_bits_user (adapter_rd_data_in  [0][   14]),
      .io_ctrl_ar_ready    (adapter_wr_ready_in [2]       ),
      .io_ctrl_ar_valid    (adapter_wr_valid_out[2]       ),
      .io_ctrl_ar_bits_addr(adapter_wr_data_out [2][31: 0]),
      .io_ctrl_ar_bits_len (adapter_wr_data_out [2][39:32]),
      .io_ctrl_ar_bits_id  (adapter_wr_data_out [2][51:40]),
      .io_ctrl_r_ready     (adapter_rd_ready_out[1]       ),
      .io_ctrl_r_valid     (adapter_rd_valid_in [1]       ),
      .io_ctrl_r_bits_resp (adapter_rd_data_in  [1][ 1: 0]),
      .io_ctrl_r_bits_data (adapter_rd_data_in  [1][33: 2]),
      .io_ctrl_r_bits_last (adapter_rd_data_in  [1][   34]),
      .io_ctrl_r_bits_id   (adapter_rd_data_in  [1][46:35]),
      .io_ctrl_r_bits_user (adapter_rd_data_in  [1][   47]),
      .io_mem_aw_ready     (adapter_wr_ready_in [3]       ),
      .io_mem_aw_valid     (adapter_wr_valid_out[3]       ),
      .io_mem_aw_bits_addr (adapter_wr_data_out [3][31: 0]),
      .io_mem_w_ready      (adapter_rd_ready_out[2]       ),
      .io_mem_w_valid      (adapter_rd_valid_in [2]       ),
      .io_mem_w_bits_data  (adapter_rd_data_in  [2][63: 0]),
      .io_mem_ar_ready     (adapter_rd_ready_out[3]       ),
      .io_mem_ar_valid     (adapter_rd_valid_in [3]       ),
      .io_mem_ar_bits_addr (adapter_rd_data_in  [3][31: 0]),
      .io_mem_r_ready      (adapter_rd_ready_out[4]       ),
      .io_mem_r_valid      (adapter_rd_valid_in [4]       )
   );
endmodule // interplay_top

