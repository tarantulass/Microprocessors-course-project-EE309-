library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ALU3_B_Mux is
port ( RF_D2, ALU2_C, SE_9, SE_6, ZE_1: in std_logic_vector(15 downto 0); 
       opcode: in std_logic_vector(3 downto 0); 
		 CCZ: in std_logic_vector(2 downto 0);
		 Mux_out : out std_logic_vector(15 downto 0));
end entity;

architecture bhiM of alu3_b_mux is

begin

process(opcode)
begin
if (opcode = "0100") or (opcode = "0101") or ((opcode = "0001") and (ccz(2) = '0')) then
Mux_out <= RF_D2;

elsif (opcode = "0001") and (ccz(2) = '1') then
Mux_out <= ZE_1;

elsif (opcode = "0000")  then
Mux_out <= SE_6 ;

elsif (opcode = "1111")  then
Mux_out <= SE_9 ;

elsif (opcode = "1000")  then
Mux_out <= ALU2_C;

end if;
end process;

end bhiM;