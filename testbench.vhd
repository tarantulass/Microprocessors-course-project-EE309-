library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is

end entity;

architecture struct of testbench is

signal clock,clear:std_logic;

component main is
	port(clock,clear: in std_logic);
end component main;

begin 
clear <= '0';

test_main: main port map(clock,clear);

sim: process
begin
clock<='0';
wait for 10 ns;
clock<='1';
wait for 10 ns;
end process sim;

end architecture struct;
