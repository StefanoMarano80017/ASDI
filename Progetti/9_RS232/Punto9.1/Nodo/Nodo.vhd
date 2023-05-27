library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nodo is
 generic( N:integer:=7);
  Port ( 
    Input :in std_logic_vector( N downto 0):=( others =>'0');
    Clock,Reset :in std_logic:='0';
    Uscita :out std_logic_vector( N downto 0):=( others =>'0')
  );
end Nodo;

architecture Behavioral of Nodo is

begin
    AcquisizioneIngresso :process(Clock,Reset)
        begin
            if( Reset='1') then
                Uscita <=( others =>'0');
            elsif(Clock' event and Clock='1')then
                Uscita<=Input;
            end if;
      end process;  


end Behavioral;
