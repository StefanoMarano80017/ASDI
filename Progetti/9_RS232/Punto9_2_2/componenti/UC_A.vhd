library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC_A is
    Port ( 
        ClockA, ResetA: in std_logic;
		Start: in std_logic:='0';
		
		----handshake
		OkB: in std_logic;
		ReqA: out std_logic;
		
		----UART
		Tbe: in std_logic:='0';
		EnWr: out std_logic:='0';
		
		---MEM
		RD_mem: out std_logic;
		OutCont: out std_logic_vector(2 downto 0) := (others => '0')
);
end UC_A;

architecture Behavioral of UC_A is

type stato is (idle, q0, q1, q2, q3);
signal stato_corrente : stato := idle;
signal stato_next: stato;

---signale contatori
signal cnt_mem: std_logic;
signal ctr_mem: std_logic_vector(2 downto 0) := "000";

begin

---EVOLUZIONE
process(ClockA, ResetA)
begin 
     if (ClockA'event and ClockA='1') then 
         if ResetA = '1' then 
            stato_corrente <= idle;
         else
            stato_corrente <= stato_next;
        end if;
     end if;

    case stato_corrente is     
    when idle => 
                if Start = '1' then 
                    stato_next <= q0;
                elsif Start = '0' then
                    stato_next <= idle;
                end if;
                
                RD_mem       <= '0';
                ReqA         <= '0';  
                cnt_mem      <= '0';  
                  
    when q0 => 
                if OkB = '1' then 
                    stato_next <= q0;
                elsif OkB = '0' then
                    stato_next <= q1;
                end if; 
    when q1 => 
                if OkB = '0' then 
                    stato_next <= q1;
                elsif OkB = '1' then
                    stato_next <= q2;
                end if;
                RD_mem       <= '1';
                ReqA         <= '1';
    when q2 =>
                stato_next <= q3;
                ---abilito trasmissione
                EnWr         <=  '1';
    when q3 => 
                if Tbe = '0' and OkB = '0' then 
                    --aspetto fine trasmissione
                    stato_next <= q3;              
                end if;
   
                if Tbe = '0' and OkB = '1' then 
                    --effettuo ritrasmissione
                    stato_next <= q2;
                end if;
   
                if Tbe = '1' and OkB = '0' then 
                        -- trasmissione completata
                        stato_next <= idle;
                        cnt_mem <= '1';
                        ReqA    <= '0';
                end if;
   
                ---disabilito strobe
                EnWr    <=  '0';
                RD_mem  <=  '0';
    end case;
end process;

---CONTATORE MEM
process(ClockA)
begin
    if (ClockA'event and ClockA='1') then
         if ResetA = '1' then 
            ctr_mem <= (others => '0');
         elsif  cnt_mem = '1' then 
            ctr_mem <= ctr_mem + 1;
         else 
            ctr_mem <= ctr_mem;
         end if;  
    end if;
    
    OutCont  <= ctr_mem;
end process;


end Behavioral;