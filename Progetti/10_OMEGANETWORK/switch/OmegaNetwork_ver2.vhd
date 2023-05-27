library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity OmegaNetwork_ver2 is
    generic (
        N: natural:= 2
    );
    Port ( 
        xi0, xi1, xi2, xi3, xi4, xi5, xi6, xi7: in std_logic_vector(N-1 downto 0);
        src, dst: in std_logic_vector(N-1 downto 0);
        yu0, yu1, yu2, yu3, yu4, yu5, yu6, yu7: out std_logic_vector(N-1 downto 0)
    );
end OmegaNetwork_ver2;

architecture structural of OmegaNetwork_ver2 is
     component switch is 
        generic(
            N: natural:= 2
        ); 
        port(
            A0, A1: in std_logic_vector(N-1 downto 0);
            B0, B1: out std_logic_vector(N-1 downto 0);
            SRC: in std_logic;
            DST: in std_logic
        );     
    end component;
    
    signal k0, k1, k2, k3, k4, k5, k6, k7: std_logic_vector(N-1 downto 0);

begin

    sw1: switch generic map(N)
        port map(
            A0 => xi0, 
            A1 => xi1,
            B0 => k0,
            B1 => k1,
            SRC => src(1),
            DST => dst(1)
        );
    sw2: switch generic map(N)
        port map(
            A0 => xi2, 
            A1 => xi3,
            B0 => k2,
            B1 => k3,
            SRC => src(1),
            DST => dst(1)
        );
    sw3: switch generic map(N)
        port map(
            A0 => xi4, 
            A1 => xi5,
            B0 => k4,
            B1 => k5,
            SRC => src(1),
            DST => dst(1)
        );
    sw4: switch generic map(N)
        port map(
            A0 => xi6, 
            A1 => xi7,
            B0 => k6,
            B1 => k7,
            SRC => src(1),
            DST => dst(1)
        );
        
    sw5: switch generic map(N)
        port map(
            A0 => k0, 
            A1 => k2,
            B0 => yu0,
            B1 => yu1,
            SRC => src(0),
            DST => dst(0)
        );
    sw6: switch generic map(N)
        port map(
            A0 => k1, 
            A1 => k3,
            B0 => yu2,
            B1 => yu3,
            SRC => src(0),
            DST => dst(0)
        );
    sw7: switch generic map(N)
        port map(
            A0 => k4, 
            A1 => k6,
            B0 => yu4,
            B1 => yu5,
            SRC => src(0),
            DST => dst(0)
        );
    sw8: switch generic map(N)
        port map(
            A0 => k5, 
            A1 => k7,
            B0 => yu6,
            B1 => yu7,
            SRC => src(0),
            DST => dst(0)
        );
end structural;
