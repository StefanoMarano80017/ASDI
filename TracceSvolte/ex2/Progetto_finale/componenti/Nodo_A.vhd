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

entity Nodo_A is
    Port (
            CLK_A : in std_logic;
            RESET_A : in std_logic;
            START_A : in std_logic;
            OK_BA : in std_logic;
            Fine_BA : in std_logic;
            OK_CA : in std_logic;
            Fine_CA : in std_logic;
            
            Req_AB : out std_logic;
            Req_AC : out std_logic;
            Dato_AB : out std_logic_vector(5 downto 0);
            Dato_AC : out std_logic_vector(5 downto 0)
          );
end Nodo_A;

architecture Structural of Nodo_A is

-- componenti

    component UO_A is
        Port (
            CLK_A : in std_logic;
            RESET_UO_A : in std_logic;
            Read_ROM_A : in std_logic;
            En_Cont_A : in std_logic;
            
            Lsb : out std_logic;
            Stop_Cont_A : out std_logic;
            Dato_AC : out std_logic_vector(5 downto 0);
            Dato_AB : out std_logic_vector(5 downto 0)
            
          
          );
    end component;
    
    component UC_A is
        Port (
                CLK_A : in std_logic;
                RESET_A : in std_logic;
                START_A : in std_logic;
                OK_BA : in std_logic;
                OK_CA : in std_logic;
                Fine_BA : in std_logic;
                Fine_CA : in std_logic;
                Stop_Cont_A : in std_logic;
                Lsb : in std_logic;
                
                Req_AB : out std_logic;
                Req_AC : out std_logic;
                Read_ROM_A : out std_logic;
                En_Cont_A : out std_logic;
                RESET_UO_A : out std_logic
          );
    end component;

-- segnali interni
    
    signal out_reset_uo_a : std_logic;
    signal out_read_rom_a : std_logic;
    signal out_en_cont_a : std_logic;
    signal out_lsb : std_logic;
    signal out_stop_cont_a : std_logic;

begin

Parte_di_Controllo_A : UC_A
    Port Map(
                CLK_A => CLK_A,
                RESET_A => RESET_A,
                START_A => START_A,
                OK_BA => OK_BA,
                OK_CA => OK_CA,
                Fine_BA => Fine_BA,
                Fine_CA => Fine_CA,
                Stop_Cont_A => out_stop_cont_a,
                Lsb => out_lsb,
                
                Req_AB => Req_AB,
                Req_AC => Req_AC,
                Read_ROM_A => out_read_rom_a,
                En_Cont_A => out_en_cont_a,
                RESET_UO_A => out_reset_uo_a
            );

Parte_Operativa_A : UO_A
    Port Map(
                CLK_A => CLK_A,
                RESET_UO_A => out_reset_uo_a,
                Read_ROM_A => out_read_rom_a,
                En_Cont_A => out_en_cont_a,
                
                Lsb => out_lsb,
                Stop_Cont_A => out_stop_cont_a,
                Dato_AC => Dato_AC,
                Dato_AB => Dato_AB
            );


end Structural;
