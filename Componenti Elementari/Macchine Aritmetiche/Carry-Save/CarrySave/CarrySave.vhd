library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity CarrySave is
    generic( N :integer :=4);
    Port (
        --somma tre stringhe di bit X,Y e Z 
        X,Y,Z :in std_logic_vector( N-1 downto 0);
        s :out std_logic_vector( N+1 downto 0)
    );
end CarrySave;

architecture Structural of CarrySave is
component FullAdder is
   Port ( 
        a,b,c_in :in std_logic;
        s,c_out :out std_logic
  );
end component;
signal cs : std_logic_vector( N-1 downto 0);
signal t,temp : std_logic_vector( N downto 0);
begin
    CarrSaveOn: for i in 0 to N-1 generate
        Csi:FullAdder port map( a=>X(i), b=>Y(i), c_in=>Z(i) ,s=>t(i) , c_out=>cs(i));
     end generate; 
     t(N) <='0';
     temp(0) <='0';
     
     RCA: for i in 0 to N-1 generate
        FA:FullAdder port map( a=>t(i+1), b=>cs(i), c_in=>temp(i) ,s=>s(i+1) , c_out=>temp(i+1));
     end generate; 
     

end Structural;
