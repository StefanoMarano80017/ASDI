library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA_pc is
    port(
        StartA: in std_logic;
        ClockA: in std_logic;
        ResetA: in std_logic;
        
        ReqA:   out std_logic;
        OkB:    in  std_logic;
        
        rx:     out std_logic;
        read:   out std_logic;
        stop:   in std_logic;
        set:    out std_logic
    );
end NodoA_pc;

architecture Behavioral of NodoA_pc is 

type stato is (idle, q0, q1, q2, q3);
signal stato_corrente : stato := idle;
signal stato_next: stato;

----cont pooling
signal      cont: natural := 0;
constant    polling_limit: natural := 100;

begin

--Evoluzione stati 
process(ClockA, ResetA)
begin
    
    if ResetA = '1' then 
        stato_corrente <= idle;
    elsif (ClockA'event and ClockA = '1') then
        stato_corrente <= stato_next;
    end if;

    case stato_corrente is     
    when idle => 
                cont    <=   0;
                if StartA = '1' then 
                    stato_next <= q0;
                elsif StartA = '0' then
                    stato_next <= idle;
                end if;
    when q0 => 
                if stop = '1' or OkB = '1' then 
                    stato_next <= idle;
                elsif stop = '0' and OkB = '0' then
                    stato_next <= q1;
                end if;
                
    when q1 => 
                if OkB = '0' then 
                    
                   if cont < polling_limit then 
                        cont <= cont + 1;
                        stato_next <= q1;
                   elsif cont = polling_limit then 
                        cont <= 0;
                        stato_next <= idle;
                   end if;
                                        
                elsif OkB = '1' then
                    stato_next <= q2;
                end if;
    when q2 =>
                stato_next <= q3;
    when q3 => 
                stato_next <= q0;
                
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        ReqA    <= '0';       
                        read    <= '0';
                        set     <= '0';
                        rx      <= '0';
        when q0    => 
                        ReqA    <= '0';       
                        read    <= '0';
                        set     <= '0';
                        rx      <= '0';     
        when q1    => 
                        ReqA    <= '1';
                        read    <= '1';
        when q2    => 
                        rx      <= '1';
                        read    <= '0';
        when q3    =>   
                        rx      <= '0';
                        ReqA    <= '0';
                        set     <= '1';         
    end case;
end process;

end Behavioral;