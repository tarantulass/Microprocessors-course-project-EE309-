library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ALU3_A_Mux is
port ( RF_D1, ALU1_C, SE_9, SE_6: in std_logic_vector(15 downto 0); 
       opcode: in std_logic_vector(3 downto 0); 
		 CCZ: in std_logic_vector(2 downto 0);
		 Mux_out : out std_logic_vector(15 downto 0));
end entity;

architecture bhiii of alu3_a_mux is

begin

process(opcode)
begin
if (opcode = "0100") or (opcode = "0101") or (opcode = "1000") or (opcode = "1001")   then
Mux_out <= SE_6;

elsif (opcode = "1100") then
Mux_out <= SE_9;

elsif (opcode = "1111") or ( (opcode = "0001") and ((CCZ ="000") or (CCZ ="010") or (CCZ = "001"))) or (opcode = "0000")  then
Mux_out <= RF_D1;

elsif (opcode = "0001") and ((CCZ= "011") or (CCZ ="111"))  then
Mux_out <= ALU1_C;

end if;
end process;

end bhiii;