library ieee;
use ieee.std_logic_1164.all;
entity shift_register is
generic(
    data_len: natural := 23
);
port (
  i_clk          : in  std_logic;
  i_rstb         : in  std_logic;
  i_data         : in  std_logic;
  i_data_par     : in  std_logic_vector(data_len downto 0);
  o_data_par         : out std_logic_vector(data_len downto 0);
  o_data_ser         : out std_logic;
  enable_read        : in std_logic;
  enable_sh          : in std_logic
);
end shift_register;

architecture rtl of shift_register is
signal r_data   : std_logic_vector(data_len downto 0) := "000000000000000000000000";
begin

p_sreg : process(i_clk, i_rstb)
begin

  if(i_rstb='0') then
    r_data <= (others => '0');
  elsif(i_clk'event and i_clk = '0') then
    if enable_sh = '1' then 
        r_data    <= r_data(data_len-1 downto 0) & i_data;
    elsif (enable_read = '1') then
        r_data    <= i_data_par;
    end if;
  end if;
  
  o_data_par  <= r_data;
  o_data_ser  <= r_data(data_len);
 
end process p_sreg;
end rtl;