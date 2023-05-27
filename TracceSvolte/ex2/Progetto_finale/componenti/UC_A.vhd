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

entity UC_A is
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
end UC_A;

architecture Behavioral of UC_A is
    type stato is (idle, q0, q1, q2,q3, q4, q5, q6, qf);
    signal stato_corrente : stato := idle;
    begin
       ReteControllo_A : process (CLK_A)
       begin 
         if(CLK_A'event and CLK_A = '1') then
            if (RESET_A = '1') then
                   RESET_UO_A <= '1';
                    Req_AB <= '0';
                    Req_AC <= '0';
                    Read_ROM_A <= '0';
                    En_Cont_A <= '0';
                    stato_corrente <= idle;
            else						
                  case stato_corrente is
                        when idle =>
                            RESET_UO_A <= '1';
                            if(RESET_A = '0' and START_A = '1') then
                                    stato_corrente <= q0;
                                    
                            else
                                    stato_corrente <= idle;
                            end if;
                        
                        when q0 =>
                                RESET_UO_A <= '0';
                                Read_ROM_A <= '1';
                                En_Cont_A <= '0';
                                if(Stop_Cont_A = '0') then
                                    stato_corrente <= q1;	
                                else
                                    stato_corrente <= q5;
                                    
                                end if;                     
                       
                        when q1 => 
                                
                                if (Lsb = '0' and Fine_CA = '1') then
                                    stato_corrente <= q2;
                                elsif (Lsb = '1' and Fine_BA = '1') then
                                    stato_corrente <= q3;
                                else
                                    stato_corrente <= q1;
                                end if;
                         
                         when q2 => 
                                
                                Req_AC <= '1';
                                if (OK_CA = '1') then
                                    stato_corrente <= q4;
                                else
                                    stato_corrente <= q2;
                                end if;
                         
                          
                         when q3 => 
                                
                                Req_AB <= '1';
                                if (OK_BA = '1') then
                                    stato_corrente <= q4;
                                else
                                    stato_corrente <= q3;
                                end if;
                            
                            
                        when q4 => 
                                
                                Req_AC <= '0';
                                Req_AB <= '0';
                                Read_ROM_A <= '0';
                                En_Cont_A <= '1';           
                                stato_corrente <= q0;
                         
                         
                        when q5 => 
                                
                                if (Fine_BA = '1' and Fine_CA = '1') then
                                    stato_corrente <= q6;
                                else
                                    stato_corrente <= q5;
                                end if;
                      
                      
                        when q6 => 
                                
                                Req_AB <= '1';
                                Req_AC <= '1';
                                if (OK_BA = '1' and OK_CA = '1') then
                                    stato_corrente <= qf;
                                else
                                    stato_corrente <= q6;
                                end if;
                                     
                                     
                        when qf => 
                                Req_AB <= '0';
                                Req_AB <= '0';
                                              
                   when others =>
                             stato_corrente <= idle;
    
                end case;
                          
        end if;
    end if;
end process;


end Behavioral;