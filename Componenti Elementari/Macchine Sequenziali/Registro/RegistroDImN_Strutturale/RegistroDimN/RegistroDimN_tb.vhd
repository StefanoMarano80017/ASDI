library ieee;
use ieee.std_logic_1164.all;

entity tb_ShiftRegister is
end tb_ShiftRegister;

architecture tb of tb_ShiftRegister is

    component ShiftRegister
        port (Clock   : in std_logic;
              Reset   : in std_logic;
              EnData  : in std_logic;
              InData  : in std_logic_vector (7 downto 0);
              OutData : out std_logic_vector (7 downto 0));
    end component;

    signal Clock   : std_logic;
    signal Reset   : std_logic;
    signal AbilitaIngresso  : std_logic;
    signal Ingresso  : std_logic_vector (7 downto 0);
    signal OutData : std_logic_vector (7 downto 0);
    constant CLK_period: time := 10 ns;
begin

    dut : ShiftRegister
    port map (Clock   => Clock,
              Reset   => Reset,
              EnData  => AbilitaIngresso,
              InData  => Ingresso,
              OutData => OutData);
    CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock  <= '1';
		wait for CLK_period/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        AbilitaIngresso<='1';
        Ingresso<="00000011";
        wait for 10ns;
        AbilitaIngresso<='0';
        Ingresso<="01101011";
        wait for 10ns;
        AbilitaIngresso<='1';
        Ingresso<="11111111";
        wait for 10ns;
        AbilitaIngresso<='1';
        wait for 10ns;
        Reset<='1';
        
        
        
        
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;