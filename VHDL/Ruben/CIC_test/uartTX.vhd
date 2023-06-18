library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- warning: LSB is sent first
entity TXbuffer is
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
end entity TXbuffer;

architecture RTL of TXbuffer is

    constant OS_CLK_DIV_VAL   : integer := integer(real(CLK_FREQ)/real(16*BAUD_RATE));
    constant UART_CLK_DIV_VAL : integer := integer(real(CLK_FREQ)/real(OS_CLK_DIV_VAL*BAUD_RATE));
    
    constant c_bufferindexBits : natural := integer(ceil(log2(real(BUFFER_SIZE))));

    type t_BUFF is array(0 to BUFFER_SIZE-1) of std_logic_vector(7 downto 0);
    signal BUFF : t_BUFF;
    signal BUFFindex : unsigned(c_bufferindexBits-1 downto 0) := (others => '0');
    signal TXindex : unsigned(c_bufferindexBits-1 downto 0) := (others => '0');

    signal os_clk_en            : std_logic;
    
    signal dataReady: std_logic := '0';
    
    signal UART_TX_DIN: std_logic_vector(7 downto 0) := (others => '0');
    signal UART_TX_DIN_VLD: std_logic := '0';
    signal UART_TX_DIN_RDY: std_logic;

begin

    os_clk_divider_i : entity work.UART_CLK_DIV
    generic map(
        DIV_MAX_VAL  => OS_CLK_DIV_VAL,
        DIV_MARK_POS => OS_CLK_DIV_VAL-1
    )
    port map (
        CLK      => CLK,
        RST      => RST,
        CLEAR    => RST,
        ENABLE   => '1',
        DIV_MARK => os_clk_en
    );

    uart_tx_i: entity work.UART_TX
    generic map (
        CLK_DIV_VAL => UART_CLK_DIV_VAL,
        PARITY_BIT  => "none"
    )
    port map (
        CLK         => CLK,
        RST         => RST,
        -- UART INTERFACE
        UART_CLK_EN => os_clk_en,
        UART_TXD    => UART_TXD,
        -- USER DATA INPUT INTERFACE
        DIN         => UART_TX_DIN,
        DIN_VLD     => UART_TX_DIN_VLD,
        DIN_RDY     => UART_TX_DIN_RDY
    );
    -- writing to buffer
    BUFFproc:process(DIN_RDY)
        begin
        if rising_edge(DIN_RDY) then
            if (RST = '1') then
                BUFFindex <= (others => '0');
            else
                if (BUFFindex < BUFFER_SIZE) then 
                    BUFF(to_integer(BUFFindex)) <= DIN; 
                    BUFFindex <= BUFFindex + 1;
                end if;
            end if; 
        end if;
    end process BUFFproc;    
    
    -- transmitting from buffer
    TXproc:process(CLK)
        begin
        if falling_edge(CLK) then
            if (RST = '1') then
                TXindex <= (others => '0');
                UART_TX_DIN_VLD <= '0';
                dataReady <= '0';
            else
                if (dataReady = '0') and (TXindex < BUFFindex) then -- need new data at UART_TX input
                    --UART_TX_DIN <= BUFF(to_integer(TXindex));
                    for bit in 0 to 7 loop
                        UART_TX_DIN(bit) <= BUFF(to_integer(TXindex))(7-bit); -- inverting bit order because transmitter transmits LSB firstt
                    end loop;
                    dataReady <= '1';
                end if; 
                if (UART_TX_DIN_VLD = '1') then
                    UART_TX_DIN_VLD <= '0';
                elsif (UART_TX_DIN_RDY = '1') and (dataReady = '1') then
                    UART_TX_DIN_VLD <= '1'; -- start transmission
                    dataReady <= '0'; -- need new data
                    TXindex <= TXindex + 1;
                end if;
            end if; 
        end if;
    end process TXproc;

end architecture;