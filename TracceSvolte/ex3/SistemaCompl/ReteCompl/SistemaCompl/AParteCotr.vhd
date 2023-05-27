library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AParteCotr is
generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
     --handshake per dati paralleli
     ReqA : out std_logic:='0';
     OKB : in std_logic:='0';
     --comunicazione altro process
    InRicezione : in std_logic:='0';
    StartRicezione : out std_logic:='0';
    ClockA : in std_logic:='0';
    ResetA : in std_logic:='0';
    ResetPo : out std_logic:='0';
    Start : in std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:out std_logic:='0';
    EnRx1:out std_logic:='0';
    ---segnali registro S2_Rx
    EnSend2:out std_logic:='0';
    EnRx2:out std_logic:='0';
    ---segnali registro Cod_Rx
    EnSendCod:out std_logic:='0';
    EnRxCod:out std_logic:='0';
    --sengnale contatore indirizzo Demux
    EnSelect :out std_logic:='0';
    ValoreSelDmux : in  STD_LOGIC_VECTOR (1 downto 0);
    --segnali Memoria
    EnRead: out STD_LOGIC;
	EnAddr: out STD_LOGIC;
	FineLett: in  STD_LOGIC
);
end AParteCotr;
architecture Behavioral of AParteCotr is
type stato is (idle,qscelta,q1,q2,q3,q4,q5,q6,q7,q8);
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
            if(Start='0' and FineLett='1') then
                  stato_next <=idle;
            elsif(Start='1' and FineLett='0') then
                  stato_next <=qscelta;
            end if;
    when qscelta=>
                
                    if(InRicezione='0')then
                        if(ValoreSelDmux="00") then
                            stato_next <=q1;
                        elsif(ValoreSelDmux="01") then
                            stato_next <=q2;
                        elsif(ValoreSelDmux="10") then
                            stato_next <=q3;
                        elsif(ValoreSelDmux="11") then
                            stato_next <=q5;
                      end if;
                  end if;
    when q1=> 
              stato_next <=q4;
    when q2=> 
              stato_next <=q4;
    when q3=> 
              stato_next <=q4;
              
              
    when q4=> 
              stato_next <=qscelta;
    when q5=> 
              if(OKB='1') then 
                 stato_next <=q5;
              elsif(OKB='0') then
                  stato_next <=q6;
              end if;
     when q6=> 
              if(OKB='0') then 
                 stato_next <=q6;
              elsif(OKB='1') then
                  stato_next <=q7;         
              end if;                    
     when q7=> 
              stato_next <=q8;
    
     when q8=> 
              if(FineLett='0' and InRicezione='1' ) then 
                 stato_next <=qscelta;
              elsif(FineLett='1' and InRicezione='0') then
                  stato_next <=idle;         
              end if;
    
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                       StartRicezione<='0';
                       ResetPO<='0';
        when qscelta =>
                      EnSelect<='0';
                      StartRicezione<='0';
                      EnAddr<='0';
                      if(InRicezione='0')then
                            EnRead<='1';
                      end if;
        when q1=> 
                       EnRx1<='1';
        when q2=> 
                      EnRx2<='1';
        when q3=> 
                       EnRxCod<='1';
        when q4=> 
                       EnRx1<='0';
                       EnRx2<='0';
                       EnRxCod<='0';
                       EnRead<='0';
                       EnSelect<='1';
                       EnAddr<='1';
                       EnRead<='0';
                    
        when q5=> 
                       EnRead<='0';
                       EnSelect<='0';     
        when q6=> 
                       ReqA<='1';          
        when q7=> 
                       EnSend1<='1';
                       EnSend2<='1';
                       EnSendCod<='1';
                       EnSelect<='1';
    
     when q8=> 
                       EnSend1<='0';
                       EnSend2<='0';
                       EnSendCod<='0';
                       EnSelect<='0';
                       ReqA<='0'; 
                       StartRicezione<='1';
     end case;
end process;                     


end Behavioral;
