library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
    
entity UnitOp is
    generic(
         N: natural:= 2; --dimensione pacchetto
         M: natural:= 2 --dimensione indirizzamento
    );
    Port ( 
        a0, a1, a2, a3 : in STD_LOGIC_VECTOR (N-1 downto 0);
        src: in std_logic_vector(M-1 downto 0);
        dst: in std_logic_vector(M-1 downto 0);
        b0, b1, b2, b3 : out std_logic_vector(N-1 downto 0)
    );
end UnitOp;

architecture structural of UnitOp is
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
    signal k0, k1, k2, k3: std_logic_vector(N-1 downto 0);
    
begin
    sw1: switch generic map(N)
        port map(
            A0 => a0, 
            A1 => a1,
            B0 => k0,
            B1 => k1,
            SRC => src(0),
            DST => dst(1)
        );
    sw2: switch generic map(N)
        port map(
            A0 => a2, 
            A1 => a3,
            B0 => k2,
            B1 => k3,
            SRC => src(0),
            DST => dst(1)
        );
    sw3: switch generic map(N)
        port map(
            A0 => k0, 
            A1 => k2,
            B0 => b0,
            B1 => b1,
            SRC => src(1),
            DST => dst(0)
        );
    sw4: switch generic map(N)
        port map(
            A0 => k1, 
            A1 => k3,
            B0 => b2,
            B1 => b3,
            SRC => src(1),
            DST => dst(0)
        );
end structural;
