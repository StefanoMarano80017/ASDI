
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoBPc is
  Port ( ClockB: in std_logic;
    ResetB: in std_logic := '0';
    ResetPO: out std_logic := '0';
    StartUc1: out std_logic:='0';
    --protocollo hanshake completo
    ReqA: in std_logic:='0';
    OkB: out std_logic := '0';
    FineB: out std_logic := '0';
    ---segnali parte operativa
    
          --segnali Memoria
		  EnWrite: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
        
          ---segnali Registro RX
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          ---segnali Registro ValX
          EnX: out  STD_LOGIC:='0';
          StatoFlgX: in  STD_LOGIC:='0');
end NodoBPc;

architecture Behavioral of NodoBPc is

type stato is (idle, q0, q1, q2,q3,q11,q12,qwait);
signal stato_corrente : stato := idle;
signal stato_next: stato;
begin
--Evoluzione stati 
process(ClockB, ResetB, stato_corrente)
begin
    
    if ResetB = '1' then 
        stato_corrente <= idle;
    elsif (ClockB'event and ClockB = '1') then
        stato_corrente <= stato_next;
    end if;

    case stato_corrente is     
    when idle => 
                if ReqA = '1' and FineLett='0' and StatoFlgX='0' then 
                    stato_next <=qwait;
                elsif (ReqA = '0'  and FineLett='1')and(StatoFlgX='1') then
                    stato_next <= idle;
                end if;
    when qwait => 
                if ReqA='1'then
                    stato_next <=qwait;
                elsif ReqA='0'   then
                    stato_next <=q0;
                 
                end if;
        when q0 =>           
               
                 if StatoFlgX='1'  then
                    stato_next <=q11;
                 elsif StatoFlgX='0'  then
                    stato_next <=q1;
                end if;
   
    when q1 => 
              
                    stato_next <=q2;
               
                    
    when q2 => 
                stato_next <= q3;
                 when q3 => 
                stato_next <= idle;
     when q11 => 
                stato_next <= q12;
                
                when q12 => 
                stato_next <= idle;
                
              
    
    
    
   
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        StartUc1<='0';
                        FineB<='0';
                        OkB<= '0';       
                        EnAddr<= '0';
                        EnWrite<= '0'; 
                        EnRx<= '0';
                        EnX<= '0';
                        SendRx<= '0';
                        FineB<='0';
                        ResetPO<='0';
        when qwait => 
                        OkB<= '1';
                        EnRx<= '1';
                        EnX<= '1';
        when q0 => 
                        EnRx<= '0';
                        EnX<= '0';
        when q1    => 
                        SendRx<= '1';
                        OkB<='0';
        when q2    => 
                       SendRx<= '0';
                       EnWrite<= '1';
       when q3    => 
                       EnWrite<= '0';
                       EnAddr<='1';          
       when q11    => 
                       OkB<='0';
                       ResetPO<='1';
       when q12    => 
                       ResetPO<='0';
                       StartUc1<='1';
                       FineB<='1';
                        
                 
       end case;
end process;                     



end Behavioral;

