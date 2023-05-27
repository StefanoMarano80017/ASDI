library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity MemRw is
generic(
        AddrLen: natural :=2;
        DataLen: natural :=3;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
                       
    READ : in std_logic;
    WRITE : in std_logic; 
                           
                           
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAIN : in std_logic_vector(DataLen downto 0);
    DATAOUT : out std_logic_vector(DataLen downto 0) 
    );
end MemRw;
-- creo una ROM di NumberCells elementi da DataLen bit ciascuno
architecture behavioural of MemRw is 
type rom_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal ROM : rom_type := (
"1111",
"1110",
"1100",
"1000",
"0100",
"0010",
"0001",
"1001"
);

--attribute rom_style : string;
--attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT

signal flag: td_logic :='0';
begin


WriteRead_ROM:process(CLK)
  begin
    if (CLK' event and CLK='0') then
        if (READ ='1' and flag='0') then
            DATAOUT <= ROM(conv_integer(ADDR));
	    flag<='1';
        
        else if (RST ='1' ) then
            DATAOUT <= ROM(conv_integer("000"));
	    flag<='0';
           
      else  if (WRITE ='1' and flag='1') then
             ROM(conv_integer(ADDR)) <=DATAIN;
	     flag<='0';
        end if;     
        end if; 
        end if; 
    end if; 
       
end process;
end behavioural;

