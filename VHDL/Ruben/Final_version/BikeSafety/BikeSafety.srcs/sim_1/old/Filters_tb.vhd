library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.common.all;
use ieee.math_real.all;

entity Filter_tb is
end Filter_tb;

architecture Behavioral of Filter_tb is

file filter_input_file : text;
constant fileName_input: string := "sine_400Hz.txt";
file filter_output_file : text;
constant fileName_output: string := "filter_output.txt";
signal readEN : std_logic := '1';

component Filter is
    Port ( i_S_clk : in STD_LOGIC; -- input sensor sample frequency
           i_CIC_clk : in STD_LOGIC; -- clock for CIC output
           i_HB11_clk : in STD_LOGIC; -- clock for Halfband11 output
           i_HB19_clk : in STD_LOGIC; -- clock for Halfband19 output
           i_HB11add2_clk : in STD_LOGIC;
           i_HB19add2_clk : in STD_LOGIC;
           mi_HB11add2mulindex : in unsigned(c_HB11multiplierIndexBits-1 downto 0);
           mi_HB11add2in1index : in unsigned(0 downto 0);
           mi_HB19add2mulindex : in unsigned(c_HB19multiplierIndexBits-1 downto 0);
           mi_HB19add2in1index : in unsigned(0 downto 0);
           i_data : in STD_LOGIC;
           mo_data : out signed(c_FIR51bits-1 downto 0));
end component;
signal HB11_mi_ADD2mulindex : unsigned(c_HB11multiplierIndexBits-1 downto 0) := (others => '0');
signal HB11_mi_ADD2in1index : unsigned(0 downto 0) := (0 => '0');
signal HB19_mi_ADD2mulindex : unsigned(c_HB19multiplierIndexBits-1 downto 0) := (others => '0');
signal HB19_mi_ADD2in1index : unsigned(0 downto 0) := (0 => '0');
signal fil_i_data : STD_LOGIC := '1';
signal Fil_mo_data : signed(c_FIR51bits-1 downto 0);

signal FPGA_clk : STD_LOGIC := '1';
signal PDM_clk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal S_clk: std_logic := '1'; 
signal CIC_clk: std_logic := '1'; 
signal HB11_clk: std_logic := '1'; 
signal HB19_clk: std_logic := '1'; 
signal HB11add2_clk: std_logic := '1'; 
signal HB19add2_clk: std_logic := '1'; 

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal CICclk_counter: unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');

constant HB11clkoffset: integer := 0;
signal HB11add2clk_counter: unsigned(c_HB11fpgaclkcounterbits-1 downto 0) := (others => '0');
signal HB11add2clk_countermax: unsigned(c_HB11fpgaclkcounterbits-1 downto 0) := to_unsigned(c_HB11fpgaclkcountermax-HB11clkoffset, c_HB11fpgaclkcounterbits);
signal HB11add2cyclestarted: std_logic := '0';

constant HB19clkoffset: integer := 0;
signal HB19add2clk_counter: unsigned(c_HB19fpgaclkcounterbits-1 downto 0) := (others => '0');
signal HB19add2cyclestarted: std_logic := '0';
signal HB19add2clk_countermax: unsigned(c_HB19fpgaclkcounterbits-1 downto 0) := to_unsigned(c_HB19fpgaclkcountermax-HB19clkoffset, c_HB19fpgaclkcounterbits);


