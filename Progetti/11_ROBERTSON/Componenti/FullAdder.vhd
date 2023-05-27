library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FullAdder is
   Port ( 
        a,b,c_in :in std_logic;
        s,c_out :out std_logic
  );
end FullAdder;

architecture dataflow of FullAdder is

begin
    s<=((a xor b) xor c_in);
    c_out <= ((a and b) or(c_in and (a xor b)));

end dataflow;
