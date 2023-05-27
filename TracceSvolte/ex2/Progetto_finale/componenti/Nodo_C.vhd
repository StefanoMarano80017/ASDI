----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 12:56:51
-- Design Name: 
-- Module Name: Nodo_A - Structural
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

entity Nodo_C is
    Port (
            CLK_C : in std_logic;
            RESET_C : in std_logic;
            Dato_AC : in std_logic_vector(5 downto 0);
            Req_AC : in std_logic;
            OK_BC : in std_logic;
            Fine_BC : in std_logic;
            
            Req_CB : out std_logic;
            OK_CA : out std_logic;
            Fine_CA : out std_logic;
            Conteggio_C : out std_logic_vector(3 downto 0)
          );
end Nodo_C;

architecture Structural of Nodo_C is

-- componenti

    component UO_C is
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
    end component;
    
    component UC_C is
        Port (
                CLK_C : in std_logic;
                RESET_C : in std_logic;
                OK_BC : in std_logic;
                Req_AC : in std_logic;
                Fine_BC : in std_logic;
                Fine_A : in std_logic;
                
                Read_R_C : out std_logic;
                Write_R_C : out std_logic;
                En_Cont_C : out std_logic;
                OK_CA : out std_logic;
                Fine_CA : out std_logic;
                Req_CB : out std_logic;
                RESET_UO_C : out std_logic
          );
    end component;

-- segnali interni
    
    signal out_fine_a : std_logic;
    signal out_read_r_c : std_logic;
    signal out_write_r_c : std_logic;
    signal out_en_cont_c : std_logic;
    signal out_reste_uo_c : std_logic;
    
begin

Parte_di_Controllo_C : UC_C
    Port Map(
                CLK_C => CLK_C,
                RESET_C => RESET_C,
                OK_BC => OK_BC,
                Req_AC => Req_AC,
                Fine_BC => Fine_BC,
                Fine_A => out_fine_a,
                
                Read_R_C => out_read_r_c,
                Write_R_C => out_write_r_c,
                En_Cont_C => out_en_cont_c,
                OK_CA => OK_CA,
                Fine_CA => Fine_CA,
                Req_CB => Req_CB,
                RESET_UO_C => out_reste_uo_c
            );

Parte_Operativa_A : UO_C
    Port Map(
                CLK_C => CLK_C,
                RESET_UO_C => out_reste_uo_c,
                Read_R_C => out_read_r_c,
                Write_R_C => out_write_r_c,
                En_Cont_C => out_en_cont_c,
                Dato_AC => Dato_AC,
                
                Fine_A => out_fine_a,
                Conteggio_C => Conteggio_C
            );


end Structural;
