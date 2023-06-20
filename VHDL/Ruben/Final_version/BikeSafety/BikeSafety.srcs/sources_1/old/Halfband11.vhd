library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;
use work.filterCoefs.all;

entity HB11 is
    Port ( i_clk_BUFF0 : in STD_LOGIC;
           i_clk_MUL1 : in STD_LOGIC; -- period(i_clk_MUL1) = 2*period(i_clk_BUFF0)
           i_clk_ADD2 : in STD_LOGIC; -- period(i_clk_ADD2) = period(i_clk_MUL1)/c_multipliers
           mi_ADD2mulindex : in unsigned(c_HB11multiplierIndexBits-1 downto 0);
           mi_ADD2in1index : in unsigned(0 downto 0);
           mi_data : in signed(c_HB11bits-1 downto 0);
           mo_data : out signed(c_HB11bits-1 downto 0) := (others => '0'));
end HB11;

architecture Behavioral of HB11 is

    constant c_taps: natural:= 11;
    constant c_multipliers: natural := 7;
    constant c_MUL1shiftbits: integer := -7; -- increase this if overflow, decrease if low resolution

    type t_BUFF0 is array(0 to c_taps - 1) of signed(c_HB11bits-1 downto 0);
    signal BUFF0: t_BUFF0 := (others => (others => '0')); -- input buffer

    type t_ADD2data is array(0 to 1) of signed(c_HB11bits-1 downto 0); -- to easily switch input data of adder
    signal ADD2data: t_ADD2data := (others => (others => '0')); -- 0 => 0, 1 => output(input1)
    signal ADD2datain2: signed(c_HB11bits-1 downto 0) := (others => '0');

    type t_MUL1data0 is array(0 to c_multipliers-1) of signed((2*c_HB11bits)-1 downto 0);
    type t_MUL1data is array(0 to c_multipliers-1) of signed(c_HB11bits-1 downto 0);
    signal MUL1data0: t_MUL1data0 := (others => (others => '0'));
    signal MUL1data: t_MUL1data := (others => (others => '0')); 
    
begin 
    
    BUFF0proc:process(i_clk_BUFF0)
    begin
        if rising_edge(i_clk_BUFF0) then
            BUFF0(0) <= mi_data;
            for tap in c_taps-1 downto 1 loop 
                BUFF0(tap) <= BUFF0(tap-1); 
            end loop;
        end if;
    end process;
    
    MUL1proc:process(i_clk_MUL1)

    begin
        if rising_edge(i_clk_MUL1) then
            -- multiplications
            MUL1data0(0) <= BUFF0(0) * c_HB11coefs(0);
            MUL1data0(1) <= BUFF0(2) * c_HB11coefs(1);
            MUL1data0(2) <= BUFF0(4) * c_HB11coefs(2);
            MUL1data0(3) <= BUFF0(5) * c_HB11coefs(3);
            MUL1data0(4) <= BUFF0(6) * c_HB11coefs(2);
            MUL1data0(5) <= BUFF0(8) * c_HB11coefs(1);
            MUL1data0(6) <= BUFF0(10) * c_HB11coefs(0);

            mo_data <= ADD2data(1);
        end if;
    end process;


    ifgenerate0: if (c_MUL1shiftbits >= 0) generate
        partsgenerate: for part in 0 to c_multipliers-1 generate
            -- shift multiplier input to avoid overflow
            shiftMUL1bitsgenerate: for i in 1 to c_MUL1shiftbits generate
                MUL1data(part)(c_HB11bits-i) <= MUL1data0(part)((2*c_HB11bits)-1);
            end generate shiftMUL1bitsgenerate;
            MUL1data(part)(c_HB11bits-1-c_MUL1shiftbits downto 0) <= MUL1data0(part)((2*c_HB11bits)-1 downto c_HB11bits+c_MUL1shiftbits);
        end generate partsgenerate;
    end generate ifgenerate0;
    
    ifgenerate1: if (c_MUL1shiftbits < 0) generate
        partsgenerate: for part in 0 to c_multipliers-1 generate
            -- shift multiplier input to avoid overflow
            MUL1data(part)(c_HB11bits-1 downto 0) <= MUL1data0(part)((2*c_HB11bits)-1+c_MUL1shiftbits downto c_HB11bits+c_MUL1shiftbits);
        end generate partsgenerate;
    end generate ifgenerate1;


    ADD2proc:process(i_clk_ADD2) 
        begin
        if rising_edge(i_clk_ADD2) then
            ADD2data(1) <= ADD2data(to_integer(mi_ADD2in1index)) + ADD2datain2; -- add one mul val every clock cycle
            ADD2datain2 <= MUL1data(to_integer(mi_ADD2mulindex)); -- update input 2
        end if;
    end process ADD2proc;

end Behavioral;