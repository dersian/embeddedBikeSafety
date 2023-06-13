library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;
use ieee.math_real.all;

entity mic_test is
    Port ( 
           i_FPGAclk : in std_logic; -- internal FPGA clock
           i_mic : in STD_LOGIC; -- microphone output
           o_mic_clk: out STD_LOGIC; -- mic clk
           o_mic : out std_logic); -- monitor this pin
end mic_test;

architecture Behavioral of mic_test is

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal PDMclk: std_logic := '1'; -- assumes PDM microphone setting to be low

begin

    PDMclkdivproc:process(i_FPGAclk) -- generates PDM clock from FPGA clock
        begin
        if rising_edge(i_FPGAclk) then
            if (PDMclk_counter = c_PDMclkcountermax) then
                PDMclk_counter <= (others => '0'); 
                PDMclk <= not(PDMclk);
            else
                PDMclk_counter <= PDMclk_counter + 1;
            end if;    
        end if;
    end process PDMclkdivproc;
    o_mic_clk <= PDMclk; 
    o_mic <= i_mic;

end Behavioral;

