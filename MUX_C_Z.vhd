library ieee;
use ieee.std_logic_1164.all;

entity MUX_C_Z is
	port(opcode: in std_logic_vector(3 downto 0);
	     con : in std_logic;
		  cz : in std_logic_vector(1 downto 0);
		  alu_1_carry : in std_logic;
		  alu_3_carry : in std_logic;
		  alu_1_zero  :  in std_logic;
		  alu_3_zero  : in std_logic;
		  c_out:  out std_logic;
		  z_out : out std_logic);
end MUX_C_Z;

architecture abab of MUX_C_Z is

	signal ada, adc, adz, awc, aca, acc, acz, acw, adi, ndu, ndc, ndz, ncu, ncc, ncz, lw: std_logic;

	begin
		
		ada <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and not(con) and not(cz(1)) and not(cz(0));
		
		adc <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and not(con) and not(cz(1)) and (cz(0));
		
		adz <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and not(con) and (cz(1)) and not(cz(0));
		
		awc <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and not(con) and (cz(1)) and (cz(0));
		
		aca <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and (con) and not(cz(1)) and not(cz(0));
		
		acc <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and (con) and not(cz(1)) and (cz(0));
		
		acz <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and (con) and (cz(1)) and not(cz(0));
		
		acw <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and (opcode(0)) and (con) and (cz(1)) and (cz(0));
		
		adi <= not(opcode(3)) and not(opcode(2))  and not(opcode(1)) and not(opcode(0));
		
		ndu <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and not(con) and not(cz(1)) and not(cz(0));
		
		ndc <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and not(con) and (cz(1)) and not(cz(0));
		
		ndz <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and not(con) and not(cz(1)) and (cz(0));
		
		ncu <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and (con) and not(cz(1)) and not(cz(0));
		
		ncc <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and (con) and (cz(1)) and not(cz(0));
		
		ncz <= not(opcode(3)) and not(opcode(2))  and (opcode(1)) and not(opcode(0)) and (con) and not(cz(1)) and (cz(0));
		
		lw <= not(opcode(3)) and (opcode(2))  and not(opcode(1)) and not(opcode(0));
		
		c_out <= (alu_1_carry and (aca or acc or acz )) or (alu_3_carry and (ada or adc or adz or awc or acw or adi));
		
		z_out <= (alu_1_zero and (aca or acc or acz or ndu or ndc or ncu or ncc or ncz or lw)) or (alu_3_zero and (ada or adc or adz or awc or acw or adi));
		
end abab;