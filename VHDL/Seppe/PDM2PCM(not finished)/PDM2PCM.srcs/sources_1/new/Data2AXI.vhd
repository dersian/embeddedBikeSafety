library ieee;
use ieee.std_logic_1164.all;

entity Data2AXI is
    port (
        clk : in std_logic;
        data_in : in std_logic_vector(8 downto 0);
        valid : out std_logic;
        data_out : out std_logic_vector(8 downto 0);
        ready : in std_logic
    );
end entity Data2AXI;

architecture Behavioral of Data2AXI is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if valid = '0' then
                -- Wait for the consumer to assert ready
                if ready = '1' then
                    -- Assert valid and provide new data
                    valid <= '1';
                    data_out <= data_in;  -- Pass the data to the consumer
                end if;
            else
                -- Wait for the consumer to deassert ready
                if ready = '0' then
                    -- Deassert valid and prepare for new data
                    valid <= '0';
                    data_out <= '0';  -- Optional: Set data_out to default value
                end if;
            end if;
        end if;
    end process;
end architecture Behavioral;


