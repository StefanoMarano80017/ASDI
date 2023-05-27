library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity CompByteSeriale is
  generic(N:integer:=7);
   port ( 
        a, b :IN std_logic_vector(N DOWNTO 0); -- data inputs
        gt,eq,lt :IN std_logic:='0'; --  gt previous greater than -- eq previous equal --  lt previous less than
        a_gt_b,a_eq_b,a_lt_b :OUT std_logic:='0' --  a_gt_b---- a  b --  a_eq_b---- a = b   --  a_lt_b---   a  b
 ); 
end CompByteSeriale;
architecture structural of CompByteSeriale is
component Bit_Comparator is
   port( a, b, i_gt, i_eq, i_lt: in std_logic;
        a_lt_b, a_eq_b, a_gt_b :out std_logic ); 
end component;
CONSTANT k1: INTEGER := 3;---costante relativo ai tre segnali generati a_gt_b,a_eq_b,a_lt_b 
CONSTANT k: INTEGER := (N*k1)-1;

SIGNAL im : std_logic_vector( 0 TO k);
BEGIN
c0: Bit_Comparator PORT MAP( a(0), b(0), gt, eq, lt, im(0), im(1), im(2));

c1toN_1: FOR i IN 1 TO N-1 GENERATE
c: Bit_Comparator PORT MAP( a(i), b(i), im(i*k1-1), im(i*k1-2), im(i*k1-3),
im(i*k1), im(i*k1+1), im(i*k1+2) );

END GENERATE;

cN: bit_Comparator  PORT MAP( a(N), b(N), im(k), im(k-1), im(k-2),
a_lt_b,a_eq_b,a_gt_b );

end structural;
