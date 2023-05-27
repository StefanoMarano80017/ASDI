library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OmegaNetwork is
    generic(
        N: natural:= 6;
        payload: natural := 2;
        M: natural:= 2
    );
    Port ( 
        e0, e1, e2, e3: in std_logic;
        i0, i1, i2, i3: in std_logic_vector(N-1 downto 0);
        u0, u1, u2, u3: out std_logic_vector(payload-1 downto 0)
    );
end OmegaNetwork;

architecture Structural of OmegaNetwork is

    component UnitOP is 
        generic(
            N: natural:= 2;
            M: natural:= 2
        );
        Port ( 
            a0, a1, a2, a3 : in STD_LOGIC_VECTOR (N-1 downto 0);
            src: in std_logic_vector(M-1 downto 0);
            dst: in std_logic_vector(M-1 downto 0);
            b0, b1, b2, b3 : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component UnitContr is 
        generic(
            N: natural:= 6;
            payload: natural:= 2; 
            M: natural:= 2 
        );
        port(
            x0, x1, x2, x3: in std_logic_vector(N-1 downto 0);
            enu0, enu1, enu2, enu3: in std_logic;
            s, d: out std_logic_vector(M-1 downto 0);
            yu0, yu1, yu2, yu3: out std_logic_vector(payload-1 downto 0)
        );
    end component;
    signal k0, k1, k2, k3: std_logic_vector(payload-1 downto 0);
    signal SRC, DST: std_logic_vector(M-1 downto 0);
    
begin

    unit_controllo: UnitContr 
    generic map(6, 2, 2)
    port map(
        x0 => i0,
        x1 => i1,
        x2 => i2,
        x3 => i3,
        enu0 => e0,
        enu1 => e1,
        enu2 => e2, 
        enu3 => e3,
        yu0 => k0,
        yu1 => k1,
        yu2 => k2,
        yu3 => k3,
        s => SRC,
        d => DST
    );

    unit_operativa: UnitOP
    generic map(2, 2)
    port map(
        a0 => k0,
        a1 => k1,
        a2 => k2,
        a3 => k3,
        src => SRC,
        dst => DST,
        b0 => u0,
        b1 => u1,
        b2 => u2, 
        b3 => u3
    );
end Structural;
