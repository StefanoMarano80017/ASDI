----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 14:44:49
-- Design Name: 
-- Module Name: Sistema_Complessivo - Structural
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

entity Sistema_Complessivo is
    Port (
                CLK_A : in std_logic;
                CLK_B : in std_logic;
                CLK_C : in std_logic;
                RESET_A : in std_logic;
                RESET_B : in std_logic;
                RESET_C : in std_logic;
                START_A : in std_logic
         );
end Sistema_Complessivo;

architecture Structural of Sistema_Complessivo is

-- componenti

    component Nodo_A is
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
    end component;
    
    component Nodo_B is
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
    end component;
    
    component Nodo_C is
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
    end component;
    

-- segnali interni

    signal out_ok_ba : std_logic;
    signal out_fine_ba : std_logic;
    signal out_ok_ca : std_logic;
    signal out_fine_ca : std_logic;
    signal out_req_ab : std_logic;
    signal out_req_ac : std_logic;
    signal out_dato_ab : std_logic_vector(5 downto 0);
    signal out_dato_ac : std_logic_vector(5 downto 0);
    signal out_conteggio_c : std_logic_vector(3 downto 0);
    signal out_req_cb : std_logic;
    signal out_ok_bc : std_logic;
    signal out_fine_bc : std_logic;
    

begin

NodoC : Nodo_C
    Port Map(
                CLK_C => CLK_C,
                RESET_C => RESET_C,
                Dato_AC => out_dato_ac,
                Req_AC => out_req_ac,
                OK_BC => out_ok_bc,
                Fine_BC => out_fine_bc,
                
                Req_CB => out_req_cb,
                OK_CA => out_ok_ca,
                Fine_CA => out_fine_ca,
                Conteggio_C => out_conteggio_c 
            );

NodoB : Nodo_B
    Port Map(
                CLK_B => CLK_B,
                RESET_B => RESET_B,
                Req_AB => out_req_ab,
                Dato_AB => out_dato_ab,
                Req_CB => out_req_cb,
                Conteggio_C => out_conteggio_c,
                
                OK_BA => out_ok_ba,
                Fine_BA => out_fine_ba,
                OK_BC => out_ok_bc,
                Fine_BC => out_fine_bc
            );

NodoA : Nodo_A
    Port Map(
                CLK_A => CLK_A,
                RESET_A => RESET_A,
                START_A => START_A,
                OK_BA => out_ok_ba,
                Fine_BA => out_fine_ba,
                OK_CA => out_ok_ca,
                Fine_CA => out_fine_ca,
                
                Req_AB => out_req_ab,
                Req_AC => out_req_ac,
                Dato_AB => out_dato_ab,
                Dato_AC => out_dato_ac    
            );

end Structural;
