library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF_D3 is
	port(opcode:IN std_logic_vector(3 downto 0);Cbar:In std_logic;CZ:IN std_logic_vector(1 downto 0);
	ZE9,ALU1C,ALU2C,ALU3C,Dmem_D1:IN std_logic_vector(15 downto 0);RFD3:out std_logic_vector(15 downto 0));
end entity;

architecture struct of RF_D3 is
signal RF1,RF3,RF4,RF5,RF6,RF7,RF8,RF9,RFDmem_D1,RF3c,RF2c,RF1c:std_logic;

begin
RF1 <= not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0) and not(cbar) and not(cz(0) and cz(1));
RF3 <= not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and not(opcode(0));
RF4 <= opcode(3) and opcode(2) and not(opcode(1)) and not(opcode(0));
RF5 <= opcode(3) and opcode(2) and not(opcode(1)) and opcode(0);
RF6 <= not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0));
RF7 <= not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0) and cbar and not(CZ(0) and CZ(1)) ;
RF8 <= not(opcode(3)) and opcode(2) and not(opcode(1)) and not(opcode(0));
RF9 <= not(opcode(3)) and opcode(2) and opcode(1) and not(opcode(0));
RF3C <= RF1 OR RF3;
RF2C <= RF4 OR RF5;
RF1C <= RF6 OR RF7;
RFDmem_D1 <= RF8 or RF9;

mux:process(opcode,cz,cbar,ALU1C,ALU2C,ALU3C)
begin
if (RF3c = '1') or (RF3C and cbar and CZ(0) and CZ(1)) = '1' then 
	RFD3 <= ALU3C;
elsif RF2C = '1' then
	RFD3 <= ALU2C;
elsif RF1C = '1' then
	RFD3 <= ALU1C;
elsif RFDmem_D1 = '1' then
	RFD3 <= Dmem_D1;
else 
	RFD3 <= x"0000";
end if;
end process mux;
end architecture struct;