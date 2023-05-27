library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rx_seriale is
    Port ( 
        Data_in: in std_logic;
        
        ReqA: in std_logic;
        okB: out std_logic;
        
        Clock: in std_logic;
        reset: in std_logic
);
end Rx_seriale;

architecture Behavioral of Rx_seriale is

component UC_B is
    Port (    
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        
        ReqA: in std_logic;
        OkA: out std_logic := '0';
        
        --segnali controllo parte operativa
        EnRx: out std_logic;
        sel:  out std_logic;
        res:  in std_logic;
        en_write: out std_logic;
        val_out:  out std_logic_vector(1 downto 0)      
    );
end component;

component shift_register is
generic(
    data_len: natural := 23
);
port (
  i_clk          : in  std_logic;
  i_rstb         : in  std_logic;
  i_data         : in  std_logic;
  i_data_par     : in std_logic_vector(data_len downto 0);
  o_data_par         : out std_logic_vector(data_len downto 0);
  o_data_ser         : out std_logic;
  enable_read        : in std_logic;
  enable_sh          : in std_logic
);
end component;

component comparatore is
generic(N:natural:=4);
    Port (
        input_1 : in std_logic_vector(N-1 downto 0);
        input_2 : in std_logic_vector(N-1 downto 0);
        output : out std_logic --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end component;

component mux_21_gen is
    generic (
        N: natural:= 8
    );
    Port ( 
        a0, a1: in std_logic_vector(N-1 downto 0);
        s: in std_logic;
        y: out std_logic_vector(N-1 downto 0)
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
		  cnt:        in STD_LOGIC;
		  InData:     in std_logic_vector(DataLen downto 0);
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end component;

signal o_data_par: std_logic_vector(23 downto 0);
signal enableh_sh: std_logic;
signal o_data_ser: std_logic;
signal res: std_logic;
signal en_write: std_logic;
signal val_out: std_logic_vector(1 downto 0);
signal o_data_sel: std_logic_vector(7 downto 0);
signal sel: std_logic;
signal OutData: std_logic_vector(1 downto 0);

begin

UC: UC_B
port map(
        ClockB => Clock,
        ResetB => reset,
        
        ReqA => ReqA,
        OkA  => okB,
        
        --segnali controllo parte operativa
        EnRx => enableh_sh,
        res  =>  res,
        sel  => sel,
        en_write =>  en_write,
        val_out  =>  val_out
);

SH: shift_register
generic map(
    data_len => 23
)
port map (
  i_clk        => Clock,
  i_rstb       => reset, 
  i_data       => Data_in,
  i_data_par   => (others => '0'),
  o_data_par   => o_data_par, 
  o_data_ser   => o_data_ser,
  enable_read  => '0',
  enable_sh    => enableh_sh
);

CMP: comparatore 
generic map ( 
        N => 8
)
Port map (
        input_1 => o_data_par(7 downto 0),
        input_2 => o_data_sel,
        output  => res
);

MUX:  mux_21_gen 
generic map (
        N => 8
)
Port map( 
        a0 => o_data_par(15 downto 8),
        a1 => o_data_par(23 downto 16),
        s  => sel,
        y  => o_data_sel
);

MEM: L_MEM_RW 
generic map(
            DataLen => 1
)
Port map (
		  ClkIn    => Clock,
		  RstIn    => reset,
		  EnRead   => '0',
		  EnWrite  => en_write,
		  cnt      => en_write,
		  InData   => val_out,
		  OutData  => OutData
);

end Behavioral;
