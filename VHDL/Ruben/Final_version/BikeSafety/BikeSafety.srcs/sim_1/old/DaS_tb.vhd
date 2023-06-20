library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;
use ieee.math_real.all;

entity DaS_tb is
end DaS_tb;

architecture Behavioral of DaS_tb is

    file filter_input_file : text;
    constant fileName_input: string := "DaS_input.txt";
    file filter_output_file : text;
    constant fileName_output: string := "DaS_output.txt";
    signal readEN : std_logic := '1';

component DaS is
  Port ( 
    i_clk_BUFF0:   IN std_logic; -- input sample frequency
    FPGA_clk:      IN std_logic; -- FPGA freq
    mi_data:        IN t_DaSinput;
    mo_data:       OUT unsigned(c_DaS_bits-1 downto 0) := (others => '0');
    mo_angle:       OUT unsigned(c_DaSangleIndexBits-1 downto 0) := (others => '0'));
end component;
signal DaS_mi_data : t_DaSinput := (others => (others => '0')); --(others => ("0010000000000000"));
signal DaS_mo_data : unsigned(c_DaS_bits-1 downto 0);
signal DaS_mo_angle : unsigned(c_DaSangleIndexBits-1 downto 0);

signal FPGA_clk : STD_LOGIC := '1';
signal PDM_clk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal S_clk: std_logic := '1'; 
signal CIC_clk: std_logic := '1'; 
signal HB11_clk: std_logic := '1'; 
signal HB19_clk: std_logic := '1'; 

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal CICclk_counter: unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');

begin

    DaS_p: DaS PORT MAP(i_clk_BUFF0 => HB19_clk, FPGA_clk => FPGA_clk, mi_data => DaS_mi_data, mo_data => DaS_mo_data, mo_angle => DaS_mo_angle);

    FPGAclkproc:process -- generates FPGA clock
        begin
        wait for 1ps * c_FPGAhalfclkperiod;
        FPGA_clk <= not(FPGA_clk);
    end process FPGAclkproc;
   
    PDMclkdivproc:process(FPGA_clk) -- generates PDM clock from FPGA clock
        begin
        if rising_edge(FPGA_clk) then
            if (PDMclk_counter = c_PDMclkcountermax) then
                PDMclk_counter <= (others => '0'); 
                PDM_clk <= not(PDM_clk);
            else
                PDMclk_counter <= PDMclk_counter + 1;
            end if;
        end if;
    end process PDMclkdivproc;

    Sclkdelayproc:process(FPGA_clk) -- A delay for the filter clock to guarantee valid data
        begin
        if rising_edge(FPGA_clk) then
            if (PDM_clk = '0') then -- assumes PDM select to be low
                if (Sclkdelay_counter = c_Sclkdelay_countermax) then
                    S_clk <= '1';
                else
                    Sclkdelay_counter <= Sclkdelay_counter + 1;
                end if;
            else
                S_clk <= '0';
                Sclkdelay_counter <= (others => '0');
            end if;
        end if;
    end process Sclkdelayproc;
    
    CICclkdivproc:process(S_clk) -- CIC filter output clock
        begin
        if rising_edge(S_clk) then
            if (CICclk_counter = ((c_CICdecimation/2)-1)) then
                CICclk_counter <= (others => '0'); 
                CIC_clk <= not(CIC_clk);
            else
                CICclk_counter <= CICclk_counter + 1;
            end if;
        end if;
    end process CICclkdivproc;
    
    HB11clkdivproc:process(CIC_clk) -- Halfband11 filter output clock
        begin
        if rising_edge(CIC_clk) then
            HB11_clk <= not(HB11_clk);
        end if;
    end process HB11clkdivproc;
    
    HB19clkdivproc:process(HB11_clk) -- Halfband11 filter output clock
        begin
        if rising_edge(HB11_clk) then
            HB19_clk <= not(HB19_clk);
        end if;
    end process HB19clkdivproc;

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
                while (HB19_clk = '0') loop
                    wait for 1 ns;
                end loop;

                micloop: for mic in 0 to c_mics-1 loop
                    read(v_ILINE, line_val);
                    DaS_mi_data(mic) <= to_signed(line_val, c_DaS_bits);
                    readline(filter_input_file, v_ILINE);
                end loop micloop;
                v_int_writeval := to_integer(DaS_mo_angle);
                write(v_OLINE, v_int_writeval);
                writeline(filter_output_file, v_OLINE);
                
                while (HB19_clk = '1') loop
                    wait for 1 ns;
                end loop;
                wait for 1 ns;
            end loop;
            file_close(filter_input_file);
            file_close(filter_output_file);
            wait for 10 ns;
        end if;
        wait for 100 ns;
    end process;
end Behavioral;