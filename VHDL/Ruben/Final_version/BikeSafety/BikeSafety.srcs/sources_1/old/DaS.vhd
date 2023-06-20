library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all; 
use work.delayTable.all; 
use ieee.math_real.all;

entity DaS is
  Port ( 
    i_clk_BUFF0:   IN std_logic; -- input sample frequency
    FPGA_clk:      IN std_logic; -- FPGA freq
    mi_data:        IN t_DaSinput;
    mo_data:       OUT unsigned(c_DaS_bits-1 downto 0) := (others => '0');
    mo_angle:       OUT unsigned(c_DaSangleIndexBits-1 downto 0) := (others => '0'));
end DaS;

architecture Behavioral of DaS is

    constant c_buffershiftbits: natural := 0; -- shifting the input before placing in the input buffer to avoid overflow
    type t_DaSinBuffers is array(0 to c_mics-1) of t_DaSinBuffer; -- all the sample buffers 
    signal BUFF0mem: t_DaSinBuffers := (others => (others => (others => '0'))); -- input buffer
    
    signal DaSadd1_clk : STD_LOGIC := '1';
    signal DaSmul2_clk : STD_LOGIC := '1';
    signal DaScomp7_clk : STD_LOGIC := '1';
    
    -- PIPELINE --
    -- BUFF0: 
    -- ADD1: angleindex(0)
    -- MUL2: angleindex(1)
    -- ADD3: angleindex(2)
    -- SUB4: angleindex(3)
    -- COMP5: angleindex(4)
    -- BUFF6: 
    -- COMP7: 
    constant c_angleindexInstances : natural := 5; -- The delay specified as i_clk_MUL periods so angleindex is given with the pipeline
    type t_angleindex is array(0 to c_angleindexInstances-1) of unsigned(c_SerialAngleBits-1 downto 0); --unsigned(c_SerialAngleBits-1 downto 0);
    signal angleindex: t_angleindex := (others => (others => '0'));
    type t_SerialProcessing is array(0 to c_DaSprocessingParts-1) of t_DaSsample;
    type t_SerialProcessing_u is array(0 to c_DaSprocessingParts-1) of unsigned(c_DaS_bits-1 downto 0);
    
    -- c_mics * c_DaSstoredAngles additions for one adder
    signal ADD1micindex: natural range 0 to c_mics-1 := 0; --unsigned(c_miccounterbits-1 downto 0) := (others => '0');
    type t_2xDaSsample is array(0 to 1) of t_DaSsample; -- to easily switch input data
    type t_ADD1data is array(0 to c_DaSprocessingParts-1) of t_2xDaSsample;
    signal ADD1data: t_ADD1data := (others => (others => (others => '0'))); -- 0 => 0, 1 => output(input1)
    signal ADD1datain2: t_SerialProcessing := (others => (others => '0'));
    signal ADD1in1index: natural range 0 to 1 := 0; -- start with 0 as input

    -- c_DaSstoredAngles multiplications for one multiplier
    constant c_MUL2shiftbits: natural := 0; -- shifting the multiplier output to avoid overflow
    signal MUL2data: t_SerialProcessing_u;
    type t_MUL2data0 is array(0 to c_DaSprocessingParts-1) of signed((c_DaS_bits*2)-1 downto 0);
    signal MUL2data0: t_MUL2data0 := (others => (others => '0'));
    
    type t_ADD3data0 is array(0 to c_SerialAngles-1) of unsigned(c_DaS_bits-1 downto 0);
    type t_ADD3data is array(0 to c_DaSprocessingParts-1) of t_ADD3data0;
    signal ADD3data: t_ADD3data := (others => (others => (others => '0')));
    type t_SUB4buff0 is array(0 to c_DaSsumlength-1) of unsigned(c_DaS_bits-1 downto 0); -- CICc delay buffer
    type t_SUB4buff1 is array(0 to c_SerialAngles-1) of t_SUB4buff0;
    type t_SUB4buff is array(0 to c_DaSprocessingParts-1) of t_SUB4buff1; 
    signal SUB4buff: t_SUB4buff := (others => (others => (others => (others => '0'))));
    signal SUB4data: t_SerialProcessing_u := (others => (others => '0'));
    
    signal COMP5data: t_SerialProcessing_u := (others => (others => '0')); -- largest value for each part
    type t_COMP5angle is array(0 to c_DaSprocessingParts-1) of unsigned(c_DaSangleIndexBits-1 downto 0);
    signal COMP5angle: t_COMP5angle := (others => (others => '0')); -- angle associated with largest value for each part
    signal BUFF6data:  t_SerialProcessing_u := (others => (others => '0')); -- a buffer to not lose the COMP5data (triggered at lower frequency clock)
    signal BUFF6angle:  t_COMP5angle := (others => (others => '0')); -- a buffer to not lose the COMP5 angle (triggered at lower frequency clock)
    signal COMP7data: unsigned(c_DaS_bits-1 downto 0) := (others => '0'); -- largest value
    signal COMP7angle: unsigned(c_DaSangleIndexBits-1 downto 0) := (others => '0'); -- angle of largest value
    signal COMP7partindex: unsigned(c_DaSprocessingPartBits-1 downto 0) := (others => '0'); -- angle of largest value
    
    signal ADD1clkcounter: unsigned(c_DaSadd1fpgaclkcounterbits-1 downto 0) := (others => '0'); -- careful: use largest of c_DaSadd1fpgaclkcounterbits and c_DaSadd1synccounterbits
    --signal ADD1clkcountermax: unsigned(c_DaSadd1counterbits-1 downto 0) := to_unsigned(c_DaSadd1fpgaclkcountermax, c_DaSadd1counterbits);
    signal ADD1cyclestarted: std_logic := '1'; -- clocks start high
    signal ADD1cycleended: std_logic := '0'; -- clocks start high
    --signal MUL2clkcounter: unsigned(c_DaSmul2clkcounterbits-1 downto 0) := (others => '0');
    signal COMP7clkcounter: unsigned(c_DaScomp7fpgaclkcounterbits-1 downto 0) := (others => '0');
    --signal COMP7clkcountermax: unsigned(c_DaScomp7fpgaclkcounterbits-1 downto 0) := to_unsigned(c_DaScomp7fpgaclkcountermax, c_DaScomp7fpgaclkcounterbits);
    
