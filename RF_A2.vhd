library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF_A2 is
	port(opcode:IN std_logic_vector(3 downto 0);Imem_6_8,PE_out:IN std_logic_vector(2 downto 0);RFA2:out std_logic_vector(2 downto 0));
end entity;

architecture struct of RF_A2 is
signal RF1,RF2,RF3,RF4,RF:std_logic;

begin
RF1 <= opcode(3) and opcode(2) and not(opcode(1)) and not(opcode(0));
RF2 <= opcode(3) and opcode(2) and opcode(1) and opcode(0);
RF3 <= not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0);
RF4 <= not(opcode(3)) and opcode(2) and opcode(1) and opcode(0);  
RF <= (RF1 or RF2) or RF3;

mux:process(opcode,PE_out,Imem_6_8)
begin
if RF4 = '1' then 
	RFA2 <= PE_out;

elsif RF = '1' then
	RFA2 <= "000";

else
	RFA2 <= Imem_6_8;
end if;
end process mux;
end architecture struct;