library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Lw_haza_mux2 is 
port(X, Y, Z: in std_logic;
	  OPCODE_ID_RR, OPCODE_RR_EX, OPCODE_EX_MEM, OPCODE_MEM_WB: in std_logic_vector(3 downto 0);
	  stall_id_rr : out std_logic);
end entity;

architecture aba of Lw_haza_mux2 is

begin

--stall_if_id <= '0';

	process(X, Y, Z, OPCODE_ID_RR, OPCODE_RR_EX, OPCODE_EX_MEM, OPCODE_MEM_WB)
	
	begin
	
		if (X ='1') AND (OPCODE_ID_RR = "0100") then
			
			stall_id_rr <= '1';
			
		elsif (Y ='1') AND (OPCODE_RR_EX = "0100") then
			
			stall_id_rr <= '1';
			
		elsif (Z ='1') AND (OPCODE_EX_MEM = "0100") then
			
			stall_id_rr <= '1';
			
		else stall_id_rr <= '0';
			
		end if;
		
		if (OPCODE_MEM_WB = "0100") then
		
			stall_id_rr  <= '0';
			
		end if;
		
	--	if (OPCODE_IF_ID = "0110") or (OPCODE_IF_ID = "0111") then
		
		--	stall_if_id <= VO;
			
		--end if;
		
	end process;
	
end aba;