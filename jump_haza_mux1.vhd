library ieee;
use ieee.std_logic_1164.all;

entity jump_haza_mux1 is
	port(
			S : in std_logic;
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		   V: out std_logic);
end jump_haza_mux1;

architecture utk of jump_haza_mux1 is

	begin
		
		process(opcode_rr_ex,S) 
		
		begin
				if(opcode_rr_ex="1000") or (opcode_rr_ex = "1001") or (opcode_rr_ex = "1010") then--BEQ
					if(S='1') then
						V<='0';
					else
						V<='1';
					end if;
				elsif(opcode_rr_ex="1100" or opcode_rr_ex="1111") then -- JAL/JRI
					V<='0';
				else v<= '1';
				end if;
		end process;
		
end utk;