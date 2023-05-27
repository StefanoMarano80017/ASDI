library ieee;
use ieee.std_logic_1164.all;

entity tb_MemoriaRam is
end tb_MemoriaRam;

architecture tb of tb_MemoriaRam is

    component MemoriaRam
        port (ClkIn    : in std_logic;
              RstIn    : in std_logic;
              WriteEn  : in std_logic;
              CountEn : in  STD_LOGIC;
              InData   : in std_logic_vector (3 downto 0);
              EndWrite : out std_logic);
    end component;

    signal ClkIn    : std_logic;
    signal RstIn    : std_logic;
    signal WriteEn  : std_logic;
    signal CountEn  : std_logic;
    signal InData   : std_logic_vector (3 downto 0);
    signal EndWrite : std_logic;
    constant CLK_period: time := 10 ns;

begin

    dut : MemoriaRam
    port map (ClkIn    => ClkIn,
              RstIn    => RstIn,
              WriteEn  => WriteEn,
            CountEn =>CountEn,
              InData   => InData,
              EndWrite => EndWrite);
CLK_process :process
   begin
		ClkIn <= '0';
		wait for CLK_period/2;
		ClkIn  <= '1';
		wait for CLK_period/2;
   end process;
    stimuli : process
    begin
        -- ins 10
        wait for 10ns;
        WriteEn <= '1';
        InData <= "1010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        
        
        -- ins 14
        wait for 10ns;
        WriteEn <= '1';
        InData <= "1110";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        -- ins 2
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        
        wait for 10ns;
        RstIn<='1';
        wait for 10ns;
        RstIn<='0';
        
        
        wait for 10ns;
        WriteEn <= '1';
        InData <= "0010";
        wait for 10ns;
        WriteEn <= '0';
        wait for 10ns;
        CountEn<='1';
        wait for 10ns;
        CountEn<='0';
        
        
         wait for 10ns;
        RstIn<='1';
        wait for 10ns;
        RstIn<='0';

        wait;
    end process;

end tb;
