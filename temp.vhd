library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Temp is 
port ( clk, temp_w_en : in std_logic;
       t_in : in std_logic_vector(15 downto 0);
		 t_out : out std_logic_vector(15 downto 0));
end entity Temp;

architecture beeha of temp is

signal reg : std_logic_vector(15 downto 0) := x"0000";

begin

process(clk)
begin

if rising_edge(clk) then
if (temp_w_en = '1') then

reg <= t_in;

end if;
end if;

end process;

t_out <= reg;

end beeha;
		 