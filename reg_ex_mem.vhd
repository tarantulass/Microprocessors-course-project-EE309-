library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Reg_ex_mem is
port (clk, v, stall : in std_logic; Iword_in, ALU1C_IN,ALU2c_in,ALU3C_IN,RF_D1,RF_D2,ZE9,pe_adder_o1 : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU1C_OUT,ALU2c_out,ALU3C_out,RF_D1_out,RF_D2_out,ZE9_out,pe_adder_o1_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end entity;

--	ip_write ,REGCY_WRITE,REGZ_WRITE,Dmem_write,	Dmem_read,rf_write,temp_write ; order

architecture struct of Reg_ex_mem is

type reg_type is array (0 to 7 ) of std_logic_vector (15 downto 0);
type control_type is array (0 to 6) of std_logic;
type pe_type is array (0 to 2) of std_logic;
signal reg_array: reg_type:= (0 => x"0000",1 => x"0000",2 => x"0000",3 => x"0000",4 => x"0000",5 => x"0000",6 => x"0000",7 =>x"0000");
signal control_reg: std_logic_vector(6 downto 0);
signal pe_reg: std_logic_vector(2 downto 0);
signal NOPS : std_logic_vector(15 downto 0);

begin 
NOPS <= x"E325";

Process(clk, v,stall, reg_array,pe_reg,control_reg,NOPS,Iword_in,ALU1C_IN,ALU2C_in,ALU3C_IN,RF_D1,RF_D2,ZE9,pe_in,pe_adder_o1,control_sig_in)
begin
--read asynchronous
--reg(0) is for I word
--reg(1) is for ALU1C
--reg(2) is for alu2c
--reg(3) is for ALU3C
--reg(4) is for rfd1
--reg(5) is for rfd2
--reg(6) is for ze9
--reg(7) is for pe_adder_o1

if rising_edge(clk) then
	if (v = '0') and (stall = '0') then
		reg_array(0) <= NOPS;
		reg_array(1) <= x"0000";
		reg_array(2) <= x"0000";
		reg_array(3) <= x"0000";
		reg_array(4) <= x"0000";
		reg_array(5) <= x"0000";
		reg_array(6) <= x"0000";
		reg_array(7) <= x"0000";
		pe_reg <= "000";
	control_reg <= "0000000";

	elsif (v = '1') and (stall = '0') then
		reg_array(0) <= Iword_in;
		reg_array(1) <= ALU1C_in;
		reg_array(2) <= alu2c_in;
		reg_array(3) <= alu3c_in;
		reg_array(4) <= rf_d1;
		reg_array(5) <= rf_d2;
		reg_array(6) <= ze9;
		reg_array(7) <= pe_adder_o1;
		pe_reg <= pe_in;
		control_reg <= control_sig_in;

	elsif(v = '1') and (stall = '1') then
		reg_array(0) <= Iword_in;
		reg_array(1) <= ALU1C_in;
		reg_array(2) <= alu2c_in;
		reg_array(3) <= alu3c_in;
		reg_array(4) <= rf_d1;
		reg_array(5) <= rf_d2;
		reg_array(6) <= ze9;
		reg_array(7) <= pe_adder_o1;
		pe_reg <= pe_in;
		control_reg <= control_sig_in;
		--v = '0' and stall = '1'

	else 
		reg_array(0) <= NOPS;
		reg_array(1) <= x"0000";
		reg_array(1) <= x"0000";
		reg_array(2) <= x"0000";
		reg_array(3) <= x"0000";
		reg_array(4) <= x"0000";
		reg_array(5) <= x"0000";
		reg_array(6) <= x"0000";
		reg_array(7) <= x"0000";
		pe_reg <= "000";
	control_reg <= "0000000";
		
	end if;
end if;

--write synchronous
	
	if (v = '0') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU1c_out <= reg_array(1);
		ALU2c_out <= reg_array(2);
		ALU3c_out <= reg_array(3);
	   RF_D1_OUT <= reg_array(4);
		RF_D2_OUT <= reg_array(5);
		ze9_out <= reg_array(6);
		pe_adder_o1_out <= reg_array(7);
		pe_out <= pe_reg;
		control_sig_out <= control_reg;
		
	elsif (v = '1') and (stall = '0') then
		Iword_out <= reg_array(0);
		ALU1c_out <= reg_array(1);
		ALU2c_out <= reg_array(2);
		ALU3c_out <= reg_array(3);
	   RF_D1_OUT <= reg_array(4);
		RF_D2_OUT <= reg_array(5);
		ze9_out <= reg_array(6);
		pe_adder_o1_out <= reg_array(7);
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