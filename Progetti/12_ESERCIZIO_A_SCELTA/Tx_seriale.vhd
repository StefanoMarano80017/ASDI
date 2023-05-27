library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tx_seriale is
    port ( 
        Data_out: out std_logic;
        
        ReqA: out std_logic;
        okB: in std_logic;
        
        Clock: in std_logic;
        reset: in std_logic;
        
        StartA: in std_logic
    );
end Tx_seriale;

architecture Behavioral of Tx_seriale is

component UC_1 is 
    Port (    
        Clock: in std_logic;
        Reset: in std_logic := '0';
        
        StartA: in std_logic;
        ReqA: out std_logic;
        OkB: in std_logic := '0';
        
        --segnali controllo parte operativa
        rx: out std_logic;
        shift_value: out std_logic;
        enable_read: out std_logic;
        EN_RD:   out std_logic;
        stopMEM: in std_logic;
        cnt_mem: out std_logic
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
  i_data_par     : in  std_logic_vector(data_len downto 0);
  o_data_par         : out std_logic_vector(data_len downto 0);
  o_data_ser         : out std_logic;
  enable_read        : in std_logic;
  enable_sh          : in std_logic
);
end component;

component L_MEM_R is
    generic(
            DataLen: natural :=24
            );
    Port(
		  ClkIn:      in  STD_LOGIC;
		  RstIn:      in  STD_LOGIC;
		  EnRead:     in  STD_LOGIC;
		  cnt:        in STD_LOGIC;
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end component;


signal enable_sh: std_logic;
signal enable_read: std_logic;
signal i_data: std_logic;
signal Data_out_par: std_logic_vector(23 downto 0);
signal i_data_par: std_logic_vector(23 downto 0);

---Lettura rom
signal EN_RD: std_logic;
signal stopMEM: std_logic;
signal cnt_mem: std_logic;
begin

UC: UC_1
port map(
        Clock => Clock,
        Reset => reset,
        
        StartA => StartA,
        ReqA   => ReqA,
        OkB    => okB,
        
        --segnali controllo parte operativa
        rx          => enable_sh,
        enable_read => enable_read,
        shift_value => i_data, 
        EN_RD       => EN_RD,
        stopMEM     => stopMEM,
        cnt_mem     => cnt_mem
);

SR: shift_register
generic map(
    data_len => 23
)
port map (
  i_clk     => Clock,
  i_rstb    => reset,
  i_data    => i_data,
  i_data_par => i_data_par,
  o_data_par  => Data_out_par,
  o_data_ser  => Data_out,
  enable_read => enable_read,
  enable_sh   => enable_sh
);

MEM_R: L_MEM_R  
generic map(
            DataLen => 23
)
Port map (
		  ClkIn       => Clock,
		  RstIn       => reset,
		  EnRead      => EN_RD,
		  cnt         => cnt_mem,
		  OutData     => i_data_par
);

end Behavioral;