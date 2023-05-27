----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 14:07:42
-- Design Name: 
-- Module Name: UO_B - Structural
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

entity UO_B is
    Port (
            CLK_B : in std_logic;
            RESET_UO_B : in std_logic;
            DATO_AB : in std_logic_vector(5 downto 0);
            Conteggio_C : in std_logic_vector(3 downto 0);
            Write_R1_B : in std_logic;
            Read_R1_B : in std_logic;
            Write_R2_B : in std_logic;
            Read_R2_B : in std_logic;
            
            Fine_A : out std_logic
         );
end UO_B;

architecture Structural of UO_B is

-- componenti

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
    
    component Registro_R4 is
        generic(N: natural:=4);
        port(
            ClockRx, ResetRx: in std_logic;
            InRx: in std_logic_vector(N-1 downto 0);
            WriteRx: in std_logic;
            ReadRx: in std_logic;
            OutRx: out std_logic_vector(N-1 downto 0)
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

    signal out_r1_b : std_logic_vector(5 downto 0);
    signal out_r2_b : std_logic_vector(3 downto 0); 

begin

Comparatore_B : comparatore
    Port Map(
               input_1 => out_r1_b,
               input_2 => "111111",
               output_uguali => Fine_A
            );


Registro_4_B : Registro_R4
    Port Map(
               ClockRx => CLK_B,
               ResetRx => RESET_UO_B,
               InRx => Conteggio_C,
               WriteRx => Write_R2_B,
               ReadRx => Read_R2_B,
               OutRx => out_r2_b
            );

Registro_6_B : Registro_R6
    Port Map(
               ClockRx => CLK_B,
               ResetRx => RESET_UO_B,
               InRx => Dato_AB,
               WriteRx => Write_R1_B,
               ReadRx => Read_R1_B,
               OutRx => out_r1_b
            );


end Structural;
