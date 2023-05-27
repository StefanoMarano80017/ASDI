library ieee;
use ieee.std_logic_1164.all;

entity tb_MemoriaRW is
end tb_MemoriaRW;

architecture tb of tb_MemoriaRW is

    component MemoriaRW
        port (ClkIn   : in std_logic;
              RstIn   : in std_logic;
              EnRead  : in std_logic;
              EnWrite : in std_logic;
              InData  : in std_logic_vector (3 downto 0);
              OutData : out std_logic_vector (3 downto 0));
    end component;

    signal Clock  : std_logic;
    signal RstIn   : std_logic;
    signal EnRead  : std_logic;
    signal EnWrite : std_logic;
    signal InData  : std_logic_vector (3 downto 0);
    signal OutData : std_logic_vector (3 downto 0);
    constant CLK_period: time := 10 ns;

begin

    dut : MemoriaRW
    port map (ClkIn   => Clock,
              RstIn   => RstIn,
              EnRead  => EnRead,
              EnWrite => EnWrite,
              InData  => InData,
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
        wait for 10ns;
        EnRead<='1';
        InData<="0000";
        wait for 10ns;
        EnRead<='0';
        wait for 10ns;
        EnWrite<='1';
        wait for 10ns;
        EnWrite<='0';
         wait for 10ns;
         
         
         
          wait for 10ns;
        EnRead<='1';
        InData<="0001";
        wait for 10ns;
        EnRead<='0';
        wait for 10ns;
        EnWrite<='1';
        wait for 10ns;
        EnWrite<='0';
         wait for 10ns;
         
         
          wait for 10ns;
        EnRead<='1';
        InData<="0010";
        wait for 10ns;
        EnRead<='0';
        wait for 10ns;
        EnWrite<='1';
        wait for 10ns;
        EnWrite<='0';
         wait for 10ns;
    
        
        
         wait for 10ns;
        EnRead<='1';
        InData<="0011";
        wait for 10ns;
        EnRead<='0';
        wait for 10ns;
        EnWrite<='1';
        wait for 10ns;
        EnWrite<='0';
         wait for 10ns;
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
