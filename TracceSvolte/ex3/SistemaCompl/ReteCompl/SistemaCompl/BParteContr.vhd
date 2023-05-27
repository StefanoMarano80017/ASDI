library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BParteContr is
 Port ( 
    --handshake
    ReqA : in std_logic:='0';
    OKB : out std_logic:='0';
    --comunicazione altro process
    InTrasmissione : in std_logic:='0';
    StartTrasmissione : out std_logic:='0';
    
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
     ResetPo : out std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:out std_logic:='0';
    EnRx1:out std_logic:='0';
    ---segnali registro S2_Rx
    EnSend2:out std_logic:='0';
    EnRx2:out std_logic:='0';
    ---segnali registro Cod_Rx
    EnSendCod:out std_logic:='0';
    EnRxCod:out std_logic:='0';
    OutCod: in std_logic_vector(1 downto 0);
    --sel demux
    selDMux :out std_logic:='0';
    --sel mux
    selMux :out std_logic:='0';
     ---segnali registro scorrimento Tx
    LoadTx:out std_logic:='0'
    
    
  );
end BParteContr;

architecture Behavioral of BParteContr is

type stato is (idle, q0, q1,qscelta,qSomma,qCompara,qfine);
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
                if (ReqA = '1' and InTrasmissione='0') then 
                    stato_next <=q0;
                elsif (ReqA = '0'  and InTrasmissione='1') then
                    stato_next <= idle;
                end if;
    when q0 => 
                if ReqA='1' then
                    stato_next <=q0;
                elsif ReqA='0'  then
                    stato_next <=q1;
                 
                end if;
    when q1 => 
              stato_next <=qscelta;
    when qscelta =>
               if OutCod="00"  and InTrasmissione='0' then
                    stato_next <= qCompara;
               elsif OutCod="11"   and InTrasmissione='0' then
                stato_next <= qSomma;
                end if;
     when qCompara => 
                stato_next <= qfine;
                
                when qSomma => 
                stato_next <= qfine;
    
          
                
      when qfine => 
                stato_next <= idle; 
    
   
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                       StartTrasmissione<='0';
                      -- selDMux<='0';
                      -- selMux<='0';
                       ResetPO<='0';
                       LoadTx<='0';
                        
        when q0 => 
                        if  InTrasmissione='0' then
                        OkB<= '1';
                        EnRx1<= '1';
                        EnRx2<= '1';
                        EnRxCod<= '1';
                        
                        end if;
        when q1 => 
                        EnRx1<= '0';
                        EnRx2<= '0';
                        EnRxCod<= '0';
                        EnSendCod<='1';
                        
                          
                        
        when qscelta =>
                         if(InTrasmissione='0')then
                         
                         EnSend1<='1';
                         EnSend2<='1';
                        -- LoadTx<='1';
                        end if;
                        EnSendCod<='0';
                         
                         
        when qCompara =>
                          selDMux<='1';
                          selMux<='1';
                          LoadTx<='1';
                         
                         
                         
                          
                          
         when qSomma =>
                          
                          selDMux<='0';
                          selMux<='0';
                           LoadTx<='1';
                         
       
                                           
      
        
        when qfine =>
                       
                          EnSend1<='0';
                          EnSend2<='0';
                          LoadTx<='0';
                          OkB<='0';
                           if(InTrasmissione='0')then 
                          StartTrasmissione<='1';
                         end if;
                         -- ResetPO<='1'; 
      
                                       
                 
       end case;
end process;                     


end Behavioral;
