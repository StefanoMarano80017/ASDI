library ieee;
use ieee.std_logic_1164.all;

entity tb_ring_buffer is
end tb_ring_buffer;

architecture tb of tb_ring_buffer is

    component ring_buffer
        port (clk        : in std_logic;
              rst        : in std_logic;
              wr_en      : in std_logic;
              wr_data    : in std_logic_vector (2 - 1 downto 0);
              rd_en      : in std_logic;
              rd_valid   : out std_logic;
              rd_data    : out std_logic_vector (2- 1 downto 0);
              empty      : out std_logic;
              empty_next : out std_logic;
              full       : out std_logic;
              full_next  : out std_logic;
              fill_count : out integer);
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal wr_en      : std_logic;
    signal wr_data    : std_logic_vector (2 - 1 downto 0);
    signal rd_en      : std_logic;
    signal rd_valid   : std_logic;
    signal rd_data    : std_logic_vector (2 - 1 downto 0);
    signal empty      : std_logic;
    signal empty_next : std_logic;
    signal full       : std_logic;
    signal full_next  : std_logic;
    signal fill_count : integer;
    constant CLK_period: time := 10 ns;

begin

    dut : ring_buffer
    port map (clk        => clk,
              rst        => rst,
              wr_en      => wr_en,
              wr_data    => wr_data,
              rd_en      => rd_en,
              rd_valid   => rd_valid,
              rd_data    => rd_data,
              empty      => empty,
              empty_next => empty_next,
              full       => full,
              full_next  => full_next,
              fill_count => fill_count);
              CLK_process :process
   begin
		clk <= '0';
		wait for CLK_period/2;
		clk  <= '1';
		wait for CLK_period/2;
   end process;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       
        wr_en <= '1';
        wr_data <= (others => '1');
        wait for 10ns;
        wr_en <= '0';
        wait for 10ns;
        wr_en <= '1';
        wr_data <= "10";
        wait for 10ns;
        wr_en <= '0';
        rd_en<='1';
        wait for 10ns;
        rd_en<='0';
        
         wait for 10ns;
       
        rd_en<='1';
        wait for 10ns;
        rd_en<='0';
        
         wr_en <= '1';
        wr_data <= (others => '1');
        wait for 10ns;
        wr_en <= '0';
        
        
         wr_en <= '1';
        wr_data <= (others => '0');
        wait for 10ns;
        wr_en <= '0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;