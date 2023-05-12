library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;

entity mainTop is
  Port ( 
    clk:            IN std_logic;
    data_in:        IN std_logic_vector(7 downto 0);
    data_out:       OUT std_logic_vector(15 downto 0);
    data_in_valid:  IN std_logic;
    data_in_ready:  OUT std_logic;
    data_out_valid: OUT std_logic
  );
end mainTop;

architecture Behavioral of mainTop is

    COMPONENT fir_compiler_0
      PORT (
        aclk : IN STD_LOGIC;
        s_axis_data_tvalid : IN STD_LOGIC;
        s_axis_data_tready : OUT STD_LOGIC;
        s_axis_data_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axis_data_tvalid : OUT STD_LOGIC;
        m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
    END COMPONENT; 
     
begin
    fir_filter : fir_compiler_0
    PORT MAP (
        aclk                => clk,
        s_axis_data_tvalid  => data_in_valid,
        s_axis_data_tready  => data_in_ready,
        s_axis_data_tdata   => data_in,
        m_axis_data_tvalid  => data_out_valid,
        m_axis_data_tdata   => data_out
    );

end Behavioral;
