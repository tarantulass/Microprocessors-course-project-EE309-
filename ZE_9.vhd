library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity ZE_9 is
	port(
		A: in std_logic_vector(8 downto 0);
		B: out std_logic_vector(15 downto 0)
	);
end entity ZE_9;

architecture arch of ZE_9 is
	begin 
		B(15 downto 9) <= "0000000";
		B(8 downto 0) <= A;
end arch;
	