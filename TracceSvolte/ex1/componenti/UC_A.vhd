library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA_pc is
    port(
        StartA: in std_logic;
        ClockA: in std_logic;
        ResetA: in std_logic;
        
        ReqA:   out std_logic;
        OkB:    in  std_logic;
        
        ---memoria
        tx:         out std_logic;
        read:       out std_logic;
        mem_val:    in  std_logic_vector(4 downto 0);
        addr:       out std_logic_vector(3 downto 0) := (others => '0')
);
end NodoA_pc;

architecture Behavioral of NodoA_pc is 

type stato is (idle, qmem, q0, q1, q2, q3);
signal stato_corrente : stato := idle;
signal stato_next: stato;

--Cont
signal Cont_en: std_logic;
signal StopCont: std_logic;


component ContModN is
    generic(
        N:natural:=3
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC :='0'
    );
           
end component;

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
                if StartA = '1' and StopCont = '0' then 
                        stato_next <= q0;
                elsif StartA = '0' or StopCont = '1' then
                    stato_next <= idle;
                end if;
    when q0 => 
                if OkB = '1' then 
                    stato_next <= q0;
                elsif OkB = '0' then
                    stato_next <= qmem;
                end if; 
    when qmem => 
                if mem_val = "00000" then
                    stato_next <= q0;
                else
                    stato_next <= q1;
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
                stato_next <= idle;
                
    end case;
end process;

--OUTPUT
process(stato_corrente)
begin
    case stato_corrente is 
        when idle => 
                        ReqA    <= '0';       
                        read    <= '0';
                        tx      <= '0';
                        Cont_en     <= '0';   
        when q0    => 
                        ReqA    <= '0';       
                        read    <= '1';
                        Cont_en <= '0';
                        tx      <= '0'; 
        when qmem =>
                        if mem_val = "00000" then
                            Cont_en <= '1';
                        end if;    
        when q1    => 
                        ReqA    <= '1';       
        when q2    => 
                        tx      <= '1';
                        read    <= '0';
        when q3    =>   
                        tx          <= '0';
                        ReqA        <= '0';
                        Cont_en     <= '1';         
    end case;
end process;


--CONT
CONT: ContModN
port map(
           clock       => ClockA,
           reset        => ResetA,
		   enable       => Cont_en,
           counter      => addr,
           stopCount    => StopCont
);


end Behavioral;