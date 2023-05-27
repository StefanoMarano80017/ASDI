library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AParteContr1 is
generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    --handshake
    ReqB : in std_logic:='0';
    OKA : out std_logic:='0';
    --comunicazione altro process
    InRicezione : out std_logic:='0';
    StartRicezione : in std_logic:='0';
    ClockA : in std_logic:='0';
    ResetA : in std_logic:='0';
    ResetPo : out std_logic:='0';
    ---segnali registro scorrimento Tx
    ShiftTx:out std_logic:='0';
    --sengnale contatore Sh
    EnContSh :out std_logic:='0';
    FlagStopSh :in std_logic:='0'
    
    
      );
end AParteContr1;
architecture Behavioral of AParteContr1 is
    type stato is (idle,q0,q1,q2,q3,q4,qreset);
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
                    if (StartRicezione='1' and FlagStopSh='0')  then 
                        stato_next <=q0;
                    elsif (StartRicezione='0' and FlagStopSh='1') then
                        stato_next <= idle;
                   
                    end if;
                
                when q0 => 
                    if ReqB='1'then
                        stato_next <=q1;
                    elsif ReqB='0'   then
                        stato_next <=q0;
                    end if;
                
                when q1 => 
                    if ReqB='1'then
                        stato_next <=q2;
                    elsif ReqB='0'   then
                        stato_next <=q1;
                    end if;
      
               when q2 =>
                   
                    
                        stato_next <= q3;
                  
                
                when q3 => 
                    stato_next <= q4;
                
                
               when q4 => 
                    if (FlagStopSh='1') then
                        stato_next <= qreset;
                    elsif (FlagStopSh='0') then
                        stato_next <= q0;
                    end if;
                    
                     when qreset =>
                   
                    
                        stato_next <= idle;
                   
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                       InRicezione<='0';
                       ResetPO<='0';
        when q0 => 
                        InRicezione<='1';
                        
        when q1 => 
                        OKA<='1';
        when q2 =>
                          ShiftTx<='1';
                          --DataIn<='0';
         when q3 =>
                           EnContSh<='1';
                           ShiftTx<='0';
                          
         when q4 =>
                          EnContSh<='0';
                          OKA<='0';
                          
           when qreset =>
                   
                    
                        InRicezione<='0'; 
                        ResetPO<='1';                  
                          
                          
        
                                       
                 
       end case;
end process;                     


end Behavioral;
