library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;
use work.types.all; 

entity DaS_tb is
end DaS_tb;

architecture Behavioral of DaS_tb is
    
    component DaS is 
      Port ( 
        clk:            IN std_logic;
        data_in:        IN sampleBuffers_t;
        buffer_full:    IN boolean;
        data_out:       OUT outputBuffer_t;
        DaS_done:       OUT boolean
        );
    end component;
    -- Component Signals
    signal clk:             std_logic := '0';
    signal data_in :        sampleBuffers_t;
    signal buffer_full:     boolean := false;
    signal data_out:        outputBuffer_t;
    signal DaS_done:        boolean := false;
    signal writeEN:         std_logic := '0';
    -- Clock
    constant clkPeriod_c: time := 100ns;
    -- Mic Signals File
    file micSignals_file : text;
    constant read_fileName: string := "/home/indi/Documents/EDSP/DaS/DaS.srcs/sim_1/new/micSignals.txt";
    signal readEN: std_logic := '0';
    signal readDone: boolean := false;
    -- Output File
    file output_file : text;
    constant write_fileName : string := "/home/indi/Documents/EDSP/DaS/DaS.srcs/sim_1/new/output.txt";
    signal writeDone : boolean := false;
    -- Mic Signals Buffer
    type micSignal_t is array(0 to signalLength + maxDelay) of sample_t;
    type micSignals_t is array(0 to mics - 1) of micSignal_t;
    signal mic_signals : micSignals_t := (others => (others => 0));
    -- Write Buffer
    constant writeBufferLength : natural := (signalLength/sampleBufferLength)*outputLength;
    type writeBufferRow_t is array(0 to writeBufferLength) of output_sample_t;
    type writeBuffer_t is array(0 to angleRange - 1) of writeBufferRow_t;
    signal writeBuffer : writeBuffer_t := (others => (others => 0));

begin
    UUT:DaS
    port map(
        clk => clk,
        data_in => data_in,
        buffer_full => buffer_full,
        data_out => data_out,
        DaS_done => DaS_done
    );
    
    clk_process:process
    begin
        clk <= '0';
        wait for clkPeriod_c/2;
        clk <= '1';
        wait for clkPeriod_c/2;
    end process;
    
    -- Read the file with the signals and pass it to 1 buffer (to simulate a stream)
    read_process:process(clk, readEN)
    variable read_line : line;
    variable line_val : integer;
    begin
        file_open(micSignals_file, read_fileName, read_mode);
        if rising_edge(clk) then
            if readEN = '1' then
                micLoop: for i in 0 to mics - 1 loop
                    sampleLoop: for j in 0 to signalLength + maxDelay - 1 loop
                        readline(micSignals_file, read_line);
                        read(read_line, line_val);
                        mic_signals(i)(j) <= line_val;
                    end loop sampleLoop;
                end loop micLoop;
                readDone <= true;
            end if;
        end if;
        file_close(micSignals_file);
    end process;
    
    -- Simulate an input stream by filling the sample buffers(mic_signals -> data_in)
    -- Simulate an output stream by filling the write buffers(data_out -> write_buffer)
    DaS_control:process(clk)
    variable sample_offset : natural := 0;
    variable output_offset : natural := 0;
    variable sampleBufferCtr : natural := 0;
    variable outputBufferCtr : natural := 0;
    variable startUp : boolean := true;
    begin
        if rising_edge(clk) then
            if readDone = false then
                readEN <= '1';
            else
                readEN <= '0';
                buffer_full <= false;
                -- Pass mic signals to DaS buffer
                if DaS_done = true or startUp = true then
                    if sample_offset + sampleBufferLength < signalLength then -- check if at the end or not
                        writeEN <= '0';
                        -- Pass signal data to the input buffer
                        sample_offset := sampleBufferCtr*sampleBufferLength;
                        micLoop: for i in 0 to mics - 1 loop
                            sampleLoop: for j in 0 to sampleBufferLength - 1 loop
                                data_in(i)(j) <= mic_signals(i)(j + sample_offset);
                            end loop sampleLoop;
                        end loop micLoop; 
                        sampleBufferCtr := sampleBufferCtr + 1;
                        buffer_full <= true;
                    elsif sampleBufferCtr = buffer_amount then -- toggle buffer signal one last time
                        buffer_full <= true;
                        sampleBufferCtr := sampleBufferCtr + 1;                       
                    end if;
                    startUp := false;
                end if;
                -- Pass output buffer to write buffer while next buffer is being calculated
                if DaS_done = true and startUp = false then
                    if outputBufferCtr < buffer_amount then
                        output_offset := outputBufferCtr*outputLength;
                        angleLoop: for i in 0 to angleRange - 1 loop
                            outputSampleLoop: for j in 0 to outputLength - 1 loop
                                writeBuffer(i)(j + output_offset) <= data_out(i)(j);    
                            end loop outputSampleLoop;
                        end loop angleLoop;
                        outputBufferCtr := outputBufferCtr + 1;
                    else
                        writeEN <= '1';
                    end if;
                end if;
            end if; 
        end if;
    end process;
    
    -- Write the write buffer to a file
    write_process:process(writeEN)
    variable write_line : line;
    variable line_val : integer;
    begin
        file_open(output_file, write_fileName, write_mode);
        if writeEN = '1' then
            if writeDone = false then
                angleLoop: for angle in 0 to angleRange - 1 loop
                    sampleLoop: for sample in 0 to writeBufferLength loop
                        write(write_line, writeBuffer(angle)(sample));
                        writeline(output_file, write_line);
                    end loop sampleLoop;
                end loop angleLoop;
                writeDone <= true;
            end if;    
        end if;
        file_close(output_file);
    end process;
end Behavioral;
