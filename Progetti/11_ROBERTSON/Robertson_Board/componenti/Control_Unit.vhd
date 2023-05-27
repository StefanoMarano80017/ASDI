library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
	port(
		clock: in std_logic;
		reset: in std_logic;
		start: in std_logic;
		q0: in std_logic;
		end_cont: in std_logic_vector(3 downto 0);
		count_enable: out std_logic;
		subt: out std_logic;
		en_mux: out std_logic;
		en_ff : out std_logic;
		enable: out std_logic;
		shift_en: out std_logic;
		fshift_en : out std_logic;
		load: out std_logic;
		load_add: out std_logic;
		stop: out std_logic
	);
end Control_Unit;

architecture Behavioral of Control_Unit is

type state is (idle,init,check,sum,shift,subtract,final_shift);
signal current, nxt: state := idle;

begin

process_state: process(clock, reset)
	begin
		if(clock' event and clock='1') then
			if (reset='1') then
				current <= idle;
			else
				current <= nxt;
			end if;
		end if;
	end process;
	
fsm: process(current, start, reset,q0,end_cont)
	
	begin

	case current is
	
		when idle =>
			count_enable <= '0';
			subt <= '0';
			en_mux <= '0';
			enable <= '0';
			shift_en <= '0';
			load <= '0';
			stop <= '0';
			en_ff <= '1';
			if(start='1') then
				nxt <= init;
			else
				nxt <= idle;
			end if;
			
		
		when init =>
			enable <= '1';
			load <= '1';
			nxt <= check;
			en_ff <= '1';
		
		when check =>
			enable <= '0';
			load <= '0';
			load_add <= '1';
			nxt <= sum;
			en_mux <= q0;
			count_enable <= '1';
			shift_en <= '0';
			fshift_en <= '0';
			en_ff <= '1';
			if(end_cont = "0111") then
				nxt <= subtract;
				subt <= '1';
			end if;
			
		when subtract =>
			nxt <= final_shift;
			shift_en <= '0';
			fshift_en <= '1';
			subt <= '0';
			load_add <= '0';
			count_enable <= '0';
			stop <= '1';
			en_ff <= '0';
			
		when sum =>
			nxt <= shift;
			load_add <= '0';
			count_enable <= '0';
			shift_en <= '1';
			fshift_en <= '0';
			en_ff <= '0';
		
		when shift =>
			nxt <= check;
			shift_en <= '0';
			fshift_en <= '0';
			en_ff <= '0';
		
		when final_shift =>
			shift_en <= '0';
			fshift_en <= '0';
			nxt <= idle;
			en_ff <= '0';
			
	end case;
	
	end process;
	
end Behavioral;

