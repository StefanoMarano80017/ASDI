library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bit_Comparator is
    port( 
        a,b,i_gt,i_eq,i_lt: in std_logic;
        a_lt_b, a_eq_b, a_gt_b: out std_logic 
);
end bit_Comparator;
architecture behavior of bit_Comparator is
begin
a_lt_b <= (i_lt and (not a)) or (i_lt and b) or ((not a) and b);
a_eq_b <= (i_eq and a and b) or (i_eq and (not a) and (not b));
a_gt_b <= (i_gt and a) or (i_gt and (not b)) or (a and (not b));
end behavior;