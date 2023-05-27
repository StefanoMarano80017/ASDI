library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoC_Pc is
  Port ( 
        ClockC: in std_logic;
        ResetC: in std_logic := '0';
        ResetPO: out std_logic := '0';
        --protocollo hanshake completo
        ReqB: in std_logic:='0';
        OkC: out std_logic := '0';
        ---segnali parte operativa
        --segnali Memoria
		  EnWrite: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
         ---segnali Registro RX
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          ---segnali Registro ValX
          FlagStringa: in STD_LOGIC:='0';
          EnRStr: out  STD_LOGIC:='0');
end NodoC_Pc;

architecture Behavioral of NodoC_Pc is

type stato is (idle, q0, q1, q2,q3,q4,q11);
signal stato_corrente : stato := idle;
signal stato_next: stato;
begin
--Evoluzione stati 
process(ClockC, ResetC, stato_corrente)
begin
    
    if ResetC = '1' then 
        stato_corrente <= idle;
    elsif (ClockC'event and ClockC = '1') then
        stato_corrente <= stato_next;
    end if;

    case stato_corrente is     
    when idle => 
                if ReqB = '1' and FineLett='0' then 
                    stato_next <=q0;
                elsif (ReqB = '0'  and FineLett='1') then
                    stato_next <= idle;
                end if;
    when q0 => 
                if ReqB='1'then
                    stato_next <=q0;
                elsif ReqB='0'   then
                    stato_next <=q1;
               
                
                end if;
     when q1 => 
               
                    
                if  FlagStringa='0'  then
                    stato_next <=q2;
                elsif FlagStringa='1'  then
                    stato_next <=q11;
                
                end if;
     
   
    when q2 => 
                stato_next <=q3;
    when q3 => 
                stato_next <= q4;
    when q4 => 
                stato_next <= idle;
    when q11 => 
                stato_next <= idle;
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        OkC<= '0';       
                        EnAddr<= '0';
                        EnWrite<= '0'; 
                        EnRx<= '0';
                        EnRStr<= '0';
                        SendRx<= '0';
        when q0 => 
                        OkC<= '1';
                        EnRStr<= '1';
                        EnRx<= '1';
        when q1 => 
                       
                        EnRx<= '0';
                        EnRStr<= '0';
        when q2    => 
                       
                        SendRx<= '1';
                       
        when q3 =>      
                        SendRx<= '0';
                        EnWrite<='1';       
        when q4    => 
                       SendRx<= '0';
                       EnWrite<='0';
                       OkC<='0';
                       EnAddr<= '1';
         when q11    => 
                       OkC<= '0';
                        EnRx<= '0';
                        EnRStr<= '0';
        end case;
end process;                     
end Behavioral;

