library ieee;
use ieee.std_logic_1164.all;

entity tb_FullAdder is
end tb_FullAdder;

architecture tb of tb_FullAdder is

    component FullAdder
        port (a     : in std_logic;
              b     : in std_logic;
              c_in  : in std_logic;
              s     : out std_logic;
              c_out : out std_logic);
    end component;

    signal a     : std_logic;
    signal b     : std_logic;
    signal c  : std_logic;
    signal somma     : std_logic;
    signal carry : std_logic;

begin

    dut : FullAdder
    port map (a     => a,
              b     => b,
              c_in  => c,
              s     => somma,
              c_out => carry);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       wait for 5ns;
        a<='0';
        b<='0';
        c<='0';
        wait for 5ns;
        a<='0';
        b<='1';
        wait for 5ns;
        a<='1';
        b<='0';
        wait for 5ns;
        a<='1';
        b<='1';
        wait for 15ns;
        a<='0';
        b<='0';
        c<='1';
        wait for 5ns;
        a<='0';
        b<='1';
        wait for 5ns;
        a<='1';
        b<='0';
        wait for 5ns;
        a<='1';
        b<='1';
        wait for 15ns;
        a<='0';
        b<='0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

