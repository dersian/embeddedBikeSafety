library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package types is
    use IEEE.STD_LOGIC_1164.ALL;
    constant mics: natural := 9;
    constant angleRange: natural := 360;
    -- Input Buffer
    constant signalLength: natural := 48000;
    constant sampleSize: natural := 16;
    constant sampleBufferLength: natural := 6000; -- Change value 
    constant buffer_amount : natural := signalLength / sampleBufferLength;
    -- Delay Buffer
    constant maxDelay: natural := 17;
    constant delayBufferLength: natural := maxDelay*2+1;
    constant outputLength: natural := (sampleBufferLength + delayBufferLength + 1) / delayBufferLength;
    --subtype sample_t is std_logic_vector(sampleSize-1 downto 0); -- 1 sample 
    subtype sample_t is integer; -- 1 sample 
    -- Sample Buffer type
    type sampleBuffer_t is array(0 to sampleBufferLength) of sample_t;
    type sampleBuffers_t is array(0 to mics-1) of sampleBuffer_t;
    -- Delay Buffer type
    type delayBuffer_t is array(0 to delayBufferLength) of sample_t; -- 1 delaybuffer per mic
    type delayBuffers_t is array(0 to mics-1) of delayBuffer_t; -- all the delay buffers 
    -- Output type
    subtype output_sample_t is integer;
    type outputRow_t is array(0 to outputLength) of output_sample_t;
    type outputBuffer_t is array(0 to angleRange - 1) of outputRow_t;
end package types;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.types.all; 
use std.textio.all;

entity DaS is
  Port ( 
    clk:            IN std_logic;
    data_in:        IN sampleBuffers_t;
    buffer_full:    IN boolean;
    data_out:       OUT outputBuffer_t;
    DaS_done:       OUT boolean
  );
end DaS;

architecture Behavioral of DaS is
    -- Read Delay Table to RAM 
    file delayTable_file : text;
    constant fileName: string := "/home/indi/Documents/EDSP/DaS/DaS.srcs/sim_1/new/delayTable.txt";
    constant delayTable_depth : natural := angleRange;
    constant delayTable_width : natural := mics;
    --subtype delay_t is std_logic_vector(sampleSize-1 downto 0);
    subtype delay_t is integer;
    type delayTableCol_t is array(0 to mics-1) of delay_t;
    type delayTable_t is array (0 to angleRange - 1) of delayTableCol_t;
    signal delayTable: delayTable_t := (others => (others => 0));

    -- Delay Buffer
    --signal delayBuffers : delayBuffers_t;
    
    -- Output
    --signal output : output_t;
     
    -- Logic vars
    signal readEN : std_logic := '0';
    signal readDone: boolean := false;
    
begin
    read_delayTable:process(clk, readEN)
    variable text_line : line;
    variable line_val : integer;
    begin
        file_open(delayTable_file, fileName, read_mode);
        if rising_edge(clk) then
            if readEN = '1' then
                angleLoop: for i in 0 to delayTable_depth - 1 loop
                    micLoop: for j in 0 to mics - 1 loop
                        readline(delayTable_file, text_line);
                        read(text_line, line_val);
                        delayTable(i)(j) <= line_val;
                    end loop micLoop;
                end loop angleLoop;
                readDone <= true;
            end if;
        end if;
    end process;
    
    DaS:process(clk)
    variable sampleBufferOffset : natural := 0;
    variable outputCtr: natural := 0;
    variable delayIndex: natural := 0;
    variable res: natural := 0;
    variable delayBuffers : delayBuffers_t := (others => (others => 0));
    variable output : outputBuffer_t := (others => (others => 0));
    begin
        if rising_edge(clk) then
            if readDone = false then -- start reading signals from file
                readEN <= '1';
            else -- done reading signals from file
                readEN <= '0';
                DaS_done <= false;
                if buffer_full = true then -- only when buffer is full, start DaS
                    angleLoop: for angle in 0 to angleRange - 1 loop
                        sampleBufferOffset := 0; -- offset signal samples
                        outputCtr := 0; -- output index
                        bufferLoop: while sampleBufferOffset + maxDelay < sampleBufferLength loop -- go over every buffer -> depends on sampleBufferLength
                            micLoop: for mic in 0 to mics - 1 loop
                                delayBufferLoop: for i in 0 to delayBufferLength loop -- fill the delaybuffer 
                                    delayBuffers(mic)(i) := data_in(mic)(sampleBufferOffset + i); 
                                end loop delayBufferLoop; 
                                -- Check delay index
                                delayIndex := delayTable(angle)(mic);
                                -- Calculate output
                                output(angle)(outputCtr) := output(angle)(outputCtr) + delayBuffers(mic)(delayIndex-1);
                            end loop micLoop;
                            sampleBufferOffset := sampleBufferOffset + delayBufferLength;
                            outputCtr := outputCtr + 1;
                        end loop bufferLoop;    
                    end loop angleLoop;
                    data_out <= output;
                    DaS_done <= true;
                end if;
            end if;
        end if; 
    end process;
  
end Behavioral;
