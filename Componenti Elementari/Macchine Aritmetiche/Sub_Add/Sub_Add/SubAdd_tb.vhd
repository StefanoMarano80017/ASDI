library ieee;
use ieee.std_logic_1164.all;

entity tb_SubAdd is
end tb_SubAdd;

architecture tb of tb_SubAdd is

    component SubAdd
        port (X    : in std_logic_vector (3 downto 0);
              Y    : in std_logic_vector (3 downto 0);
              cin  : in std_logic;
              Z    : out std_logic_vector (3 downto 0);
              cout : out std_logic);
    end component;

    signal In1    : std_logic_vector (3 downto 0);
    signal In2    : std_logic_vector (3 downto 0);
    signal segno  : std_logic;
    signal somma    : std_logic_vector (3 downto 0);
    signal carry : std_logic;

begin

    dut : SubAdd
    port map (X    => In1,
              Y    => In2,
              cin  => segno,
              Z    => somma,
              cout => carry);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 10ns;
        --sottrazione ponendo segno=1
        In1<="1001";
        In2<="0110";
        segno <='1';
        
        wait for 10ns;
        --addizione ponendo segno=0
        In1<="1001";
        In2<="0110";
        segno <='0';
        

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
