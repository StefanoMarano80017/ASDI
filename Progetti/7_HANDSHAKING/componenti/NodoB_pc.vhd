library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodob_Cp is
    Port (    
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        
        ReqA: in std_logic;
        OkA: out std_logic := '0';
        
        --segnali controllo parte operativa
        EnRic: out std_logic;
        ReadRic: out std_logic;
        RdMEM: out std_logic;
        WrMEM: out std_logic;
        IncMEM: out std_logic;
        StopMEM: in std_logic;
        DoADD: out std_logic         
    );
end nodob_Cp;

architecture Behavioral of nodob_Cp is

type stato is (idle,q0,q1,q2,q3);
signal stato_corrente : stato := idle;
signal stato_next: stato;

begin

--Process evoluzione stati
process (ClockB, ResetB)
begin
        if ResetB = '1' then 
            stato_corrente <= idle;
        elsif(ClockB'event and ClockB = '1') then
            stato_corrente <= stato_next;
        end if;

        case stato_corrente is 
        when idle => 
                     if (ReqA = '0' or StopMEM = '1') then 
                        stato_next <= idle;
                     elsif (ReqA = '1' and StopMEM = '0') then 
                        stato_next <= q0;
                     end if;
        when q0 =>   
                    if ReqA = '0' then 
                        stato_next <= q1;
                    elsif ReqA = '1' then 
                        stato_next <= q0;
                    end if;
        when q1 =>
                     stato_next <= q2;     
        when q2 =>
                     stato_next <= q3;
        when q3 =>   
                     stato_next <= idle;     
        end case;
end process;

--OUTPUT 
process(stato_corrente)
begin 
    case stato_corrente is
        when idle =>
                        EnRic   <= '0';
                        ReadRic <= '0';
                        RdMEM   <= '0';
                        WrMEM   <= '0';
                        IncMEM  <= '0';
                        DoADD   <= '0';
                        
                        if StopMEM = '0' then 
                            okA <= '0';
                        elsif StopMEM = '1' then 
                            okA <= '1';
                        end if;                         
        when q0 =>
                        EnRic   <= '1';
                        ReadRic <= '0';
                        okA     <= '1';
        when q1 =>  
                        EnRic   <= '0';
                        ReadRic <= '1';
                        RdMEM   <= '1';
        when q2 =>  
                        ReadRic <= '0';
                        RdMEM   <= '0';
                        DoADD   <= '1';
                        WrMEM   <= '1';
        when q3 =>
                        DoAdd   <= '0';
                        WrMEM   <= '0';
                        IncMEM  <= '1';      
    end case;
end process;

end Behavioral;