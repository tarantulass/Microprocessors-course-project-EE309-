library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 
--opcode rr/ex
entity branch_mux is
	port(opcode:IN std_logic_vector(3 downto 0);
	ALU1Cy,ALU1Z:IN std_logic;
	ALU3C,ALU2C: IN std_logic_vector(15 downto 0);
	IP_in:out std_logic_vector(15 downto 0);
	valid:out std_logic);
end entity;
--here alu1cy is alu1c(15)
architecture struct  of branch_mux is

signal beq,ble,blt:std_logic; 


begin

beq <= opcode(3) and not(opcode(2)) and not(opcode(1)) and not(opcode(0));
blt <= opcode(3) and not(opcode(2)) and not(opcode(1)) and opcode(0);
ble <= opcode(3) and not(opcode(2)) and opcode(1) and not(opcode(0));

branch:process(beq,ble,blt,ALU3C,ALU2C,ALU1Z,ALU1Cy)
begin
	if beq = '1' and ble = '0' and blt = '0' then
		if ALU1Z = '1' THEN
			IP_in <= ALU3C;
			valid <= '1';
		else 
			IP_in <= ALU2C;
			valid <= '0';
		end if;
		
	elsif beq = '0' and ble = '1' and blt = '0' then
		if ALU1Cy = '1' OR ALU1Z = '1' THEN
			IP_in <= ALU3C;
			valid <= '1';
		else 
			IP_in <= ALU2C;
			valid <= '1';
		end if;
		
	elsif beq = '0' and ble = '0' and blt = '1' then
		if ALU1Cy = '1' THEN
			IP_in <= ALU3C;
			valid <= '1';
		else 
			IP_in <= ALU2C;
			valid <= '1';
		end if;
	end if;
		
end process branch;

end architecture struct;