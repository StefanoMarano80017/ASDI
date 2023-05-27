library ieee;
use ieee.std_logic_1164.all;

entity tb_ContaBit is
end tb_ContaBit;

architecture tb of tb_ContaBit is

    component ContaBit
        port (A    : in std_logic_vector (3 downto 0);
              B    : in std_logic_vector (3 downto 0);
              ones : out std_logic_vector (3 downto 0));
    end component;

    signal A    : std_logic_vector (3 downto 0);
    signal B    : std_logic_vector (3 downto 0);
    signal ones : std_logic_vector (3 downto 0);

begin

    dut : ContaBit
    port map (A    => A,
              B    => B,
              ones => ones);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <= (others => '1');
        B <= (others => '0');
        
        
        wait for 20ns;
        
        A <= (others => '1');
        B <= (others => '1');
        
        
        wait for 20ns;
        
        A <= "0111";
        B <= "0100";
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