begin

    -- shift contents of input buffer on rising clock
    inbufferShiftproc:process(i_clk_BUFF0) 
        begin
        if rising_edge(i_clk_BUFF0) then
            micloop: for mic in 0 to (c_mics-1) loop
                -- shift input to avoid overflow
                for i in 1 to c_buffershiftbits loop
                    BUFF0mem(mic)(0)(c_DaS_bits-i) <= mi_data(mic)(c_DaS_bits-1); -- BUFF0
                end loop;
                BUFF0mem(mic)(0)(c_DaS_bits-1-c_buffershiftbits downto 0) <= mi_data(mic)(c_DaS_bits-1 downto c_buffershiftbits);
                for j in 1 to (c_DaSinbufferlength-1) loop
                    BUFF0mem(mic)(j) <= BUFF0mem(mic)(j-1);
                end loop;
            end loop micloop;
            partsloop: for part in 0 to c_DaSprocessingParts-1 loop -- to reset comp val
                BUFF6data(part) <= COMP5data(part); -- BUFF6
                BUFF6angle(part) <= COMP5angle(part);
            end loop partsloop;
        end if;
    end process inbufferShiftproc;
    
    DaSclkdivproc:process(FPGA_clk) 
        begin
        if rising_edge(FPGA_clk) then
            if (i_clk_BUFF0 = '0') then
                ADD1cyclestarted <= '0';
            end if;
            if (i_clk_BUFF0 = '1') and (ADD1cyclestarted = '0') then -- synchronize with i_clk_BUFF0, one FPGA cycle too late
                ADD1clkcounter <= (0 => '1', others => '0');
                COMP7clkcounter <= (0 => '1', others => '0');
                ADD1cyclestarted <= '1';
                DaSadd1_clk <= '1';
                DaSmul2_clk <= '1';
                DaScomp7_clk <= '1';
                ADD1micindex <= 0;-- re-synchronize
                angleindex(0) <= (others => '0');
                ADD1in1index <= 1; -- select adder output as input1 for next clock cycle
                ADD1cycleended <= '0';
            else 
                if (COMP7clkcounter = c_DaScomp7fpgaclkcountermax) then
                    COMP7clkcounter <= (others => '0'); 
                    if (DaScomp7_clk = '0') then
                        DaScomp7_clk <= '1';
                        --if (COMP7partindex = 0) then
                        --    DaSadd1_clk <= '1';
                        --    DaSmul2_clk <= '1';
                        --end if;
                        --end if;
                    else
                        DaScomp7_clk <= '0';
                        COMP7partindex <= COMP7partindex + 1; -- automatically overflows
                    end if;
                else
                    COMP7clkcounter <= COMP7clkcounter + 1;
                end if;
                if (ADD1cycleended = '1') then
                    if (COMP7clkcounter = c_DaScomp7fpgaclkcountermax) and (DaScomp7_clk = '0') and (COMP7partindex = 0) then
                        DaSadd1_clk <= '1';
                        DaSmul2_clk <= '1';
                    end if;
                else
                    if (ADD1clkcounter = c_DaSadd1fpgaclkcountermax) then
                        ADD1clkcounter <= (others => '0'); 
                        if (DaSadd1_clk = '0') then
                            DaSadd1_clk <= '1';
                            if (ADD1micindex = 0) then
                                DaSmul2_clk <= '1';
                            elsif (ADD1micindex = c_mics/2) then
                                DaSmul2_clk <= '0';
                            end if;
                        else
                            DaSadd1_clk <= '0';
                            if (ADD1micindex = c_mics-1) then
                                --DaSmul2_clk <= '1';
                                ADD1micindex <= 0;
                                -- here and not in mulproc so that value will already be updated when ADD1micindex is zero
                                pipeloop: for i in c_angleindexInstances-1 downto 1 loop
                                    angleindex(i) <= angleindex(i-1);
                                end loop pipeloop; 
                                if (angleindex(0) = c_SerialAngles-1) then
                                    ADD1cycleended <= '1';
                                    --DaSmul2_clk <= '0';
                                    ADD1in1index <= 0; -- select zero as input1 for next clock cycle
                                end if;
                                angleindex(0) <= angleindex(0) + 1; -- SerialAngles should be a power of two, so never out of range
                            else
                                ADD1micindex <= ADD1micindex + 1;
                            end if;
                        end if;
                    else
                        ADD1clkcounter <= ADD1clkcounter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process DaSclkdivproc;  
    
    ADD1proc:process(DaSadd1_clk) 
        begin
        if rising_edge(DaSadd1_clk) then
            partsloop: for part in 0 to c_DaSprocessingParts-1 loop
                ADD1data(part)(1) <= ADD1data(part)(ADD1in1index) + ADD1datain2(part); -- add one mic val every clock cycle
                ADD1datain2(part) <= BUFF0mem(ADD1micindex)(delayTable((part*c_SerialAngles)+to_integer(angleindex(0)))(ADD1micindex)); -- update input 2
            end loop partsloop;
        end if;
    end process ADD1proc;

    MUL2proc:process(DaSmul2_clk) 
        begin
        if rising_edge(DaSmul2_clk) then
            partsloop: for part in 0 to c_DaSprocessingParts-1 loop
                MUL2data0(part) <= ADD1data(part)(1)*ADD1data(part)(1); -- MUL2
                ADD3data(part)(to_integer(angleindex(2))) <= MUL2data(part) + ADD3data(part)(to_integer(angleindex(2))); -- ADD3
                SUB4data(part) <= ADD3data(part)(to_integer(angleindex(3))) + SUB4buff(part)(to_integer(angleindex(3)))(c_DaSsumlength-1);
                SUB4buff(part)(to_integer(angleindex(3)))(0) <= 0 - ADD3data(part)(to_integer(angleindex(3))); -- SUB4
                buff4loop: for sample in c_DaSsumlength-1 downto 1 loop
                    SUB4buff(part)(to_integer(angleindex(3)))(sample) <= SUB4buff(part)(to_integer(angleindex(3)))(sample);
                end loop buff4loop; 
                if (angleindex(4) = 0) or (SUB4data(part) > COMP5data(part)) then
                    COMP5data(part) <= SUB4data(part);
                    COMP5angle(part)(c_DaSangleIndexBits-1 downto c_SerialAngleBits) <= to_unsigned(part, c_DaSangleIndexBits-c_SerialAngleBits); -- store upper part of associated angle
                    COMP5angle(part)(c_SerialAngleBits-1 downto 0) <= to_unsigned(to_integer(angleindex(4)), c_SerialAngleBits); -- store lower part of associated angle
                end if;
            end loop partsloop;
        end if; 
    end process MUL2proc;
    
partsgenerate: for part in 0 to c_DaSprocessingParts-1 generate
    -- shift multiplier input to avoid overflow
    shiftbitsgenerate: for i in 1 to c_MUL2shiftbits generate
        MUL2data(part)(c_DaS_bits-i) <= MUL2data0(part)((2*c_DaS_bits)-1);
    end generate shiftbitsgenerate;
    MUL2data(part)(c_DaS_bits-1-c_MUL2shiftbits downto 0) <= unsigned(MUL2data0(part)((2*c_DaS_bits)-1 downto c_DaS_bits+c_MUL2shiftbits));
end generate partsgenerate;

    COMP7proc:process(DaScomp7_clk) 
        begin
        if rising_edge(DaScomp7_clk) then
            if (COMP7partindex = 0) or (BUFF6data(to_integer(COMP7partindex)) > COMP7data) then
                COMP7data <= BUFF6data(to_integer(COMP7partindex));
                COMP7angle <= BUFF6angle(to_integer(COMP7partindex));
            end if;
        end if; 
    end process COMP7proc;
    
mo_data <= COMP7data; 
mo_angle <= COMP7angle; 

end Behavioral;
