library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Reg_ID_RR is
port (clk, v, stall : in std_logic; Iword_in, ALU2c_in : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU2c_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end entity;

--	ip_write ,REGCY_WRITE,REGZ_WRITE,Dmem_write,	Dmem_read,rf_write,temp_write ; order

architecture struct of Reg_ID_RR is

type reg_type is array (0 to 1 ) of std_logic_vector (15 downto 0);
type control_type is array (0 to 6) of std_logic;
type pe_type is array (0 to 2) of std_logic;
signal reg_array: reg_type:= (0 => x"0000",1 => x"0000");
signal control_reg: std_logic_vector(6 downto 0);
signal pe_reg: std_logic_vector(2 downto 0);
signal NOPS : std_logic_vector(15 downto 0);

begin 
NOPS <= x"E325";

Process(clk, v,stall, reg_array,pe_reg,control_reg,NOPS,Iword_in,ALU2C_in,pe_in,control_sig_in)
begin
--read asynchronous
--reg(0) is for I word
--reg(1) is for ALU2C
if rising_edge(clk) then

if (v = '0') and (stall = '0') then
	reg_array(0) <= NOPS;
	reg_array(1) <= x"0000";
	pe_reg <= "000";
	control_reg <= "0000000";

elsif (v = '1') and (stall = '0') then
	reg_array(0) <= Iword_in;
	reg_array(1) <= ALU2C_in;
	pe_reg <= pe_in;
	control_reg <= control_sig_in;

elsif(v = '1') and (stall = '1') then
	reg_array(0) <= Iword_in;
	reg_array(1) <= ALU2C_in;
	pe_reg <= pe_in;
	control_reg <= control_sig_in;
	--v = '0' and stall = '1'

else 
	reg_array(0) <= NOPS;
	reg_array(1) <= x"0000";
	pe_reg <= "000";
	control_reg <= "0000000";
end if;
end if;


--write synchronous
	
	if (v = '0') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU2c_out <= reg_array(1);
		pe_out <= pe_reg;
		control_sig_out <= control_reg;
	elsif (v = '1') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU2c_out <= reg_array(1);
		pe_out <= pe_reg;
		control_sig_out <= control_reg;
	--elsif (v = '1') and (stall = '1') then
		--Iword_out <= NOPS;
		--ALU2c_out <= x"0000";
		--pe_out <= "000";
		--control_sig_out <= x"00";
	--v = '0' and stall = '1'
	--else
		--Iword_out <= reg_array(0);
		--ALU2c_out <= reg_array(1);
		--pe_out <= "000";
		--control_sig_out <= x"00";
	end if;

end process;

end architecture struct;