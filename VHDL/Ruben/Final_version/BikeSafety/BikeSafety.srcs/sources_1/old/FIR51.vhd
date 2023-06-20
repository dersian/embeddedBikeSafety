library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;
use work.filterCoefs.all;

entity FIR51 is
    Port ( i_clk : in STD_LOGIC;
           mi_data : in STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0);
           mo_data : out STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0) := (others => '0'));
end FIR51;

architecture Behavioral of FIR51 is

    component ShiftADD is
        generic (g_N : integer);
        port( i_a : in  std_logic_VECTOR (g_N-1 downto 0);
             i_b : in  std_logic_VECTOR (g_N-1 downto 0);
             o_result : out std_logic_VECTOR (g_N-1 downto 0));
    end component;

    constant c_bits: natural:= c_FIR51bits;
    constant c_taps: natural:= 51;

    type t_inbuffer is array(0 to c_taps - 1) of signed(c_bits-1 downto 0);
    signal BUFF0: t_inbuffer := (others => (others => '0')); -- input buffer
    type t_data0 is array(0 to 50) of signed((2*c_bits)-1 downto 0); -- 51
    signal data0: t_data0;
    type t_data1 is array(0 to 25) of std_logic_vector((2*c_bits)-1 downto 0); -- 26
    signal data1: t_data1;
    type t_data2 is array(0 to 12) of std_logic_vector((2*c_bits)-1 downto 0); -- 13
    signal data2: t_data2;
    type t_data3 is array(0 to 6) of std_logic_vector((2*c_bits)-1 downto 0); -- 7
    signal data3: t_data3;
    type t_data4 is array(0 to 3) of std_logic_vector((2*c_bits)-1 downto 0); -- 4
    signal data4: t_data4;
    type t_data5 is array(0 to 1) of std_logic_vector((2*c_bits)-1 downto 0); -- 2
    signal data5: t_data5;
    signal data6: std_logic_vector((2*c_bits)-1 downto 0); -- output of last adder
    signal mul1data0: t_data0 := (others => (others => '0'));
    
