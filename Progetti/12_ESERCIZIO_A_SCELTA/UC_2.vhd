library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC_B is
    Port (    
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        
        ReqA: in std_logic;
        OkA: out std_logic := '0';
        
        --segnali controllo parte operativa
        EnRx: out std_logic;
        sel:  out std_logic;
        res:  in std_logic;
        en_write: out std_logic;
        val_out:  out std_logic_vector(1 downto 0)
);
end UC_B;

architecture Behavioral of UC_B is

---contatore rx
       signal cnt: std_logic;
       signal cnt_val: std_logic_vector(4 downto 0); 
       
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

type stato is (idle,q0,q1, q2, q3, q4a, q4b, q5);
signal stato_corrente : stato := idle;
signal stato_next: stato;
signal reset_mem: std_logic;

begin

--Process evoluzione stati
process (ClockB, ResetB)
begin
        if ResetB = '1' then 
            stato_corrente <= idle;
        elsif(ClockB'event and ClockB = '1') then
            stato_corrente <= stato_next;
        end if;

        case stato_corrente is 
        when idle => 
                         if (ReqA = '0') then 
                            stato_next <= idle;
                         elsif (ReqA = '1') then 
                            stato_next <= q0;
                         end if;
        when q0 =>   
                    if ReqA = '0' then 
                        stato_next <= idle;
                    elsif ReqA = '1' then 
                        stato_next <= q1;
                    end if;
        when q1 =>
                    stato_next <= q2;  
        when q2 => 
                    if cnt_val < "11000" then 
                        stato_next <= idle;
                    else 
                        stato_next <= q3;
                    end if;
        when q3 => 
                    if res = '1' then 
                       stato_next <= q4a;
                    elsif res = '0' then
                        stato_next <= q4b;
                    end if;
        when q4a  => 
                    if res = '1' then 
                       stato_next <= q5;
                    elsif res = '0' then 
                        stato_next <= q4b;
                    end if;
        when q4b => 
                    stato_next <= idle;
        when q5 =>
                    stato_next <= idle;
        end case;
end process;

--OUTPUT 
process(stato_corrente)
begin 
    case stato_corrente is
        when idle =>
                        EnRx    <= '0';
                        okA     <= '0'; 
                        cnt     <= '0';
                        en_write <= '0'; 
                        reset_mem <= '0';                      
        when q0 =>
                        okA     <= '1';
        when q1 =>  
                        EnRx    <= '1';
                        cnt     <= '1';
        when q2 => 
                        EnRx    <= '0';
                        cnt     <= '0';
                        sel     <= '0';
        when q3 =>     
                        if res = '1' then 
                            sel <= '1';
                        end if;
        when q4a => 
                         sel <= '0';
        when q4b => 
                        reset_mem <= '1';
                        val_out  <= "11";
                        en_write <= '1';
        when q5  => 
                        reset_mem <= '1';
                        val_out  <= "00";
                        en_write <= '1';
    end case;
end process;

cont: ContModN 
port map(
           clock => ClockB,
           reset => reset_mem,
		   enable => cnt,
           counter => cnt_val
);

end Behavioral;