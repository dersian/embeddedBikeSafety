library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;

entity main_tb is
end main_tb;

architecture Behavioral of main_tb is

    file filter_input_file : text;
    constant fileName_input: string := "main_input.txt";
    file filter_output_file : text;
    constant fileName_output: string := "main_output.txt";
    signal readEN : std_logic := '1';

component main is
    Port ( 
           i_clk : in std_logic; -- internal FPGA clock
           mi_mics : in STD_LOGIC_VECTOR (c_mics-1 downto 0);
           o_mic_clk: out STD_LOGIC;
            mo_data: OUT unsigned(c_DaS_bits-1 downto 0);
            mo_angle: OUT unsigned(c_DaSangleIndexBits-1 downto 0));
end component;
signal main_i_clk : STD_LOGIC := '0';
signal main_mi_mics : STD_LOGIC_VECTOR (c_mics-1 downto 0) := (others => '0');
signal main_o_mic_clk : STD_LOGIC;
signal main_mo_data : unsigned(c_DaS_bits-1 downto 0);
signal main_mo_angle: unsigned(c_DaSangleIndexBits-1 downto 0);

begin

    main_p: main PORT MAP(i_clk => main_i_clk, mi_mics => main_mi_mics, o_mic_clk => main_o_mic_clk, mo_data => main_mo_data, mo_angle => main_mo_angle);

    FPGAclkproc:process -- generates FPGA clock
        begin
        wait for 1ps * c_FPGAhalfclkperiod;
        main_i_clk <= not(main_i_clk);
    end process FPGAclkproc;

    read_samples:process
    variable line_val : integer;
    variable v_ILINE     : line;
    begin
        if readEN = '1' then
            file_open(filter_input_file, fileName_input, read_mode);
            readline(filter_input_file, v_ILINE);
            readLoop: while v_ILINE'length > 0 loop
                while (main_o_mic_clk = '1') loop
                wait for 1 ns;
                end loop;
                
                read(v_ILINE, line_val);
                main_mi_mics <= std_logic_vector(to_unsigned(line_val, c_mics));
                readline(filter_input_file, v_ILINE);
                --micloop: for mic in 0 to c_mics-1 loop
                --    read(v_ILINE, line_val);
                --    if (line_val = 0) then main_mi_mics(mic) <= '0';
                --    else main_mi_mics(mic) <= '1';
                --    end if;
                --    readline(filter_input_file, v_ILINE);
                --end loop micloop;
                
                while (main_o_mic_clk = '0') loop
                wait for 1 ns;
                end loop;
            end loop;
            wait for 1 ns;
            file_close(filter_input_file);
            wait for 10 ns;
        end if;
        wait for 100 ns;
    end process;
end Behavioral;

