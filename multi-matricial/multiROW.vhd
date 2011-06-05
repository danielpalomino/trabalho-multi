LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multiROW IS
    PORT (	a,b,sum_IN: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
				carry_IN: IN STD_LOGIC;
				carry_OUT: OUT STD_LOGIC;
				sum_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
END multiROW;

ARCHITECTURE comportamento OF multiROW IS

COMPONENT multiBIT IS
    PORT (	a,b,sum_IN, carry_IN: IN STD_LOGIC;
				sum_OUT, carry_OUT: OUT STD_LOGIC
			);
END COMPONENT;

SIGNAL carry_OUT_0, carry_OUT_1, carry_OUT_2: STD_LOGIC;

BEGIN

multiBIT_0: multiBIT PORT MAP (
a => a(0),
b => b(0),
sum_IN => sum_IN(0),
carry_IN => carry_IN,
sum_OUT => sum_OUT(0),
carry_OUT => carry_OUT_0
 );
 
 multiBIT_1: multiBIT PORT MAP (
a => a(1),
b => b(1),
sum_IN => sum_IN(1),
carry_IN => carry_OUT_0,
sum_OUT => sum_OUT(1),
carry_OUT => carry_OUT_1
 );
 
multiBIT_2: multiBIT PORT MAP (
a => a(2),
b => b(2),
sum_IN => sum_IN(2),
carry_IN => carry_OUT_1,
sum_OUT => sum_OUT(2),
carry_OUT => carry_OUT_2
 );
 
 multiBIT_3: multiBIT PORT MAP (
a => a(3),
b => b(3),
sum_IN => sum_IN(3),
carry_IN => carry_OUT_2,
sum_OUT => sum_OUT(3),
carry_OUT => carry_OUT
 );

END comportamento;