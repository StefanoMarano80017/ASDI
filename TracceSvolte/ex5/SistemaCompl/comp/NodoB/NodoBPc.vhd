library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoBPc is
generic(N:integer:=2);
  Port (
    --handshake
    ReqA : out std_logic:='0';
    OKA : in std_logic:='0';
    --handshake
    Start: in std_logic:='0';
    ClockB: in std_logic:='0';
    ResetB: in std_logic:='0';
    ResetPo: out std_logic:='0';
     --Reigistro Rx
    EnRx : out std_logic:='0';
    EnSendRx : out std_logic:='0';
    OutValRx :in std_logic:='0';
    --Reigistro Tx
    EnTx : out std_logic:='0';
    EnSendTx : out std_logic:='0';
    --Contatore Generale per numero di invii
    EnContG: out std_logic:='0';
    StopCountG : in STD_LOGIC :='0';
     --Contatore numero 1 ricevuti
    EnCont1: out std_logic:='0'
    );
end NodoBPc;

architecture Behavioral of NodoBPc is

type stato is (idle,qcarica,qcarica1,q0,q1,q2,q3,q4,q4a,q5,qwait);
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
                if (Start='0' and  StopCountG='1') then 
                    stato_next <=idle;
                elsif (Start='1' and  StopCountG='0') then
                    stato_next <= qcarica;
                end if;
    when qcarica => 
                stato_next <=qcarica1;
    when qcarica1 => 
                 if(OKA='1') then
                    stato_next <=qcarica1;
                 elsif(OKA='0') then
                    stato_next <=q0;
                 end if;
     when q0 => 
              if(OKA='0') then
                    stato_next <=q0;
                 elsif(OKA='1') then
                    stato_next <=q1;
                 end if;
     when q1 => 
                stato_next <=qwait;
      
      
      
      when qwait=> 
                 if(OKA='1') then
                    stato_next <=qwait;
                 elsif(OKA='0') then
                    stato_next <=q2;
                 end if;
                 
      when q2 => 
                stato_next <=q3;
      
      
      
      
      when q3 => 
                 if(OutValRx='1') then
                    stato_next <=q4;
                 elsif(OutValRx='0') then
                    stato_next <=q4a;
                 end if;      
        when q4 => 
                stato_next <=q4a;
          when q4a => 
                stato_next <=q5;
           when q5 => 
                stato_next <=idle;
     
              
    
    
   
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                      ResetPo<='0';
        when qcarica => 
                      EnTx<= '1';
        when qcarica1 => 
                        EnTx<= '0';
        when q0 =>
                         ReqA<='1';
        when q1 =>
                         EnSendTx<='1';
                         EnRx<='1';
        
         when qwait =>
                         EnSendTx<='0';
                         EnRx<='1';
        
        when q2 =>
                           EnRx<='0';
                           EnSendRx<='1';
        when q3 =>
                            EnSendRx<='0';    
        when q4 =>
                            EnCont1<='1';
        when q4a =>
                           EnCont1<='0';
                           EnContG<='1';
         when q5 =>
                          EnContG<='0';
                          ReqA<='0';              
                         
                         
                         
                          
                          
       
                 
       end case;
end process;                     



end Behavioral;
