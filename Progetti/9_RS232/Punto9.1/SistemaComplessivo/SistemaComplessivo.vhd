library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity SistemaComplessivo is
  generic (N:integer:=7);
  Port ( 
        CLOCK,RESET:in std_logic;
        SWITCH:in std_logic_vector(N downto 0);
        LEDS:out std_logic_vector(N downto 0);
        STARTWRITE:in std_logic:='0'
  );
end SistemaComplessivo;
architecture strucrtural of SistemaComplessivo is


signal OutFromA: std_logic_vector(N downto 0);
signal OutFromB: std_logic_vector(N downto 0);
signal UartIn: std_logic_vector(N downto 0);
signal UartOut: std_logic_vector(N downto 0);
signal linkTx_Rx: std_logic :='0';

component Nodo is
 generic( N:integer:=7);
  Port ( 
    Input :in std_logic_vector( N downto 0):=( others =>'0');
    Clock,Reset :in std_logic:='0';
    Uscita :out std_logic_vector( N downto 0):=( others =>'0')
  );
end component;


component UARTcomponent is
	Generic (
		--@48MHz
--		BAUD_DIVIDE_G : integer := 26; 	--115200 baud
--		BAUD_RATE_G   : integer := 417

		--@26.6MHz
		BAUD_DIVIDE_G : integer := 14; 	--115200 baud
		BAUD_RATE_G   : integer := 231
	);
	Port (	
		TXD 	: out 	std_logic  	:= '1';					-- Transmitted serial data output
		RXD 	: in  	std_logic;							-- Received serial data input
		CLK 	: in  	std_logic;							-- Clock signal
		DBIN 	: in  	std_logic_vector (7 downto 0);		-- Input parallel data to be transmitted
		DBOUT 	: out 	std_logic_vector (7 downto 0);		-- Recevived parallel data output
		RDA		: inout  std_logic;							-- Read Data Available
		TBE		: out 	std_logic 	:= '1';					-- Transfer Buffer Emty
		RD		: in  	std_logic;							-- Read Strobe
		WR		: in  	std_logic;							-- Write Strobe
		PE		: out 	std_logic;							-- Parity error		
		FE		: out 	std_logic;							-- Frame error
		OE		: out 	std_logic;							-- Overwrite error
		RST		: in  	std_logic	:= '0');				-- Reset signal
						
end component;






begin

NODO_A: Nodo 
     Port map ( 
    Input =>SWITCH,
    Clock=>CLOCK,
    Reset =>RESET,
    Uscita =>OutFromA
  );
Uart : UARTcomponent generic map(
			BAUD_DIVIDE_G => 14,
			BAUD_RATE_G  => 231
		) 
		
	Port map (	
		TXD =>linkTx_Rx,
		RXD =>linkTx_Rx,
		CLK=>CLOCK,							
		DBIN =>OutFromA,
		DBOUT =>UartOut,
		RDA	=>OPEN,
		TBE=>OPEN,
		RD=>'0',
		WR=>STARTWRITE,
	    RST=>RESET
	    );				
						


 NODO_B: Nodo
     Port map ( 
    Input =>UartOut,
    Clock=>CLOCK,
    Reset =>RESET,
    Uscita =>OutFromB
  );

LEDS<=OutFromB;
end strucrtural;
