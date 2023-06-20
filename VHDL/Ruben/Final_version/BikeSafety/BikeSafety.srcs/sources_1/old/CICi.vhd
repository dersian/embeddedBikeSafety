library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CICi is
    generic (g_N: integer:=16);
    Port ( i_clk : in std_logic;
           --i_reset : in std_logic; -- set low to reset
           mi_data : in signed((g_N-1) downto 0);
           mo_data : out signed((g_N-1) downto 0));
end CICi;

architecture Behavioral of CICi is    
    
    signal ADD_o_result : signed(g_N-1 downto 0) := (others => '0');
    
begin

    addproc:process(i_clk)
    begin
        if rising_edge(i_clk) then
            ADD_o_result <= ADD_o_result + mi_data;
        end if;
    end process addproc;

    mo_data <= ADD_o_result;
end Behavioral;
