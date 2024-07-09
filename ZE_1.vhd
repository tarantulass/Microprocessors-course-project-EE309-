library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity ZE_1 is
	port(
		A: in std_logic;
		B: out std_logic_vector(15 downto 0)
	);
end entity ZE_1;

architecture arch of ZE_1 is
	begin 
		B(15 downto 1) <= "000000000000000";
		B(0) <= A;
end arch;
	