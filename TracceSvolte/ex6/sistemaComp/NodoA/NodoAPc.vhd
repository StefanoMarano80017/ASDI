
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoA_Pc is
  Port ( 
    ClockA: in std_logic;
    ResetA: in std_logic := '0';
    ResetPO: out std_logic := '0';
    
    StartA: in std_logic;
    --protocollo hanshake completo
    ReqA: out std_logic;
    OkB: in std_logic := '0';
    ---segnali parte operativa
          --segnali Memoria
		  EnRead: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC;
		  EndRead: in  STD_LOGIC;
         ---segnali Registro RX_A
          EnTx: out  STD_LOGIC;
          SendTx: out  STD_LOGIC
    
    
  );
end NodoA_Pc;

architecture Behavioral of NodoA_Pc is
type stato is (idle, q0, q1, q2, q3,q4);
signal stato_corrente : stato := idle;
signal stato_next: stato;
begin
--Evoluzione stati 
process(ClockA, ResetA, stato_corrente)
begin
    
    if ResetA = '1' then 
        stato_corrente <= idle;
    elsif (ClockA'event and ClockA = '1') then
        stato_corrente <= stato_next;
    end if;

    case stato_corrente is     
    when idle => 
                if StartA = '1' and EndRead='0'then 
                    stato_next <=q0;
                elsif StartA = '0'  or EndRead='1' then
                    stato_next <= idle;
                end if;
    when q0 => 
                if OkB='1'then
                    stato_next <=q0;
                elsif OkB='0' then
                    stato_next <=q1;
                
                end if;
   
    when q1 => 
                if OkB='0'then
                    stato_next <=q1;
                elsif OkB='1'  then
                    stato_next <=q2;
                
                end if;
                    
    when q2 => 
                stato_next <= q3;
     when q3 => 
                stato_next <= q4;
               
    when q4 =>
                if EndRead = '0' then
                    stato_next <= q0;
                elsif EndRead = '1' then
                    stato_next <= idle;
                 end if;
   
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        ReqA<= '0';       
                        EnAddr<= '0';
                        EnRead<= '0'; 
                        EnTx<= '0';
                        SendTx<= '0';
                        --ResetPO<='1';
        when q0 => 
                        ResetPO<='0';
                        EnAddr<= '0';
                        EnRead<= '0'; 
                       
       
        when q1    => 
                        EnRead<= '1'; 
                        EnTx<= '1';
                        ReqA<= '1'; 
        when q2    => 
                        EnRead<= '0'; 
                        EnTx<= '1';
                        
        
        when q3    => 
                         
                        SendTx<= '0';
                         EnTx<= '0';
                         SendTx<= '1';
                        
        
        
        
        when q4    => 
                        ReqA<= '0'; 
                        SendTx<= '0';
                        EnAddr<= '1';
                        
        
       
            
                        
       end case;
end process;                     



end Behavioral;
