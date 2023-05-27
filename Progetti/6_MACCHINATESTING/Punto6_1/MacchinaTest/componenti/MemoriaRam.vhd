library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity MemoriaRam is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=2;
        NumberCells: natural :=15
);
   port
   (
       CLK: in std_logic;
	   WRITE: in std_logic;
	   RST: in std_logic;
	   DATAIN: in  std_logic_vector (DataLen DOWNTO 0);
	   DATAOUT: out  std_logic_vector (DataLen DOWNTO 0)
   );
END MemoriaRam;

ARCHITECTURE Behavioral OF MemoriaRam IS
   
	type ram_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
   	
	signal RAM : ram_type := (
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000",
"000"
);
	signal address : std_logic_vector (AddrLen DOWNTO 0) :=(others => '0');
    begin
    WRITE_MEM: Process (CLK)
        begin
          if (CLK'event AND CLK = '1') then
                if (WRITE = '1') then
                    RAM(conv_integer(address)) <= DATAIN;
                    DATAOUT<=DATAIN;
                    address <= std_logic_vector(unsigned(address) + 1);
                end if;
                if (RST ='1') then
                   RAM<= (others => (others => '0'));
                   address<=(others => '0');
                   DATAOUT<="000";
                end if;
         end if; 
        end process;
end Behavioral;
