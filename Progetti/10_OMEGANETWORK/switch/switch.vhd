library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
    generic (
        N: natural:=2 --dimensione pacchetto
    );
    Port ( 
        A0, A1: in std_logic_vector(N-1 downto 0);
        B0, B1: out std_logic_vector(N-1 downto 0);
        SRC: in std_logic;
        DST: in std_logic
    );
end switch;
architecture structural of switch is

    component mux_21_gen is 
        generic(
            N: natural:= 2
        );
        port(
            a0, a1: in std_logic_vector(N-1 downto 0);
            s: in std_logic;
            Y: out std_logic_vector(N-1 downto 0)
        );
    end component;
    component demux_21_gen is
        generic(
            N: natural:= 2
        );
        port(
            y: in std_logic_vector( N-1 downto 0);
            s: in std_logic;
            a0, a1: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    signal k0: std_logic_vector (N-1 downto 0);
begin

    mux: mux_21_gen generic map(N)
        port map(
            a0 => A0,
            a1 => A1,
            s => SRC,
            y => k0
        );
    demux: demux_21_gen generic map(N)
        port map(
            y => k0,
            s => DST,
            a0 => B0,
            a1 => B1
        );
end structural;
