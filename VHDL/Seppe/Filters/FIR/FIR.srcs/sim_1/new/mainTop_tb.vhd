library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity mainTop_tb is
end mainTop_tb;

architecture Behavioral of mainTop_tb is
    -- Length constrains
    constant filter_coeffs_length: natural := 18;
    constant cycles_per_output: natural := 4;
    constant input_sample_length: natural := 7; -- FIR input
    constant output_sample_length: natural := 15; -- FIR output
    constant input_sample_array_length: natural := 1024; -- Input samples from file
    constant output_sample_array_length: natural := input_sample_array_length + filter_coeffs_length;
    

    component mainTop is
        Port(
            clk:            IN std_logic;
            data_in:        IN std_logic_vector(7 downto 0);
            data_out:       OUT std_logic_vector(15 downto 0);
            data_in_valid:  IN std_logic;
            data_in_ready:  OUT std_logic;
            data_out_valid: OUT std_logic
        );
    end component;
    
    signal clk_s:               std_logic := '0';
    signal data_in_s:           std_logic_vector(7 downto 0) := (others => '0');
    signal data_out_s:          std_logic_vector(15 downto 0) := (others => '0');
    signal data_in_valid_s:     std_logic := '0';
    signal data_in_ready_s:     std_logic := '0';
    signal data_out_valid_s:    std_logic := '0';
    signal ctr_valid_s:         std_logic := '0';
    
    
    constant clkPeriod_c: time := 100ns;
    
    -- File vars
    file read_file : text;
    file write_file: text;
    constant inputbits_per_cycle: natural := 7;
    constant outputbits_per_cycle: natural := 15;
    signal read_EN: std_logic := '0';
    signal write_EN: std_logic := '0';
    signal writing: boolean := false;
    signal reading_done: boolean := false;
    signal receiving: boolean := false;
    
    -- Input array
    subtype input_sample_t is std_logic_vector(7 downto 0); -- 1 sample
    type sample_array_t is array(0 to input_sample_array_length) of input_sample_t; -- all input samples
    signal input_sample_array : sample_array_t := (others => (others => '0'));
    
    -- Output array
    type FIR_output_sample_t is array(0 to output_sample_array_length) of integer;
    signal FIR_output : FIR_output_sample_t := (others => 0);
    
begin
    UUT:mainTop
    port map(
        clk => clk_s,
        data_in => data_in_s,
        data_out => data_out_s,
        data_in_valid => data_in_valid_s,
        data_in_ready => data_in_ready_s,
        data_out_valid => data_out_valid_s
    );
    
    -- Read and Write File
    read_write_file:process(read_EN, write_EN)
        variable read_line: line;
        variable read_line_ctr: integer := 0;
        variable write_line: line;
        variable PDM_bit: std_logic;
        
    begin
        file_open(read_file, "/home/indi/Documents/EDSP/Filters/FIR/FIR.srcs/sim_1/new/input_test_vector_ones.txt", read_mode);
        file_open(write_file, "/home/indi/Documents/EDSP/Filters/FIR/FIR.srcs/sim_1/new/output_test_vector_ones.txt", write_mode);     
        
        --if rising_edge(clk_s) then
            -- Read File
            if read_EN = '1' then
                -- Check if array is already filled
                if read_line_ctr < 1024 then
                    -- Fill the input array
                    while not endfile(read_file) loop
                        -- Read line (= 1 bit per column)
                        readline(read_file, read_line);
                        -- Read value of line (= 1 bit)
                        read(read_line, PDM_bit);  
                        -- Zero extend because FIR filter takes 8bits as input
                        input_sample_array(read_line_ctr) <= "0000000" & PDM_bit;
                        
                        read_line_ctr := read_line_ctr + 1;
                        --read_EN <= '1';
                    end loop;
                    --read_EN <= '0';
                    file_close(read_file);
                end if;
                reading_done <= true;
            end if;
            
            -- Write to File
            if write_EN = '1' then 
                if writing = false then    
                    for i in 0 to output_sample_array_length loop
                        write(write_line, FIR_output(i));
                        -- Write output line to output file
                        writeline(write_file, write_line);
                    end loop;
                    writing <= true;
                    file_close(write_file);
                end if;
            end if;
                
        --end if;    
    end process;
      
    FIR_process:process(clk_s)
    variable clk_ctr: integer := 0;
    variable cycle_ctr: integer := 0;
    variable valid_ctr: integer := 0;
    
    begin
        if rising_edge(clk_s) then
            cycle_ctr := cycle_ctr + 1;
            -- Enable read file signal
            if reading_done = false and read_EN = '0' then
                read_EN <= '1';
            end if;
            
            -- When read file done:
            -- Toggle and feed FIR per clk pulse
            if reading_done = true then
                read_EN <= '0'; -- detoggle signal
                -- Check if we are at then end of the input array
                if clk_ctr < input_sample_array_length then
                    -- Set FIR signal
                    data_in_valid_s <= '1';
                    -- Feed data
                    data_in_s <= input_sample_array(clk_ctr);
                else
                    data_in_valid_s <= '0';
                end if;
            end if;
            
            if data_out_valid_s = '1' then
                valid_ctr := valid_ctr + 1;
                -- startup
                if receiving = false then
                    cycle_ctr := 1;
                    receiving <= true;
                end if;
                FIR_output(valid_ctr) <= to_integer(signed(data_out_s));
                cycle_ctr := 0;  
            elsif receiving = true and cycle_ctr > cycles_per_output then
                write_EN <= '1';
            end if;
            clk_ctr := clk_ctr + 1;
        end if; 
    end process;
        
    clk_process:process
    begin
        clk_s <= '0';
        wait for clkPeriod_c/2;
        clk_s <= '1';
        wait for clkPeriod_c/2;
    end process;

end Behavioral;
