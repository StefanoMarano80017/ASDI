LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY fifo_tb IS
END fifo_tb;

ARCHITECTURE behavior OF fifo_tb IS 
   --Inputs and outputs
   signal Clk,reset,enr,enw,empty,full : std_logic := '0';
   signal data_in,data_out : std_logic_vector(7 downto 0) := (others => '0');
    --temporary signals
    signal i : integer := 0;
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
    constant depth : integer := 16;  --specify depth of fifo here.

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: entity work.fifo generic map(depth => depth) PORT MAP (clk,reset,enr,enw,data_in,data_out,empty,full);

   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin        
        reset <= '1';  --apply reset for one clock cycle.
        wait for clk_period;
        reset <= '0';
        wait for clk_period*3;  --wait for 3 clock periods(simply)
        enw <= '1';     enr <= '0';         --write 10 values to fifo.
      for i in 1 to 10 loop  
            Data_In <= conv_std_logic_vector(i,8);
            wait for clk_period;
      end loop; 
        enw <= '0';     enr <= '1';         --read 4 values from fifo.
      wait for clk_period*4;
        enw <= '0';     enr <= '0'; 
        wait for clk_period*10;  --wait for some clock cycles.
        enw <= '1';     enr <= '0';         --write 10 values to fifo.
      for i in 11 to 20 loop  
            Data_In <= conv_std_logic_vector(i,8);
            wait for clk_period;
      end loop; 
        enw <= '0';     enr <= '0'; 
        wait for clk_period*10;  --wait for some clock cycles.
        enw <= '0';     enr <= '1';         --read 4 values from fifo.
      wait for clk_period*4;
        enw <= '0';     enr <= '0';
        wait for clk_period;
        enw <= '0';     enr <= '1';         --read 4 values from fifo.
      wait for clk_period*8;
        enw <= '0';     enr <= '0'; 
        wait for clk_period;
        enw <= '0';     enr <= '1';         --read 8 values from fifo.
      wait for clk_period*4;
        enw <= '0';     enr <= '0'; 
        wait for clk_period;
        enw <= '0';     enr <= '1';         --read 4 values from fifo.
      wait for clk_period*4;
        enw <= '0';     enr <= '0';     
        wait;
   end process;

END;