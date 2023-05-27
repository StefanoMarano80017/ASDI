----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 13:11:17
-- Design Name: 
-- Module Name: UO_C - Structural
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

entity UO_C is
    Port (
            CLK_C : in std_logic;
            RESET_UO_C : in std_logic;
            Read_R_C : in std_logic;
            Write_R_C : in std_logic;
            En_Cont_C : in std_logic;
            Dato_AC : in std_logic_vector(5 downto 0);
            
            Fine_A : out std_logic;
            Conteggio_C : out std_logic_vector(3 downto 0)
         );
end UO_C;

architecture Structural of UO_C is

-- compoenenti

    component Registro_R6 is
        generic(N: natural:=6);
        port(
            ClockRx, ResetRx: in std_logic;
            InRx: in std_logic_vector(N-1 downto 0);
            WriteRx: in std_logic;
            ReadRx: in std_logic;
            OutRx: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component Cont_mod_9 is
        generic( N:natural:=4);
        Port ( clock : in  STD_LOGIC;
               reset : in  STD_LOGIC;
             enable : in STD_LOGIC;
               counter : out  STD_LOGIC_VECTOR (N-1 downto 0):= (others => '0')
               );
    end component;
    
    component comparatore is
        generic(N:natural:=6);
        Port (
            input_1 : in std_logic_vector(N-1 downto 0);
            input_2 : in std_logic_vector(N-1 downto 0);
            output_uguali : out std_logic --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
            );
    end component;
    
-- segnali interni

    signal out_r_c : std_logic_vector(5 downto 0);

begin

Comparatore_C : comparatore
    port Map(
                input_1 => out_r_c,
                input_2 => "111111",
                output_uguali => Fine_A
            );

Contatore_9_C : Cont_mod_9
    port Map(
                clock => CLK_C,
                reset => RESET_UO_C,
                enable => En_Cont_C,
                counter => Conteggio_C
            );

Registro_C : Registro_R6
    port Map(
                ClockRx => CLK_C,
                ResetRx => RESET_UO_C,
                InRx => Dato_AC,
                WriteRx => Write_R_C,
                ReadRx => Read_R_C,
                OutRx => out_r_c
            );

end Structural;
