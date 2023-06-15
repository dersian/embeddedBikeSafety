-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
-- Date        : Wed Jun 14 17:19:16 2023
-- Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/indi/Documents/EDSP/MIC_Read_Test/MIC_Read_Test.gen/sources_1/bd/design_1/ip/design_1_mic_test_0_0/design_1_mic_test_0_0_stub.vhdl
-- Design      : design_1_mic_test_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_mic_test_0_0 is
  Port ( 
    i_FPGAclk : in STD_LOGIC;
    i_mic : in STD_LOGIC;
    o_mic_clk : out STD_LOGIC;
    o_mic : out STD_LOGIC
  );

end design_1_mic_test_0_0;

architecture stub of design_1_mic_test_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "i_FPGAclk,i_mic,o_mic_clk,o_mic";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "mic_test,Vivado 2021.1";
begin
end;
