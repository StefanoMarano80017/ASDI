library ieee;
use ieee.std_logic_1164.all;

entity tb_Mux_2_1 is
end tb_Mux_2_1;

architecture tb of tb_Mux_2_1 is
   

    component Mux_2_1
     generic(
        n:natural:=7
    );
        port (a0 : in std_logic_vector (n downto 0);
              a1 : in std_logic_vector (n downto 0);
              s  : in std_logic;
              y  : out std_logic_vector (n downto 0));
    end component;
    
    signal a0 : std_logic_vector (7 downto 0);
    signal a1 : std_logic_vector (7 downto 0);
    signal s  : std_logic;
    signal y  : std_logic_vector (7 downto 0);

begin

    dut : Mux_2_1
    port map (a0 => a0,
              a1 => a1,
              s  => s,
              y  => y);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a0 <="11010101";
        a1 <="11111111";
        s <= '1';
        wait for 15ns;
         a0 <="00000001";
        a1 <="11111111";
        s <= '0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;