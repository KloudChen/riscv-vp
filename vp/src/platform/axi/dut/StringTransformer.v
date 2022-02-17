module StringTransformer(
  input         clock,
  input         reset,
  output        io_core_if_wa_ready,
  input         io_core_if_wa_valid,
  input  [63:0] io_core_if_wa_bits_addr,
  input  [2:0]  io_core_if_wa_bits_prot,
  output        io_core_if_w_ready,
  input         io_core_if_w_valid,
  input  [31:0] io_core_if_w_bits_data,
  input  [3:0]  io_core_if_w_bits_strb,
  input         io_core_if_b_ready,
  output        io_core_if_b_valid,
  output [1:0]  io_core_if_b_bits_resp,
  output        io_core_if_ra_ready,
  input         io_core_if_ra_valid,
  input  [63:0] io_core_if_ra_bits_addr,
  input  [2:0]  io_core_if_ra_bits_prot,
  input         io_core_if_r_ready,
  output        io_core_if_r_valid,
  output [31:0] io_core_if_r_bits_data,
  output [1:0]  io_core_if_r_bits_resp,
  input         io_mem_if_wa_ready,
  output        io_mem_if_wa_valid,
  output [63:0] io_mem_if_wa_bits_addr,
  output [2:0]  io_mem_if_wa_bits_size,
  output [7:0]  io_mem_if_wa_bits_len,
  output [1:0]  io_mem_if_wa_bits_burst,
  output        io_mem_if_wa_bits_id,
  output        io_mem_if_wa_bits_lock,
  output [3:0]  io_mem_if_wa_bits_cache,
  output [2:0]  io_mem_if_wa_bits_prot,
  output [3:0]  io_mem_if_wa_bits_qos,
  input         io_mem_if_w_ready,
  output        io_mem_if_w_valid,
  output [31:0] io_mem_if_w_bits_data,
  output [3:0]  io_mem_if_w_bits_strb,
  output        io_mem_if_w_bits_last,
  output        io_mem_if_b_ready,
  input         io_mem_if_b_valid,
  input         io_mem_if_b_bits_id,
  input  [1:0]  io_mem_if_b_bits_resp,
  input         io_mem_if_ra_ready,
  output        io_mem_if_ra_valid,
  output [63:0] io_mem_if_ra_bits_addr,
  output [2:0]  io_mem_if_ra_bits_size,
  output [7:0]  io_mem_if_ra_bits_len,
  output [1:0]  io_mem_if_ra_bits_burst,
  output        io_mem_if_ra_bits_id,
  output        io_mem_if_ra_bits_lock,
  output [3:0]  io_mem_if_ra_bits_cache,
  output [2:0]  io_mem_if_ra_bits_prot,
  output [3:0]  io_mem_if_ra_bits_qos,
  output        io_mem_if_r_ready,
  input         io_mem_if_r_valid,
  input  [31:0] io_mem_if_r_bits_data,
  input         io_mem_if_r_bits_id,
  input         io_mem_if_r_bits_last,
  input  [1:0]  io_mem_if_r_bits_resp
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] buffer_0 [0:1023]; // @[StringTransformer.scala 50:33]
  wire  buffer_0_MPORT_1_en; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_0_MPORT_1_addr; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_0_MPORT_1_data; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_0_MPORT_data; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_0_MPORT_addr; // @[StringTransformer.scala 50:33]
  wire  buffer_0_MPORT_mask; // @[StringTransformer.scala 50:33]
  wire  buffer_0_MPORT_en; // @[StringTransformer.scala 50:33]
  reg  buffer_0_MPORT_1_en_pipe_0;
  reg [9:0] buffer_0_MPORT_1_addr_pipe_0;
  reg [7:0] buffer_1 [0:1023]; // @[StringTransformer.scala 50:33]
  wire  buffer_1_MPORT_1_en; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_1_MPORT_1_addr; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_1_MPORT_1_data; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_1_MPORT_data; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_1_MPORT_addr; // @[StringTransformer.scala 50:33]
  wire  buffer_1_MPORT_mask; // @[StringTransformer.scala 50:33]
  wire  buffer_1_MPORT_en; // @[StringTransformer.scala 50:33]
  reg  buffer_1_MPORT_1_en_pipe_0;
  reg [9:0] buffer_1_MPORT_1_addr_pipe_0;
  reg [7:0] buffer_2 [0:1023]; // @[StringTransformer.scala 50:33]
  wire  buffer_2_MPORT_1_en; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_2_MPORT_1_addr; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_2_MPORT_1_data; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_2_MPORT_data; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_2_MPORT_addr; // @[StringTransformer.scala 50:33]
  wire  buffer_2_MPORT_mask; // @[StringTransformer.scala 50:33]
  wire  buffer_2_MPORT_en; // @[StringTransformer.scala 50:33]
  reg  buffer_2_MPORT_1_en_pipe_0;
  reg [9:0] buffer_2_MPORT_1_addr_pipe_0;
  reg [7:0] buffer_3 [0:1023]; // @[StringTransformer.scala 50:33]
  wire  buffer_3_MPORT_1_en; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_3_MPORT_1_addr; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_3_MPORT_1_data; // @[StringTransformer.scala 50:33]
  wire [7:0] buffer_3_MPORT_data; // @[StringTransformer.scala 50:33]
  wire [9:0] buffer_3_MPORT_addr; // @[StringTransformer.scala 50:33]
  wire  buffer_3_MPORT_mask; // @[StringTransformer.scala 50:33]
  wire  buffer_3_MPORT_en; // @[StringTransformer.scala 50:33]
  reg  buffer_3_MPORT_1_en_pipe_0;
  reg [9:0] buffer_3_MPORT_1_addr_pipe_0;
  wire  _T_1 = ~reset; // @[StringTransformer.scala 22:15]
  reg [31:0] regSrcAddr; // @[StringTransformer.scala 27:57]
  reg [31:0] regDstAddr; // @[StringTransformer.scala 27:57]
  reg [31:0] regStrSize; // @[StringTransformer.scala 27:57]
  reg  regBufferFunc; // @[StringTransformer.scala 28:36]
  reg [3:0] state; // @[StringTransformer.scala 34:28]
  reg [7:0] regStoreBurstLen; // @[StringTransformer.scala 36:39]
  reg [31:0] regLoadBytes; // @[StringTransformer.scala 37:35]
  reg [31:0] regStoreBytes; // @[StringTransformer.scala 38:36]
  reg [31:0] regLoadAddr; // @[StringTransformer.scala 39:34]
  reg [31:0] regStoreAddr; // @[StringTransformer.scala 40:35]
  reg [7:0] regStoreBeat; // @[StringTransformer.scala 41:35]
  reg [7:0] regReadBytes_0; // @[StringTransformer.scala 42:31]
  reg [7:0] regReadBytes_1; // @[StringTransformer.scala 42:31]
  reg [7:0] regReadBytes_2; // @[StringTransformer.scala 42:31]
  reg [7:0] regReadBytes_3; // @[StringTransformer.scala 42:31]
  reg [31:0] regLastReadAddr; // @[StringTransformer.scala 43:38]
  wire  _T_3 = 4'h0 == state; // @[StringTransformer.scala 170:23]
  reg [31:0] regTransWordNum; // @[StringTransformer.scala 122:38]
  wire [34:0] _T_18 = regTransWordNum * 3'h4; // @[StringTransformer.scala 258:39]
  wire [34:0] _GEN_547 = {{3'd0}, regStrSize}; // @[StringTransformer.scala 258:45]
  wire  _T_19 = _T_18 < _GEN_547; // @[StringTransformer.scala 258:45]
  wire  _T_48 = regTransWordNum > 32'h0; // @[StringTransformer.scala 162:23]
  wire  _GEN_112 = _T_18 < _GEN_547 ? _T_48 : _T_48; // @[StringTransformer.scala 258:59]
  wire  _GEN_220 = 4'h6 == state ? io_mem_if_r_valid : 4'h7 == state & _GEN_112; // @[StringTransformer.scala 170:23]
  wire  _GEN_267 = 4'h5 == state ? 1'h0 : _GEN_220; // @[StringTransformer.scala 170:23]
  wire  _GEN_314 = 4'h4 == state ? 1'h0 : _GEN_267; // @[StringTransformer.scala 170:23]
  wire  _GEN_362 = 4'h3 == state ? 1'h0 : _GEN_314; // @[StringTransformer.scala 170:23]
  wire  _GEN_411 = 4'h2 == state ? 1'h0 : _GEN_362; // @[StringTransformer.scala 170:23]
  wire  _GEN_461 = 4'h1 == state ? 1'h0 : _GEN_411; // @[StringTransformer.scala 170:23]
  wire  wBufferWrite = 4'h0 == state ? 1'h0 : _GEN_461; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_49 = io_mem_if_r_valid ? regLoadAddr : 32'h0; // @[StringTransformer.scala 232:42 242:38]
  wire [31:0] _GEN_67 = regTransWordNum > 32'h0 ? regLastReadAddr : 32'h0; // @[StringTransformer.scala 162:30 165:34]
  wire [31:0] _GEN_113 = _T_18 < _GEN_547 ? _GEN_67 : _GEN_67; // @[StringTransformer.scala 258:59]
  wire [31:0] _GEN_197 = 4'h7 == state ? _GEN_113 : 32'h0; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_222 = 4'h6 == state ? _GEN_49 : _GEN_197; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_269 = 4'h5 == state ? 32'h0 : _GEN_222; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_316 = 4'h4 == state ? 32'h0 : _GEN_269; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_364 = 4'h3 == state ? 32'h0 : _GEN_316; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_413 = 4'h2 == state ? 32'h0 : _GEN_364; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_463 = 4'h1 == state ? 32'h0 : _GEN_413; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_523 = 4'h0 == state ? 32'h0 : _GEN_463; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_43 = io_mem_if_r_valid ? io_mem_if_r_bits_data[7:0] : 8'h0; // @[StringTransformer.scala 232:42 237:45]
  wire [7:0] _GEN_184 = 4'h7 == state ? regReadBytes_0 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_234 = 4'h6 == state ? 8'h0 : _GEN_184; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_280 = 4'h5 == state ? 8'h0 : _GEN_234; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_327 = 4'h4 == state ? 8'h0 : _GEN_280; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_375 = 4'h3 == state ? 8'h0 : _GEN_327; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_424 = 4'h2 == state ? 8'h0 : _GEN_375; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_474 = 4'h1 == state ? 8'h0 : _GEN_424; // @[StringTransformer.scala 170:23]
  wire [7:0] wBytes_0 = 4'h0 == state ? 8'h0 : _GEN_474; // @[StringTransformer.scala 170:23]
  wire [7:0] _wTransformed_0_T_1 = wBytes_0 + 8'h20; // @[StringTransformer.scala 148:46]
  wire [7:0] _GEN_53 = wBytes_0 >= 8'h41 & wBytes_0 <= 8'h5a ? _wTransformed_0_T_1 : wBytes_0; // @[StringTransformer.scala 147:65 148:41 150:41]
  wire [7:0] _wTransformed_0_T_3 = wBytes_0 - 8'h20; // @[StringTransformer.scala 155:46]
  wire [7:0] _GEN_54 = wBytes_0 >= 8'h61 & wBytes_0 <= 8'h7a ? _wTransformed_0_T_3 : wBytes_0; // @[StringTransformer.scala 154:65 155:41 157:41]
  wire [7:0] _GEN_55 = ~regBufferFunc ? _GEN_53 : _GEN_54; // @[StringTransformer.scala 145:46]
  wire [7:0] _GEN_101 = _T_18 < _GEN_547 ? _GEN_55 : _GEN_55; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_185 = 4'h7 == state ? _GEN_101 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_235 = 4'h6 == state ? 8'h0 : _GEN_185; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_281 = 4'h5 == state ? 8'h0 : _GEN_235; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_328 = 4'h4 == state ? 8'h0 : _GEN_281; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_376 = 4'h3 == state ? 8'h0 : _GEN_328; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_425 = 4'h2 == state ? 8'h0 : _GEN_376; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_475 = 4'h1 == state ? 8'h0 : _GEN_425; // @[StringTransformer.scala 170:23]
  wire [7:0] wTransformed_0 = 4'h0 == state ? 8'h0 : _GEN_475; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_68 = regTransWordNum > 32'h0 ? wTransformed_0 : 8'h0; // @[StringTransformer.scala 162:30 166:34]
  wire [7:0] _GEN_114 = _T_18 < _GEN_547 ? _GEN_68 : _GEN_68; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_198 = 4'h7 == state ? _GEN_114 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_215 = 4'h6 == state ? _GEN_43 : _GEN_198; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_262 = 4'h5 == state ? 8'h0 : _GEN_215; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_309 = 4'h4 == state ? 8'h0 : _GEN_262; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_357 = 4'h3 == state ? 8'h0 : _GEN_309; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_406 = 4'h2 == state ? 8'h0 : _GEN_357; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_456 = 4'h1 == state ? 8'h0 : _GEN_406; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_44 = io_mem_if_r_valid ? io_mem_if_r_bits_data[15:8] : 8'h0; // @[StringTransformer.scala 232:42 237:45]
  wire [7:0] _GEN_186 = 4'h7 == state ? regReadBytes_1 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_236 = 4'h6 == state ? 8'h0 : _GEN_186; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_282 = 4'h5 == state ? 8'h0 : _GEN_236; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_329 = 4'h4 == state ? 8'h0 : _GEN_282; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_377 = 4'h3 == state ? 8'h0 : _GEN_329; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_426 = 4'h2 == state ? 8'h0 : _GEN_377; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_476 = 4'h1 == state ? 8'h0 : _GEN_426; // @[StringTransformer.scala 170:23]
  wire [7:0] wBytes_1 = 4'h0 == state ? 8'h0 : _GEN_476; // @[StringTransformer.scala 170:23]
  wire [7:0] _wTransformed_1_T_1 = wBytes_1 + 8'h20; // @[StringTransformer.scala 148:46]
  wire [7:0] _GEN_56 = wBytes_1 >= 8'h41 & wBytes_1 <= 8'h5a ? _wTransformed_1_T_1 : wBytes_1; // @[StringTransformer.scala 147:65 148:41 150:41]
  wire [7:0] _wTransformed_1_T_3 = wBytes_1 - 8'h20; // @[StringTransformer.scala 155:46]
  wire [7:0] _GEN_57 = wBytes_1 >= 8'h61 & wBytes_1 <= 8'h7a ? _wTransformed_1_T_3 : wBytes_1; // @[StringTransformer.scala 154:65 155:41 157:41]
  wire [7:0] _GEN_58 = ~regBufferFunc ? _GEN_56 : _GEN_57; // @[StringTransformer.scala 145:46]
  wire [7:0] _GEN_103 = _T_18 < _GEN_547 ? _GEN_58 : _GEN_58; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_187 = 4'h7 == state ? _GEN_103 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_237 = 4'h6 == state ? 8'h0 : _GEN_187; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_283 = 4'h5 == state ? 8'h0 : _GEN_237; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_330 = 4'h4 == state ? 8'h0 : _GEN_283; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_378 = 4'h3 == state ? 8'h0 : _GEN_330; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_427 = 4'h2 == state ? 8'h0 : _GEN_378; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_477 = 4'h1 == state ? 8'h0 : _GEN_427; // @[StringTransformer.scala 170:23]
  wire [7:0] wTransformed_1 = 4'h0 == state ? 8'h0 : _GEN_477; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_69 = regTransWordNum > 32'h0 ? wTransformed_1 : 8'h0; // @[StringTransformer.scala 162:30 166:34]
  wire [7:0] _GEN_115 = _T_18 < _GEN_547 ? _GEN_69 : _GEN_69; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_199 = 4'h7 == state ? _GEN_115 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_216 = 4'h6 == state ? _GEN_44 : _GEN_199; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_263 = 4'h5 == state ? 8'h0 : _GEN_216; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_310 = 4'h4 == state ? 8'h0 : _GEN_263; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_358 = 4'h3 == state ? 8'h0 : _GEN_310; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_407 = 4'h2 == state ? 8'h0 : _GEN_358; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_457 = 4'h1 == state ? 8'h0 : _GEN_407; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_45 = io_mem_if_r_valid ? io_mem_if_r_bits_data[23:16] : 8'h0; // @[StringTransformer.scala 232:42 237:45]
  wire [7:0] _GEN_188 = 4'h7 == state ? regReadBytes_2 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_238 = 4'h6 == state ? 8'h0 : _GEN_188; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_284 = 4'h5 == state ? 8'h0 : _GEN_238; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_331 = 4'h4 == state ? 8'h0 : _GEN_284; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_379 = 4'h3 == state ? 8'h0 : _GEN_331; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_428 = 4'h2 == state ? 8'h0 : _GEN_379; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_478 = 4'h1 == state ? 8'h0 : _GEN_428; // @[StringTransformer.scala 170:23]
  wire [7:0] wBytes_2 = 4'h0 == state ? 8'h0 : _GEN_478; // @[StringTransformer.scala 170:23]
  wire [7:0] _wTransformed_2_T_1 = wBytes_2 + 8'h20; // @[StringTransformer.scala 148:46]
  wire [7:0] _GEN_59 = wBytes_2 >= 8'h41 & wBytes_2 <= 8'h5a ? _wTransformed_2_T_1 : wBytes_2; // @[StringTransformer.scala 147:65 148:41 150:41]
  wire [7:0] _wTransformed_2_T_3 = wBytes_2 - 8'h20; // @[StringTransformer.scala 155:46]
  wire [7:0] _GEN_60 = wBytes_2 >= 8'h61 & wBytes_2 <= 8'h7a ? _wTransformed_2_T_3 : wBytes_2; // @[StringTransformer.scala 154:65 155:41 157:41]
  wire [7:0] _GEN_61 = ~regBufferFunc ? _GEN_59 : _GEN_60; // @[StringTransformer.scala 145:46]
  wire [7:0] _GEN_105 = _T_18 < _GEN_547 ? _GEN_61 : _GEN_61; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_189 = 4'h7 == state ? _GEN_105 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_239 = 4'h6 == state ? 8'h0 : _GEN_189; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_285 = 4'h5 == state ? 8'h0 : _GEN_239; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_332 = 4'h4 == state ? 8'h0 : _GEN_285; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_380 = 4'h3 == state ? 8'h0 : _GEN_332; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_429 = 4'h2 == state ? 8'h0 : _GEN_380; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_479 = 4'h1 == state ? 8'h0 : _GEN_429; // @[StringTransformer.scala 170:23]
  wire [7:0] wTransformed_2 = 4'h0 == state ? 8'h0 : _GEN_479; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_70 = regTransWordNum > 32'h0 ? wTransformed_2 : 8'h0; // @[StringTransformer.scala 162:30 166:34]
  wire [7:0] _GEN_116 = _T_18 < _GEN_547 ? _GEN_70 : _GEN_70; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_200 = 4'h7 == state ? _GEN_116 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_217 = 4'h6 == state ? _GEN_45 : _GEN_200; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_264 = 4'h5 == state ? 8'h0 : _GEN_217; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_311 = 4'h4 == state ? 8'h0 : _GEN_264; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_359 = 4'h3 == state ? 8'h0 : _GEN_311; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_408 = 4'h2 == state ? 8'h0 : _GEN_359; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_458 = 4'h1 == state ? 8'h0 : _GEN_408; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_46 = io_mem_if_r_valid ? io_mem_if_r_bits_data[31:24] : 8'h0; // @[StringTransformer.scala 232:42 237:45]
  wire [7:0] _GEN_190 = 4'h7 == state ? regReadBytes_3 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_240 = 4'h6 == state ? 8'h0 : _GEN_190; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_286 = 4'h5 == state ? 8'h0 : _GEN_240; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_333 = 4'h4 == state ? 8'h0 : _GEN_286; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_381 = 4'h3 == state ? 8'h0 : _GEN_333; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_430 = 4'h2 == state ? 8'h0 : _GEN_381; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_480 = 4'h1 == state ? 8'h0 : _GEN_430; // @[StringTransformer.scala 170:23]
  wire [7:0] wBytes_3 = 4'h0 == state ? 8'h0 : _GEN_480; // @[StringTransformer.scala 170:23]
  wire [7:0] _wTransformed_3_T_1 = wBytes_3 + 8'h20; // @[StringTransformer.scala 148:46]
  wire [7:0] _GEN_62 = wBytes_3 >= 8'h41 & wBytes_3 <= 8'h5a ? _wTransformed_3_T_1 : wBytes_3; // @[StringTransformer.scala 147:65 148:41 150:41]
  wire [7:0] _wTransformed_3_T_3 = wBytes_3 - 8'h20; // @[StringTransformer.scala 155:46]
  wire [7:0] _GEN_63 = wBytes_3 >= 8'h61 & wBytes_3 <= 8'h7a ? _wTransformed_3_T_3 : wBytes_3; // @[StringTransformer.scala 154:65 155:41 157:41]
  wire [7:0] _GEN_64 = ~regBufferFunc ? _GEN_62 : _GEN_63; // @[StringTransformer.scala 145:46]
  wire [7:0] _GEN_107 = _T_18 < _GEN_547 ? _GEN_64 : _GEN_64; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_191 = 4'h7 == state ? _GEN_107 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_241 = 4'h6 == state ? 8'h0 : _GEN_191; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_287 = 4'h5 == state ? 8'h0 : _GEN_241; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_334 = 4'h4 == state ? 8'h0 : _GEN_287; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_382 = 4'h3 == state ? 8'h0 : _GEN_334; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_431 = 4'h2 == state ? 8'h0 : _GEN_382; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_481 = 4'h1 == state ? 8'h0 : _GEN_431; // @[StringTransformer.scala 170:23]
  wire [7:0] wTransformed_3 = 4'h0 == state ? 8'h0 : _GEN_481; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_71 = regTransWordNum > 32'h0 ? wTransformed_3 : 8'h0; // @[StringTransformer.scala 162:30 166:34]
  wire [7:0] _GEN_117 = _T_18 < _GEN_547 ? _GEN_71 : _GEN_71; // @[StringTransformer.scala 258:59]
  wire [7:0] _GEN_201 = 4'h7 == state ? _GEN_117 : 8'h0; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_218 = 4'h6 == state ? _GEN_46 : _GEN_201; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_265 = 4'h5 == state ? 8'h0 : _GEN_218; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_312 = 4'h4 == state ? 8'h0 : _GEN_265; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_360 = 4'h3 == state ? 8'h0 : _GEN_312; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_409 = 4'h2 == state ? 8'h0 : _GEN_360; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_459 = 4'h1 == state ? 8'h0 : _GEN_409; // @[StringTransformer.scala 170:23]
  wire  _GEN_166 = 4'h8 == state ? 1'h0 : 4'h9 == state & io_mem_if_w_ready; // @[StringTransformer.scala 170:23]
  wire  _GEN_176 = 4'h7 == state ? _T_19 : _GEN_166; // @[StringTransformer.scala 170:23]
  wire  _GEN_221 = 4'h6 == state ? 1'h0 : _GEN_176; // @[StringTransformer.scala 170:23]
  wire  _GEN_268 = 4'h5 == state ? 1'h0 : _GEN_221; // @[StringTransformer.scala 170:23]
  wire  _GEN_315 = 4'h4 == state ? 1'h0 : _GEN_268; // @[StringTransformer.scala 170:23]
  wire  _GEN_363 = 4'h3 == state ? 1'h0 : _GEN_315; // @[StringTransformer.scala 170:23]
  wire  _GEN_412 = 4'h2 == state ? 1'h0 : _GEN_363; // @[StringTransformer.scala 170:23]
  wire  _GEN_462 = 4'h1 == state ? 1'h0 : _GEN_412; // @[StringTransformer.scala 170:23]
  wire  wBufferRead = 4'h0 == state ? 1'h0 : _GEN_462; // @[StringTransformer.scala 170:23]
  wire [31:0] _wBufferReadAddr_T_1 = regTransWordNum + 32'h1; // @[StringTransformer.scala 136:41]
  wire [31:0] _GEN_93 = _T_18 < _GEN_547 ? _wBufferReadAddr_T_1 : 32'h0; // @[StringTransformer.scala 136:33 258:59]
  wire [31:0] _wBufferReadAddr_T_3 = regStoreAddr + 32'h1; // @[StringTransformer.scala 301:53]
  wire [31:0] _GEN_135 = io_mem_if_w_ready ? _wBufferReadAddr_T_3 : 32'h0; // @[StringTransformer.scala 293:42 301:37]
  wire [31:0] _GEN_151 = 4'h9 == state ? _GEN_135 : 32'h0; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_168 = 4'h8 == state ? 32'h0 : _GEN_151; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_177 = 4'h7 == state ? _GEN_93 : _GEN_168; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_227 = 4'h6 == state ? 32'h0 : _GEN_177; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_273 = 4'h5 == state ? 32'h0 : _GEN_227; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_320 = 4'h4 == state ? 32'h0 : _GEN_273; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_368 = 4'h3 == state ? 32'h0 : _GEN_320; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_417 = 4'h2 == state ? 32'h0 : _GEN_368; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_467 = 4'h1 == state ? 32'h0 : _GEN_417; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_524 = 4'h0 == state ? 32'h0 : _GEN_467; // @[StringTransformer.scala 170:23]
  wire [7:0] _GEN_10 = wBufferRead ? buffer_0_MPORT_1_data : 8'h0; // @[StringTransformer.scala 63:31 64:33]
  wire [7:0] _GEN_11 = wBufferRead ? buffer_1_MPORT_1_data : 8'h0; // @[StringTransformer.scala 63:31 64:33]
  wire [7:0] _GEN_12 = wBufferRead ? buffer_2_MPORT_1_data : 8'h0; // @[StringTransformer.scala 63:31 64:33]
  wire [7:0] _GEN_13 = wBufferRead ? buffer_3_MPORT_1_data : 8'h0; // @[StringTransformer.scala 63:31 64:33]
  wire  _GEN_91 = _T_18 < _GEN_547 | _T_48; // @[StringTransformer.scala 258:59]
  wire  _GEN_175 = 4'h7 == state ? _GEN_91 : _GEN_166; // @[StringTransformer.scala 170:23]
  wire  _GEN_219 = 4'h6 == state ? io_mem_if_r_valid : _GEN_175; // @[StringTransformer.scala 170:23]
  wire  _GEN_266 = 4'h5 == state ? 1'h0 : _GEN_219; // @[StringTransformer.scala 170:23]
  wire  _GEN_313 = 4'h4 == state ? 1'h0 : _GEN_266; // @[StringTransformer.scala 170:23]
  wire  _GEN_361 = 4'h3 == state ? 1'h0 : _GEN_313; // @[StringTransformer.scala 170:23]
  wire  _GEN_410 = 4'h2 == state ? 1'h0 : _GEN_361; // @[StringTransformer.scala 170:23]
  wire  _GEN_460 = 4'h1 == state ? 1'h0 : _GEN_410; // @[StringTransformer.scala 170:23]
  wire  wBufferEnable = 4'h0 == state ? 1'h0 : _GEN_460; // @[StringTransformer.scala 170:23]
  wire [7:0] wBufferReadData_0 = wBufferEnable ? _GEN_10 : 8'h0; // @[StringTransformer.scala 59:29]
  wire [7:0] wBufferReadData_1 = wBufferEnable ? _GEN_11 : 8'h0; // @[StringTransformer.scala 59:29]
  wire [7:0] wBufferReadData_2 = wBufferEnable ? _GEN_12 : 8'h0; // @[StringTransformer.scala 59:29]
  wire [7:0] wBufferReadData_3 = wBufferEnable ? _GEN_13 : 8'h0; // @[StringTransformer.scala 59:29]
  reg  io_core_if_b_valid_REG; // @[StringTransformer.scala 102:38]
  reg  readValidReg; // @[StringTransformer.scala 107:35]
  wire  proceed = io_core_if_w_valid & io_core_if_w_bits_data == 32'hf00dfeed; // @[StringTransformer.scala 121:42]
  wire [31:0] _GEN_32 = io_core_if_w_valid ? io_core_if_w_bits_data : regDstAddr; // @[StringTransformer.scala 192:43 193:32 27:57]
  wire [3:0] _GEN_33 = io_core_if_w_valid ? 4'h3 : state; // @[StringTransformer.scala 192:43 194:27 34:28]
  wire [31:0] _GEN_34 = io_core_if_w_valid ? io_core_if_w_bits_data : regStrSize; // @[StringTransformer.scala 198:43 199:32 27:57]
  wire [3:0] _GEN_35 = io_core_if_w_valid ? 4'h4 : state; // @[StringTransformer.scala 198:43 200:27 34:28]
  wire [31:0] _GEN_36 = io_core_if_w_valid ? io_core_if_w_bits_data : {{31'd0}, regBufferFunc}; // @[StringTransformer.scala 204:43 205:35 28:36]
  wire [3:0] _GEN_37 = io_core_if_w_valid ? 4'h5 : state; // @[StringTransformer.scala 204:43 206:27 34:28]
  wire [31:0] _io_mem_if_ra_bits_addr_T_1 = regSrcAddr + regLoadBytes; // @[StringTransformer.scala 212:54]
  wire [31:0] _last_burst_T_1 = regLoadBytes + 32'h400; // @[StringTransformer.scala 213:48]
  wire  last_burst = _last_burst_T_1 >= regStrSize; // @[StringTransformer.scala 213:85]
  wire [31:0] _T_10 = regStrSize - regLoadBytes; // @[StringTransformer.scala 215:39]
  wire [31:0] _GEN_0 = _T_10 % 32'h4; // @[StringTransformer.scala 215:55]
  wire [2:0] _T_11 = _GEN_0[2:0]; // @[StringTransformer.scala 215:55]
  wire [31:0] _io_mem_if_ra_bits_len_T_2 = _T_10 / 32'h4; // @[StringTransformer.scala 216:78]
  wire [31:0] _io_mem_if_ra_bits_len_T_7 = _io_mem_if_ra_bits_len_T_2 - 32'h1; // @[StringTransformer.scala 218:101]
  wire [31:0] _GEN_38 = _T_11 != 3'h0 ? _io_mem_if_ra_bits_len_T_2 : _io_mem_if_ra_bits_len_T_7; // @[StringTransformer.scala 215:81 216:47 218:47]
  wire [8:0] _io_mem_if_ra_bits_len_T_9 = 9'h100 - 9'h1; // @[StringTransformer.scala 221:63]
  wire [31:0] _GEN_39 = last_burst ? _GEN_38 : {{23'd0}, _io_mem_if_ra_bits_len_T_9}; // @[StringTransformer.scala 214:35 221:43]
  wire [3:0] _GEN_40 = io_mem_if_ra_ready ? 4'h6 : state; // @[StringTransformer.scala 224:43 225:27 34:28]
  wire [31:0] _regLoadBytes_T_1 = regLoadBytes + 32'h4; // @[StringTransformer.scala 243:50]
  wire [31:0] _regLoadAddr_T_1 = regLoadAddr + 32'h1; // @[StringTransformer.scala 244:48]
  wire [31:0] _T_15 = regStrSize - 32'h4; // @[StringTransformer.scala 249:58]
  wire [3:0] _GEN_41 = regLoadBytes >= _T_15 ? 4'h7 : 4'h5; // @[StringTransformer.scala 249:76 250:35 252:35]
  wire [3:0] _GEN_42 = io_mem_if_r_bits_last ? _GEN_41 : state; // @[StringTransformer.scala 247:50 34:28]
  wire [31:0] _GEN_50 = io_mem_if_r_valid ? _regLoadBytes_T_1 : regLoadBytes; // @[StringTransformer.scala 232:42 243:34 37:35]
  wire [31:0] _GEN_51 = io_mem_if_r_valid ? _regLoadAddr_T_1 : regLoadAddr; // @[StringTransformer.scala 232:42 244:33 39:34]
  wire [3:0] _GEN_52 = io_mem_if_r_valid ? _GEN_42 : state; // @[StringTransformer.scala 232:42 34:28]
  wire [31:0] _GEN_90 = _T_18 < _GEN_547 ? _wBufferReadAddr_T_1 : regTransWordNum; // @[StringTransformer.scala 258:59 259:37 122:38]
  wire [31:0] _GEN_95 = _T_18 < _GEN_547 ? regTransWordNum : regLastReadAddr; // @[StringTransformer.scala 137:33 258:59 43:38]
  wire [3:0] _GEN_118 = _T_18 < _GEN_547 ? state : 4'h8; // @[StringTransformer.scala 258:59 264:27 34:28]
  wire [31:0] _last_burst_T_3 = regStoreBytes + 32'h400; // @[StringTransformer.scala 269:49]
  wire  last_burst_1 = _last_burst_T_3 >= regStrSize; // @[StringTransformer.scala 269:86]
  wire [31:0] _T_80 = regStrSize - regStoreBytes; // @[StringTransformer.scala 272:39]
  wire [31:0] _GEN_1 = _T_80 % 32'h4; // @[StringTransformer.scala 272:56]
  wire [2:0] _T_81 = _GEN_1[2:0]; // @[StringTransformer.scala 272:56]
  wire [31:0] _wireStoreBurstLen_T_2 = _T_80 / 32'h4; // @[StringTransformer.scala 273:75]
  wire [31:0] _wireStoreBurstLen_T_4 = _wireStoreBurstLen_T_2 + 32'h1; // @[StringTransformer.scala 273:98]
  wire [31:0] _GEN_119 = _T_81 != 3'h0 ? _wireStoreBurstLen_T_4 : _wireStoreBurstLen_T_2; // @[StringTransformer.scala 272:82 273:43 275:43]
  wire [31:0] _GEN_120 = last_burst_1 ? _GEN_119 : 32'h100; // @[StringTransformer.scala 271:35 278:39]
  wire [7:0] wireStoreBurstLen = _GEN_120[7:0];
  wire [7:0] _io_mem_if_wa_bits_len_T_1 = wireStoreBurstLen - 8'h1; // @[StringTransformer.scala 280:60]
  wire [3:0] _GEN_121 = io_mem_if_wa_ready ? 4'h9 : state; // @[StringTransformer.scala 283:43 284:27 34:28]
  wire [31:0] _io_mem_if_w_bits_data_T_2 = {wBufferReadData_3,wBufferReadData_2,wBufferReadData_1,wBufferReadData_0}; // @[StringTransformer.scala 296:68]
  wire [31:0] _regStoreBytes_T_1 = regStoreBytes + 32'h4; // @[StringTransformer.scala 303:52]
  wire [7:0] _regStoreBeat_T_1 = regStoreBeat + 8'h1; // @[StringTransformer.scala 304:50]
  wire  last_beat = _regStoreBeat_T_1 >= regStoreBurstLen; // @[StringTransformer.scala 306:56]
  wire  strobe_0 = 32'h0 < _T_80; // @[StringTransformer.scala 317:43]
  wire  strobe_1 = 32'h1 < _T_80; // @[StringTransformer.scala 317:43]
  wire  strobe_2 = 32'h2 < _T_80; // @[StringTransformer.scala 317:43]
  wire  strobe_3 = 32'h3 < _T_80; // @[StringTransformer.scala 317:43]
  wire [3:0] _io_mem_if_w_bits_strb_T_2 = {strobe_3,strobe_2,strobe_1,strobe_0}; // @[StringTransformer.scala 323:78]
  wire [3:0] _GEN_126 = last_burst_1 ? 4'ha : 4'h8; // @[StringTransformer.scala 312:43 313:35 325:35]
  wire [3:0] _GEN_127 = last_burst_1 ? _io_mem_if_w_bits_strb_T_2 : 4'hf; // @[StringTransformer.scala 297:43 312:43 323:51]
  wire [3:0] _GEN_129 = last_beat ? _GEN_126 : state; // @[StringTransformer.scala 309:37 34:28]
  wire [3:0] _GEN_130 = last_beat ? _GEN_127 : 4'hf; // @[StringTransformer.scala 309:37 297:43]
  wire [31:0] _GEN_131 = io_mem_if_w_ready ? _io_mem_if_w_bits_data_T_2 : 32'h0; // @[StringTransformer.scala 293:42 296:43 94:31]
  wire [3:0] _GEN_132 = io_mem_if_w_ready ? _GEN_130 : 4'h0; // @[StringTransformer.scala 293:42 95:31]
  wire [31:0] _GEN_137 = io_mem_if_w_ready ? _regStoreBytes_T_1 : regStoreBytes; // @[StringTransformer.scala 293:42 303:35 38:36]
  wire [7:0] _GEN_138 = io_mem_if_w_ready ? _regStoreBeat_T_1 : 8'h0; // @[StringTransformer.scala 290:30 293:42 304:34]
  wire [31:0] _GEN_139 = io_mem_if_w_ready ? _wBufferReadAddr_T_3 : regStoreAddr; // @[StringTransformer.scala 293:42 305:34 40:35]
  wire  _GEN_140 = io_mem_if_w_ready & last_beat; // @[StringTransformer.scala 293:42 96:31]
  wire [3:0] _GEN_141 = io_mem_if_w_ready ? _GEN_129 : state; // @[StringTransformer.scala 293:42 34:28]
  wire [3:0] _GEN_142 = proceed ? 4'h0 : state; // @[StringTransformer.scala 332:32 333:27 34:28]
  wire [3:0] _GEN_144 = 4'ha == state ? _GEN_142 : state; // @[StringTransformer.scala 170:23 34:28]
  wire [7:0] _GEN_146 = 4'h9 == state ? _GEN_138 : regStoreBeat; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_147 = 4'h9 == state ? _GEN_131 : 32'h0; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_148 = 4'h9 == state ? _GEN_132 : 4'h0; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_153 = 4'h9 == state ? _GEN_137 : regStoreBytes; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_154 = 4'h9 == state ? _GEN_139 : regStoreAddr; // @[StringTransformer.scala 170:23 40:35]
  wire [3:0] _GEN_156 = 4'h9 == state ? _GEN_141 : _GEN_144; // @[StringTransformer.scala 170:23]
  wire  _GEN_157 = 4'h9 == state ? 1'h0 : 4'ha == state; // @[StringTransformer.scala 170:23 84:27]
  wire [7:0] _GEN_159 = 4'h8 == state ? _io_mem_if_wa_bits_len_T_1 : 8'h0; // @[StringTransformer.scala 170:23 280:39 88:31]
  wire [7:0] _GEN_160 = 4'h8 == state ? wireStoreBurstLen : regStoreBurstLen; // @[StringTransformer.scala 170:23 281:34 36:39]
  wire [3:0] _GEN_161 = 4'h8 == state ? _GEN_121 : _GEN_156; // @[StringTransformer.scala 170:23]
  wire  _GEN_162 = 4'h8 == state ? 1'h0 : 4'h9 == state; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_163 = 4'h8 == state ? regStoreBeat : _GEN_146; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_164 = 4'h8 == state ? 32'h0 : _GEN_147; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_165 = 4'h8 == state ? 4'h0 : _GEN_148; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_170 = 4'h8 == state ? regStoreBytes : _GEN_153; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_171 = 4'h8 == state ? regStoreAddr : _GEN_154; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_172 = 4'h8 == state ? 1'h0 : 4'h9 == state & _GEN_140; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_173 = 4'h8 == state ? 1'h0 : _GEN_157; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_174 = 4'h7 == state ? _GEN_90 : regTransWordNum; // @[StringTransformer.scala 170:23 122:38]
  wire [31:0] _GEN_179 = 4'h7 == state ? _GEN_95 : regLastReadAddr; // @[StringTransformer.scala 170:23 43:38]
  wire [7:0] _GEN_180 = 4'h7 == state ? wBufferReadData_0 : regReadBytes_0; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_181 = 4'h7 == state ? wBufferReadData_1 : regReadBytes_1; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_182 = 4'h7 == state ? wBufferReadData_2 : regReadBytes_2; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_183 = 4'h7 == state ? wBufferReadData_3 : regReadBytes_3; // @[StringTransformer.scala 170:23 42:31]
  wire [3:0] _GEN_202 = 4'h7 == state ? _GEN_118 : _GEN_161; // @[StringTransformer.scala 170:23]
  wire  _GEN_203 = 4'h7 == state ? 1'h0 : 4'h8 == state; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_204 = 4'h7 == state ? 8'h0 : _GEN_159; // @[StringTransformer.scala 170:23 88:31]
  wire [7:0] _GEN_205 = 4'h7 == state ? regStoreBurstLen : _GEN_160; // @[StringTransformer.scala 170:23 36:39]
  wire  _GEN_206 = 4'h7 == state ? 1'h0 : _GEN_162; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_207 = 4'h7 == state ? regStoreBeat : _GEN_163; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_208 = 4'h7 == state ? 32'h0 : _GEN_164; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_209 = 4'h7 == state ? 4'h0 : _GEN_165; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_210 = 4'h7 == state ? regStoreBytes : _GEN_170; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_211 = 4'h7 == state ? regStoreAddr : _GEN_171; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_212 = 4'h7 == state ? 1'h0 : _GEN_172; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_213 = 4'h7 == state ? 1'h0 : _GEN_173; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_223 = 4'h6 == state ? _GEN_50 : regLoadBytes; // @[StringTransformer.scala 170:23 37:35]
  wire [31:0] _GEN_224 = 4'h6 == state ? _GEN_51 : regLoadAddr; // @[StringTransformer.scala 170:23 39:34]
  wire [3:0] _GEN_225 = 4'h6 == state ? _GEN_52 : _GEN_202; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_226 = 4'h6 == state ? regTransWordNum : _GEN_174; // @[StringTransformer.scala 170:23 122:38]
  wire [31:0] _GEN_229 = 4'h6 == state ? regLastReadAddr : _GEN_179; // @[StringTransformer.scala 170:23 43:38]
  wire [7:0] _GEN_230 = 4'h6 == state ? regReadBytes_0 : _GEN_180; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_231 = 4'h6 == state ? regReadBytes_1 : _GEN_181; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_232 = 4'h6 == state ? regReadBytes_2 : _GEN_182; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_233 = 4'h6 == state ? regReadBytes_3 : _GEN_183; // @[StringTransformer.scala 170:23 42:31]
  wire  _GEN_246 = 4'h6 == state ? 1'h0 : _GEN_203; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_247 = 4'h6 == state ? 8'h0 : _GEN_204; // @[StringTransformer.scala 170:23 88:31]
  wire [7:0] _GEN_248 = 4'h6 == state ? regStoreBurstLen : _GEN_205; // @[StringTransformer.scala 170:23 36:39]
  wire  _GEN_249 = 4'h6 == state ? 1'h0 : _GEN_206; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_250 = 4'h6 == state ? regStoreBeat : _GEN_207; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_251 = 4'h6 == state ? 32'h0 : _GEN_208; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_252 = 4'h6 == state ? 4'h0 : _GEN_209; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_253 = 4'h6 == state ? regStoreBytes : _GEN_210; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_254 = 4'h6 == state ? regStoreAddr : _GEN_211; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_255 = 4'h6 == state ? 1'h0 : _GEN_212; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_256 = 4'h6 == state ? 1'h0 : _GEN_213; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_258 = 4'h5 == state ? _io_mem_if_ra_bits_addr_T_1 : regSrcAddr; // @[StringTransformer.scala 170:23 212:40 71:32]
  wire [31:0] _GEN_259 = 4'h5 == state ? _GEN_39 : 32'h0; // @[StringTransformer.scala 170:23 74:31]
  wire [3:0] _GEN_260 = 4'h5 == state ? _GEN_40 : _GEN_225; // @[StringTransformer.scala 170:23]
  wire  _GEN_261 = 4'h5 == state ? 1'h0 : 4'h6 == state; // @[StringTransformer.scala 170:23 80:27]
  wire [31:0] _GEN_270 = 4'h5 == state ? regLoadBytes : _GEN_223; // @[StringTransformer.scala 170:23 37:35]
  wire [31:0] _GEN_271 = 4'h5 == state ? regLoadAddr : _GEN_224; // @[StringTransformer.scala 170:23 39:34]
  wire [31:0] _GEN_272 = 4'h5 == state ? regTransWordNum : _GEN_226; // @[StringTransformer.scala 170:23 122:38]
  wire [31:0] _GEN_275 = 4'h5 == state ? regLastReadAddr : _GEN_229; // @[StringTransformer.scala 170:23 43:38]
  wire [7:0] _GEN_276 = 4'h5 == state ? regReadBytes_0 : _GEN_230; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_277 = 4'h5 == state ? regReadBytes_1 : _GEN_231; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_278 = 4'h5 == state ? regReadBytes_2 : _GEN_232; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_279 = 4'h5 == state ? regReadBytes_3 : _GEN_233; // @[StringTransformer.scala 170:23 42:31]
  wire  _GEN_292 = 4'h5 == state ? 1'h0 : _GEN_246; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_293 = 4'h5 == state ? 8'h0 : _GEN_247; // @[StringTransformer.scala 170:23 88:31]
  wire [7:0] _GEN_294 = 4'h5 == state ? regStoreBurstLen : _GEN_248; // @[StringTransformer.scala 170:23 36:39]
  wire  _GEN_295 = 4'h5 == state ? 1'h0 : _GEN_249; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_296 = 4'h5 == state ? regStoreBeat : _GEN_250; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_297 = 4'h5 == state ? 32'h0 : _GEN_251; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_298 = 4'h5 == state ? 4'h0 : _GEN_252; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_299 = 4'h5 == state ? regStoreBytes : _GEN_253; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_300 = 4'h5 == state ? regStoreAddr : _GEN_254; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_301 = 4'h5 == state ? 1'h0 : _GEN_255; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_302 = 4'h5 == state ? 1'h0 : _GEN_256; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_303 = 4'h4 == state ? _GEN_36 : {{31'd0}, regBufferFunc}; // @[StringTransformer.scala 170:23 28:36]
  wire [3:0] _GEN_304 = 4'h4 == state ? _GEN_37 : _GEN_260; // @[StringTransformer.scala 170:23]
  wire  _GEN_305 = 4'h4 == state ? 1'h0 : 4'h5 == state; // @[StringTransformer.scala 170:23 70:28]
  wire [31:0] _GEN_306 = 4'h4 == state ? regSrcAddr : _GEN_258; // @[StringTransformer.scala 170:23 71:32]
  wire [31:0] _GEN_307 = 4'h4 == state ? 32'h0 : _GEN_259; // @[StringTransformer.scala 170:23 74:31]
  wire  _GEN_308 = 4'h4 == state ? 1'h0 : _GEN_261; // @[StringTransformer.scala 170:23 80:27]
  wire [31:0] _GEN_317 = 4'h4 == state ? regLoadBytes : _GEN_270; // @[StringTransformer.scala 170:23 37:35]
  wire [31:0] _GEN_318 = 4'h4 == state ? regLoadAddr : _GEN_271; // @[StringTransformer.scala 170:23 39:34]
  wire [31:0] _GEN_319 = 4'h4 == state ? regTransWordNum : _GEN_272; // @[StringTransformer.scala 170:23 122:38]
  wire [31:0] _GEN_322 = 4'h4 == state ? regLastReadAddr : _GEN_275; // @[StringTransformer.scala 170:23 43:38]
  wire [7:0] _GEN_323 = 4'h4 == state ? regReadBytes_0 : _GEN_276; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_324 = 4'h4 == state ? regReadBytes_1 : _GEN_277; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_325 = 4'h4 == state ? regReadBytes_2 : _GEN_278; // @[StringTransformer.scala 170:23 42:31]
  wire [7:0] _GEN_326 = 4'h4 == state ? regReadBytes_3 : _GEN_279; // @[StringTransformer.scala 170:23 42:31]
  wire  _GEN_339 = 4'h4 == state ? 1'h0 : _GEN_292; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_340 = 4'h4 == state ? 8'h0 : _GEN_293; // @[StringTransformer.scala 170:23 88:31]
  wire [7:0] _GEN_341 = 4'h4 == state ? regStoreBurstLen : _GEN_294; // @[StringTransformer.scala 170:23 36:39]
  wire  _GEN_342 = 4'h4 == state ? 1'h0 : _GEN_295; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_343 = 4'h4 == state ? regStoreBeat : _GEN_296; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_344 = 4'h4 == state ? 32'h0 : _GEN_297; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_345 = 4'h4 == state ? 4'h0 : _GEN_298; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_346 = 4'h4 == state ? regStoreBytes : _GEN_299; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_347 = 4'h4 == state ? regStoreAddr : _GEN_300; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_348 = 4'h4 == state ? 1'h0 : _GEN_301; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_349 = 4'h4 == state ? 1'h0 : _GEN_302; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_350 = 4'h3 == state ? _GEN_34 : regStrSize; // @[StringTransformer.scala 170:23 27:57]
  wire [3:0] _GEN_351 = 4'h3 == state ? _GEN_35 : _GEN_304; // @[StringTransformer.scala 170:23]
  wire [31:0] _GEN_352 = 4'h3 == state ? {{31'd0}, regBufferFunc} : _GEN_303; // @[StringTransformer.scala 170:23 28:36]
  wire  _GEN_353 = 4'h3 == state ? 1'h0 : _GEN_305; // @[StringTransformer.scala 170:23 70:28]
  wire [31:0] _GEN_354 = 4'h3 == state ? regSrcAddr : _GEN_306; // @[StringTransformer.scala 170:23 71:32]
  wire [31:0] _GEN_355 = 4'h3 == state ? 32'h0 : _GEN_307; // @[StringTransformer.scala 170:23 74:31]
  wire  _GEN_356 = 4'h3 == state ? 1'h0 : _GEN_308; // @[StringTransformer.scala 170:23 80:27]
  wire [31:0] _GEN_365 = 4'h3 == state ? regLoadBytes : _GEN_317; // @[StringTransformer.scala 170:23 37:35]
  wire [31:0] _GEN_366 = 4'h3 == state ? regLoadAddr : _GEN_318; // @[StringTransformer.scala 170:23 39:34]
  wire [31:0] _GEN_367 = 4'h3 == state ? regTransWordNum : _GEN_319; // @[StringTransformer.scala 170:23 122:38]
  wire [31:0] _GEN_370 = 4'h3 == state ? regLastReadAddr : _GEN_322; // @[StringTransformer.scala 170:23 43:38]
  wire  _GEN_387 = 4'h3 == state ? 1'h0 : _GEN_339; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_388 = 4'h3 == state ? 8'h0 : _GEN_340; // @[StringTransformer.scala 170:23 88:31]
  wire [7:0] _GEN_389 = 4'h3 == state ? regStoreBurstLen : _GEN_341; // @[StringTransformer.scala 170:23 36:39]
  wire  _GEN_390 = 4'h3 == state ? 1'h0 : _GEN_342; // @[StringTransformer.scala 170:23 82:27]
  wire [7:0] _GEN_391 = 4'h3 == state ? regStoreBeat : _GEN_343; // @[StringTransformer.scala 170:23 41:35]
  wire [31:0] _GEN_392 = 4'h3 == state ? 32'h0 : _GEN_344; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_393 = 4'h3 == state ? 4'h0 : _GEN_345; // @[StringTransformer.scala 170:23 95:31]
  wire [31:0] _GEN_394 = 4'h3 == state ? regStoreBytes : _GEN_346; // @[StringTransformer.scala 170:23 38:36]
  wire [31:0] _GEN_395 = 4'h3 == state ? regStoreAddr : _GEN_347; // @[StringTransformer.scala 170:23 40:35]
  wire  _GEN_396 = 4'h3 == state ? 1'h0 : _GEN_348; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_397 = 4'h3 == state ? 1'h0 : _GEN_349; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_401 = 4'h2 == state ? {{31'd0}, regBufferFunc} : _GEN_352; // @[StringTransformer.scala 170:23 28:36]
  wire  _GEN_402 = 4'h2 == state ? 1'h0 : _GEN_353; // @[StringTransformer.scala 170:23 70:28]
  wire [31:0] _GEN_403 = 4'h2 == state ? regSrcAddr : _GEN_354; // @[StringTransformer.scala 170:23 71:32]
  wire [31:0] _GEN_404 = 4'h2 == state ? 32'h0 : _GEN_355; // @[StringTransformer.scala 170:23 74:31]
  wire  _GEN_405 = 4'h2 == state ? 1'h0 : _GEN_356; // @[StringTransformer.scala 170:23 80:27]
  wire  _GEN_436 = 4'h2 == state ? 1'h0 : _GEN_387; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_437 = 4'h2 == state ? 8'h0 : _GEN_388; // @[StringTransformer.scala 170:23 88:31]
  wire  _GEN_439 = 4'h2 == state ? 1'h0 : _GEN_390; // @[StringTransformer.scala 170:23 82:27]
  wire [31:0] _GEN_441 = 4'h2 == state ? 32'h0 : _GEN_392; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_442 = 4'h2 == state ? 4'h0 : _GEN_393; // @[StringTransformer.scala 170:23 95:31]
  wire  _GEN_445 = 4'h2 == state ? 1'h0 : _GEN_396; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_446 = 4'h2 == state ? 1'h0 : _GEN_397; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_451 = 4'h1 == state ? {{31'd0}, regBufferFunc} : _GEN_401; // @[StringTransformer.scala 170:23 28:36]
  wire  _GEN_452 = 4'h1 == state ? 1'h0 : _GEN_402; // @[StringTransformer.scala 170:23 70:28]
  wire [31:0] _GEN_453 = 4'h1 == state ? regSrcAddr : _GEN_403; // @[StringTransformer.scala 170:23 71:32]
  wire [31:0] _GEN_454 = 4'h1 == state ? 32'h0 : _GEN_404; // @[StringTransformer.scala 170:23 74:31]
  wire  _GEN_455 = 4'h1 == state ? 1'h0 : _GEN_405; // @[StringTransformer.scala 170:23 80:27]
  wire  _GEN_486 = 4'h1 == state ? 1'h0 : _GEN_436; // @[StringTransformer.scala 170:23 83:28]
  wire [7:0] _GEN_487 = 4'h1 == state ? 8'h0 : _GEN_437; // @[StringTransformer.scala 170:23 88:31]
  wire  _GEN_489 = 4'h1 == state ? 1'h0 : _GEN_439; // @[StringTransformer.scala 170:23 82:27]
  wire [31:0] _GEN_491 = 4'h1 == state ? 32'h0 : _GEN_441; // @[StringTransformer.scala 170:23 94:31]
  wire [3:0] _GEN_492 = 4'h1 == state ? 4'h0 : _GEN_442; // @[StringTransformer.scala 170:23 95:31]
  wire  _GEN_495 = 4'h1 == state ? 1'h0 : _GEN_445; // @[StringTransformer.scala 170:23 96:31]
  wire  _GEN_496 = 4'h1 == state ? 1'h0 : _GEN_446; // @[StringTransformer.scala 170:23 84:27]
  wire [31:0] _GEN_510 = 4'h0 == state ? 32'h0 : _GEN_451; // @[StringTransformer.scala 170:23 126:27]
  wire [31:0] _GEN_513 = 4'h0 == state ? regSrcAddr : _GEN_453; // @[StringTransformer.scala 170:23 71:32]
  wire [31:0] _GEN_514 = 4'h0 == state ? 32'h0 : _GEN_454; // @[StringTransformer.scala 170:23 74:31]
  wire [31:0] _GEN_548 = _T_1 ? 32'h0 : _GEN_510; // @[StringTransformer.scala 28:{36,36}]
  assign buffer_0_MPORT_1_en = buffer_0_MPORT_1_en_pipe_0;
  assign buffer_0_MPORT_1_addr = buffer_0_MPORT_1_addr_pipe_0;
  assign buffer_0_MPORT_1_data = buffer_0[buffer_0_MPORT_1_addr]; // @[StringTransformer.scala 50:33]
  assign buffer_0_MPORT_data = _T_3 ? 8'h0 : _GEN_456;
  assign buffer_0_MPORT_addr = _GEN_523[9:0];
  assign buffer_0_MPORT_mask = 1'h1;
  assign buffer_0_MPORT_en = wBufferEnable & wBufferWrite;
  assign buffer_1_MPORT_1_en = buffer_1_MPORT_1_en_pipe_0;
  assign buffer_1_MPORT_1_addr = buffer_1_MPORT_1_addr_pipe_0;
  assign buffer_1_MPORT_1_data = buffer_1[buffer_1_MPORT_1_addr]; // @[StringTransformer.scala 50:33]
  assign buffer_1_MPORT_data = _T_3 ? 8'h0 : _GEN_457;
  assign buffer_1_MPORT_addr = _GEN_523[9:0];
  assign buffer_1_MPORT_mask = 1'h1;
  assign buffer_1_MPORT_en = wBufferEnable & wBufferWrite;
  assign buffer_2_MPORT_1_en = buffer_2_MPORT_1_en_pipe_0;
  assign buffer_2_MPORT_1_addr = buffer_2_MPORT_1_addr_pipe_0;
  assign buffer_2_MPORT_1_data = buffer_2[buffer_2_MPORT_1_addr]; // @[StringTransformer.scala 50:33]
  assign buffer_2_MPORT_data = _T_3 ? 8'h0 : _GEN_458;
  assign buffer_2_MPORT_addr = _GEN_523[9:0];
  assign buffer_2_MPORT_mask = 1'h1;
  assign buffer_2_MPORT_en = wBufferEnable & wBufferWrite;
  assign buffer_3_MPORT_1_en = buffer_3_MPORT_1_en_pipe_0;
  assign buffer_3_MPORT_1_addr = buffer_3_MPORT_1_addr_pipe_0;
  assign buffer_3_MPORT_1_data = buffer_3[buffer_3_MPORT_1_addr]; // @[StringTransformer.scala 50:33]
  assign buffer_3_MPORT_data = _T_3 ? 8'h0 : _GEN_459;
  assign buffer_3_MPORT_addr = _GEN_523[9:0];
  assign buffer_3_MPORT_mask = 1'h1;
  assign buffer_3_MPORT_en = wBufferEnable & wBufferWrite;
  assign io_core_if_wa_ready = 1'h1; // @[StringTransformer.scala 100:29]
  assign io_core_if_w_ready = 1'h1; // @[StringTransformer.scala 101:28]
  assign io_core_if_b_valid = io_core_if_b_valid_REG; // @[StringTransformer.scala 102:28]
  assign io_core_if_b_bits_resp = 2'h0; // @[StringTransformer.scala 103:32]
  assign io_core_if_ra_ready = 1'h1; // @[StringTransformer.scala 113:29]
  assign io_core_if_r_valid = readValidReg; // @[StringTransformer.scala 114:28]
  assign io_core_if_r_bits_data = {{28'd0}, state}; // @[StringTransformer.scala 115:32]
  assign io_core_if_r_bits_resp = 2'h0; // @[StringTransformer.scala 116:32]
  assign io_mem_if_wa_valid = 4'h0 == state ? 1'h0 : _GEN_486; // @[StringTransformer.scala 170:23 83:28]
  assign io_mem_if_wa_bits_addr = {{32'd0}, regDstAddr}; // @[StringTransformer.scala 85:32]
  assign io_mem_if_wa_bits_size = 3'h2; // @[StringTransformer.scala 87:32]
  assign io_mem_if_wa_bits_len = 4'h0 == state ? 8'h0 : _GEN_487; // @[StringTransformer.scala 170:23 88:31]
  assign io_mem_if_wa_bits_burst = 2'h1; // @[StringTransformer.scala 89:33]
  assign io_mem_if_wa_bits_id = 1'h1; // @[StringTransformer.scala 93:30]
  assign io_mem_if_wa_bits_lock = 1'h0; // @[StringTransformer.scala 90:32]
  assign io_mem_if_wa_bits_cache = 4'h2; // @[StringTransformer.scala 91:33]
  assign io_mem_if_wa_bits_prot = 3'h0; // @[StringTransformer.scala 86:32]
  assign io_mem_if_wa_bits_qos = 4'h0; // @[StringTransformer.scala 92:31]
  assign io_mem_if_w_valid = 4'h0 == state ? 1'h0 : _GEN_489; // @[StringTransformer.scala 170:23 82:27]
  assign io_mem_if_w_bits_data = 4'h0 == state ? 32'h0 : _GEN_491; // @[StringTransformer.scala 170:23 94:31]
  assign io_mem_if_w_bits_strb = 4'h0 == state ? 4'h0 : _GEN_492; // @[StringTransformer.scala 170:23 95:31]
  assign io_mem_if_w_bits_last = 4'h0 == state ? 1'h0 : _GEN_495; // @[StringTransformer.scala 170:23 96:31]
  assign io_mem_if_b_ready = 4'h0 == state ? 1'h0 : _GEN_496; // @[StringTransformer.scala 170:23 84:27]
  assign io_mem_if_ra_valid = 4'h0 == state ? 1'h0 : _GEN_452; // @[StringTransformer.scala 170:23 70:28]
  assign io_mem_if_ra_bits_addr = {{32'd0}, _GEN_513};
  assign io_mem_if_ra_bits_size = 3'h2; // @[StringTransformer.scala 72:32]
  assign io_mem_if_ra_bits_len = _GEN_514[7:0];
  assign io_mem_if_ra_bits_burst = 2'h1; // @[StringTransformer.scala 73:33]
  assign io_mem_if_ra_bits_id = 1'h1; // @[StringTransformer.scala 79:30]
  assign io_mem_if_ra_bits_lock = 1'h0; // @[StringTransformer.scala 78:32]
  assign io_mem_if_ra_bits_cache = 4'h2; // @[StringTransformer.scala 75:33]
  assign io_mem_if_ra_bits_prot = 3'h0; // @[StringTransformer.scala 76:32]
  assign io_mem_if_ra_bits_qos = 4'h0; // @[StringTransformer.scala 77:31]
  assign io_mem_if_r_ready = 4'h0 == state ? 1'h0 : _GEN_455; // @[StringTransformer.scala 170:23 80:27]
  always @(posedge clock) begin
    if (buffer_0_MPORT_en & buffer_0_MPORT_mask) begin
      buffer_0[buffer_0_MPORT_addr] <= buffer_0_MPORT_data; // @[StringTransformer.scala 50:33]
    end
    buffer_0_MPORT_1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      buffer_0_MPORT_1_addr_pipe_0 <= _GEN_524[9:0];
    end
    if (buffer_1_MPORT_en & buffer_1_MPORT_mask) begin
      buffer_1[buffer_1_MPORT_addr] <= buffer_1_MPORT_data; // @[StringTransformer.scala 50:33]
    end
    buffer_1_MPORT_1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      buffer_1_MPORT_1_addr_pipe_0 <= _GEN_524[9:0];
    end
    if (buffer_2_MPORT_en & buffer_2_MPORT_mask) begin
      buffer_2[buffer_2_MPORT_addr] <= buffer_2_MPORT_data; // @[StringTransformer.scala 50:33]
    end
    buffer_2_MPORT_1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      buffer_2_MPORT_1_addr_pipe_0 <= _GEN_524[9:0];
    end
    if (buffer_3_MPORT_en & buffer_3_MPORT_mask) begin
      buffer_3[buffer_3_MPORT_addr] <= buffer_3_MPORT_data; // @[StringTransformer.scala 50:33]
    end
    buffer_3_MPORT_1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      buffer_3_MPORT_1_addr_pipe_0 <= _GEN_524[9:0];
    end
    if (_T_1) begin // @[StringTransformer.scala 27:57]
      regSrcAddr <= 32'h0; // @[StringTransformer.scala 27:57]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regSrcAddr <= 32'h0; // @[StringTransformer.scala 126:27]
    end else if (4'h1 == state) begin // @[StringTransformer.scala 170:23]
      if (io_core_if_w_valid) begin // @[StringTransformer.scala 186:43]
        regSrcAddr <= io_core_if_w_bits_data; // @[StringTransformer.scala 187:32]
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 27:57]
      regDstAddr <= 32'h0; // @[StringTransformer.scala 27:57]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regDstAddr <= 32'h0; // @[StringTransformer.scala 126:27]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (4'h2 == state) begin // @[StringTransformer.scala 170:23]
        regDstAddr <= _GEN_32;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 27:57]
      regStrSize <= 32'h0; // @[StringTransformer.scala 27:57]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regStrSize <= 32'h0; // @[StringTransformer.scala 126:27]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regStrSize <= _GEN_350;
      end
    end
    regBufferFunc <= _GEN_548[0]; // @[StringTransformer.scala 28:{36,36}]
    if (_T_1) begin // @[StringTransformer.scala 34:28]
      state <= 4'h0; // @[StringTransformer.scala 34:28]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      if (proceed) begin // @[StringTransformer.scala 180:32]
        state <= 4'h1; // @[StringTransformer.scala 181:27]
      end
    end else if (4'h1 == state) begin // @[StringTransformer.scala 170:23]
      if (io_core_if_w_valid) begin // @[StringTransformer.scala 186:43]
        state <= 4'h2; // @[StringTransformer.scala 188:27]
      end
    end else if (4'h2 == state) begin // @[StringTransformer.scala 170:23]
      state <= _GEN_33;
    end else begin
      state <= _GEN_351;
    end
    if (_T_1) begin // @[StringTransformer.scala 36:39]
      regStoreBurstLen <= 8'h0; // @[StringTransformer.scala 36:39]
    end else if (!(4'h0 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
          regStoreBurstLen <= _GEN_389;
        end
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 37:35]
      regLoadBytes <= 32'h0; // @[StringTransformer.scala 37:35]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regLoadBytes <= 32'h0; // @[StringTransformer.scala 172:30]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regLoadBytes <= _GEN_365;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 38:36]
      regStoreBytes <= 32'h0; // @[StringTransformer.scala 38:36]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regStoreBytes <= 32'h0; // @[StringTransformer.scala 173:31]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regStoreBytes <= _GEN_394;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 39:34]
      regLoadAddr <= 32'h0; // @[StringTransformer.scala 39:34]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regLoadAddr <= 32'h0; // @[StringTransformer.scala 174:29]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regLoadAddr <= _GEN_366;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 40:35]
      regStoreAddr <= 32'h0; // @[StringTransformer.scala 40:35]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regStoreAddr <= 32'h0; // @[StringTransformer.scala 175:30]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regStoreAddr <= _GEN_395;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 41:35]
      regStoreBeat <= 8'h0; // @[StringTransformer.scala 41:35]
    end else if (!(4'h0 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
          regStoreBeat <= _GEN_391;
        end
      end
    end
    if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regReadBytes_0 <= 8'h0; // @[StringTransformer.scala 177:53]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h3 == state)) begin // @[StringTransformer.scala 170:23]
          regReadBytes_0 <= _GEN_323;
        end
      end
    end
    if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regReadBytes_1 <= 8'h0; // @[StringTransformer.scala 177:53]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h3 == state)) begin // @[StringTransformer.scala 170:23]
          regReadBytes_1 <= _GEN_324;
        end
      end
    end
    if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regReadBytes_2 <= 8'h0; // @[StringTransformer.scala 177:53]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h3 == state)) begin // @[StringTransformer.scala 170:23]
          regReadBytes_2 <= _GEN_325;
        end
      end
    end
    if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regReadBytes_3 <= 8'h0; // @[StringTransformer.scala 177:53]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        if (!(4'h3 == state)) begin // @[StringTransformer.scala 170:23]
          regReadBytes_3 <= _GEN_326;
        end
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 43:38]
      regLastReadAddr <= 32'h0; // @[StringTransformer.scala 43:38]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regLastReadAddr <= 32'h0; // @[StringTransformer.scala 178:33]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regLastReadAddr <= _GEN_370;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 122:38]
      regTransWordNum <= 32'h0; // @[StringTransformer.scala 122:38]
    end else if (4'h0 == state) begin // @[StringTransformer.scala 170:23]
      regTransWordNum <= 32'h0; // @[StringTransformer.scala 176:33]
    end else if (!(4'h1 == state)) begin // @[StringTransformer.scala 170:23]
      if (!(4'h2 == state)) begin // @[StringTransformer.scala 170:23]
        regTransWordNum <= _GEN_367;
      end
    end
    if (_T_1) begin // @[StringTransformer.scala 102:38]
      io_core_if_b_valid_REG <= 1'h0; // @[StringTransformer.scala 102:38]
    end else begin
      io_core_if_b_valid_REG <= io_core_if_wa_valid; // @[StringTransformer.scala 102:38]
    end
    if (_T_1) begin // @[StringTransformer.scala 107:35]
      readValidReg <= 1'h0; // @[StringTransformer.scala 107:35]
    end else if (~readValidReg) begin // @[StringTransformer.scala 108:32]
      readValidReg <= io_core_if_ra_valid; // @[StringTransformer.scala 109:26]
    end else begin
      readValidReg <= ~io_core_if_r_ready; // @[StringTransformer.scala 111:26]
    end
  end
// Register and memory initialization
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
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    buffer_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    buffer_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    buffer_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    buffer_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  buffer_0_MPORT_1_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  buffer_0_MPORT_1_addr_pipe_0 = _RAND_2[9:0];
  _RAND_4 = {1{`RANDOM}};
  buffer_1_MPORT_1_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  buffer_1_MPORT_1_addr_pipe_0 = _RAND_5[9:0];
  _RAND_7 = {1{`RANDOM}};
  buffer_2_MPORT_1_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  buffer_2_MPORT_1_addr_pipe_0 = _RAND_8[9:0];
  _RAND_10 = {1{`RANDOM}};
  buffer_3_MPORT_1_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  buffer_3_MPORT_1_addr_pipe_0 = _RAND_11[9:0];
  _RAND_12 = {1{`RANDOM}};
  regSrcAddr = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regDstAddr = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regStrSize = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regBufferFunc = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  state = _RAND_16[3:0];
  _RAND_17 = {1{`RANDOM}};
  regStoreBurstLen = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  regLoadBytes = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regStoreBytes = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regLoadAddr = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regStoreAddr = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regStoreBeat = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  regReadBytes_0 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  regReadBytes_1 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  regReadBytes_2 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  regReadBytes_3 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  regLastReadAddr = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regTransWordNum = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  io_core_if_b_valid_REG = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  readValidReg = _RAND_30[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
