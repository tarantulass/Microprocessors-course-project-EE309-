library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity D_MEM is
port ( clk, DMem_en : in std_logic;
       DM_a1: in std_logic_vector(15 downto 0);
		 DM_a2: in std_logic_vector(15 downto 0);
		 DM_d2: in std_logic_vector(15 downto 0);
		 DM_d1: out std_logic_vector(15 downto 0));
		 
end entity D_MEM;

Architecture behold of D_MEM is

type reg_type is array (0 to 7 ) of std_logic_vector (15 downto 0);

signal reg_array: reg_type;

begin 

process(clk)
begin

if (rising_edge(clk)) then

if (DMem_en = '1') then

reg_array(to_integer(unsigned(DM_a2))) <= DM_d2;

end if;
end if;

end process;

DM_d1 <= reg_array(to_integer(unsigned(DM_a1)));

end behold;

		 