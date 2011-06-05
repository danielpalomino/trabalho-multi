LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multi_matricial IS
    PORT (	clk,reset: IN STD_LOGIC;
				reg_operando0,reg_operando1: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				reg_produto: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END multi_matricial;

ARCHITECTURE comportamento OF multi_matricial IS

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

BEGIN

PROCESS (clk, reset)
BEGIN
	IF reset='0' THEN
		operando0 <= (OTHERS=>'0');
		operando1 <= (OTHERS=>'0');
		reg_produto <= (OTHERS=>'0');
	ELSIF clk'EVENT AND clk='1' THEN
		operando0 <= reg_operando0;
		operando1 <= reg_operando1;
		reg_produto <= produto;
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
a => operando0(1) & operando0(1) & operando0(1) & operando0(1),
b => operando1,
sum_IN => carry_OUT_0 & sum_OUT_0(3) & sum_OUT_0(2) & sum_OUT_0(1),
carry_IN => '0',
carry_OUT => carry_OUT_1,
sum_OUT => sum_OUT_1
);

multiROW_2: multiROW PORT MAP(
a => operando0(2) & operando0(2) & operando0(2) & operando0(2),
b => operando1,
sum_IN => carry_OUT_1 & sum_OUT_1(3) & sum_OUT_1(2) & sum_OUT_1(1),
carry_IN => '0',
carry_OUT => carry_OUT_2,
sum_OUT => sum_OUT_2
);

multiROW_3: multiROW PORT MAP(
a => operando0(3) & operando0(3) & operando0(3) & operando0(3),
b => operando1,
sum_IN => carry_OUT_2 & sum_OUT_2(3) & sum_OUT_2(2) & sum_OUT_2(1),
carry_IN => '0',
carry_OUT => carry_OUT_3,
sum_OUT => sum_OUT_3
);

produto(0) <= sum_OUT_0(0);
produto(1) <= sum_OUT_1(0);
produto(2) <= sum_OUT_2(0);
produto(3) <= sum_OUT_3(0);
produto(4) <= sum_OUT_3(1);
produto(5) <= sum_OUT_3(2);
produto(6) <= sum_OUT_3(3);
produto(7) <= carry_OUT_3;
   
END comportamento;