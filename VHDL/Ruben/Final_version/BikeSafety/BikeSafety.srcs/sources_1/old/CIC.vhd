library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CIC is
    generic (g_N: integer:=16; g_order: integer:=4; g_delaystages: integer:=4); 
    Port ( i_clk_fast : in STD_LOGIC;
           i_clk_slow : in STD_LOGIC; -- to not waste LUTs on regenerating clock signals
           --i_reset : in STD_LOGIC; -- set low to reset
           i_data : in STD_LOGIC;
           mo_data : out signed (g_N-1 downto 0));
end CIC;

architecture Behavioral of CIC is

    component CICi is
    generic (g_N: integer:=16);
    Port ( i_clk : in std_logic;
           --i_reset : in std_logic; -- set low to reset
           mi_data : in signed((g_N-1) downto 0);
           mo_data : out signed((g_N-1) downto 0));
    end component;
    type t_CICi_mo_data is array(0 to g_order-1) of signed(g_N-1 downto 0);
    signal CICi_mo_data : t_CICi_mo_data;

    component CICc is
    generic (g_N: integer:=16; g_delaystages: integer:=4);
    Port ( i_clk : in STD_LOGIC;
           --i_reset : in STD_LOGIC; -- set low to reset
           mi_data : in signed(g_N-1 downto 0);
           mo_data : out signed(g_N-1 downto 0));
    end component;
    signal CICc_mo_data : t_CICi_mo_data;

    signal warpinputsig : signed(g_N-1 downto 0);

begin

    CICi0_p: CICi GENERIC MAP(g_N) PORT MAP(i_clk => i_clk_fast, mi_data => warpinputsig, mo_data => CICi_mo_data(0));
    CICc0_p: CICc GENERIC MAP(g_N, g_delaystages) PORT MAP(i_clk => i_clk_slow, mi_data => CICi_mo_data(g_order-1), mo_data => CICc_mo_data(0));
    MemGenerate: for i in 1 to g_order-1 generate
        CICi_p: CICi GENERIC MAP(g_N) PORT MAP(i_clk => i_clk_fast, mi_data => CICi_mo_data(i-1), mo_data => CICi_mo_data(i));
        CICc_p: CICc GENERIC MAP(g_N, g_delaystages) PORT MAP(i_clk => i_clk_slow, mi_data => CICc_mo_data(i-1), mo_data => CICc_mo_data(i));
    end generate MemGenerate;
    
    warpinputsig <= (0 => '1', others => not(i_data)); -- '1' => 1 and '0' => -1
    
    mo_data <= CICc_mo_data(g_order-1); 

end Behavioral;