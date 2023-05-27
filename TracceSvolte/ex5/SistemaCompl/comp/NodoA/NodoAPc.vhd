

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoAPc is
generic(N:integer:=2);
  Port (
   --handshake
    ReqB : in std_logic:='0';
    OKA : out std_logic:='0';
    ClockA: in std_logic:='0';
    ResetA: in std_logic:='0';
    ResetPo: out std_logic:='0';
    --Reigistro Rx
    EnRx : out std_logic:='0';
    EnSendRx : out std_logic:='0';
    ValRx : in  STD_LOGIC_VECTOR (N downto 0);
    --Reigistro Tx
    EnTx : out std_logic:='0';
    EnSendTx : out std_logic:='0';
    --Contatore
    EnCont: out std_logic:='0';
    Counter : in  STD_LOGIC_VECTOR (N downto 0);
   --ShiftReg
    EnShift : out std_logic:='0';
    EnLoad : out std_logic:='0');
end NodoAPc;

architecture Behavioral of NodoAPc is

type stato is (idle, q0, q1,q2,q3,q4,q3a,q4a,q5a);
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
                if (ReqB = '1') then 
                    stato_next <=q0;
                elsif (ReqB = '0') then
                    stato_next <= idle;
                end if;
    when q0 => 
                if ReqB='1'then
                    stato_next <=q0;
                elsif ReqB='0'   then
                    stato_next <=q1;
                 
                end if;
     when q1 => 
              stato_next <=q2;
              
    when q2 => 
              if(Counter=ValRx) then
                 stato_next <=q3a;
              elsif(Counter<=ValRx) then
                 stato_next <=q3;
              end if;
    when q3 => 
              stato_next <=q4;
    when q4 => 
              stato_next <=q1;
    when q3a => 
              stato_next <=q4a;
    when q4a => 
              stato_next <=q5a;
    when q5a => 
              stato_next <=idle;
     
              
    
    
   
               
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                      ResetPo<='0';
                      
        when q0 => 
                        OkA<= '1';
                        EnRx<= '1';
                        EnLoad<='1';
                        
                        
        
        
        when q1 => 
                        EnShift<='0';
                        EnRx<= '0';
                        EnLoad<='0';
                        EnSendRx<='1';
        when q2 =>
                         EnLoad<='0';
                         EnSendRx<='0';
        when q3 =>
                         EnShift<='1';
                          EnCont<='1';
        when q4 =>
                           EnShift<='0';
                          EnCont<='0';
        when q3a =>
                          EnTx<='1';
        when q4a =>
                          EnTx<='0';
                          EnSendTx<='1';
         when q5a =>
                          EnSendTx<='0';
                          ResetPo<='1';
                          OKA<='0';
                          
                         
                         
                         
                          
                          
       
                 
       end case;
end process;                     



end Behavioral;
