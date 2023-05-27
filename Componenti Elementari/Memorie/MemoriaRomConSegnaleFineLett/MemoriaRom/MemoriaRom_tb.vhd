library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MemoriaRom_tb is
end;

architecture bench of MemoriaRom_tb is

  component MemoriaRom
  Port(
  		  ClkIn : in  STD_LOGIC;
  		  RstIn : in  STD_LOGIC;
  		  ReadEn : in  STD_LOGIC;
  		  EndRead :out STD_LOGIC;
  		  OutData : out std_logic_vector(3 downto 0)
  			  );
  end component;

  signal Clock: STD_LOGIC;
  signal RstIn: STD_LOGIC;
  signal ReadEn: STD_LOGIC;
  signal EndRead: STD_LOGIC;
  signal OutData: std_logic_vector(3 downto 0) ;
  constant CLK_period: time := 10 ns;

begin

  uut: MemoriaRom port map ( ClkIn   => Clock,
                             RstIn   => RstIn,
                             ReadEn  => ReadEn,
                             EndRead => EndRead,
                             OutData => OutData );
                             
                             CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock  <= '1';
		wait for CLK_period/2;
   end process;

  stimulus: process
  begin
  
    -- Put initialisation code here
    ReadEn<='1';
    wait for 80ns;
    ReadEn<='0';
    RstIn<='1';
    wait for 10ns;
    RstIn<='0';
    ReadEn<='1';
    wait for 30ns;
    ReadEn<='0';
    wait for 10ns;
    RstIn<='1';
    wait for 10ns;
    RstIn<='0';
    ReadEn<='1';

    -- Put test bench stimulus code here

    wait;
  end process;


end;
