library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;

entity FIR51_tb is
end FIR51_tb;

architecture Behavioral of FIR51_tb is

component FIR51 is
    Port ( i_clk : in STD_LOGIC;
           mi_data : in STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0);
           mo_data : out STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0) := (others => '0'));
end component;

signal FIR51_i_clk : STD_LOGIC := '1';
signal FIR51_mi_data : STD_LOGIC_VECTOR (c_FIR51bits-1 downto 0) := (others => '0');
signal FIR51_mo_data : STD_LOGIC_VECTOR (c_FIR51bits-1 downto 0);

    file filter_input_file : text;
    constant fileName_input: string := "Halfband19_output.txt";
    file filter_output_file : text;
    constant fileName_output: string := "FIR51_output.txt";
    signal readEN : std_logic := '1';
    
    signal writeCounter : std_logic := '0';

begin

    FIR51_p: FIR51 PORT MAP(i_clk => FIR51_i_clk, mi_data => FIR51_mi_data, mo_data => FIR51_mo_data);

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
                FIR51_i_clk <= '0'; --- clk
                read(v_ILINE, line_val);
                FIR51_mi_data <= std_logic_vector(to_signed(line_val, c_FIR51bits));
                wait for 100 ns; --- clk
                FIR51_i_clk <= '1'; --- clk 
                  
                v_int_writeval := to_integer(signed(FIR51_mo_data));
                write(v_OLINE, v_int_writeval);
                writeline(filter_output_file, v_OLINE);
                readline(filter_input_file, v_ILINE);
                wait for 100 ns; 
            end loop;
            file_close(filter_input_file);
            file_close(filter_output_file);
        else
            --CIC0_i_data <= not(CIC0_i_data);
            FIR51_i_clk <= '0';
            wait for 10 ns;
            FIR51_i_clk <= '1';
            FIR51_i_clk <= not(FIR51_i_clk); 
            wait for 10 ns;
        end if;
    end process;
end Behavioral;

