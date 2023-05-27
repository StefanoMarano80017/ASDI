library ieee;
use ieee.std_logic_1164.all;

entity tb_MacchinaTesting is
end tb_MacchinaTesting;

architecture tb of tb_MacchinaTesting is

    component MacchinaTesting
        port (Clock      : in std_logic;
              Reset      : in std_logic;
              EnableOp   : in std_logic;
              OutputData : out std_logic_vector (2 downto 0));
    end component;

    signal Clock      : std_logic;
    signal Reset      : std_logic;
    signal EnableOp   : std_logic;
    signal OutputData : std_logic_vector (2 downto 0);

    constant CLK_period: time := 10 ns;
begin

    dut : MacchinaTesting
    port map (Clock      => Clock,
              Reset      => Reset,
              EnableOp   => EnableOp,
              OutputData => OutputData);
              
              CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock  <= '1';
		wait for CLK_period/2;
   end process;

    stimuli : process
    begin
        
       --caso1
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       --caso2
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso3
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso4
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 20ns;
       
       --reset
       
       Reset<='1';
       wait for 20ns;
       Reset<='0';
       
       
       
       --caso1
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso2
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso3
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso4
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
       
       
        --caso5
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso6
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso7
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso8
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso9
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso10
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso11
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 20ns;


        --reset
       Reset<='1';
       wait for 20ns;
       Reset<='0';
        
       
       
        --caso1
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso2
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso3
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso4
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
       
       
        --caso5
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso6
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso7
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso8
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso9
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso10
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso11
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;

       --caso12
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso13
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 20ns;
       
       
       
       
        --reset
       Reset<='1';
       wait for 20ns;
       Reset<='0';
        
       
       
       
       
       
         --caso1
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso2
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso3
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso4
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
       
       
        --caso5
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso6
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso7
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
         --caso8
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso9
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso10
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
        --caso11
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;

       --caso12
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso13
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
       
       
        --caso14
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso15
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso16
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
       
         --caso17
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
         --caso18
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 20ns;
       
       --reset
       Reset<='1';
       wait for 20ns;
       Reset<='0';
        
       
       
       
       
       
         --caso1
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
        --caso2
       EnableOp<='1';
       wait for 10ns;
       EnableOp<='0';
       wait for 10ns;
       
       
       
          
      

        wait;
    end process;

end tb;