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

entity UC_C is
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
end UC_C;

architecture Behavioral of UC_C is
    type stato is (idle, q0, q1, q2,q3, q4, q5, q6, qf);
    signal stato_corrente : stato := idle;
    begin
       ReteControllo_C : process (CLK_C)
       begin 
         if(CLK_C'event and CLK_C = '1') then
            if (RESET_C = '1') then
                   RESET_UO_C <= '1';
                    Read_R_C <= '0';
                    Write_R_C <= '0';
                    En_Cont_C <= '0';
                    OK_CA <= '0';
                    Fine_CA <= '0';
                    Req_CB <= '0';
                    stato_corrente <= idle;
            else						
                  case stato_corrente is
                        when idle =>
                            RESET_UO_C <= '1';
                            if(RESET_C = '0') then
                                    stato_corrente <= q0;
                            else
                                    stato_corrente <= idle;
                            end if;
                        
                        when q0 =>
                                Fine_CA <= '1';
                                RESET_UO_C <= '0';
                                En_Cont_C <= '0';
                                if(Req_AC = '1') then
                                    stato_corrente <= q1;	
                                else
                                    stato_corrente <= q0;
                                end if;                     
                       
                        when q1 => 
                        
                                OK_CA <= '1';
                                Fine_CA <= '0';
                                Write_R_C <= '1';
                                stato_corrente <= q2;
                          
                        when q2 => 
                          
                                Write_R_C <= '0';
                                Read_R_C <= '1';
                                OK_CA <= '0';
                                stato_corrente <= q3;
                          
                       
                        when q3 => 
                             
                              if(Fine_A = '1') then
                                    stato_corrente <= q5;	
                                else
                                    stato_corrente <= q4;
                                end if; 
                              
                         
                         when q4 => 
                                
                                Read_R_C <= '0';
                                En_Cont_C <= '1';
                                stato_corrente <= q0;
                         
                          
                         when q5 => 
                                
                                Read_R_C <= '0';
                                if(Fine_BC = '1') then
                                    stato_corrente <= q6;	
                                else
                                    stato_corrente <= q5;
                                end if;
                            
                            
                        when q6 => 
                                
                                Req_CB <= '1';
                                if (OK_BC = '1') then
                                    stato_corrente <= qf;
                                else
                                    stato_corrente <= q6;
                                end if;            
                         
                                      
                        when qf => 
                                
                                Req_CB <= '0';
                                              
                   when others =>
                             stato_corrente <= idle;
    
                end case;
                          
        end if;
    end if;
end process;


end Behavioral;