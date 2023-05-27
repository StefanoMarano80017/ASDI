library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlopT is
    Port ( 
            clk :in std_logic;
            rst :in std_logic;
            y :out std_logic
    );
end FlipFlopT;

architecture rtl of FlipFlopT is
    signal ty: std_logic;
begin
    fft:process(clk,rst)
        begin
             if(rst ='1') then
                ty <= '0';
             elsif(clk'event and clk='0')then
                ty <= not ty;
             end if;
    end process;
    y <=  ty;
end rtl;
