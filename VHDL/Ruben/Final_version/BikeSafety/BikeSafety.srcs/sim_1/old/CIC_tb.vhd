library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;

entity CIC_tb is
end CIC_tb;

architecture Behavioral of CIC_tb is

component CIC is
    generic (g_N: integer:=16; g_order: integer:=4; g_delaystages: integer:=4); 
    Port ( i_clk_fast : in STD_LOGIC;
           i_clk_slow : in STD_LOGIC; -- to not waste LUTs on regenerating clock signals
           --i_reset : in STD_LOGIC; -- set low to reset
           i_data : in STD_LOGIC;
           mo_data : out signed (g_N-1 downto 0));
end component;

signal CIC0_i_clk_fast : STD_LOGIC;
signal CIC0_i_clk_slow : STD_LOGIC := '1';
--signal CIC0_i_reset : STD_LOGIC := '1';
signal CIC0_i_data : STD_LOGIC := '1';
signal CIC0_mo_data : signed(c_CICbits-1 downto 0);

    file filter_input_file : text;
    constant fileName_input: string := "sine_400Hz.txt";
    file filter_output_file : text;
    constant fileName_output: string := "CIC_output.txt";
    signal readEN : std_logic := '1';
    
    signal decCounter : unsigned(c_CICclockdivbits downto 0) := (others => '0');
    signal writeCounter : std_logic := '0';

begin

    CIC_p: CIC 
    GENERIC MAP(c_CICbits, c_CICorder, c_CICdelaystages)
    PORT MAP(i_clk_fast => CIC0_i_clk_fast, i_clk_slow => CIC0_i_clk_slow, i_data => CIC0_i_data, mo_data => CIC0_mo_data);

    read_samples:process
    variable line_val : integer;
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_int_writeval : integer;
    begin
        if readEN = '1' then
            file_open(filter_input_file, fileName_input, read_mode);
            file_open(filter_output_file, fileName_output, write_mode);
            readline(filter_input_file, v_ILINE);
            readLoop: while v_ILINE'length > 0 loop
            --for i in 0 to 360000 - 1 loop
                CIC0_i_clk_fast <= '0'; --- clk
                read(v_ILINE, line_val);
                if (line_val = 0) then CIC0_i_data <= '0';
                else CIC0_i_data <= '1';
                end if;
                wait for 10 ns; --- clk
                CIC0_i_clk_fast <= '1'; --- clk                
                if (decCounter = (c_CICdecimation/2-1)) then
                    CIC0_i_clk_slow <= not(CIC0_i_clk_slow);
                    decCounter <= (others => '0'); 
                    
                    if (writeCounter = '1') then
                        writeCounter <= '0';
                        v_int_writeval := to_integer(signed(CIC0_mo_data));
                        write(v_OLINE, v_int_writeval);
                        writeline(filter_output_file, v_OLINE);
                    else
                        writeCounter <= '1';
                    end if;
                else
                    decCounter <= decCounter + 1;
                end if;
                readline(filter_input_file, v_ILINE);
                wait for 10 ns; 
            end loop;
            file_close(filter_input_file);
            file_close(filter_output_file);
        else
            --CIC0_i_data <= not(CIC0_i_data);
            CIC0_i_clk_fast <= '0';
            wait for 10 ns;
            CIC0_i_clk_fast <= '1';
            wait for 10 ns;
        end if;
    end process;
end Behavioral;