begin

    Fil_p: Filter PORT MAP(i_S_clk => S_clk, i_CIC_clk => CIC_clk, i_HB11_clk => HB11_clk, i_HB19_clk => HB19_clk, i_HB11add2_clk => HB11add2_clk, i_HB19add2_clk => HB19add2_clk, mi_HB11add2mulindex => HB11_mi_ADD2mulindex, mi_HB11add2in1index => HB11_mi_ADD2in1index, mi_HB19add2mulindex => HB19_mi_ADD2mulindex, mi_HB19add2in1index => HB19_mi_ADD2in1index, i_data => Fil_i_data, mo_data => Fil_mo_data);


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
    
    HB11add2FPGAclkdivproc:process(FPGA_clk) 
        begin
        if rising_edge(FPGA_clk) then
            if (HB11_clk = '0') then 
                HB11add2cyclestarted <= '0';
            end if;
            if (HB11_clk = '1') and (HB11add2cyclestarted = '0') then -- synchronize with HB11_clk, one FPGA cycle too late
                HB11add2clk_counter <= (1 => '1', others => '0');
                HB11add2cyclestarted <= '1';
                HB11add2_clk <= '1';
                HB11_mi_ADD2mulindex <= (others => '0'); -- re-synchronize
                HB11_mi_ADD2in1index(0) <= '1'; -- select adder output as input1 for next clock cycle
                HB11add2clk_countermax <= to_unsigned(c_HB11fpgaclkcountermax-HB11clkoffset, c_HB11fpgaclkcounterbits);
            elsif (HB11add2clk_counter = HB11add2clk_countermax) then
                HB11add2clk_counter <= (others => '0');
                if (HB11add2_clk = '0') then
                    if ((HB11add2clk_countermax = c_HB11fpgaclkcountermax-HB11clkoffset) and (HB11_mi_ADD2mulindex = 0)) then
                        HB11add2clk_countermax <= to_unsigned(c_HB11synccountermax-HB11clkoffset, c_HB11fpgaclkcounterbits);
                    else
                        HB11add2_clk <= '1';
                    end if;
                else
                    HB11add2_clk <= '0';
                    if (HB11_mi_ADD2mulindex = c_HB11multipliers-1) then
                        HB11_mi_ADD2mulindex <= (others => '0');
                        HB11_mi_ADD2in1index(0) <= '0'; -- select zero as input1 for next clock cycle
                    else
                        HB11_mi_ADD2mulindex <= HB11_mi_ADD2mulindex + 1;
                        HB11_mi_ADD2in1index(0) <= '1'; -- select adder output as input1 for next clock cycle
                    end if;
                end if;
            else
                HB11add2clk_counter <= HB11add2clk_counter + 1;
            end if;
        end if;
    end process HB11add2FPGAclkdivproc;  
    
    HB19add2FPGAclkdivproc:process(FPGA_clk) 
        begin
        if rising_edge(FPGA_clk) then
            if (HB19_clk = '0') then 
                HB19add2cyclestarted <= '0';
            end if;
            if (HB19_clk = '1') and (HB19add2cyclestarted = '0') then -- synchronize with HB11_clk, one FPGA cycle too late
                HB19add2clk_counter <= (1 => '1', others => '0');
                HB19add2cyclestarted <= '1';
                HB19add2_clk <= '1';
                HB19_mi_ADD2mulindex <= (others => '0'); -- re-synchronize
                HB19_mi_ADD2in1index(0) <= '1'; -- select adder output as input1 for next clock cycle
                HB19add2clk_countermax <= to_unsigned(c_HB19fpgaclkcountermax-HB19clkoffset, c_HB19fpgaclkcounterbits);
            elsif (HB19add2clk_counter = HB19add2clk_countermax) then
                HB19add2clk_counter <= (others => '0');
                if (HB19add2_clk = '0') then
                    if ((HB19add2clk_countermax = c_HB19fpgaclkcountermax-HB19clkoffset) and (HB19_mi_ADD2mulindex = 0)) then
                        HB19add2clk_countermax <= to_unsigned(c_HB19synccountermax-HB19clkoffset, c_HB19fpgaclkcounterbits);
                    else
                        HB19add2_clk <= '1';
                    end if;
                else
                    HB19add2_clk <= '0';
                    if (HB19_mi_ADD2mulindex = c_HB19multipliers-1) then
                        HB19_mi_ADD2mulindex <= (others => '0');
                        HB19_mi_ADD2in1index(0) <= '0'; -- select zero as input1 for next clock cycle
                    else
                        HB19_mi_ADD2mulindex <= HB19_mi_ADD2mulindex + 1;
                        HB19_mi_ADD2in1index(0) <= '1'; -- select adder output as input1 for next clock cycle
                    end if;
                end if;
            else
                HB19add2clk_counter <= HB19add2clk_counter + 1;
            end if;
        end if;
    end process HB19add2FPGAclkdivproc;  


    read_samples:process
    variable line_val : integer;
    variable v_ILINE     : line;
    begin
        if readEN = '1' then
            file_open(filter_input_file, fileName_input, read_mode);
            readline(filter_input_file, v_ILINE);
            readLoop: while v_ILINE'length > 0 loop
                while (PDM_clk = '1') loop
                wait for 1 ns;
                end loop;
                
                read(v_ILINE, line_val);
                if (line_val = 0) then Fil_i_data <= '0';
                else Fil_i_data <= '1';
                end if;
                readline(filter_input_file, v_ILINE);
                
                while (PDM_clk = '0') loop
                wait for 1 ns;
                end loop;
            end loop;
            wait for 1 ns;
            file_close(filter_input_file);
            wait for 10 ns;
        end if;
        wait for 100 ns;
    end process;
    
    write_samples:process
    variable v_OLINE     : line;
    variable v_int_writeval : integer;
    begin
        if readEN = '1' then
            file_open(filter_output_file, fileName_output, write_mode);
            infLoop: while (1 = 1) loop
                while (HB19_clk = '0') loop
                wait for 10 ns;
                end loop;

                v_int_writeval := to_integer(signed(Fil_mo_data));
                write(v_OLINE, v_int_writeval);
                writeline(filter_output_file, v_OLINE);
                
                while (HB19_clk = '1') loop
                wait for 10 ns;
                end loop;
            end loop;
            file_close(filter_output_file);
            wait for 10 ns;
        end if;
        wait for 100 ns;
    end process;
end Behavioral;