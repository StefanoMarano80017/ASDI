



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NodoBPc is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        ResetPo:out std_logic:='0';
        OutS2:in std_logic_vector( 3 downto 0):="0000";
        OutS1:in std_logic_vector( 3 downto 0):="0000";
       --handshake
        ReqA: in std_logic;
        OkA: out std_logic := '0';
       
        --Segnali Mem
        EnWrite: out  STD_LOGIC:='0';
		EndRead: in STD_LOGIC := '0';
		EnAdrr: out STD_LOGIC:='0';
		--Segnali Rx
		WriteRx: out std_logic:='0';
		ReadRx: out std_logic:='0';
		--Segnali Rx1
		WriteS1: out std_logic:='0';
		ReadS1: out std_logic:='0';
		--Segnali Rx2
		WriteS2: out std_logic:='0';
		ReadS2: out std_logic:='0';
		---selettore Mux
		SelMux: out std_logic:='0';
		---selettore Demux
		selDmux :out std_logic:='0'
		
		
		 
        
   );
end NodoBPc;

architecture Behavioral of NodoBPc is
type stato is (idle,q0,q1,q2,q3,q4,q5,q5a,q6,q7,q8,q2wait);
signal stato_corrente : stato := idle;
signal stato_next: stato;

begin

--Process evoluzione stati
process (ClockB, ResetB,OutS2,OutS1)
begin
        if ResetB = '1' then 
            stato_corrente <= idle;
        elsif(ClockB'event and ClockB = '1') then
            stato_corrente <= stato_next;
        end if;

        case stato_corrente is 
        when idle => 
                     if (ReqA = '0' or EndRead = '1') then 
                        stato_next <= idle;
                     elsif (ReqA = '1' and EndRead = '0') then 
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
                     stato_next <= q2wait;
         when q2wait =>
                     stato_next <= q3;
        
        when q3 =>
                     stato_next <= q4;
        when q4 =>   
                     if(OutS2<=OutS1 ) then
                        stato_next <= q5a;
                     elsif(OutS2 >OutS1) then
                         stato_next <= q5;
                     end if;     
         when q5 =>
                     stato_next <= q6;
         when q6 =>
                     stato_next <= q7;
         when q7 =>
                     stato_next <= q8;
         when q5a =>
                     stato_next <= q2wait;
         
         
         when q8 =>
                     stato_next <= idle;
        end case;
end process;

--OUTPUT 
process(stato_corrente)
begin 
    case stato_corrente is
        when idle =>
                       ResetPo  <= '0';
                       EnAdrr<='0';
                       SelMux<='0';
                       SelDmux<='0';
        when q0 =>
                       okA<= '1';
        when q1 =>  
                       WriteRx<='1';
        when q2 =>  
                        WriteRx<='0';
                        ReadRx<='1';
                        WriteS1<= '1';
                        WriteS2<= '1';
        when q2wait =>
                        ReadRx<='0';
                        
        when q3 =>
                        WriteS2<= '0';
                        WriteS1<= '0';                
        
        
        when q4 =>
                        ReadS1<= '1';
                        ReadS2<= '1';
                         SelMux<='1';
                       
        when q5a =>
                        ReadS1<= '0';
                        ReadS2<= '0';
                        WriteS1<='1';
        
         when q5 =>
                        ReadS1<= '0';
                        ReadS2<= '0';
                        WriteS1<='1';
        
        
        
        when q6 =>
                        ReadS1<= '1';
                        WriteS1<='0';
                        ReadS2<= '0';
                        okA<= '0';
                        SelDmux<='1';
       
       
       when q7 =>
                        ReadS1<= '0';
                        EnWrite<='1';
                        
       when q8 =>
                        
                        EnWrite<='0';
                        EnAdrr<='1';
                        --ResetPo<='1';
                              
    end case;
end process;

end Behavioral;