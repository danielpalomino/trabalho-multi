LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multiBIT IS
    PORT (	a,b,sum_IN, carry_IN: IN STD_LOGIC;
				sum_OUT, carry_OUT: OUT STD_LOGIC
			);
END multiBIT;

ARCHITECTURE comportamento OF multiBIT IS

SIGNAL ab: STD_LOGIC;

BEGIN

ab <= a AND b;
sum_OUT <= (ab XOR sum_IN) XOR carry_IN;
carry_OUT <= (ab AND sum_IN) OR (ab AND carry_IN) OR (sum_IN AND carry_IN);

END comportamento;