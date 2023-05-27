library ieee;
use ieee.std_logic_1164.all;

entity tb_MemRw is
end tb_MemRw;

architecture tb of tb_MemRw is

    component MemRw
        port (CLK   : in std_logic;
              RST   : in std_logic;
              READ  : in std_logic;
              WRITE : in std_logic;
              ADDR  : in std_logic_vector (2 downto 0);
              DATAIN  : in std_logic_vector (3 downto 0);
              DATAOUT  : out std_logic_vector (3 downto 0)
              
              
              
              );
              
    end component;

    signal Clock   : std_logic;
    signal RST   : std_logic;
    signal READ  : std_logic;
    signal WRITE : std_logic;
    signal ADDR  : std_logic_vector (2 downto 0);
    signal DATAIN  : std_logic_vector (3 downto 0);
    signal DATAOUT  : std_logic_vector (3 downto 0);
constant CLK_period: time := 10 ns;
begin

    dut : MemRw
    port map (CLK   => Clock,
              RST   => RST,
              READ  => READ,
              WRITE => WRITE,
              ADDR  => ADDR,
              DATAOUT   => DATAOUT,
              DATAIN   => DATAIN );
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
        ADDR<="000";
        READ<='1';
        wait for 15ns;
        READ<='0';
         wait for 15ns;
        WRITE<='1';
        DATAIN<="0001";
         wait for 15ns;
        WRITE<='0';
        
        
         wait for 5ns;
        ADDR<="000";
        READ<='1';
        wait for 15ns;
        READ<='0';
          wait for 5ns;
        ADDR<="001";
        READ<='1';
         wait for 5ns;
        ADDR<="000";
        
        

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;