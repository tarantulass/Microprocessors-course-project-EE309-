library ieee;
use ieee.std_logic_1164.all;

entity DMem_A2_MUX is
	port(PE_Add : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_A2_out: out std_logic_vector(15 downto 0));
end DMem_A2_MUX;

architecture utk of DMem_A2_MUX is

	begin
		
		process(opcode)
			begin
			case opcode is
			when "0101" => --SW
				DMem_A2_out <= ALU_3_c;
			when "0111" => -- SM
				DMem_A2_out <= PE_add;
			when others => --??Ideally should not exist
				DMem_A2_out <= ALU_3_c;
			end case;			
			
		end process;
		
end utk;