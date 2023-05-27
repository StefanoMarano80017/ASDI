
library ieee;
use ieee.std_logic_1164.all;

entity tb_CompByteSeriale is
end tb_CompByteSeriale;

architecture tb of tb_CompByteSeriale is

    component CompByteSeriale
        port (a      : in std_logic_vector (7 downto 0);
              b      : in std_logic_vector (7 downto 0);
              gt     : in std_logic:='0';
              eq     : in std_logic:='0';
              lt     : in std_logic:='0';
              a_gt_b : out std_logic:='0';
              a_eq_b : out std_logic:='0';
              a_lt_b : out std_logic:='0');
    end component;

    signal a      : std_logic_vector (7 downto 0);
    signal b      : std_logic_vector (7 downto 0);
    signal gt     : std_logic:='0';
    signal eq     : std_logic:='0';
    signal lt     : std_logic:='0';
    signal a_gt_b : std_logic:='0';
    signal a_eq_b : std_logic:='0';
    signal a_lt_b : std_logic:='0';

begin

    dut : CompByteSeriale
    port map (a      => a,
              b      => b,
              gt     => gt,
              eq     => eq,
              lt     => lt,
              a_gt_b => a_gt_b,
              a_eq_b => a_eq_b,
              a_lt_b => a_lt_b);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= (others => '1');
        b <= (others => '0');
        --gt<='1';
        
        
        wait for 20ns;
        
         b <= (others => '1');
         a <= (others => '0');
      
          wait for 20ns;
        
         b <= (others => '1');
         a <= (others => '1');
         eq<='1';
        wait for 20ns;
        eq<='0';
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
