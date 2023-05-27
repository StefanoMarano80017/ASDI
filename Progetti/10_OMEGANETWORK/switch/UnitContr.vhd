library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UnitContr is
    generic(
        N: natural:= 6; --dimensione dati
        payload: natural:= 2;
        M: natural:= 2 -- dimensione indirizzi
    );
    
    port(
        x0, x1, x2, x3: in std_logic_vector(N-1 downto 0);
        enu0, enu1, enu2, enu3: in std_logic;
        s, d: out std_logic_vector(M-1 downto 0);
        yu0, yu1, yu2, yu3: out std_logic_vector(payload-1 downto 0)
    );
end UnitContr;

architecture structural of UnitContr is

    component Arbitro is 
        port(
            en0, en1, en2, en3: in std_logic;
            y: out std_logic_vector(1 downto 0)
        );
    end component;
    component mux_41_gen is
        generic(
            N: natural:= 2;
            M: natural:= 2
        );
        port(
            a0, a1, a2, a3: in std_logic_vector(N-1 downto 0);
            s: in std_logic_vector(M-1 downto 0);
            y: out std_logic_vector(N-1 downto 0)
        );
    end component;
    component demux_41_gen is
        generic(
            N: natural:= 6;
            M: natural:= 2
        );
        port(
            a0: in std_logic_vector(N-1 downto 0);
            s: in std_logic_vector(M-1 downto 0);
            y0, y1, y2, y3: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    signal k: std_logic_vector(M-1 downto 0);
    signal p: std_logic_vector(payload-1 downto 0);
    
    
begin

    mux: mux_41_gen 
    generic map(payload, M)
    port map(
        a0 => x0(1 downto 0), 
        a1 => x1(1 downto 0),
        a2 => x2(1 downto 0),
        a3 => x3(1 downto 0),
        s  => k,
        y  => p
    );
    
    demux: demux_41_gen 
    generic map(payload, M)
    port map(
        a0 => p,
        s  => k,
        y0 => yu0,
        y1 => yu1,
        y2 => yu2,
        y3 => yu3
    );
    
    arb: Arbitro 
    port map(
        en0 => enu0,
        en1 => enu1,
        en2 => enu2, 
        en3 => enu3,
        y => k
    );
    
        s <=    x0 (5 downto 4) when k ="00" else
                x1 (5 downto 4) when k ="01" else
                x2 (5 downto 4) when k ="10" else
                x3 (5 downto 4) when k ="11" else
                "--";
                
        d <= x0 (3 downto 2) when k ="00" else
             x1 (3 downto 2) when k ="01" else
             x2 (3 downto 2) when k ="10" else
             x3 (3 downto 2) when k ="11" else
                "--";
    
end structural;
