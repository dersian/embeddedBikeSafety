library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ClockDivider is
  Port ( 
        i_FPGA_clk : IN std_logic;
        o_PDM_clk: OUT std_logic
        --o_PCM_clk: OUT std_logic
  );
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal PDM_ctr: unsigned(7 downto 0) := (others => '0');
    --signal PCM_ctr: unsigned(7 downto 0) := (others => '0');
    signal PDM_clk: std_logic := '0';
    --signal PCM_clk: std_logic := '0';
begin
    ClockDivProc:process(i_FPGA_clk)
    begin
        if rising_edge(i_FPGA_clk) then       
            if (PDM_ctr = 11) then -- 55.3MHz/2.304MHz -- PDM
                PDM_ctr <= (others => '0'); 
                PDM_clk <= not(PDM_clk);
            --elsif (PCM_ctr = 575)  then
                --PCM_ctr <= (others => '0');
                --PCM_clk <= not(PCM_clk);
            else
                PDM_ctr <= PDM_ctr + 1;         
                --PCM_ctr <= PCM_ctr + 1;     
            end if;    
        end if;
        o_PDM_clk <= PDM_clk; 
        --o_PCM_clk <= PCM_clk;
    end process ClockDivProc;
end Behavioral;
