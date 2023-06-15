library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic_test is
    Port ( 
           i_FPGAclk : in std_logic; -- internal FPGA clock
           i_mic : in STD_LOGIC; -- microphone input
           o_mic_clk: out STD_LOGIC; -- output PDM clk
           o_mic : out std_logic); -- monitor this pin
end mic_test;

architecture Behavioral of mic_test is
    signal PDMclk_ctr : unsigned(7 downto 0) := (others => '0');
    signal PDMclk: std_logic := '0'; 
    signal delay_ctr: unsigned(3 downto 0) := (others => '0'); -- delay for cable and silicon
    signal temp_mic: std_logic;
begin
    PDMclkdivproc:process(i_FPGAclk) -- generates PDM clock from FPGA clock
        begin
        if rising_edge(i_FPGAclk) then       
            if (PDMclk_ctr = 11) then -- 55.3MHz/2.304MHz
                PDMclk_ctr <= (others => '0'); 
                PDMclk <= not(PDMclk);
            else
                PDMclk_ctr <= PDMclk_ctr + 1;
            end if;    
        end if;
        o_mic_clk <= PDMclk; 
    end process PDMclkdivproc;
    
    DelayInput:process(i_FPGAclk)
    begin
        if rising_edge(i_FPGAclk) then
            if (delay_ctr = 5) then -- apprx 72 ns
                temp_mic <= i_mic;
                delay_ctr <= (others => '0');     
            else
                delay_ctr <= delay_ctr + 1;
            end if;
        end if;
        o_mic <= temp_mic;
    end process DelayInput;
end Behavioral;
