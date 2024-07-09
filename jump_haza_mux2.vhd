library ieee;
use ieee.std_logic_1164.all;

entity jump_haza_mux2 is
	port(
			S : in std_logic;
		  opcode_id_rr  : in std_logic_vector(3 downto 0);
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		   V: out std_logic);
end jump_haza_mux2;

architecture utk of jump_haza_mux2 is

	begin
		
		process(opcode_id_rr,opcode_rr_ex,S) begin
				if(opcode_rr_ex="1000") or (opcode_rr_ex = "1001") or (opcode_rr_ex = "1010") then--BEQ
					if(S='1') then
						V<='0';
					else
						V<='1';
					end if;
				elsif(opcode_rr_ex="1100" or opcode_rr_ex="1111") then -- JAL/JRI
					V<='0';
				elsif(opcode_id_rr="1101") then      --JLR
					V<='0';
				else V<='1';
				end if;
		end process;
		
end utk;