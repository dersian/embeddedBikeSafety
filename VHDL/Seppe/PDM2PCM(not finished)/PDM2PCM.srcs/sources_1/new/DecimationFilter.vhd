library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DecimationFilter is
    port (
        clk : in std_logic;
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(15 downto 0)
    );
end entity DecimationFilter;

architecture Behavioral of DecimationFilter is
    signal counter : unsigned(1 downto 0) := (others => '0');
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = "10" then
                output <= input;  -- Pass the input to the output
                counter <= (others => '0');  -- Reset the counter
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
end architecture Behavioral;
