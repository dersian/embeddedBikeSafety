library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic_test is
    Port ( 
           i_FPGA_clk: IN std_logic;
           i_PDM_clk : IN std_logic; 
           i_mic : IN std_logic_vector(8 downto 0); 
           o_mic : OUT std_logic_vector(8 downto 0);
           o_sample_valid : OUT std_logic); 
end mic_test;

architecture Behavioral of mic_test is
    signal PDM_ctr: unsigned(7 downto 0) := (others => '0'); -- delay for cable and silicon
begin
    DelayInput:process(i_FPGA_clk)
    begin
        if falling_edge(i_FPGA_clk) then
            if (i_PDM_clk = '0') then
                if (PDM_ctr = 7) then -- wait 80 ns
                    o_mic <= i_mic;
                    o_sample_valid <= '1';
                    PDM_ctr <= (others => '0'); 
                else
                    o_sample_valid <= '0';
                end if;
                PDM_ctr <= PDM_ctr + 1;    
            else
                PDM_ctr <= (others => '0');
                o_sample_valid <= '0'; 
            end if;
        end if;
    end process DelayInput;
end Behavioral;

