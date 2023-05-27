library ieee;
use ieee.std_logic_1164.all;

entity tb_halfAdd is
end tb_halfAdd;

architecture tb of tb_halfAdd is

    component halfAdd
        port (
              x : in std_logic;
              y : in std_logic;
              s : out std_logic;
              c : out std_logic);
    end component;

    signal ad1 : std_logic;
    signal ad2 : std_logic;
    signal somma : std_logic;
    signal carry : std_logic;

begin

    dut : halfAdd
    port map (x => ad1,
              y => ad2,
              s => somma,
              c => carry);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 5ns;
        ad1<='0';
        ad2<='0';
        wait for 5ns;
        ad1<='0';
        ad2<='1';
        wait for 5ns;
        ad1<='1';
        ad2<='0';
        wait for 5ns;
        ad1<='1';
        ad2<='1';
        wait for 15ns;
        ad1<='0';
        ad2<='0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
