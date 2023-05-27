library ieee;
use ieee.std_logic_1164.all;

entity tb_Nodo is
end tb_Nodo;

architecture tb of tb_Nodo is

    component Nodo
        port (Input  : in std_logic_vector (7 downto 0):=( others =>'0');
              Clock  : in std_logic;
              Reset  : in std_logic;
              Uscita : out std_logic_vector (7 downto 0):=( others =>'0'));
    end component;

    signal Input  : std_logic_vector (7 downto 0):=( others =>'0');
    signal Clock  : std_logic;
    signal Reset  : std_logic;
    signal Uscita : std_logic_vector (7 downto 0):=( others =>'0');
    constant CLK_period: time := 10 ns;
begin

    dut : Nodo
    port map (Input  => Input,
              Clock  => Clock,
              Reset  => Reset,
              Uscita => Uscita);
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
        wait for 10ns;
        Input<="00000001";

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;