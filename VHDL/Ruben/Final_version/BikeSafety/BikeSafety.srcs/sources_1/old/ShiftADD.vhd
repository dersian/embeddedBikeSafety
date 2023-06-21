library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftADD is
    generic (g_N : INTEGER := 16);
    port(--i_clk : in  std_logic;
         i_a : in  std_logic_vector(g_N-1 downto 0);
         i_b : in  std_logic_vector(g_N-1 downto 0);
         o_result : out std_logic_vector(g_N-1 downto 0) := (others => '0'));
end ShiftADD;

architecture Behavioral of ShiftADD is

begin

    ShiftADDproc:process(i_a, i_b)--i_clk)
            variable carry : std_logic;
        begin
        --if rising_edge(i_clk) then
            carry := (i_a(0) AND i_b(0));
            FOR i IN 1 TO g_N-1 LOOP -- this is excecuted sequentially because of variable
                o_result(i-1) <= i_a(i) XOR i_b(i) XOR carry;
                carry := ((i_a(i) AND i_b(i)) OR (i_a(i) AND carry) OR (i_b(i) AND carry));
            END LOOP;
            o_result(g_N-1) <= i_a(g_N-1) XOR i_b(g_N-1) XOR carry;
        --end if;
    END process ShiftADDproc;
    
    -- alternative
    --signal carry: std_logic_vector(g_N downto 1);
    --carry(1) <= (i_a(0) AND i_b(0));
    --GenerateSum: for i in 1 to g_N-1 generate
    --    carry(i+1) <= ((i_a(i) AND i_b(i)) OR (i_a(i) AND carry(i)) OR (i_b(i) AND carry(i)));
    --    o_result(i-1) <= i_a(i) XOR i_b(i) XOR carry(i);
    --end generate GenerateSum;
    --o_result(g_N-1) <= i_a(g_N-1) XOR i_b(g_N-1) XOR carry(g_N);

end Behavioral;
