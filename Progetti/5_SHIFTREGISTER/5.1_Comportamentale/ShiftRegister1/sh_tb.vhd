library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity shift_register_tb is
end;

architecture bench of shift_register_tb is

  component shift_register
  generic(
      data_len: natural := 23
  );
  port (
    i_clk          : in  std_logic;
    i_rstb         : in  std_logic;
    i_data         : in  std_logic;
    o_data_par         : out std_logic_vector(data_len downto 0);
    o_data_ser         : out std_logic;
    enable_sh          : in std_logic
  );
  end component;

  signal i_clk: std_logic;
  signal i_rstb: std_logic;
  signal i_data: std_logic;
  signal o_data_par: std_logic_vector(23 downto 0);
  signal o_data_ser: std_logic;
  signal enable_sh: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: shift_register generic map ( data_len   => 23 )
                         port map ( i_clk      => i_clk,
                                    i_rstb     => i_rstb,
                                    i_data     => i_data,
                                    o_data_par => o_data_par,
                                    o_data_ser => o_data_ser,
                                    enable_sh  => enable_sh );

  stimulus: process
  begin
  
    -- Put initialisation code here
    enable_sh <= '1';
    i_data <= '0';
    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
    while True loop
      i_clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;