begin

    mulproc:process(i_clk)
    begin
        if rising_edge(i_clk) then
        
            BUFF0(0) <= signed(mi_data);
            for tap in c_taps-1 downto 1 loop 
                BUFF0(tap) <= BUFF0(tap-1); 
                data0(tap) <= mul1data0(tap);
            end loop;
            data0(0) <= mul1data0(0);
            
            -- multiplications
            MUL1data0(0) <= BUFF0(0) * c_FIR51coefs(0);
            MUL1data0(1) <= BUFF0(1) * c_FIR51coefs(1);
            MUL1data0(2) <= BUFF0(2) * c_FIR51coefs(2);
            MUL1data0(3) <= BUFF0(3) * c_FIR51coefs(3);
            MUL1data0(4) <= BUFF0(4) * c_FIR51coefs(4);
            MUL1data0(5) <= BUFF0(5) * c_FIR51coefs(5);
            MUL1data0(6) <= BUFF0(6) * c_FIR51coefs(6);
            MUL1data0(7) <= BUFF0(7) * c_FIR51coefs(7);
            MUL1data0(8) <= BUFF0(8) * c_FIR51coefs(8);
            MUL1data0(9) <= BUFF0(9) * c_FIR51coefs(9);
            MUL1data0(10) <= BUFF0(10) * c_FIR51coefs(10);
            MUL1data0(11) <= BUFF0(11) * c_FIR51coefs(11);
            MUL1data0(12) <= BUFF0(12) * c_FIR51coefs(12);
            MUL1data0(13) <= BUFF0(13) * c_FIR51coefs(13);
            MUL1data0(14) <= BUFF0(14) * c_FIR51coefs(14);
            MUL1data0(15) <= BUFF0(15) * c_FIR51coefs(15);
            MUL1data0(16) <= BUFF0(16) * c_FIR51coefs(16);
            MUL1data0(17) <= BUFF0(17) * c_FIR51coefs(17);
            MUL1data0(18) <= BUFF0(18) * c_FIR51coefs(18);
            MUL1data0(19) <= BUFF0(19) * c_FIR51coefs(19);
            MUL1data0(20) <= BUFF0(20) * c_FIR51coefs(20);
            MUL1data0(21) <= BUFF0(21) * c_FIR51coefs(21);
            MUL1data0(22) <= BUFF0(22) * c_FIR51coefs(22);
            MUL1data0(23) <= BUFF0(23) * c_FIR51coefs(23);
            MUL1data0(24) <= BUFF0(24) * c_FIR51coefs(24);
            MUL1data0(25) <= BUFF0(25) * c_FIR51coefs(25);
            MUL1data0(26) <= BUFF0(26) * c_FIR51coefs(24);
            MUL1data0(27) <= BUFF0(27) * c_FIR51coefs(23);
            MUL1data0(28) <= BUFF0(28) * c_FIR51coefs(22);
            MUL1data0(29) <= BUFF0(29) * c_FIR51coefs(21);
            MUL1data0(30) <= BUFF0(30) * c_FIR51coefs(20);
            MUL1data0(31) <= BUFF0(31) * c_FIR51coefs(19);
            MUL1data0(32) <= BUFF0(32) * c_FIR51coefs(18);
            MUL1data0(33) <= BUFF0(33) * c_FIR51coefs(17);
            MUL1data0(34) <= BUFF0(34) * c_FIR51coefs(16);
            MUL1data0(35) <= BUFF0(35) * c_FIR51coefs(15);
            MUL1data0(36) <= BUFF0(36) * c_FIR51coefs(14);
            MUL1data0(37) <= BUFF0(37) * c_FIR51coefs(13);
            MUL1data0(38) <= BUFF0(38) * c_FIR51coefs(12);
            MUL1data0(39) <= BUFF0(39) * c_FIR51coefs(11);
            MUL1data0(40) <= BUFF0(40) * c_FIR51coefs(10);
            MUL1data0(41) <= BUFF0(41) * c_FIR51coefs(9);
            MUL1data0(42) <= BUFF0(42) * c_FIR51coefs(8);
            MUL1data0(43) <= BUFF0(43) * c_FIR51coefs(7);
            MUL1data0(44) <= BUFF0(44) * c_FIR51coefs(6);
            MUL1data0(45) <= BUFF0(45) * c_FIR51coefs(5);
            MUL1data0(46) <= BUFF0(46) * c_FIR51coefs(4);
            MUL1data0(47) <= BUFF0(47) * c_FIR51coefs(3);
            MUL1data0(48) <= BUFF0(48) * c_FIR51coefs(2);
            MUL1data0(49) <= BUFF0(49) * c_FIR51coefs(1);
            MUL1data0(50) <= BUFF0(50) * c_FIR51coefs(0);
        end if;
    end process;

    -- additions
    ShiftADD1Generate: for i in 0 to 24 generate
        ShiftADD_p: ShiftADD 
            GENERIC MAP(2*c_bits)
            PORT MAP(i_a => std_logic_vector(data0(2*i)), i_b => std_logic_vector(data0(2*i+1)), o_result => data1(i));
    end generate ShiftADD1Generate;
    data1(25)((2*c_bits)-1) <= data0(50)((2*c_bits)-1); -- extra element shifted because uneven amount
    data1(25)((2*c_bits)-2 downto 0) <= std_logic_vector(data0(50)((2*c_bits)-1 downto 1));

    ShiftADD2Generate: for i in 0 to 12 generate
        ShiftADD_p: ShiftADD 
            GENERIC MAP(2*c_bits)
            PORT MAP(i_a => data1(2*i), i_b => data1(2*i+1), o_result => data2(i));
    end generate ShiftADD2Generate;

    ShiftADD3Generate: for i in 0 to 5 generate
        ShiftADD_p: ShiftADD 
            GENERIC MAP(2*c_bits)
            PORT MAP(i_a => data2(2*i), i_b => data2(2*i+1), o_result => data3(i));
    end generate ShiftADD3Generate;
    data3(6)((2*c_bits)-1) <= data2(12)((2*c_bits)-1); -- extra element shifted because uneven amount
    data3(6)((2*c_bits)-2 downto 0) <= data2(12)((2*c_bits)-1 downto 1);

    ShiftADD4Generate: for i in 0 to 2 generate
        ShiftADD_p: ShiftADD 
            GENERIC MAP(2*c_bits)
            PORT MAP(i_a => data3(2*i), i_b => data3(2*i+1), o_result => data4(i));
    end generate ShiftADD4Generate;
    data4(3)((2*c_bits)-1) <= data3(6)((2*c_bits)-1); -- extra element shifted because uneven amount
    data4(3)((2*c_bits)-2 downto 0) <= data3(6)((2*c_bits)-1 downto 1);

    ShiftADD5Generate: for i in 0 to 1 generate
        ShiftADD_p: ShiftADD 
            GENERIC MAP(2*c_bits)
            PORT MAP(i_a => data4(2*i), i_b => data4(2*i+1), o_result => data5(i));
    end generate ShiftADD5Generate;

    ShiftADD0_p: ShiftADD 
        GENERIC MAP(2*c_bits)
        PORT MAP(i_a => data5(0), i_b => data5(1), o_result => data6);
    mo_data <= std_logic_vector(data6(25 downto 10));
end Behavioral;