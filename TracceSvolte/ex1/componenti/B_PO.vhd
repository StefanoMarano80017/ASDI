library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B_PO is
Port ( 
    Clock:   in std_logic;
    Reset:   in std_logic;
    
    Data_in: in std_logic_vector(4 downto 0);
    EnRic:   in std_logic;
    ReadRic: in std_logic;
    cnt:     in std_logic;
    wrt:     in std_logic
);
end B_PO;

architecture Behavioral of B_PO is

component Registro is
   generic(
            N: natural:= 4
   );
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

component demux_12_gen is
    generic(
        N: natural:= 2
    );
    Port ( 
        y: in std_logic_vector(N downto 0);
        s: in std_logic;
        a0, a1: out std_logic_vector(N downto 0)
    );
end component;

component Parity is
Port ( 
    Data: in std_logic_vector(3 downto 0);
    par:  in std_logic;
    out_par: out std_logic
);
end component;

component L_MEM_RW is
    generic(
            DataLen: natural :=3
            );
    Port(
		  ClkIn:      in  STD_LOGIC;
		  RstIn:      in  STD_LOGIC;
		  EnRead:     in  STD_LOGIC;
		  EnWrite:    in  STD_LOGIC;
		  EndRead:    out STD_LOGIC := '0';
		  cnt:        in STD_LOGIC;
		  InData:     in std_logic_vector(DataLen downto 0);
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end component;

signal demux_in: std_logic_vector(5 downto 0);

signal out_reg: std_logic_vector(4 downto 0);
signal out_par: std_logic;
signal par: std_logic;
signal mem_in_1: std_logic_vector(5 downto 0);
signal mem_in_2: std_logic_vector(5 downto 0);

---placeholder
signal stop_mem: std_logic;
signal out_mem:  std_logic_vector(3 downto 0);

begin

REG: Registro
port map(
        ClockRx     => Clock, 
        ResetRx     => Reset,
		InRx        => Data_in,
		WriteRx     => EnRic,
		ReadRx      => ReadRic,
		OutRx       => out_reg
);

demux_in <= out_reg(4 downto 1) & wrt & cnt;

DEMUX: demux_12_gen
generic map(
    N => 5
)
port map(
    y   => demux_in,
    s   => out_par,
    a0  => mem_in_1,
    a1  => mem_in_2
);

Cpar: parity
port map(
    Data    => out_reg(4 downto 1),
    par     => out_reg(0),
    out_par => out_par
);

MEM1: L_MEM_RW
port map(
          ClkIn      => Clock,
		  RstIn      => Reset, 
		  EnRead     => '0',
		  EnWrite    => mem_in_1(1),
		  EndRead    => stop_mem,
		  cnt        => mem_in_1(0),
		  InData     => mem_in_1(5 downto 2),
		  OutData    => out_mem
);

MEM2: L_MEM_RW
port map(
          ClkIn      => Clock,
		  RstIn      => Reset, 
		  EnRead     => '0',
		  EnWrite    => mem_in_2(1),
		  EndRead    => stop_mem,
		  cnt        => mem_in_2(0),
		  InData     => mem_in_2(5 downto 2),
		  OutData    => out_mem
);

end Behavioral;