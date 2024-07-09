library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity comp_type2 is 
port(Iword_9_11 , Iword2_9_11, Iword2_6_8 : in std_logic_vector(2 downto 0); y: out std_logic);
end entity comp_type2;

architecture Bhii of comp_type2 is 

begin

	process(Iword2_6_8,Iword_9_11,Iword2_9_11)
		begin

			if ( Iword_9_11 = Iword2_9_11 ) or (Iword_9_11 = Iword2_6_8) then
			y <= '1';

			else 
			y <= '0';

			end if;

	end process;

end bhii;

