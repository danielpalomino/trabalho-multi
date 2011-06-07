LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 

COMPONENT multi_matricial IS
    PORT (	clk,reset: IN STD_LOGIC;
				reg_operando0,reg_operando1: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				reg_produto: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END COMPONENT;


--Inputs
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal reg_operando0 : std_logic_vector(3 downto 0);
signal reg_operando1 : std_logic_vector(3 downto 0);

--Outputs
signal reg_produto : std_logic_vector(7 downto 0);

-- Clock period definitions
constant clk_period : time := 20ns;

BEGIN

-- Instantiate the Unit Under Test (UUT)
		uut: multi_matricial PORT MAP (
						clk => clk,
						reset => reset,
						reg_operando0 => reg_operando0,
						reg_operando1 => reg_operando1,
						reg_produto => reg_produto
						);

		-- Clock process definitions
		clk_process :process
		begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		end process;


		-- Stimulus process
		stim_proc: process
		begin		
		-- hold reset state for 100ms.
		reset <= '1';
		wait for 20ns;
		reset <= '0';

		-- insert stimulus here 
		
		reg_operando0 <= "0101";
		reg_operando1 <= "0101";

		wait;
		end process;

		END;

