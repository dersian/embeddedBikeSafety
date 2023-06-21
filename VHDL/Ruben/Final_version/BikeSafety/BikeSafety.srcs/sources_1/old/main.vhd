library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity main is
    Port ( 
           i_clk : in std_logic; -- internal FPGA clock
           mi_mics : in STD_LOGIC_VECTOR (c_mics-1 downto 0);
           o_mic_clk: out STD_LOGIC;
            mo_data: OUT unsigned(c_DaS_bits-1 downto 0);
            mo_angle: OUT unsigned(c_DaSangleIndexBits-1 downto 0));
end main;

architecture Behavioral of main is

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
type t_Fil_mo_data is array(0 to c_mics-1) of signed(c_FIR51bits-1 downto 0); -- 1 sample buffer per mic
signal Fil_mo_data : t_Fil_mo_data;

component DaS is
  Port ( 
    i_clk_BUFF0:   IN std_logic; -- input sample frequency
    FPGA_clk:      IN std_logic; -- FPGA freq
    mi_data:        IN t_DaSinput;
    mo_data:       OUT unsigned(c_DaS_bits-1 downto 0) := (others => '0');
    mo_angle:       OUT unsigned(c_DaSangleIndexBits-1 downto 0) := (others => '0'));
end component;
signal DaS_mi_data : t_DaSinput;

signal FPGA_clk : STD_LOGIC := '1';
signal PDM_clk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal S_clk: std_logic := '1'; 
signal CIC_clk: std_logic := '1'; 
signal HB11_clk: std_logic := '1'; 
signal HB19_clk: std_logic := '1'; 
signal HB11add2_clk: std_logic := '1'; 
signal HB19add2_clk: std_logic := '1'; 
signal DaSadd1_clk : STD_LOGIC := '1';
signal DaSmul2_clk : STD_LOGIC := '1';
signal DaScomp7_clk : STD_LOGIC := '1';

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal CICclk_counter: unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');

signal HB11add2clk_counter: unsigned(c_HB11fpgaclkcounterbits-1 downto 0) := (others => '0');
signal HB11add2clk_countermax: unsigned(c_HB11fpgaclkcounterbits-1 downto 0) := to_unsigned(c_HB11fpgaclkcountermax, c_HB11fpgaclkcounterbits);
signal HB11add2cyclestarted: std_logic := '0';
signal HB19add2clk_counter: unsigned(c_HB19fpgaclkcounterbits-1 downto 0) := (others => '0');
signal HB19add2cyclestarted: std_logic := '0';
signal HB19add2clk_countermax: unsigned(c_HB19fpgaclkcounterbits-1 downto 0) := to_unsigned(c_HB19fpgaclkcountermax, c_HB19fpgaclkcounterbits);


begin

    FiltersGenerate: for i in 0 to c_mics-1 generate
        Fil_p: Filter PORT MAP(i_S_clk => S_clk, i_CIC_clk => CIC_clk, i_HB11_clk => HB11_clk, i_HB19_clk => HB19_clk, i_HB11add2_clk => HB11add2_clk, i_HB19add2_clk => HB19add2_clk, mi_HB11add2mulindex => HB11_mi_ADD2mulindex, mi_HB11add2in1index => HB11_mi_ADD2in1index, mi_HB19add2mulindex => HB19_mi_ADD2mulindex, mi_HB19add2in1index => HB19_mi_ADD2in1index, i_data => mi_mics(i), mo_data => Fil_mo_data(i));
        DaS_mi_data(i) <= Fil_mo_data(i)(c_DaS_bits-1 downto 0);
    end generate FiltersGenerate;
    DaS_p: DaS PORT MAP(i_clk_BUFF0 => HB19_clk, FPGA_clk => FPGA_clk, mi_data => DaS_mi_data, mo_data => mo_data, mo_angle => mo_angle);
    

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
    o_mic_clk <= PDM_clk;

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
                HB11add2clk_countermax <= to_unsigned(c_HB11fpgaclkcountermax, c_HB11fpgaclkcounterbits);
            elsif (HB11add2clk_counter = HB11add2clk_countermax) then
                HB11add2clk_counter <= (others => '0');
                if (HB11add2_clk = '0') then
                    if ((HB11add2clk_countermax = c_HB11fpgaclkcountermax) and (HB11_mi_ADD2mulindex = 0)) then
                        HB11add2clk_countermax <= to_unsigned(c_HB11synccountermax, c_HB11fpgaclkcounterbits);
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
                HB19add2clk_countermax <= to_unsigned(c_HB19fpgaclkcountermax, c_HB19fpgaclkcounterbits);
            elsif (HB19add2clk_counter = HB19add2clk_countermax) then
                HB19add2clk_counter <= (others => '0');
                if (HB19add2_clk = '0') then
                    if ((HB19add2clk_countermax = c_HB19fpgaclkcountermax) and (HB19_mi_ADD2mulindex = 0)) then
                        HB19add2clk_countermax <= to_unsigned(c_HB19synccountermax, c_HB19fpgaclkcounterbits);
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
    
end Behavioral;
