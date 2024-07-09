library ieee;
use ieee.std_logic_1164.all;

entity IP_MUX_2 is
	port(ALU_2_c : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  RF_D2   : in std_logic_vector(15 downto 0);
		  IP_MUX  : in std_logic_vector(15 downto 0);
		  IP : in std_logic_vector(15 downto 0);
		  VO : in std_logic;
		  opcode_if_id  : in std_logic_vector(3 downto 0);
		  opcode_id_rr  : in std_logic_vector(3 downto 0);
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		  IP_MUX2_out: out std_logic_vector(15 downto 0));
end IP_MUX_2;

architecture abab of IP_MUX_2 is

	begin
		
		process(opcode_id_rr,opcode_rr_ex, RF_D2, IP_MUX, ALU_3_C, ALU_2_c, IP, VO, opcode_if_id)
		
			begin
			
			if (opcode_id_rr = "1101") then
			
				IP_MUX2_OUT <= RF_D2;
				
			elsif (opcode_rr_ex = "1000") or (opcode_rr_ex = "1001") or (opcode_rr_ex = "1010") then
			
				IP_MUX2_OUT <= IP_MUX;
				
			elsif (opcode_rr_ex = "1100") or (opcode_rr_ex = "1111") then
			
				IP_MUX2_OUT <= ALU_3_C;
				
			elsif ((opcode_if_id = "0110") or (opcode_if_id = "0111")) and (VO = '1') then
			
				IP_MUX2_OUT <= IP;
				
			else IP_MUX2_OUT <= ALU_2_c;
		
			end if;			
			
		end process;
		
end abab;