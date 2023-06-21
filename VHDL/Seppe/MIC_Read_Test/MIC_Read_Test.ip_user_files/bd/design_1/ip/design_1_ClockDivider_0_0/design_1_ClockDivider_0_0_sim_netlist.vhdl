-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
-- Date        : Fri Jun 16 09:39:17 2023
-- Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/indi/Documents/EDSP/MIC_Read_Test/MIC_Read_Test.gen/sources_1/bd/design_1/ip/design_1_ClockDivider_0_0/design_1_ClockDivider_0_0_sim_netlist.vhdl
-- Design      : design_1_ClockDivider_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_ClockDivider_0_0_ClockDivider is
  port (
    o_PDM_clk : out STD_LOGIC;
    i_FPGA_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_ClockDivider_0_0_ClockDivider : entity is "ClockDivider";
end design_1_ClockDivider_0_0_ClockDivider;

architecture STRUCTURE of design_1_ClockDivider_0_0_ClockDivider is
  signal PDM_clk_i_1_n_0 : STD_LOGIC;
  signal PDM_clk_i_2_n_0 : STD_LOGIC;
  signal clk_ctr : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \clk_ctr[6]_i_2_n_0\ : STD_LOGIC;
  signal \clk_ctr[7]_i_2_n_0\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[0]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[1]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[2]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[3]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[4]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[5]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[6]\ : STD_LOGIC;
  signal \clk_ctr_reg_n_0_[7]\ : STD_LOGIC;
  signal \^o_pdm_clk\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of PDM_clk_i_2 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \clk_ctr[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \clk_ctr[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \clk_ctr[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \clk_ctr[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \clk_ctr[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \clk_ctr[6]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \clk_ctr[7]_i_1\ : label is "soft_lutpair2";
begin
  o_PDM_clk <= \^o_pdm_clk\;
PDM_clk_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00004000"
    )
        port map (
      I0 => PDM_clk_i_2_n_0,
      I1 => \clk_ctr_reg_n_0_[3]\,
      I2 => \clk_ctr_reg_n_0_[0]\,
      I3 => \clk_ctr_reg_n_0_[1]\,
      I4 => \clk_ctr_reg_n_0_[2]\,
      I5 => \^o_pdm_clk\,
      O => PDM_clk_i_1_n_0
    );
PDM_clk_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[5]\,
      I1 => \clk_ctr_reg_n_0_[4]\,
      I2 => \clk_ctr_reg_n_0_[7]\,
      I3 => \clk_ctr_reg_n_0_[6]\,
      O => PDM_clk_i_2_n_0
    );
PDM_clk_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => PDM_clk_i_1_n_0,
      Q => \^o_pdm_clk\,
      R => '0'
    );
\clk_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[0]\,
      O => clk_ctr(0)
    );
\clk_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[0]\,
      I1 => \clk_ctr_reg_n_0_[1]\,
      O => clk_ctr(1)
    );
\clk_ctr[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFFB000"
    )
        port map (
      I0 => PDM_clk_i_2_n_0,
      I1 => \clk_ctr_reg_n_0_[3]\,
      I2 => \clk_ctr_reg_n_0_[1]\,
      I3 => \clk_ctr_reg_n_0_[0]\,
      I4 => \clk_ctr_reg_n_0_[2]\,
      O => clk_ctr(2)
    );
\clk_ctr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4AF0F0F0"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[2]\,
      I1 => PDM_clk_i_2_n_0,
      I2 => \clk_ctr_reg_n_0_[3]\,
      I3 => \clk_ctr_reg_n_0_[0]\,
      I4 => \clk_ctr_reg_n_0_[1]\,
      O => clk_ctr(3)
    );
\clk_ctr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[2]\,
      I1 => \clk_ctr_reg_n_0_[1]\,
      I2 => \clk_ctr_reg_n_0_[0]\,
      I3 => \clk_ctr_reg_n_0_[3]\,
      I4 => \clk_ctr_reg_n_0_[4]\,
      O => clk_ctr(4)
    );
