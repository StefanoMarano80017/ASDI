library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity UC_1 is

    Port (    
        Clock: in std_logic;
        Reset: in std_logic := '0';
        
        StartA: in std_logic;
        ReqA: out std_logic;
        OkB: in std_logic := '0';
        
        --segnali controllo parte operativa
        rx: out std_logic;
        shift_value: out std_logic;
        enable_read: out std_logic;
        
        --segnali memoria
         EN_RD:   out std_logic;
         stopMEM: in std_logic;
         cnt_mem: out std_logic
);
end UC_1;

architecture Behavioral of UC_1 is

---contatore tx
       signal cnt: std_logic;
       signal cnt_val: std_logic_vector(4 downto 0); 
       signal reset_mem: std_logic;
       
component ContModN is
 generic(
        N:natural:=4
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0)
    );
end component;

type stato is (idle, q0, q1, q2, q3, carica1, carica2);
signal stato_corrente : stato := idle;
signal stato_next: stato;

begin

--Evoluzione stati 
process(Clock, Reset, stato_corrente)
begin
    
    if Reset = '1' then 
        stato_corrente <= idle;
    elsif (Clock'event and Clock = '1') then
        stato_corrente <= stato_next;
    end if;

    case stato_corrente is     
    when idle => 
                if StartA = '1'then 
                    stato_next <= carica1;
                elsif StartA = '0' then
                    stato_next <= idle;
                end if;
    when carica1 => 
                stato_next <= carica2;
    when carica2 => 
                stato_next <= q0;
    when q0 => 
                if cnt_val < "11000" then 
                    if OkB = '1' then 
                        stato_next <= q0;
                    elsif OkB = '0' then
                        stato_next <= q1;
                    end if; 
                 elsif cnt_val = "11000" then
                    stato_next <= idle;
                 end if;
    when q1 => 
                if OkB = '0' then 
                    stato_next <= q1;
                elsif OkB = '1' then
                    stato_next <= q2;
                end if;
    when q2 =>
                stato_next <= q3;
    when q3 => 
                stato_next <= q0;
                
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        ReqA    <= '0';       
                        cnt     <= '0';
                        cnt_mem  <= '0'; 
                        rx      <= '0';
                        reset_mem <= '0';
        when carica1 => 
                        if cnt_val = "00000" then
                            EN_RD   <= '1';
                        end if;  
        when carica2 => 
                        if cnt_val = "00000" then
                            enable_read    <= '1';
                        end if; 
        when q0    => 
                        if cnt_val = "11000" then 
                            cnt_mem  <= '1';
                            reset_mem <= '1';
                        end if;  
                            EN_RD          <= '0';
                            enable_read    <= '0';
                            ReqA    <= '0';       
                            cnt     <= '0';
                            rx      <= '0';
        when q1    => 
                        ReqA           <= '1';
        when q2    => 
                        ReqA           <= '0';
        when q3    =>  
                        rx             <= '1';
                        shift_value    <= '0';
                        cnt     <= '1';    
    end case;
end process;

cont: ContModN 
port map(
           clock => Clock,
           reset => reset_mem,
		   enable => cnt,
           counter => cnt_val
);

end Behavioral;