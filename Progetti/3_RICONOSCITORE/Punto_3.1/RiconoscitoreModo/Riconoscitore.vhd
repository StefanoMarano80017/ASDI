library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Riconoscitore is
  Port ( 
        Clock : in std_logic;
        Reset : in std_logic;
        InDato : in std_logic;
        Modo : in std_logic;
        Y: out std_logic
  );
end Riconoscitore;
architecture Behavioral of Riconoscitore is
    
   --definisco gli stati S0,S1,S2,S3,S4,SX,SXX,SXXX,S11,S21,S31,S41
        type Stato is(S0,S1,S2,S3,S4,SX,SXX,SXXX,S11,S21,S31,S41);
        signal statoCorrente : stato :=S0;
        signal statoProssimo : stato;

   begin
       -- definisco il comportamento del mio sistema
        statoUscita :process(statoCorrente,InDato)
                      begin
                        case statoCorrente is
                           
                          --vado a descrivere il comportmanto della macchina con Modo=0
                           when S1 => 
                                    if(InDato='1') then
                                        statoProssimo <=S2;
                                        y <='0';
                                     else
                                        statoProssimo <=SX;
                                        y <='0';
                                     end if; 
                           when S2 => 
                                    if(InDato='0') then
                                        statoProssimo <=S3;
                                        y <='0';
                                     else
                                        statoProssimo <=SXX;
                                        y <='0';
                                     end if;
                                     
                           when S3 => 
                                    if(InDato='0') then
                                        statoProssimo <=S4;
                                        y <='0';
                                     else
                                        statoProssimo <=SXXX;
                                        y <='0';
                                     end if;
                                     
                            when S4 => 
                                    if(InDato='1') then
                                        statoProssimo <=S1;
                                        y <='1';
                                     else
                                        statoProssimo <=S1;
                                        y <='0';
                                     end if;
                                     
                            --gestisco gli stati che non mi portano all'uscita 1 
                            when SX => 
                                    if(InDato='1' or InDato='0') then
                                        statoProssimo <=SXX;
                                        y <='0';
                                     end if;
                            when SXX => 
                                    if(InDato='1' or InDato='0') then
                                        statoProssimo <=SXXX;
                                        y <='0';
                                     end if;
                                     
                            when SXXX => 
                                    if(InDato='1' or InDato='0') then
                                        statoProssimo <=S1;
                                        y <='0';
                                     end if;          
                                   
                          --vado a descrivere il comportmanto della macchina con Modo=1
                          
                            when S11 => 
                                    if(InDato='1') then
                                        statoProssimo <=S21;
                                        y <='0';
                                     else
                                        statoProssimo <=S11;
                                        y <='0';
                                     end if;
                            when S21 => 
                                    if(InDato='0') then
                                        statoProssimo <=S31;
                                        y <='0';
                                     else
                                        statoProssimo <=S21;
                                        y <='0';
                                     end if;
                                     
                             when S31 => 
                                    if(InDato='0') then
                                        statoProssimo <=S41;
                                        y <='0';
                                     else
                                        statoProssimo <=S21;
                                        y <='0';
                                     end if;
                                     
                              when S41 => 
                                    if(InDato='1') then
                                        statoProssimo <=S11;
                                        y <='1';
                                     else
                                        statoProssimo <=S11;
                                        y <='0';
                                     end if;                          
                                    
                           when others =>
                                        if(Modo='1') then
                                        statoProssimo <=S11;
                                     else 
                                        statoProssimo <=S1;
                                        
                                      end if;
                                      y<='0';
                                        
                           end case;
                     end process;
       
       --comportemendo relativo alla memorizzazione degli stati
      Memoria :process(Clock)
                    begin
                        if( Clock'event and Clock = '1' ) then
		                  if(Reset = '1') then
	                           statoCorrente <= S0;
	                           if(Modo='0') then
	                               statoCorrente <= S1;
	                           else
	                              statoCorrente <= S11;
	                           
	                           end if;
	                           
	                      else
	                           statoCorrente <= statoProssimo;
	                      end if;
                        end if;
               end process;

end Behavioral;