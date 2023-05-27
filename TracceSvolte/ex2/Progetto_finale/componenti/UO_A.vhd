----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2023 12:11:05
-- Design Name: 
-- Module Name: UO_A - Structural
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

entity UO_A is
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
end UO_A;

architecture Structural of UO_A is

-- componenti

    component ROM is
                generic(
                        AddrLen: natural :=2;
                        DataLen: natural :=6;
                        NumberCells: natural :=7
                        );

                    port(
                        CLK : in std_logic; 
                        RST : in std_logic; 
                                           
                        READ : in std_logic; 
                                               
                                               
                        ADDR : in std_logic_vector(AddrLen downto 0); 
                                                               
                        DATA : out std_logic_vector(DataLen downto 0) 
                        );
    end component;
    
    component Cont_con_stop_mod_8 is
                generic( N:natural:=3);
                    Port ( clock : in  STD_LOGIC;
                           reset : in  STD_LOGIC;
                            enable : in STD_LOGIC;
                           counter : out  STD_LOGIC_VECTOR (N-1 downto 0):= (others => '0');
                           stopCount : out STD_LOGIC
                           );
    end component;
    
    component demux_1_2 is
                generic(N:natural:=6);
                Port (
                input : in std_logic_vector (N-1 downto 0);
                s : in std_logic;
                out_1 : out std_logic_vector (N-1 downto 0);
                out_2 : out std_logic_vector (N-1 downto 0)
                );
    end component;
    
    component mux_21_gen is
                generic (N: natural:= 6);
                Port ( 
                    a0, a1: in std_logic_vector(N-1 downto 0);
                    s: in std_logic;
                    y: out std_logic_vector(N-1 downto 0)
                );
    end component;
    
-- segnali interni
    
    signal out_rom_a : std_logic_vector(6 downto 0);
    signal out_cont_a : std_logic_vector(2 downto 0);
    signal out_stop_cont_a : std_logic;
    signal out_dmux_ac : std_logic_vector(5 downto 0);
    signal out_dmux_ab : std_logic_vector(5 downto 0);

begin

MUX_AC : mux_21_gen
    Port Map(
                a0 => out_dmux_ac,
                a1 => "111111",
                s => out_stop_cont_a,
                y => Dato_AC
            );

MUX_AB : mux_21_gen
    Port Map(
                a0 => out_dmux_ab,
                a1 => "111111",
                s => out_stop_cont_a,
                y => Dato_AB
            );

DMUX_A : demux_1_2
    Port Map(
                input => out_rom_a(6 downto 1),
                s => out_rom_a(0),
                out_1 => out_dmux_ac,
                out_2 => out_dmux_ab
            );
            
 
Lsb <= out_rom_a(0);
            

Cont_A : Cont_con_stop_mod_8
    Port Map(
                clock => CLK_A,
                reset => RESET_UO_A,
                enable => En_Cont_A,
                counter => out_cont_a,
                stopCount => out_stop_cont_a
            );
            
Stop_Cont_A <= out_stop_cont_a;
 

ROM_A : ROM
    Port Map(
                CLK => CLK_A,
                RST => RESET_UO_A,
                READ => Read_ROM_A,
                ADDR => out_cont_a,
                DATA => out_rom_a
            );
            




end Structural;
