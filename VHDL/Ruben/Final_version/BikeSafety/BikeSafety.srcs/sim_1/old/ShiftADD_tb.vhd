library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity ShiftADD_tb is
end ShiftADD_tb;

architecture Behavioral of ShiftADD_tb is

component ShiftADD is
    generic (g_N : INTEGER);
    port(i_clk : in  std_logic;
         i_a : in  signed(g_N-1 downto 0);
         i_b : in  signed(g_N-1 downto 0);
         o_result : out signed(g_N-1 downto 0));
end component;
signal ADD_i_clk : std_logic := '0';
signal ADD_i_a : signed(c_CICbits-1 downto 0) := to_signed(-16, c_CICbits);
signal ADD_i_b : signed (c_CICbits-1 downto 0) := (others => '0');
signal ADD_o_result : signed (c_CICbits-1 downto 0);

begin

    ADD0_p: ShiftADD 
    GENERIC MAP(c_CICbits)
    PORT MAP(i_clk => ADD_i_clk, i_a => ADD_i_a, i_b => ADD_i_b, o_result => ADD_o_result);

    process
    begin
        ADD_i_b <= signed(ADD_i_b) + 1;
        wait for 10 ns;
    end process;

end Behavioral;
