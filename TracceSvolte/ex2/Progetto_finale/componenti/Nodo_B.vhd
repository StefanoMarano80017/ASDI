----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 14:32:00
-- Design Name: 
-- Module Name: Nodo_B - Structural
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

entity Nodo_B is
    Port (
            CLK_B : in std_logic;
            RESET_B : in std_logic;
            Req_AB : in std_logic;
            Dato_AB : in std_logic_vector(5 downto 0);
            Req_CB : in std_logic;
            Conteggio_C : in std_logic_vector(3 downto 0);
            
            OK_BA : out std_logic;
            Fine_BA : out std_logic;
            OK_BC : out std_logic;
            Fine_BC : out std_logic
         );
end Nodo_B;

architecture Structural of Nodo_B is

-- compoennti

    component UC_B is
        Port (
                CLK_B : in std_logic;
                RESET_B : in std_logic;
                Req_CB : in std_logic;
                Req_AB : in std_logic;
                Fine_A : in std_logic;
                
                Read_R1_B : out std_logic;
                Read_R2_B : out std_logic;
                Write_R1_B : out std_logic;
                Write_R2_B : out std_logic;
                OK_BA : out std_logic;
                Fine_BA : out std_logic;
                OK_BC : out std_logic;
                Fine_BC : out std_logic;
                RESET_UO_B : out std_logic
          );
    end component;
    
    component UO_B is
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
    end component;
    
    
-- segnali interni

      signal out_fine_a : std_logic;
      signal out_read_r1_b : std_logic;
      signal out_read_r2_b : std_logic;
      signal out_write_r1_b : std_logic;
      signal out_write_r2_b : std_logic;
      signal out_reset_uo_b : std_logic;
      

begin

Parte_Operativa_B : UO_B
    Port Map(
                    CLK_B => CLK_B,
                    RESET_UO_B => out_reset_uo_b,
                    DATO_AB => DATO_AB,
                    Conteggio_C => Conteggio_C,
                    Write_R1_B => out_write_r1_b,
                    Read_R1_B => out_read_r1_b,
                    Write_R2_B => out_write_r2_b,
                    Read_R2_B => out_read_r2_b,
                    
                    Fine_A => out_fine_a
            );

Parte_di_Controllo_B : UC_B
    Port Map(
                    CLK_B => CLK_B,
                    RESET_B => RESET_B,
                    Req_CB => Req_CB,
                    Req_AB => Req_AB,
                    Fine_A => out_fine_a,
                    
                    Read_R1_B => out_read_r1_b,
                    Read_R2_B => out_read_r2_b,
                    Write_R1_B => out_write_r1_b,
                    Write_R2_B => out_write_r2_b,
                    OK_BA => OK_BA,
                    Fine_BA => Fine_BA,
                    OK_BC => OK_BC,
                    Fine_BC => Fine_BC,
                    RESET_UO_B => out_reset_uo_b
            );


end Structural;
