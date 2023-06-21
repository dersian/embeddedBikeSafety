library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic_test_tb is
end mic_test_tb;

architecture Behavioral of mic_test_tb is
    component mic_test is
        Port(
           i_FPGA_clk: IN std_logic;
           i_PDM_clk : IN std_logic; 
           i_mic : IN STD_LOGIC; -- microphone input
           o_mic : OUT std_logic -- monitor this pin    
        );
    end component;
    
    signal i_FPGA_clk: std_logic := '0';
    signal i_PDM_clk: std_logic := '0';
    signal i_mic: std_logic := '0';
    signal o_mic: std_logic := '0';
    
    constant FPGA_clk_c: time := 10ns;
    constant PDM_clk_c: time := 434ns;
    
begin
    UUT:mic_test
    port map(
        i_FPGA_clk => i_FPGA_clk,
        i_PDM_clk => i_PDM_clk,
        i_mic => i_mic,
        o_mic => o_mic
    );
    
    FPGAclk_process:process
    begin
        i_FPGA_clk <= '0';
        wait for FPGA_clk_c/2;
        i_FPGA_clk <= '1';
        wait for FPGA_clk_c/2;
    end process;
    
    PDMclk_process:process
    begin
        i_PDM_clk <= '0';
        wait for PDM_clk_c/2;
        i_PDM_clk <= '1';
        wait for PDM_clk_c/2;
    end process;

end Behavioral;
