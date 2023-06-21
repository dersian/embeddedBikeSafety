--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
--Date        : Sun Jun 18 17:12:35 2023
--Host        : indi-VM running 64-bit Ubuntu 20.04.1 LTS
--Command     : generate_target BlockDesignMain_wrapper.bd
--Design      : BlockDesignMain_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BlockDesignMain_wrapper is
  port (
    clk : in STD_LOGIC;
    pcm_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    pdm_data : in STD_LOGIC
  );
end BlockDesignMain_wrapper;

architecture STRUCTURE of BlockDesignMain_wrapper is
  component BlockDesignMain is
  port (
    clk : in STD_LOGIC;
    pdm_data : in STD_LOGIC;
    pcm_data : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component BlockDesignMain;
begin
BlockDesignMain_i: component BlockDesignMain
     port map (
      clk => clk,
      pcm_data(15 downto 0) => pcm_data(15 downto 0),
      pdm_data => pdm_data
    );
end STRUCTURE;
