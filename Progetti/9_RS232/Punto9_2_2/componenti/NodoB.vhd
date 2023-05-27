library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoB is
 Port (   
          ClockB : in  STD_LOGIC:='0';
		  ResetB : in  STD_LOGIC:='0';
		  Link_Rx_Tx : in  STD_LOGIC;
		  OkB: out std_logic;
		  reqA: in std_logic 
);
end NodoB;

architecture Structural of NodoB is

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


component MemRw is
    generic(
            AddrLen: natural :=2;
            DataLen: natural :=7;
            NumberCells: natural :=7
    );
    port(
        CLK : in std_logic; 
        RST : in std_logic; 
                           
        READ : in std_logic;
        WRITE : in std_logic; 
                              
        ADDR : in std_logic_vector(AddrLen downto 0);    
        DATAIN : in std_logic_vector(DataLen downto 0);
        DATAOUT : out std_logic_vector(DataLen downto 0) 
     );
end component;


component UC_B is
    Port ( 
        ClockB, ResetB: in std_logic;
		
		----handshake
		OkB: out std_logic;
		ReqA: in std_logic;
		
		----UART
		RDA: in std_logic:='0';
		EnRD: out std_logic:='0';
		OE, PE, FE: in std_logic;
		
		---MEM
		WR_mem: out std_logic;
		OutCont: out std_logic_vector(2 downto 0) := (others => '0')
);
end component;


signal OutFromRx:           std_logic_vector (7 DOWNTO 0);
signal rdaRx, tbeRx, rdRx:  std_logic := '0';
signal OE, PE, FE:          std_logic := '0';
signal WR_mem:            std_logic;
signal address:             std_logic_vector( 2 downto 0);

begin


UC: UC_B
port map(

        ClockB => ClockB,
        ResetB => ResetB,
		
		----handshake
		OkB => OkB,
		ReqA => ReqA,
		
		----UART
		RDA   => rdaRx,
		EnRD  => rdRx,
		OE    => OE,
		PE    => PE,
		FE    => FE,
		
		---MEM
		WR_mem   => WR_mem,
		OutCont  => address
);


Rx: UARTcomponent 
        Generic map (
            --@48MHz
            --		BAUD_DIVIDE_G : integer := 26; 	--115200 baud
            --		BAUD_RATE_G   : integer := 417
            
            --@26.6MHz
            BAUD_DIVIDE_G =>26,
            BAUD_RATE_G=>417
        )
        Port  map(	
            TXD         => open,					-- Transmitted serial data output
            RXD 	    => Link_Rx_Tx,							-- Received serial data input
            CLK 	    => ClockB,							-- Clock signal
            DBIN        => "00000000",	-- Input parallel data to be transmitted
            DBOUT 	    => OutFromRx,		-- Recevived parallel data output
            RDA	        => rdaRx,						-- Read Data Available
            TBE         => open,					-- Transfer Buffer Emty
            RD          => rdRx,							-- Read Strobe
            WR	        => '0',							-- Write Strob
            RST		    => ResetB,          -- Reset signal
            PE		    => PE,						-- Parity error		
		    FE		    => FE,							-- Frame error
		    OE		    => OE
);				
	
	
MEM: MemRw
port map(

        CLK     => ClockB,
        RST     => ResetB, 
                           
        READ    => '0',
        WRITE   => WR_mem,
                              
        ADDR    => address, 
        DATAIN  => OutFromRx,
        DATAOUT => open
);


end Structural;
