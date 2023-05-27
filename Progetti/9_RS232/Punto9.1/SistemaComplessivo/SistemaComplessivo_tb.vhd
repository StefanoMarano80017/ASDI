
library ieee;
use ieee.std_logic_1164.all;

entity tb_SistemaComplessivo is
end tb_SistemaComplessivo;

architecture tb of tb_SistemaComplessivo is

    component SistemaComplessivo
        port (CLOCK      : in std_logic;
              RESET      : in std_logic;
              SWITCH     : in std_logic_vector (7 downto 0):=( others =>'0');
              LEDS       : out std_logic_vector (7 downto 0):=( others =>'0');
              STARTWRITE : in std_logic);
    end component;

    signal CLOCK      : std_logic;
    signal RESET      : std_logic;
    signal SWITCH     : std_logic_vector (7 downto 0):=( others =>'0');
    signal LEDS       : std_logic_vector (7 downto 0):=( others =>'0');
    signal STARTWRITE : std_logic;
    constant CLK_period: time := 10 ns;
begin

    dut : SistemaComplessivo
    port map (CLOCK      => CLOCK,
              RESET      => RESET,
              SWITCH     => SWITCH,
              LEDS       => LEDS,
              STARTWRITE => STARTWRITE);
              
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
        SWITCH<="10101010";
        wait for 10ns;
        RESET<='1';
        wait for 60ns;
        RESET<='0';
        STARTWRITE <='0';
        wait for 60ns;
        STARTWRITE <='1';
        wait for 60 us;
        STARTWRITE <='0';
        wait for 10ns;
          
          
        SWITCH<="00001010";
        wait for 60ns;
        RESET<='1';
        wait for 60ns;
        RESET<='0';
        STARTWRITE <='0';
        wait for 60ns;
        STARTWRITE <='1';
        wait for 60 us;
        STARTWRITE <='0';
        
        
        
      
     
      
         
         
       
        

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;