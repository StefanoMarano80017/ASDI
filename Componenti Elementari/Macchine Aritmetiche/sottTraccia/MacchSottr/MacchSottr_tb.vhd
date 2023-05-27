library ieee;
use ieee.std_logic_1164.all;

entity tb_MacchSottr is
end tb_MacchSottr;

architecture tb of tb_MacchSottr is

    component MacchSottr
        port (A     : in std_logic_vector (3 downto 0);
              B1     : in std_logic_vector (1 downto 0);
              S     : out std_logic_vector (3 downto 0);
              C_in  : in std_logic;
              C_out : out std_logic);
    end component;

    signal A     : std_logic_vector (3 downto 0);
    signal B1     : std_logic_vector (1 downto 0);
    signal S     : std_logic_vector (3 downto 0);
    signal C_in  : std_logic;
    signal C_out : std_logic;

begin

    dut : MacchSottr
    port map (A     => A,
              B1     => B1,
              S     => S,
              C_in  => C_in,
              C_out => C_out);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <= "1010";
        B1 <= "11";
        C_in <= '0';
        
        
        wait for 20ns;
        
        
         A <= "1010";
        B1 <= "11";
        C_in <= '0';
        
        
        wait for 20ns;
        
        
         A <= "10"&"10";
        B1 <= "01";
        C_in <= '0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;