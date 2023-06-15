-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
-- Date        : Wed Jun 14 14:40:08 2023
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
    o_mic_clk : out STD_LOGIC;
    i_FPGAclk : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test is
  signal PDMclk_counter : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \PDMclk_counter[0]_i_1_n_0\ : STD_LOGIC;
  signal \PDMclk_counter[7]_i_2_n_0\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[0]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[1]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[2]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[3]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[4]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[5]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[6]\ : STD_LOGIC;
  signal \PDMclk_counter_reg_n_0_[7]\ : STD_LOGIC;
  signal PDMclk_i_1_n_0 : STD_LOGIC;
  signal PDMclk_i_2_n_0 : STD_LOGIC;
  signal \^o_mic_clk\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \PDMclk_counter[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \PDMclk_counter[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \PDMclk_counter[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \PDMclk_counter[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \PDMclk_counter[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \PDMclk_counter[7]_i_2\ : label is "soft_lutpair2";
begin
  o_mic_clk <= \^o_mic_clk\;
\PDMclk_counter[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFBF"
    )
        port map (
      I0 => PDMclk_i_2_n_0,
      I1 => \PDMclk_counter_reg_n_0_[3]\,
      I2 => \PDMclk_counter_reg_n_0_[1]\,
      I3 => \PDMclk_counter_reg_n_0_[2]\,
      I4 => \PDMclk_counter_reg_n_0_[0]\,
      O => \PDMclk_counter[0]_i_1_n_0\
    );
\PDMclk_counter[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00FBFF00"
    )
        port map (
      I0 => PDMclk_i_2_n_0,
      I1 => \PDMclk_counter_reg_n_0_[3]\,
      I2 => \PDMclk_counter_reg_n_0_[2]\,
      I3 => \PDMclk_counter_reg_n_0_[0]\,
      I4 => \PDMclk_counter_reg_n_0_[1]\,
      O => PDMclk_counter(1)
    );
\PDMclk_counter[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[1]\,
      I1 => \PDMclk_counter_reg_n_0_[0]\,
      I2 => \PDMclk_counter_reg_n_0_[2]\,
      O => PDMclk_counter(2)
    );
\PDMclk_counter[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3CCCCC8C"
    )
        port map (
      I0 => PDMclk_i_2_n_0,
      I1 => \PDMclk_counter_reg_n_0_[3]\,
      I2 => \PDMclk_counter_reg_n_0_[1]\,
      I3 => \PDMclk_counter_reg_n_0_[2]\,
      I4 => \PDMclk_counter_reg_n_0_[0]\,
      O => PDMclk_counter(3)
    );
\PDMclk_counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[4]\,
      I1 => \PDMclk_counter_reg_n_0_[2]\,
      I2 => \PDMclk_counter_reg_n_0_[0]\,
      I3 => \PDMclk_counter_reg_n_0_[1]\,
      I4 => \PDMclk_counter_reg_n_0_[3]\,
      O => PDMclk_counter(4)
    );
\PDMclk_counter[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[5]\,
      I1 => \PDMclk_counter_reg_n_0_[3]\,
      I2 => \PDMclk_counter_reg_n_0_[1]\,
      I3 => \PDMclk_counter_reg_n_0_[0]\,
      I4 => \PDMclk_counter_reg_n_0_[2]\,
      I5 => \PDMclk_counter_reg_n_0_[4]\,
      O => PDMclk_counter(5)
    );
\PDMclk_counter[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[6]\,
      I1 => \PDMclk_counter_reg_n_0_[4]\,
      I2 => \PDMclk_counter[7]_i_2_n_0\,
      I3 => \PDMclk_counter_reg_n_0_[3]\,
      I4 => \PDMclk_counter_reg_n_0_[5]\,
      O => PDMclk_counter(6)
    );
\PDMclk_counter[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[7]\,
      I1 => \PDMclk_counter_reg_n_0_[5]\,
      I2 => \PDMclk_counter_reg_n_0_[3]\,
      I3 => \PDMclk_counter[7]_i_2_n_0\,
      I4 => \PDMclk_counter_reg_n_0_[4]\,
      I5 => \PDMclk_counter_reg_n_0_[6]\,
      O => PDMclk_counter(7)
    );
\PDMclk_counter[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[2]\,
      I1 => \PDMclk_counter_reg_n_0_[0]\,
      I2 => \PDMclk_counter_reg_n_0_[1]\,
      O => \PDMclk_counter[7]_i_2_n_0\
    );
\PDMclk_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => \PDMclk_counter[0]_i_1_n_0\,
      Q => \PDMclk_counter_reg_n_0_[0]\,
      R => '0'
    );
\PDMclk_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(1),
      Q => \PDMclk_counter_reg_n_0_[1]\,
      R => '0'
    );
\PDMclk_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(2),
      Q => \PDMclk_counter_reg_n_0_[2]\,
      R => '0'
    );
\PDMclk_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(3),
      Q => \PDMclk_counter_reg_n_0_[3]\,
      R => '0'
    );
\PDMclk_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(4),
      Q => \PDMclk_counter_reg_n_0_[4]\,
      R => '0'
    );
\PDMclk_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(5),
      Q => \PDMclk_counter_reg_n_0_[5]\,
      R => '0'
    );
\PDMclk_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(6),
      Q => \PDMclk_counter_reg_n_0_[6]\,
      R => '0'
    );
\PDMclk_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_counter(7),
      Q => \PDMclk_counter_reg_n_0_[7]\,
      R => '0'
    );
PDMclk_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFBF00000040"
    )
        port map (
      I0 => PDMclk_i_2_n_0,
      I1 => \PDMclk_counter_reg_n_0_[3]\,
      I2 => \PDMclk_counter_reg_n_0_[1]\,
      I3 => \PDMclk_counter_reg_n_0_[2]\,
      I4 => \PDMclk_counter_reg_n_0_[0]\,
      I5 => \^o_mic_clk\,
      O => PDMclk_i_1_n_0
    );
PDMclk_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \PDMclk_counter_reg_n_0_[6]\,
      I1 => \PDMclk_counter_reg_n_0_[4]\,
      I2 => \PDMclk_counter_reg_n_0_[7]\,
      I3 => \PDMclk_counter_reg_n_0_[5]\,
      O => PDMclk_i_2_n_0
    );
PDMclk_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => i_FPGAclk,
      CE => '1',
      D => PDMclk_i_1_n_0,
      Q => \^o_mic_clk\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    i_FPGAclk : in STD_LOGIC;
    i_mic : in STD_LOGIC;
    o_mic_clk : out STD_LOGIC;
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
  signal \^i_mic\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of o_mic_clk : signal is "xilinx.com:signal:clock:1.0 o_mic_clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of o_mic_clk : signal is "XIL_INTERFACENAME o_mic_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_mic_test_0_0_o_mic_clk, INSERT_VIP 0";
begin
  \^i_mic\ <= i_mic;
  o_mic <= \^i_mic\;
U0: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mic_test
     port map (
      i_FPGAclk => i_FPGAclk,
      o_mic_clk => o_mic_clk
    );
end STRUCTURE;
