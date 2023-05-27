library ieee;
use ieee.std_logic_1164.all;

entity tb_FlipFlopD is
end tb_FlipFlopD;

architecture tb of tb_FlipFlopD is

    component FlipFlopD
        port (clk      : in std_logic;
              rst      : in std_logic;
              d        : in std_logic;
              load     : in std_logic;
              inputSet : in std_logic;
              q        : out std_logic);
    end component;

    signal Clk      : std_logic;
    signal Reset    : std_logic;
    signal Inputx    : std_logic;
    signal EnInputSet  : std_logic;
    signal inputSet : std_logic;
    signal Uscita        : std_logic;
     constant CLK_period: time := 10 ns;

begin

    dut : FlipFlopD
    port map (clk      => Clk,
              rst      => Reset,
              d        => Inputx,
              load     => EnInputSet,
              inputSet => inputSet,
              q        => Uscita);
     -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 5ns;
        Inputx<='1';
        wait for 5ns;
        Inputx<='0';
        wait for 5ns;
        EnInputSet<='1';
        inputSet<='1';
        wait for 5ns;
        EnInputSet<='0';
         wait for 5ns;
        EnInputSet<='1';
        inputSet<='0';
        EnInputSet<='0';
        wait for 5ns;
        Inputx<='1';
        Inputx<='0';
        Inputx<='1';
      
        
        
        
       

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;