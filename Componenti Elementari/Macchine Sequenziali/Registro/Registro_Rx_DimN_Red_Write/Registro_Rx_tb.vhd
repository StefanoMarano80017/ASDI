library ieee;
use ieee.std_logic_1164.all;

entity tb_Registro_Rx is
end tb_Registro_Rx;

architecture tb of tb_Registro_Rx is

    component Registro_Rx
        port (ClockRx : in std_logic;
              ResetRx : in std_logic;
              InRx    : in std_logic_vector (3 downto 0);
              WriteRx : in std_logic;
              ReadRx  : in std_logic;
              OutRx   : out std_logic_vector (3 downto 0));
    end component;

    signal ClockRx : std_logic;
    signal ResetRx : std_logic;
    signal InRx    : std_logic_vector (3 downto 0);
    signal WriteRx : std_logic;
    signal ReadRx  : std_logic;
    signal OutRx   : std_logic_vector (3 downto 0);
    constant CLK_period: time := 10 ns;

begin

    dut : Registro_Rx
    port map (ClockRx => ClockRx,
              ResetRx => ResetRx,
              InRx    => InRx,
              WriteRx => WriteRx,
              ReadRx  => ReadRx,
              OutRx   => OutRx);
CLK_process :process
   begin
		ClockRx <= '0';
		wait for CLK_period/2;
		ClockRx  <= '1';
		wait for CLK_period/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       WriteRx<='1';
       InRx<="1010";
       wait for 15ns;
       WriteRx<='0';
       wait for 10ns;
       InRx<="1010";
       wait for 5ns;
       ReadRx<='1';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;