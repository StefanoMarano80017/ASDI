library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA is
  Port ( 
  
        ClockA : in  STD_LOGIC:='0';
		ResetA : in  STD_LOGIC:='0';
		StartA: in  STD_LOGIC:='0';
		OkB: in std_logic;
		ReqA: out std_logic;
		link_Tx_Rx:out  STD_LOGIC
  );
end NodoA;

architecture structural of NodoA is

component UC_A is
    Port ( 
        ClockA, ResetA: in std_logic;
		Start: in std_logic:='0';
		
		----handshake
		OkB: in std_logic;
		ReqA: out std_logic;
		
		----UART
		Tbe: in std_logic:='0';
		EnWr: out std_logic:='0';
		
		---MEM
		RD_mem: out std_logic;
		OutCont: out std_logic_vector(2 downto 0) := (others => '0')
);
end component;

component MemR is
generic(
        AddrLen: natural :=2;
        DataLen: natural :=7;
        NumberCells: natural :=7
);
port(
        CLK : in std_logic; 
                           
        READ : in std_logic;
                              
        ADDR : in std_logic_vector(AddrLen downto 0);    
        DATAOUT : out std_logic_vector(DataLen downto 0) 
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

signal OutFromRom :  std_logic_vector (7 downto 0):= (others => '0');
signal address :  std_logic_vector (2 downto 0):= (others => '0');
signal tbeTx,writeTx,rdaTx:std_logic:='0';
signal EN_RD: std_logic;

begin
	
UC: UC_A
port map(
        ClockA  => ClockA,
        ResetA  => ResetA,
		Start   => StartA,
		
		----handshake
		OkB     => OkB,
		ReqA    => ReqA,
		
		----UART
		Tbe   => tbeTx,
		EnWr  => writeTx,
		
		---MEM
		RD_mem  => EN_RD,
		OutCont => address

);	
		
UartTx:UARTcomponent 
	Generic map (
		
		--@26.6MHz
		BAUD_DIVIDE_G =>26,
		BAUD_RATE_G=>417
	)
	Port map (	
		TXD =>link_Tx_Rx,					-- Transmitted serial data output
		RXD =>'0',							-- Received serial data input
		CLK =>ClockA,							-- Clock signal
		DBIN =>OutFromRom,	-- Input parallel data to be transmitted
		DBOUT =>open,		-- Recevived parallel data output
		RDA	=>rdaTx,						-- Read Data Available
		TBE	=>tbeTx,					-- Transfer Buffer Emty
		RD=>'1',							-- Read Strobe
		WR=>writeTx,							-- Write Strobe
		RST	=>ResetA);				-- Reset signal
						
RomMem: MemR 
port map(
        CLK     => ClockA,
                           
        READ    => EN_RD,
                              
        ADDR    => address,
        DATAOUT => OutFromRom
    );


end structural;
