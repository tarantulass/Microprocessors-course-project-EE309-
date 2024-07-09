library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF_A3 is
	port(opcode:IN std_logic_vector(3 downto 0);Imem_6_8,Imem_3_5,Imem_9_11,PE_out:IN std_logic_vector(2 downto 0)
	;RFA3:out std_logic_vector(2 downto 0));
end entity;

architecture struct of RF_A3 is
signal RF1,RF2,RF3,RF3_5,RF6_8,RF_PE,RF4,RF5,RF9_11:std_logic;

begin
RF1 <= not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0);
RF2 <= not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0));
RF3_5 <= RF1 or RF2;
RF6_8 <= not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and not(opcode(0));
RF_PE <= not(opcode(3)) and opcode(2) and opcode(1) and not(opcode(0));
RF4 <= not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0);
RF5 <= not(opcode(3)) and opcode(2) and not(opcode(1)) and not(opcode(0));
RF9_11 <= RF4 or RF5;

mux:process(opcode,PE_out,Imem_6_8,Imem_9_11,Imem_3_5)
begin
if RF_PE = '1' then 
	RFA3 <= PE_out;
elsif RF3_5 = '1' then
	RFA3 <= Imem_3_5;
elsif RF6_8 <= '1' then
	RFA3 <= Imem_6_8;
elsif RF9_11 <= '1' then
	RFA3 <= Imem_9_11;
else
	RFA3 <= "000";
end if;
end process mux;
end architecture struct;