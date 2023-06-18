library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CICc is
    generic (g_N: integer:=16; g_delaystages: integer:=4);
    Port ( i_clk : in STD_LOGIC;
           --i_reset : in STD_LOGIC; -- set low to reset
           mi_data : in signed(g_N-1 downto 0);
           mo_data : out signed(g_N-1 downto 0) := (others => '0'));
end CICc;

architecture Behavioral of CICc is

    type t_mem is array(0 to g_delaystages-1) of signed(g_N-1 downto 0);
    signal mem : t_mem := (others => (others => '0'));
    
begin

    subtractproc:process(i_clk)
    begin
        if rising_edge(i_clk) then
            mo_data <= mi_data - mem(g_delaystages-1);
            
            mem(0) <= mi_data;
            for i in 1 to g_delaystages-1 loop
                mem(i) <= mem(i-1);
            end loop;
        end if;
    end process subtractproc;

end Behavioral;
