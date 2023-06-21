library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

entity Filter is
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
end Filter;

architecture Behavioral of Filter is

component CIC is
    generic (g_N: integer:=16; g_order: integer:=4; g_delaystages: integer:=4); 
    Port ( i_clk_fast : in STD_LOGIC;
           i_clk_slow : in STD_LOGIC; -- to not waste LUTs on regenerating clock signals
           i_data : in STD_LOGIC;
           mo_data : out signed (g_N-1 downto 0));
end component;
signal CIC0_mo_data : signed(c_CICbits-1 downto 0);

component HB11 is
    Port ( i_clk_BUFF0 : in STD_LOGIC;
           i_clk_MUL1 : in STD_LOGIC; -- period(i_clk_MUL1) = 2*period(i_clk_BUFF0)
           i_clk_ADD2 : in STD_LOGIC; -- period(i_clk_ADD2) = period(i_clk_MUL1)/c_multipliers 
           mi_ADD2mulindex : in unsigned(c_HB11multiplierIndexBits-1 downto 0);
           mi_ADD2in1index : in unsigned(0 downto 0);
           mi_data : in signed(c_HB11bits-1 downto 0); 
           mo_data : out signed(c_HB11bits-1 downto 0) := (others => '0')); 
end component;
signal HB11_mo_data : signed(c_HB11bits-1 downto 0);

component HB19 is
    Port ( i_clk_BUFF0 : in STD_LOGIC;
           i_clk_MUL1 : in STD_LOGIC; -- period(i_clk_MUL1) = 2*period(i_clk_BUFF0)
           i_clk_ADD2 : in STD_LOGIC; -- period(i_clk_ADD2) = period(i_clk_MUL1)/c_multipliers
           mi_ADD2mulindex : in unsigned(c_HB19multiplierIndexBits-1 downto 0);
           mi_ADD2in1index : in unsigned(0 downto 0);
           mi_data : in signed(c_HB19bits-1 downto 0);
           mo_data : out signed(c_HB19bits-1 downto 0) := (others => '0'));
end component;
signal HB19_mo_data : signed(c_HB19bits-1 downto 0);

--component FIR51 is
--    Port ( i_clk : in STD_LOGIC;
--           mi_data : in STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0);
--           mo_data : out STD_LOGIC_VECTOR(c_FIR51bits-1 downto 0) := (others => '0'));
--end component;
--signal FIR51_mo_data : STD_LOGIC_VECTOR (c_FIR51bits-1 downto 0);

begin
    
    CIC_p: CIC GENERIC MAP(c_CICbits, c_CICorder, c_CICdelaystages) PORT MAP(i_clk_fast => i_S_clk, i_clk_slow => i_CIC_clk, i_data => i_data, mo_data => CIC0_mo_data);
    Halfband11_p: HB11 PORT MAP(i_clk_BUFF0 => i_CIC_clk, i_clk_MUL1 => i_HB11_clk, i_clk_ADD2 => i_HB11add2_clk, mi_ADD2mulindex => mi_HB11add2mulindex, mi_ADD2in1index => mi_HB11add2in1index, mi_data => CIC0_mo_data, mo_data => HB11_mo_data);
    Halfband19_p: HB19 PORT MAP(i_clk_BUFF0 => i_HB11_clk, i_clk_MUL1 => i_HB19_clk, i_clk_ADD2 => i_HB19add2_clk, mi_ADD2mulindex => mi_HB19add2mulindex, mi_ADD2in1index => mi_HB19add2in1index, mi_data => HB11_mo_data, mo_data => HB19_mo_data);
    --FIR51_p: FIR51 PORT MAP(i_clk => i_HB19_clk, mi_data => std_logic_vector(HB19_mo_data), mo_data => FIR51_mo_data);

    --mo_data <= signed(FIR51_mo_data);
    mo_data <= HB19_mo_data;

end Behavioral;