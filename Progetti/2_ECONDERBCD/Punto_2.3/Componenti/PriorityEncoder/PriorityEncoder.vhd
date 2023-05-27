library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PriorityEncoder is
  Port ( 
        InBcd: in std_logic_vector( 9 downto 0);
        OutBcd: out std_logic_vector( 3 downto 0)
  );
end PriorityEncoder;

architecture Structural of PriorityEncoder is
       signal outReferee :std_logic_vector(9 downto 0);
       component PriorityReferee  is
                  port(
                        Inx: in std_logic_vector(9 downto 0);
                        Ux: out std_logic_vector(9 downto 0)  
			      );
        end component;
        component Encoder_10_4  is
                  port(
                         a:in std_logic_vector(9 downto 0); 
                         y:out std_logic_vector(3 downto 0)   
			      );
        end component;
begin
SystemPriority: PriorityReferee  
			Port map(
				  Inx => InBcd,
				  Ux =>outReferee
			);
			
Encoder_10_4_0: Encoder_10_4  
			Port map(
				  a => outReferee,
				  y =>OutBcd
			);


end Structural;
