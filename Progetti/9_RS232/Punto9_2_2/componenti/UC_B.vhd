library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC_B is
    Port ( 
        ClockB, ResetB: in std_logic;
		
		----handshake
		OkB: out std_logic;
		ReqA: in std_logic;
		
		----UART
		RDA: in std_logic:='0';
		EnRD: out std_logic:='0';
		OE, PE, FE: in std_logic;
		
		---MEM
		WR_mem: out std_logic;
		OutCont: out std_logic_vector(2 downto 0) := (others => '0')
);
end UC_B;

architecture Behavioral of UC_B is

type stato is (idle, q0, q1, q2, q3);
signal stato_corrente : stato := idle;
signal stato_next: stato;

---signale contatori
signal cnt_mem: std_logic;
signal ctr_mem: std_logic_vector(2 downto 0) := "000";

begin

---EVOLUZIONE
process(ClockB, ResetB)
begin 
     if (ClockB'event and ClockB='1') then 
         if ResetB = '1' then 
            stato_corrente <= idle;
         else
            stato_corrente <= stato_next;
        end if;
     end if;

    case stato_corrente is     
    when idle => 
                if ReqA = '1' then 
                    stato_next <= q0;
                elsif ReqA = '0' then
                    stato_next <= idle;
                end if;
                EnRD         <= '0';
                WR_mem       <= '0';
                cnt_mem      <= '0';  
                OkB          <= '0';
    when q0 =>  
                stato_next   <= q1;
                OkB          <= '1';  
    when q1 => 
                if RDA = '1' then
                    if (OE = '1' or  PE = '1' or FE = '1') then 
                        stato_next <= q0;
                    else 
                        stato_next <= q2;
                    end if;
                else
                    OkB <= '0';  
                    stato_next <= q1;
                end if;
    when q2 =>
                OkB  <= '0';
                EnRD         <= '1';
                WR_mem       <= '1';
                stato_next   <= q3;
    when q3 => 
                if  ReqA = '0' then 
                    cnt_mem      <= '1';
                    stato_next  <= idle;
                elsif  ReqA = '1' then 
                    stato_next  <= q3;
                end if;
                EnRD         <= '0';
                WR_mem       <= '0';
                OkB          <= '0';
    end case;
end process;

---CONTATORE MEM
process(ClockB)
begin
    if (ClockB'event and ClockB='1') then
         if ResetB = '1' then 
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