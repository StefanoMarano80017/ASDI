library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity RAM is
generic(
        AddrLen: natural :=1;
        DataLen: natural :=2;
        NumberCells: natural :=7
);
port(
    CLK : in std_logic; 
    RST : in std_logic; 
    WRITE : in std_logic; 
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATA : in std_logic_vector(DataLen downto 0)
    );
end RAM;
-- creo una ROM di NumberCells elementi da DataLen bit ciascuno
architecture rtl of RAM is 
type rom_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal RAM : rom_type ; 
begin
WRITE_RAM:process(CLK)
  begin
    if (CLK' event and CLK='1') then
        if (WRITE ='1') then
             RAM(conv_integer(ADDR)) <=DATA;
            
        else if (RST ='1' ) then
            RAM<= (others => (others => '0'));
        end if; 
        end if; 
    end if; 
       
end process;
end rtl;
