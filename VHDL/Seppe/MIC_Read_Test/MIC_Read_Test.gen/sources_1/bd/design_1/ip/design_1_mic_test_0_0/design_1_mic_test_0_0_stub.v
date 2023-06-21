// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Mon Jun 19 14:55:34 2023
// Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/indi/Documents/EDSP/MIC_Read_Test/MIC_Read_Test.gen/sources_1/bd/design_1/ip/design_1_mic_test_0_0/design_1_mic_test_0_0_stub.v
// Design      : design_1_mic_test_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mic_test,Vivado 2021.1" *)
module design_1_mic_test_0_0(i_FPGA_clk, i_PDM_clk, i_mic, o_mic, 
  o_sample_valid)
/* synthesis syn_black_box black_box_pad_pin="i_FPGA_clk,i_PDM_clk,i_mic,o_mic,o_sample_valid" */;
  input i_FPGA_clk;
  input i_PDM_clk;
  input i_mic;
  output o_mic;
  output o_sample_valid;
endmodule
