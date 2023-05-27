library ieee;
use ieee.std_logic_1164.all;

entity tb_RippleCarryAdd is
end tb_RippleCarryAdd;

architecture tb of tb_RippleCarryAdd is

    component RippleCarryAdd
        port (A     : in std_logic_vector (3 downto 0);
              B     : in std_logic_vector (3 downto 0);
              S     : out std_logic_vector (3 downto 0);
              C_in  : in std_logic;
              C_out : out std_logic);
    end component;

    signal in1     : std_logic_vector (3 downto 0);
    signal in2     : std_logic_vector (3 downto 0);
    signal somma     : std_logic_vector (3 downto 0);
    signal c_in  : std_logic;
    signal carry : std_logic;

begin

    dut : RippleCarryAdd
    port map (A     => in1,
              B     => in2,
              S     => somma,
              C_in  => c_in,
              C_out => carry);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 10ns;
        c_in<='0';
        in1<="1010";
        in2<="0101";
        wait for 10ns;
        c_in<='0';
         wait for 10ns;
        c_in<='0';
        in1<="1111";
        in2<="1111";
        wait for 10ns;
        c_in<='1';
        wait for 10ns;
        c_in<='0';
        in1<="0100";
        in2<="1001";
   
        

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;