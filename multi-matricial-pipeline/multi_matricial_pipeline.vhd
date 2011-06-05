LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multi_matricial_pipeline IS
    PORT (	clk,reset: IN STD_LOGIC;
				reg_operando0,reg_operando1: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				reg_produto: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END multi_matricial_pipeline;

ARCHITECTURE comportamento OF multi_matricial_pipeline IS

COMPONENT multiROW IS
    PORT (	a,b,sum_IN: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
				carry_IN: IN STD_LOGIC;
				carry_OUT: OUT STD_LOGIC;
				sum_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
END COMPONENT;

SIGNAL operando0,operando1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL produto: STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL carry_OUT_0, carry_OUT_1, carry_OUT_2, carry_OUT_3: STD_LOGIC;
SIGNAL sum_OUT_0, sum_OUT_1, sum_OUT_2, sum_OUT_3: STD_LOGIC_VECTOR(3 DOWNTO 0);

--estgios de pipeline
SIGNAL reg_b1, reg_b2, reg_b3: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL reg_a1: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL reg_a2: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL reg_a3: STD_LOGIC;
SIGNAL reg_p0: STD_LOGIC;
SIGNAL reg_p1: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL reg_p2: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL reg_sum_OUT0, reg_sum_OUT1, reg_sum_OUT2: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

PROCESS (clk, reset)
BEGIN
	IF reset='0' THEN
		operando0 <= (OTHERS=>'0');
		operando1 <= (OTHERS=>'0');
		reg_produto <= (OTHERS=>'0');
		
		reg_a1 <= (OTHERS=>'0');
		reg_a2 <= (OTHERS=>'0');
		reg_a3 <= '0';
		reg_b1 <= (OTHERS=>'0');
		reg_b2 <= (OTHERS=>'0');
		reg_b3 <= (OTHERS=>'0');
		reg_p0 <= '0';
		reg_p1 <= (OTHERS=>'0');
		reg_p2 <= (OTHERS=>'0');
		
		reg_sum_OUT0 <= (OTHERS=>'0');
		reg_sum_OUT1 <= (OTHERS=>'0');
		reg_sum_OUT2 <= (OTHERS=>'0');
	ELSIF clk'EVENT AND clk='1' THEN
		operando0 <= reg_operando0;
		operando1 <= reg_operando1;
		reg_produto <= produto;
		
		reg_a1 <= operando0(3 DOWNTO 1);
		reg_a2 <= reg_a1(2 DOWNTO 1);
		reg_a3 <= reg_a2(1);
		reg_b1 <= operando1;
		reg_b2 <= reg_b1;
		reg_b3 <= reg_b2;
		reg_p0 <= sum_OUT_0(0);
		reg_p1 <= sum_OUT_1(0) & reg_p0;
		reg_p2 <= sum_OUT_2(0) & reg_p1;
		
		reg_sum_OUT0 <= carry_OUT_0 & sum_OUT_0(3 DOWNTO 1);
		reg_sum_OUT1 <= carry_OUT_1 & sum_OUT_1(3 DOWNTO 1);
		reg_sum_OUT2 <= carry_OUT_2 & sum_OUT_2(3 DOWNTO 1);
	END IF;
END PROCESS;

multiROW_0: multiROW PORT MAP(
a => operando0(0) & operando0(0) & operando0(0) & operando0(0),
b => operando1,
sum_IN => "0000",
carry_IN => '0',
carry_OUT => carry_OUT_0,
sum_OUT => sum_OUT_0
);

multiROW_1: multiROW PORT MAP(
a => reg_a1(0) & reg_a1(0) & reg_a1(0) & reg_a1(0),
b => reg_b1,
sum_IN => reg_sum_OUT0,
carry_IN => '0',
carry_OUT => carry_OUT_1,
sum_OUT => sum_OUT_1
);

multiROW_2: multiROW PORT MAP(
a => reg_a2(0) & reg_a2(0) & reg_a2(0) & reg_a2(0),
b => reg_b2,
sum_IN => reg_sum_OUT1,
carry_IN => '0',
carry_OUT => carry_OUT_2,
sum_OUT => sum_OUT_2
);

multiROW_3: multiROW PORT MAP(
a => reg_a3 & reg_a3 & reg_a3 & reg_a3,
b => reg_b3,
sum_IN => reg_sum_OUT2,
carry_IN => '0',
carry_OUT => carry_OUT_3,
sum_OUT => sum_OUT_3
);

produto(0) <= reg_p2(0);
produto(1) <= reg_p2(1);
produto(2) <= reg_p2(2);
produto(3) <= sum_OUT_3(0);
produto(4) <= sum_OUT_3(1);
produto(5) <= sum_OUT_3(2);
produto(6) <= sum_OUT_3(3);
produto(7) <= carry_OUT_3;
   
END comportamento;