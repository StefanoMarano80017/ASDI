LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Shift_Register_Beahv_TB IS
END Shift_Register_Beahv_TB;
 
ARCHITECTURE behavior OF Shift_Register_Beahv_TB IS 
 
 
    COMPONENT ShiftRegister
    PORT(
        
		clk : in std_logic;
		rst : in std_logic;
		xDati: in std_logic_vector (0 to 3);--dato in input parallelo
		load: in std_logic;
		shift: in std_logic;
		y: out std_logic_vector (0 to 3);
		ySerial: out std_logic:='0'
        );
    END COMPONENT;
    

   --Inputs
   signal Shift : std_logic := '0';
   signal Clk : std_logic := '0';
   signal EnParall : std_logic := '0';
   signal InputPar : std_logic_vector (0 to 3);
   signal Rst : std_logic := '0';
   signal InputSer : std_logic := '0';
   signal Stato : std_logic := '0';
 	--Outputs
   signal Uscita : std_logic_vector(0 to 3);
   signal ySerial:  std_logic:='0';
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftRegister PORT MAP (
          xDati=>InputPar,
          load => EnParall,
          shift => Shift,
          clk => Clk,
          rst => Rst,
          y => Uscita,
          ySerial =>ySerial
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      	
		
		
	
		--SHIFT A Sinistra una posizione per volta
		--Shift<='1';
	--	Stato<='0';
	
		--SHIFT A Sinistra due posizione per volta
		
      --  Shift<='1';
	--	Stato<='1';
      
        
        --SHIFT A Destra una posizione per volta
		
       -- Shift<='0';
	--	Stato<='0';
       
		 --SHIFT A Destra due posizione per volta
		
       
        --Shift<='0';
	--	Stato<='1';
        
        
       
        --Abilito inserimento in parallelo 
        EnParall<='1';
        InputPar<="0001";
        wait for 10ns;
        EnParall<='0';
        Shift<='1';
        wait for 10ns;
        Shift<='0';
        
        wait for 10ns;
        Shift<='1';
        wait for 10ns;
        Shift<='0';
        
        wait for 10ns;
        Shift<='1';
        wait for 10ns;
        Shift<='0';
        
        
        
        wait for 10ns;
        Shift<='1';
        wait for 10ns;
        Shift<='0';
        
        
        wait for 10ns;
        Shift<='1';
        wait for 10ns;
        Shift<='0';
      wait;
   end process;

END;
