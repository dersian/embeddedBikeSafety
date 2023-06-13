library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity mic_test is
    Port ( 
           i_FPGAclk : in std_logic; -- internal FPGA clock
           i_mic : in STD_LOGIC; -- microphone output
           o_mic_clk: out STD_LOGIC; -- mic clk
           o_Sclk: out STD_LOGIC; -- clk for reading sensor values
           o_mic : out std_logic); -- monitor this pin
end mic_test;

architecture Behavioral of mic_test is

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal PDMclk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal Sclk : STD_LOGIC := '0';

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
    
    Sclkdelayproc:process(i_FPGAclk) -- A delay for the filter clock to guarantee valid data
        begin
        if rising_edge(i_FPGAclk) then
            if (PDMclk = '0') then -- assumes PDM select to be low
                if (Sclkdelay_counter = c_Sclkdelay_countermax) then
                    Sclk <= '1';
                else
                    Sclkdelay_counter <= Sclkdelay_counter + 1;
                end if;
            else
                Sclk <= '0';
                Sclkdelay_counter <= (others => '0');
            end if;
        end if;
    end process Sclkdelayproc;
    o_Sclk <= Sclk;
    
end Behavioral;

