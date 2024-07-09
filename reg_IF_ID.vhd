library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Reg_IF_ID is
port (clk, v, stall : in std_logic; Iword_in, ALU2c_in : in std_logic_vector(15 downto 0);
        Iword_out, ALU2c_out: out std_logic_vector(15 downto 0));
end entity;

architecture bregi of Reg_IF_ID is

type reg_type is array (0 to 1 ) of std_logic_vector (15 downto 0);
signal reg_array: reg_type:= (0 => x"0000",1 => x"0000");
signal NOPS : std_logic_vector(15 downto 0);

begin 
NOPS <= x"E325";

Process(clk, v,stall, reg_array,NOPS,Iword_in,ALU2C_in)
begin
--read asynchronous
--reg(0) is for I word
--reg(1) is for ALU2C

if rising_edge(clk) then
	if (v = '0') and (stall = '0') then
		reg_array(0) <= NOPS;
		reg_array(1) <= x"0000";

	elsif (v = '1') and (stall = '0') then
		reg_array(0) <= Iword_in;
		reg_array(1) <= ALU2C_in;

	elsif(v = '1') and (stall = '1') then
		reg_array(0) <= Iword_in;
		reg_array(1) <= ALU2C_in;
		--v = '0' and stall = '1'

	else 
		reg_array(0) <= NOPS;
		reg_array(1) <= x"0000";
		
	end if;
end if;

--write synchronous
	
	if (v = '0') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU2c_out <= reg_array(1);
	elsif (v = '1') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU2c_out <= reg_array(1);
		
--say we dont write any condition then since Iword_out was already some value nothing would be changed in Iword_out
-- i.e previous value will be transferred .		
	--elsif (v = '1') and (stall = '1') then
		--Iword_out <= NOPS;
		--ALU2c_out <= x"0000";
	--v = '0' and stall = '1'
	--else
		--Iword_out <= reg_array(0);
		--ALU2c_out <= reg_array(1);
	end if;

	

end process;

end bregi;