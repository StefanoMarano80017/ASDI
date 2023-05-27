library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=3;
        NumberCells: natural :=15
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
    ADDR : in std_logic_vector(AddrLen downto 0);
    FLAGWRITE : out std_logic;
    READ : in std_logic;  
    DATA : out std_logic_vector(DataLen downto 0) 
    );
end ROM;
-- creo una ROM di NumberCells elementi da DataLen bit ciascuno
architecture rtl of ROM is 
type rom_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal ROM : rom_type := (
"0000",
"0001",
"0010",
"0011",
"0100",
"0101",
"0110",
"0111",
"1000",
"1001",
"1010",
"1011",
"1100",
"1101",
"1110",
"1111"
);

begin

READ_ROM:process(CLK,RST)
  begin
    if (CLK' event and CLK='1') then
        if (RST ='1') then
            DATA <= ROM(conv_integer("0000"));
            FLAGWRITE<='0';
        end if;
        if (READ ='1' ) then
            DATA <= ROM(conv_integer(ADDR));
	        FLAGWRITE<='1';
	    else
	       FLAGWRITE<='0';
       end if; 
   end if; 
 end process;
end rtl;
