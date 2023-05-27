library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
generic(
        AddrLen: natural :=2;
        DataLen: natural :=6;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
                       
    READ : in std_logic; 
                           
                           
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATA : out std_logic_vector(DataLen downto 0) 
    );
end ROM;
-- creo una ROM di NumberCells elementi da DataLen bit ciascuno
architecture rtl of ROM is 
type rom_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal ROM : rom_type := (
"0000000",
"0000011",
"0000010",
"0000101",
"0000100",
"0000111",
"0000110",
"0001001"
);

--attribute rom_style : string;
--attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT


begin


READ_ROM:process(CLK)
  begin
    if (CLK' event and CLK='0') then
        if (READ ='1') then
            DATA <= ROM(conv_integer(ADDR));
        
        else if (RST ='1' ) then
            DATA <= ROM(conv_integer("000"));
    
       -- else if(ADDR>"111") then   
       --     DATA <= "----";
       
       -- end if;     
        end if; 
        end if; 
    end if; 
       
end process;
end rtl;
