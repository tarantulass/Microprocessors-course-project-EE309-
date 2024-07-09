	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	USE IEEE.numeric_std.all; 

	entity dflipflop is
	port( clk, D : in std_logic; Q : out std_logic);
	end entity;

	architecture Bee of dflipflop is

	begin 

	process(clk)
	begin
	if(rising_edge(clk)) then
	Q <= D;
	end if;

	end process;
	end  bee;
