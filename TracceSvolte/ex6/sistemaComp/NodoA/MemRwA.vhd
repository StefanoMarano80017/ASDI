library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemRwA is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=5;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
                       
    READ : in std_logic; 
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAOUT : out std_logic_vector(DataLen downto 0) 
    );
end MemRwA;

-- creo una ROM di NumberCells elementi da DataLen bit ciascuno
architecture behavioural of MemRwA is 
type rom_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal ROM : rom_type := (
"111010",
"101011",
"110110",
"110101",
"111010",
"101001",
"101010",
"101010"
);

--attribute rom_style : string;
--attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT

begin
WriteRead_ROM:process(CLK)
begin

    if (CLK' event and CLK='0') then
        if (RST ='1' ) then
            DATAOUT <= ROM(conv_integer("0000"));
        elsif (READ ='1') then
            DATAOUT <= ROM(conv_integer(ADDR));   
        end if;     
    end if; 
       
end process;
end behavioural;