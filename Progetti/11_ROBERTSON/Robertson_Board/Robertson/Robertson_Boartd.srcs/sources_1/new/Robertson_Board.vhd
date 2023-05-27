----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2022 18:08:59
-- Design Name: 
-- Module Name: Robertson_Board - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Robertson_Board is
port(
		pulsante_start, pulsante_reset, clock: in std_logic;
		Input_A,Input_B: in std_logic_vector(7 downto 0);
		Led_stop: out std_logic;
		anodes_out : out  STD_LOGIC_VECTOR (7 downto 0);
		cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end Robertson_Board;

architecture Behavioral of Robertson_Board is

component Rete_Complessiva is
    generic (N: natural := 8);
	port(
		start, reset, clock: in std_logic;
		A,B: in std_logic_vector(7 downto 0);
		stop: out std_logic;
		RIS: out std_logic_vector(15 downto 0)
	);
	end component;


component ButtonDebouncer is
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 100000000 --durata dell'oscillazione in nanosec
        );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC);
	end component;


component display_seven_segments is
    Generic( 
				clock_frequency_in : integer := 100000000; 
				clock_frequency_out : integer := 500
				);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
       end component;

signal pulsante_start_pulito: std_logic;
signal temp :std_logic_vector(15 downto 0);
signal Input_display :std_logic_vector(31 downto 0);
	
begin

Pul_start : ButtonDebouncer
    generic map(                       
        CLK_period => 10,  -- periodo del clock in nanosec
        btn_noise_time => 100000000 --durata dell'oscillazione in nanosec
        )
    port map (
			RST => pulsante_reset,
			CLK => clock,
			BTN => pulsante_start,
			CLEARED_BTN => pulsante_start_pulito
			
        );
        


Macchina_di_Robertson : Rete_Complessiva
    port map (
			start => pulsante_start_pulito,
			reset => pulsante_reset,
			clock => clock,
			A => Input_A,
			B => Input_B,
			stop => Led_stop,
			RIS => temp
			
        );

Input_display <= "0000000000000000" & temp;

Display : display_seven_segments
    generic map(                       
        clock_frequency_in => 100000000, 
				clock_frequency_out => 500
        )
    port map (
			clock => clock,
			reset => pulsante_reset,
			value32_in => Input_display,
			enable => "11111111", -- decide quali cifre abilitare
           dots => "00000000", -- decide quali punti visualizzare
           anodes => anodes_out,
           cathodes => cathodes_out
			
        );

end Behavioral;
