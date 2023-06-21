-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
-- Date        : Fri Jun 16 09:39:16 2023
-- Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_mic_test_0_0_sim_netlist.vhdl
-- Design      : design_1_mic_test_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test is
  port (
    o_mic : out STD_LOGIC;
    i_PDMclk : in STD_LOGIC;
    i_mic : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test is
  signal \delay_ctr[3]_i_1_n_0\ : STD_LOGIC;
  signal \delay_ctr_reg_n_0_[0]\ : STD_LOGIC;
  signal \delay_ctr_reg_n_0_[1]\ : STD_LOGIC;
  signal \delay_ctr_reg_n_0_[2]\ : STD_LOGIC;
  signal \delay_ctr_reg_n_0_[3]\ : STD_LOGIC;
  signal \^o_mic\ : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal temp_mic_i_1_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \delay_ctr[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \delay_ctr[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \delay_ctr[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \delay_ctr[3]_i_2\ : label is "soft_lutpair0";
begin
  o_mic <= \^o_mic\;
\delay_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \delay_ctr_reg_n_0_[0]\,
      O => plusOp(0)
    );
\delay_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \delay_ctr_reg_n_0_[0]\,
      I1 => \delay_ctr_reg_n_0_[1]\,
      O => plusOp(1)
    );
\delay_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \delay_ctr_reg_n_0_[0]\,
      I1 => \delay_ctr_reg_n_0_[1]\,
      I2 => \delay_ctr_reg_n_0_[2]\,
      O => plusOp(2)
    );
\delay_ctr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => \delay_ctr_reg_n_0_[2]\,
      I1 => \delay_ctr_reg_n_0_[3]\,
      I2 => \delay_ctr_reg_n_0_[0]\,
      I3 => \delay_ctr_reg_n_0_[1]\,
      O => \delay_ctr[3]_i_1_n_0\
    );
\delay_ctr[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \delay_ctr_reg_n_0_[1]\,
      I1 => \delay_ctr_reg_n_0_[0]\,
      I2 => \delay_ctr_reg_n_0_[2]\,
      I3 => \delay_ctr_reg_n_0_[3]\,
      O => plusOp(3)
    );
\delay_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_PDMclk,
      CE => '1',
      D => plusOp(0),
      Q => \delay_ctr_reg_n_0_[0]\,
      R => \delay_ctr[3]_i_1_n_0\
    );
\delay_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_PDMclk,
      CE => '1',
      D => plusOp(1),
      Q => \delay_ctr_reg_n_0_[1]\,
      R => \delay_ctr[3]_i_1_n_0\
    );
\delay_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_PDMclk,
      CE => '1',
      D => plusOp(2),
      Q => \delay_ctr_reg_n_0_[2]\,
      R => \delay_ctr[3]_i_1_n_0\
    );
\delay_ctr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_PDMclk,
      CE => '1',
      D => plusOp(3),
      Q => \delay_ctr_reg_n_0_[3]\,
      R => \delay_ctr[3]_i_1_n_0\
    );
temp_mic_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFF00000200"
    )
        port map (
      I0 => i_mic,
      I1 => \delay_ctr_reg_n_0_[3]\,
      I2 => \delay_ctr_reg_n_0_[1]\,
      I3 => \delay_ctr_reg_n_0_[2]\,
      I4 => \delay_ctr_reg_n_0_[0]\,
      I5 => \^o_mic\,
      O => temp_mic_i_1_n_0
    );
temp_mic_reg: unisim.vcomponents.FDRE
     port map (
      C => i_PDMclk,
      CE => '1',
      D => temp_mic_i_1_n_0,
      Q => \^o_mic\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    i_PDMclk : in STD_LOGIC;
    i_mic : in STD_LOGIC;
    o_mic : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_1_mic_test_0_0,mic_test,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "mic_test,Vivado 2021.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
U0: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test
     port map (
      i_PDMclk => i_PDMclk,
      i_mic => i_mic,
      o_mic => o_mic
    );
end STRUCTURE;
