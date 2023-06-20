library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity CICc_tb is
end CICc_tb;

architecture Behavioral of CICc_tb is
component CICc is
    generic (g_N: integer; g_delaystages: integer);
    Port ( i_clk : in STD_LOGIC;
           --i_reset : in STD_LOGIC; -- set low to reset
           mi_data : in signed (g_N-1 downto 0);
           mo_data : out signed (g_N-1 downto 0));
end component;

signal CICc0_i_clk : STD_LOGIC;
--signal CICc0_i_reset : STD_LOGIC := '1';
signal CICc0_mi_data : signed (c_CICbits-1 downto 0) := (0 => '1', others => '0');
signal CICc0_mo_data : signed (c_CICbits-1 downto 0); 

begin

    CICc0_p: CICc 
    GENERIC MAP(c_CICbits, c_CICdelaystages)
    PORT MAP(i_clk => CICc0_i_clk, mi_data => CICc0_mi_data, mo_data => CICc0_mo_data);


    process
    begin
        CICc0_i_clk <= '0';
        wait for 10 ns;
        CICc0_i_clk <= '1';
        wait for 10 ns;
    end process;

end Behavioral;

