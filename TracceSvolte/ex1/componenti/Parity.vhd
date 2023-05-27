library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Parity is
Port ( 

    Data: in std_logic_vector(3 downto 0);
    par:  in std_logic;
    out_par: out std_logic
);
end Parity;

architecture Behavioral of Parity is

signal check_par: std_logic;

begin

    check_par <= (Data(0) xor Data(1)) xor (Data(2) xor Data(3));
    
    out_par   <= check_par xor par; 
            ----Se par calcolata bene allora check e par sono uguali e quindi avrò 0

end Behavioral;
