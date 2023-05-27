----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2023 11:35:38
-- Design Name: 
-- Module Name: UC_A - Behavioral
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

entity UC_B is
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
end UC_B;

architecture Behavioral of UC_B is
    type stato is (idle, q0, q1, q2,q3, q4, q5, qf);
    signal stato_corrente : stato := idle;
    begin
       ReteControllo_B : process (CLK_B)
       begin 
         if(CLK_B'event and CLK_B = '1') then
            if (RESET_B = '1') then
                    RESET_UO_B <= '1';
                    Read_R1_B <= '0';
                    Read_R2_B <= '0';
                    Write_R1_B <= '0';
                    Write_R2_B <= '0';
                    OK_BA <= '0';
                    Fine_BA <= '0';
                    OK_BC <= '0';
                    Fine_BC <= '0';
                    stato_corrente <= idle;
            else						
                  case stato_corrente is
                        when idle =>
                            RESET_UO_B <= '1';
                            if(RESET_B = '0') then
                                    stato_corrente <= q0;
                            else
                                    stato_corrente <= idle;
                            end if;
                        
                        when q0 =>
                                RESET_UO_B <= '0';
                                Fine_BA <= '1';
                                Read_R1_B <= '0';
                                if(Req_AB = '1') then
                                    stato_corrente <= q1;	
                                else
                                    stato_corrente <= q0;
                                end if;                     
                       
                        when q1 => 
                        
                                OK_BA <= '1';
                                Fine_BA <= '0';
                                Write_R1_B <= '1';
                                stato_corrente <= q2;
                          
                        when q2 => 
                                
                                OK_BA <= '0';
                                Write_R1_B <= '0';
                                Read_R1_B <= '1';
                                stato_corrente <= q3;
                          
                       
                        when q3 => 
                             
                              if(Fine_A = '1') then
                                    stato_corrente <= q4;	
                                else
                                    stato_corrente <= q0;
                                end if; 
                              
                         
                         when q4 => 
                                
                                Read_R1_B <= '0';
                                Fine_BC <= '1';
                                if(Req_CB = '1') then
                                    stato_corrente <= q5;	
                                else
                                    stato_corrente <= q4;
                                end if; 
                          
                         when q5 => 
                                
                                Fine_BC <= '0';
                                OK_BC <= '1';
                                Write_R2_B <= '1';
                                stato_corrente <= qf;
                                     
                         
                                      
                        when qf => 
                                
                                OK_BC <= '1';
                                Write_R2_B <= '0';
                                              
                   when others =>
                             stato_corrente <= idle;
    
                end case;
                          
        end if;
    end if;
end process;


end Behavioral;