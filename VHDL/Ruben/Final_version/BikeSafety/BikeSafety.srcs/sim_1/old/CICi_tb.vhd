-- https://fpgatutorial.com/vhdl-generic-generate/
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity CICi_tb is
end CICi_tb;

architecture Behavioral of CICi_tb is

component CICi is
    generic (g_N: integer);
    Port ( i_clk : in STD_LOGIC;
           --i_reset : in STD_LOGIC; -- low to reset
           mi_data : in signed((g_N-1) downto 0);
           mo_data : out signed((g_N-1) downto 0));
end component;
signal CICi0_i_clk : STD_LOGIC;
--signal CICi0_i_reset : STD_LOGIC := '1';
signal CICi0_mi_data : signed(c_CICbits-1 downto 0) := (0 => '1', others => '0');
signal CICi0_mo_data : signed (c_CICbits-1 downto 0); 

begin

    CICi0_p: CICi 
    GENERIC MAP(c_CICbits)
    PORT MAP(i_clk => CICi0_i_clk, mi_data => CICi0_mi_data, mo_data => CICi0_mo_data);

    process
    begin
        CICi0_i_clk <= '0';
        wait for 10 ns;
        CICi0_i_clk <= '1';
        wait for 10 ns;
    end process;

end Behavioral;

