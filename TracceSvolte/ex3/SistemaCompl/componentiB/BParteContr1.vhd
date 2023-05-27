library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BParteContr1 is
generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    --handshake
    ReqB : out std_logic:='0';
    OKA : in std_logic:='0';
    --comunicazione altro process
    InTrasmissione : out std_logic:='0';
    StartTrasmissione : in std_logic:='0';
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
    ResetPo : out std_logic:='0';
   
    ---segnali registro scorrimento Tx
    ShiftTx:out std_logic:='0';
    DataIn :out std_logic:='0';
  
    --sengnale contatore SH
    EnContSh :out std_logic:='0';
    FlagStopSh :in std_logic:='0'
  );
end BParteContr1;
architecture Behavioral of BParteContr1 is
    type stato is (idle, q0, q1,q2,q3,q4,q5,qreset);
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
                    if (StartTrasmissione='0' and(FlagStopSh='1'))  then 
                        stato_next <=idle;
                    elsif (StartTrasmissione='1' and(FlagStopSh='0')) then
                        stato_next <= q0;
                    elsif (FlagStopSh='1') then
                        stato_next <= qreset;
                    end if;
                
                when qreset=>
                       stato_next<=idle;
                
                when q0 => 
                    if OKA='1'then
                        stato_next <=q0;
                    elsif OKA='0'   then
                        stato_next <=q1;
                    end if;
                
                when q1 => 
                    if OKA='1'then
                        stato_next <=q2;
                    elsif OKA='0'   then
                        stato_next <=q1;
                    end if;
      
                when q2 => 
                    stato_next <= q3;
               
               when q3 =>
                    
                        stato_next <= q4;
                    
                
                when q4 => 
                    stato_next <= q5;
                
               
                
                when q5 => 
                    if (FlagStopSh='1') then
                        stato_next <= qreset;
                    elsif (FlagStopSh='0') then
                        stato_next <= q0;
                    end if;
            
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                       
                       InTrasmissione<='0';
                       
                       ResetPO<='0';
        when q0 => 
                        InTrasmissione<='1';
                        
                        
        when q1 => 
                        ReqB<='1';
        when q2 =>
                          ShiftTx<='1';
                         
                          DataIn<='0';
                         
        when q3 =>
                          ShiftTx<='0';
                          
                          
                          
                          
         when q4 =>
                           EnContSh<='1';
                          
                          
      
        when q5 =>
                          EnContSh<='0';
                          ReqB<='0';
                          
          when qreset =>   
          ResetPO<='1';               
                            
                          
                                       
                 
       end case;
end process;                     


end Behavioral;
