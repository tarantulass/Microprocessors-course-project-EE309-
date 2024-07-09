library ieee;
use ieee.std_logic_1164.all;

entity DMem_A1_MUX is
	port(PE_Add : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_A1_out: out std_logic_vector(15 downto 0));
end DMem_A1_MUX;

architecture utk of DMem_A1_MUX is

	begin
		
		process(opcode)
			begin
			case opcode is
			when "0100" => --LW
				DMem_A1_out <= ALU_3_c;
			when "0110" => -- LM
				DMem_A1_out <= PE_add;
			when others => --??Ideally should not exist
				DMem_A1_out <= ALU_3_c;
			end case;			
			
		end process;
		
end utk;