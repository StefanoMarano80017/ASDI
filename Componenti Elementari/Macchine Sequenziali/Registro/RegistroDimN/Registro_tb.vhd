library ieee;
use ieee.std_logic_1164.all;

entity tb_Registro is
end tb_Registro;

architecture tb of tb_Registro is

    component Registro
        port (ClockR  : in std_logic;
              ResetR  : in std_logic;
              InReg   : in std_logic_vector (7 downto 0);
              EnableR : in std_logic;
              OutR    : out std_logic_vector (7 downto 0));
    end component;

    signal Clock  : std_logic;
    signal Reset  : std_logic;
    signal Ingr   : std_logic_vector (7 downto 0);
    signal Enable : std_logic;
    signal Output    : std_logic_vector (7 downto 0);
    constant CLK_period: time := 10 ns;
begin

    dut : Registro
    port map (ClockR  => Clock,
              ResetR  => Reset,
              InReg   => Ingr,
              EnableR => Enable,
              OutR    => Output);
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
       wait for 5ns;
       Enable<='1';
       wait for 10ns;
       Ingr<="10101010";
       wait for 5ns;
       Enable<='0';
       wait for 15ns;
       Enable<='1';
       wait for 10ns;
       Ingr<="11111110";
       wait for 10ns;
       Enable<='0';
       wait for 10ns;
       Enable<='1';
       Reset<='1';
       wait for 25ns;
       Reset<='0';
       wait for 10ns;
       Enable<='0';
       wait for 25ns;
       Enable<='1';
       wait for 10ns;
       Ingr<="00001010";
       wait for 10ns;
       Enable<='0';
       
       
       
       

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
