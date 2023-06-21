library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity tb_BlockDesignMain_wrapper is
end tb_BlockDesignMain_wrapper;

architecture tb of tb_BlockDesignMain_wrapper is

    component BlockDesignMain_wrapper
        port (clk      : in std_logic;
              pcm_data : out std_logic_vector (15 downto 0 );
              pdm_data : in std_logic);
    end component;

    signal clk      : std_logic;
    signal pcm_data : std_logic_vector (15 downto 0 );
    signal pdm_data : std_logic;

    constant clkPeriod_c: time := 100ns;

begin

    dut : BlockDesignMain_wrapper
    port map (clk      => clk,
              pcm_data => pcm_data,
              pdm_data => pdm_data);
    
    clk_process: process
    begin
        clk <= '0';
        wait for clkPeriod_c/2;
        clk <= '1';
        wait for clkPeriod_c/2;
    end process;
   
    -- Read and Write File
    read_write_file:process(read_EN, write_EN)
        variable read_line: line;
        variable read_line_ctr: integer := 0;
        variable write_line: line;
        variable PDM_bit: std_logic;
        
    begin
        file_open(read_file, "/home/indi/Documents/EDSP/MultiStageFilters/PDM2PCM.srcs/sim_1/input_data_mic.txt", read_mode);
        file_open(write_file, "/home/indi/Documents/EDSP/MultiStageFilters/PDM2PCM.srcs/sim_1/output_data_mic.txt", write_mode);     
        
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
    
    MultiStageFilter_process:process(clk)
    begin
        
    end process;

end tb;