\clk_ctr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[4]\,
      I1 => \clk_ctr_reg_n_0_[3]\,
      I2 => \clk_ctr_reg_n_0_[0]\,
      I3 => \clk_ctr_reg_n_0_[1]\,
      I4 => \clk_ctr_reg_n_0_[2]\,
      I5 => \clk_ctr_reg_n_0_[5]\,
      O => clk_ctr(5)
    );
\clk_ctr[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFF08000000"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[5]\,
      I1 => \clk_ctr_reg_n_0_[2]\,
      I2 => \clk_ctr[6]_i_2_n_0\,
      I3 => \clk_ctr_reg_n_0_[3]\,
      I4 => \clk_ctr_reg_n_0_[4]\,
      I5 => \clk_ctr_reg_n_0_[6]\,
      O => clk_ctr(6)
    );
\clk_ctr[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[0]\,
      I1 => \clk_ctr_reg_n_0_[1]\,
      O => \clk_ctr[6]_i_2_n_0\
    );
\clk_ctr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[6]\,
      I1 => \clk_ctr[7]_i_2_n_0\,
      I2 => \clk_ctr_reg_n_0_[7]\,
      O => clk_ctr(7)
    );
\clk_ctr[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \clk_ctr_reg_n_0_[4]\,
      I1 => \clk_ctr_reg_n_0_[3]\,
      I2 => \clk_ctr_reg_n_0_[0]\,
      I3 => \clk_ctr_reg_n_0_[1]\,
      I4 => \clk_ctr_reg_n_0_[2]\,
      I5 => \clk_ctr_reg_n_0_[5]\,
      O => \clk_ctr[7]_i_2_n_0\
    );
\clk_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(0),
      Q => \clk_ctr_reg_n_0_[0]\,
      R => '0'
    );
\clk_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(1),
      Q => \clk_ctr_reg_n_0_[1]\,
      R => '0'
    );
\clk_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(2),
      Q => \clk_ctr_reg_n_0_[2]\,
      R => '0'
    );
\clk_ctr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(3),
      Q => \clk_ctr_reg_n_0_[3]\,
      R => '0'
    );
\clk_ctr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(4),
      Q => \clk_ctr_reg_n_0_[4]\,
      R => '0'
    );
\clk_ctr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(5),
      Q => \clk_ctr_reg_n_0_[5]\,
      R => '0'
    );
\clk_ctr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(6),
      Q => \clk_ctr_reg_n_0_[6]\,
      R => '0'
    );
\clk_ctr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGA_clk,
      CE => '1',
      D => clk_ctr(7),
      Q => \clk_ctr_reg_n_0_[7]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_ClockDivider_0_0 is
  port (
    i_FPGA_clk : in STD_LOGIC;
    o_PDM_clk : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_ClockDivider_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_ClockDivider_0_0 : entity is "design_1_ClockDivider_0_0,ClockDivider,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_ClockDivider_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_ClockDivider_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_ClockDivider_0_0 : entity is "ClockDivider,Vivado 2021.1";
end design_1_ClockDivider_0_0;

architecture STRUCTURE of design_1_ClockDivider_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of i_FPGA_clk : signal is "xilinx.com:signal:clock:1.0 i_FPGA_clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of i_FPGA_clk : signal is "XIL_INTERFACENAME i_FPGA_clk, FREQ_HZ 55298913, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of o_PDM_clk : signal is "xilinx.com:signal:clock:1.0 o_PDM_clk CLK";
  attribute x_interface_parameter of o_PDM_clk : signal is "XIL_INTERFACENAME o_PDM_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_ClockDivider_0_0_o_PDM_clk, INSERT_VIP 0";
begin
U0: entity work.design_1_ClockDivider_0_0_ClockDivider
     port map (
      i_FPGA_clk => i_FPGA_clk,
      o_PDM_clk => o_PDM_clk
    );
end STRUCTURE;
