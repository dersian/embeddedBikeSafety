-- combines one microphone and a CIC filter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;
use ieee.math_real.all;

entity CIC_test is
    generic (g_N: integer:=16; g_order: integer:=4; g_delaystages: integer:=4); 
    Port ( 
           i_FPGAclk : in std_logic; -- internal FPGA clock
           i_mic : in STD_LOGIC;
           o_mic_clk: out STD_LOGIC; -- mic clk
           o_TX_Serial : out std_logic); -- UART output
end CIC_test;

architecture Behavioral of CIC_test is

constant c_baudrate : natural := 115200; -- UART_TX
--constant c_bytespervalue : natural := 2; -- 8*c_bytespervalue needs to be <= c_CICbits
--constant c_byteindexBits : natural := integer(ceil(log2(real(g_bytespervalue))));
constant c_microsecondstostore : natural := 100000;
constant c_buffersize : natural := (c_microsecondstostore*c_FPGAclkfreq)/(2*(c_PDMclkcountermax+1)*c_CICdecimation*1000000);

component CIC is
    generic (g_N: integer:=16; g_order: integer:=4; g_delaystages: integer:=4); 
    Port ( i_clk_fast : in STD_LOGIC;
           i_clk_slow : in STD_LOGIC; -- to not waste LUTs on regenerating clock signals
           i_data : in STD_LOGIC;
           mo_data : out signed (g_N-1 downto 0));
end component;
signal CIC0_mo_data : signed(c_CICbits-1 downto 0);

component TXbuffer is
    Generic (
        CLK_FREQ      : integer := 50000000;   -- system clock frequency in Hz
        BAUD_RATE     : integer := 115200; -- baud rate value
        BUFFER_SIZE   : integer := 2048 -- how many elements  to transmit
    );
    Port (
        CLK          : in  std_logic; -- system clock
        RST          : in  std_logic; -- high active synchronous reset
        DIN          : in  std_logic_vector(7 downto 0); -- input data to be transmitted over UART
        DIN_RDY      : in  std_logic; -- high when input data is ready
        UART_TXD     : out std_logic -- serial transmit data
    );
end component;
signal RST : std_logic := '1';
signal TXbuffer_DIN : std_logic_vector(7 downto 0);

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal PDMclk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal CICclk_counter: unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');

signal Fil_i_S_clk : STD_LOGIC := '0';
signal Fil_i_CIC_clk : STD_LOGIC := '1';

constant RSTcountermax : natural := 2047; -- reset needs to take long enough or no data transmitted
signal RST_counter : natural range 0 to RSTcountermax := 0;

begin

    CIC_p: CIC 
    GENERIC MAP(g_N, g_order, g_delaystages)
    PORT MAP(i_clk_fast => Fil_i_S_clk, i_clk_slow => Fil_i_CIC_clk, i_data => i_mic, mo_data => CIC0_mo_data);

    TXbuffer_p: TXbuffer 
    GENERIC MAP(c_FPGAclkfreq, c_baudrate, c_buffersize) -- i_clk is CIC output clock
    PORT MAP(Clk => Fil_i_CIC_clk, RST => RST, DIN => TXbuffer_DIN, DIN_RDY => Fil_i_CIC_clk, UART_TXD => o_TX_Serial);

    rst_gen_p : process(i_FPGAclk)
    begin
    if rising_edge(i_FPGAclk) then
        if (RST_counter = RSTcountermax) then
            RST <= '0';
        else
            RST_counter <= RST_counter + 1;
            RST <= '1';
        end if;
    end if;
    end process;

    PDMclkdivproc:process(i_FPGAclk) -- generates PDM clock from FPGA clock
        begin
        if rising_edge(i_FPGAclk) then
            if (PDMclk_counter = c_PDMclkcountermax) then
                PDMclk_counter <= (others => '0'); 
                PDMclk <= not(PDMclk);
            else
                PDMclk_counter <= PDMclk_counter + 1;
            end if;
        end if;
    end process PDMclkdivproc;
    o_mic_clk <= PDMclk; 

    Sclkdelayproc:process(i_FPGAclk)
        begin
        if rising_edge(i_FPGAclk) then
            if (PDMclk = '0') then -- assumes PDM select to be low
                if (Sclkdelay_counter = c_Sclkdelay_countermax) then
                    Fil_i_S_clk <= '1';
                else
                    Sclkdelay_counter <= Sclkdelay_counter + 1;
                end if;
            else
                Fil_i_S_clk <= '0';
                Sclkdelay_counter <= (others => '0');
            end if;
        end if;
    end process Sclkdelayproc;
    
    CICclkdivproc:process(Fil_i_S_clk) -- CIC filter output clock
        begin
        if rising_edge(Fil_i_S_clk) then
            if (CICclk_counter = ((c_CICdecimation/2)-1)) then
                CICclk_counter <= (others => '0'); 
                Fil_i_CIC_clk <= not(Fil_i_CIC_clk);
            else
                CICclk_counter <= CICclk_counter + 1;
            end if;
        end if;
    end process CICclkdivproc;
    
    TXbuffer_DIN <= std_logic_vector(CIC0_mo_data(g_N-1 downto g_N-8));

end Behavioral;

