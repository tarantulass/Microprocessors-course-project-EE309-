library ieee;
use ieee.std_logic_1164.all;

entity DMem_D2_MUX is
	port(RF_D1 : in std_logic_vector(15 downto 0);
	     RF_D2 : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_D2_MUX: out std_logic_vector(15 downto 0));
end DMem_D2_MUX;

architecture utk of DMem_D2_MUX is

	begin
		
		process(opcode)
			begin
			case opcode is
			when "0101" => --SW
				DMem_D2_MUX <= RF_D1;
			when "0111" => -- SM
				DMem_D2_MUX <= RF_D2;
			when others => --??Ideally should not exist
				DMem_D2_MUX <= RF_D2;
			end case;			
			
		end process;
		
end utk;