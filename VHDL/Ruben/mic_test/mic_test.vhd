library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity mic_test is
    Port ( 
           i_FPGAclk : in std_logic; -- internal FPGA clock
           i_mic : in STD_LOGIC; -- microphone output
           o_mic_clk: out STD_LOGIC; -- mic clk
           o_uartTX : out std_logic); -- read ou this pin
end entity mic_test; 

architecture Behavioral of mic_test is

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

signal uart_DIN : std_logic_vector(7 downto 0);

constant BAUD_RATE     : natural := 115200;
constant CLK_PERIOD    : time := 1 ns * integer(real(1e9)/real(c_FPGAclkfreq));
constant RST_countermax : natural := 2047; -- how many FPGA-clock cycles to wait until setting reset low

signal PDMclk_counter : unsigned(c_PDMclkcounterbits-1 downto 0) := (others => '0');
signal PDMclk: std_logic := '1'; -- assumes PDM microphone setting to be low
signal Sclkdelay_counter : unsigned(c_CICclockdivbits-1 downto 0) := (others => '0');
signal Sclk : STD_LOGIC := '0';

signal RST_counter : natural range 0 to RST_countermax;
signal RST: std_logic := '1';

begin

    p_TXbuffer : entity work.TXbuffer
    generic map (
        CLK_FREQ    => c_FPGAclkfreq,
        BAUD_RATE   => BAUD_RATE
    )
    port map (
        CLK          => i_FPGAclk,
        RST          => RST,
        DIN          => uart_DIN,
        DIN_RDY      => Sclk,
        UART_TXD     => o_uartTX
    );

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
    
    Sclkdelayproc:process(i_FPGAclk) -- A delay for the filter clock to guarantee valid data
        begin
        if rising_edge(i_FPGAclk) then
            if (PDMclk = '0') then -- assumes PDM select to be low
                if (Sclkdelay_counter = c_Sclkdelay_countermax) then
                    Sclk <= '1';
                else
                    Sclkdelay_counter <= Sclkdelay_counter + 1;
                end if;
            else
                Sclk <= '0';
                Sclkdelay_counter <= (others => '0');
            end if;
        end if;
    end process Sclkdelayproc;
    uart_DIN(7 downto 1) <= (others => '0');
    uart_DIN(0) <= i_mic; 
    
    rst_gen_p : process(i_FPGAclk)
    begin
        if rising_edge(i_FPGAclk) then
            if (RST_counter = RST_countermax) then
              RST <= '0';
            else
                RST_counter <= RST_counter + 1;
                RST <= '1';
            end if;
        end if;
    end process;
    
end Behavioral;

