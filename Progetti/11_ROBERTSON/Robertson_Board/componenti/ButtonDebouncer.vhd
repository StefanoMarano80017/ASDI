----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;



entity ButtonDebouncer is
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
        );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC);
end ButtonDebouncer;

architecture Behavioral of ButtonDebouncer is

-- questo componente prende in input il segnale proveniente dal bottone e genera un 
-- segnale "ripulito" che presenta un impulso della durata di un colpo di clock per 
-- segnalare l'avvenuta pressione del bottone.
-- appena viene rilevato un segnale alto, la macchina si porta in uno stato PRESSED_VRFY
-- in cui attende che trascorra il tempo di "rimbalzo": se il segnale è ancora alto vuole dire che 
-- il bottone era stato davvero premuto e quindi si passa nello stato PRESSED_CNFRMD
-- allo stesso modo, se il segnale si abbassa, si va in uno stato di RELEASED_VRFY dove
-- si attende che trascorra il tempo di "rimbalzo" per vedere se davvero il bottone è stato
-- rilasciato, nel qual caso si va in RELEASED
-- in questo modo anche tenendo premuto il bottone viene generato un singolo impulso

type stato is (RELEASED, PRESSED_VRFY, PRESSED_CNFRMD, RELEASED_VRFY);
signal BTN_state : stato := RELEASED;

constant max_count : integer := btn_noise_time/CLK_period; -- dipende dall'oscillazione del segnale
                            -- deve essere tale da superare tutto il tempo dell'oscillazione 

begin

deb: process (CLK)
variable count: integer := 0;

begin
   if rising_edge(CLK) then
	   
	   if( RST = '1') then
	       BTN_state <= RELEASED;
	       CLEARED_BTN <= '0';
	   else
	   	  case BTN_state is
	   	  
			when RELEASED =>
			    CLEARED_BTN<= '0';
				if( BTN = '1') then
					BTN_state <= PRESSED_VRFY;
				else 
					BTN_state <= RELEASED;
				end if;
				
            when PRESSED_VRFY =>   --appena vedo il bottone premuto inizio a contare
               if(count = max_count -1) then --quando arrivo al max count controllo se è ancora alto
                       if( BTN = '1') then
                          count :=0;
                          CLEARED_BTN <= '1';
                          BTN_state <= PRESSED_CNFRMD; --se è ancora alto vado a PRESSED_CNFRMD e alzo il segnale di output
                       else
                          BTN_state <= RELEASED; 
                       end if;
               else 
                       count:= count+1;
               end if;
               
            when PRESSED_CNFRMD =>
               CLEARED_BTN <= '0';
--               if(count = 100*max_count -1) then 
--                       count :=0;
--                       BTN_state <= NOT_PRESSED;
--               else
--                       count:= count+1;
--                       BTN_state <= PRESSED_CNFRMD; 
--              end if;
               if( BTN = '0') then
                    BTN_state <= RELEASED_VRFY;
			   else 
					BTN_state <= PRESSED_CNFRMD;
			   end if;
			   
		    when RELEASED_VRFY =>
		       if(count = max_count -1) then --quando arrivo al max count controllo se è ancora basso
                       if( BTN = '0') then
                          count :=0;
                          BTN_state <= RELEASED;
                       else
                          BTN_state <= PRESSED_VRFY; 
                       end if;
               else 
                       count:= count+1;
               end if;
                
                
            when others => 
               BTN_state <= RELEASED;
		  end case;
    end if;  
  end if;  
end process;


end Behavioral;
