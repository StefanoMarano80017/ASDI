
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoBPc1 is
  Port ( 
    ClockB: in std_logic:='0';
    ResetB: in std_logic := '0';
    ResetPO1: out std_logic := '0';
    
    StartB: in std_logic:='0';
    --protocollo hanshake completo
    ReqB: out std_logic:='0';
    OkC: in std_logic := '0';
    
    ---segnali parte operativa
          --segnali Memoria
		  EnRead: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
          --segnali stato comparatore
          StatoCmp: in  STD_LOGIC:='0';
          ---segnali Registro RX_A
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          ---segnali Registro ValCostanteFF
           SendStringaFF: out  STD_LOGIC:='0'
    
    
  );
end NodoBPc1;

architecture Behavioral of NodoBPc1 is
type stato is (idle,calcola,calcola1,q0,q00,q1,q2,q3);
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
            if StartB='1' and FineLett='0'  then
            stato_next <=calcola;
            elsif  StartB='0' and FineLett='1'  then
            stato_next <=idle;
            end if;
    when calcola =>
            stato_next <=calcola1;
   when calcola1 =>
            if StatoCmp='1' then
            stato_next <=q0;
            elsif StatoCmp='1' then
            stato_next <=q00;
            end if;
   when q0 =>
            if OkC='1' then
           stato_next <=q0;
           elsif OkC='0' then
             stato_next <=q1;
             end if;
    when q1 =>
             if OkC='0' then
           stato_next <=q1;
           elsif OkC='1' then
             stato_next <=q2;
             end if;
      when q2 =>
            stato_next <=q3;
      when q3 =>
            if FineLett='1'then
            stato_next <=idle;
            elsif FineLett='0'then
            stato_next <=calcola;
            end if;
    
      when q00 =>
           stato_next <=q3;   
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle =>    
                        ResetPO1<='0';
                        
         when calcola =>    
                        EnRead<='1';
                        
         when calcola1 =>    
                        EnRead<='0';
                        EnRx<='1';
          when q0 =>    
                        EnRx<='0';
           when q00 =>    
                        EnRx<='0';
                        EnAddr<='1';
         when q1 =>
                ReqB<='1';
          when q2 =>
                SendRx<='1';
                EnAddr<='1';
           when q3 =>
                SendRx<='0';
                EnAddr<='0';      
            
end case;             
end process;                     



end Behavioral;
