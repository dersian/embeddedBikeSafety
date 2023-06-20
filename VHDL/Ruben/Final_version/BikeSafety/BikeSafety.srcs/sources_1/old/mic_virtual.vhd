library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;

entity mic_virtual is
    Port ( 
           i_clk: in STD_LOGIC; -- mic clk
           o_data : out std_logic); -- monitor this pin
end mic_virtual;

architecture Behavioral of mic_virtual is

constant c_driveDelay: natural := 30; -- time between falling edge and data in nanoseconds
constant c_highZDelay: natural := 10; -- time between rising edge and high impedance state in nanoseconds

signal drivedelaycounter: integer := 0;
signal highZdelaycounter: integer := 0;

    file filter_input_file : text;
    constant fileName_input: string := "sine_400Hz.txt";
    signal readEN : std_logic := '1';
    signal alreadyDriven : std_logic := '0';
    signal alreadyHighZ : std_logic := '0';

begin

    read_samples:process
    variable line_val : integer;
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_int_writeval : integer;
    begin
        if readEN = '1' then
            file_open(filter_input_file, fileName_input, read_mode);
            readline(filter_input_file, v_ILINE);
            readLoop: while v_ILINE'length > 0 loop
                if (i_clk = '0') then
                    if (alreadyDriven = '0') then
                        if (drivedelaycounter = c_driveDelay-1) then
                            read(v_ILINE, line_val);
                            if (line_val = 0) then o_data <= '0';
                            else o_data <= '1';
                            end if;
                            alreadyDriven <= '1';
                            drivedelaycounter <= 0;
                            readline(filter_input_file, v_ILINE);
                        else
                            drivedelaycounter <= drivedelaycounter + 1;
                        end if;
                    end if;
                    alreadyHighZ <= '0';
                    highZdelaycounter <= 0;
                else
                    if (alreadyHighZ = '0') then
                        if (highZdelaycounter = c_highZDelay-1) then
                            o_data <= 'Z';
                            alreadyHighZ <= '1';
                            highZdelaycounter <= 0;
                        else
                            highZdelaycounter <= highZdelaycounter + 1;
                        end if;
                    end if;
                    alreadyDriven <= '0'; 
                    drivedelaycounter <= 0;
                end if;               
                wait for 1 ns;           
            end loop;
            file_close(filter_input_file);
        end if;
    end process;
end Behavioral;

