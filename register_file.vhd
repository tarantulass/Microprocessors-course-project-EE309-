library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  
-- VHDL code for the register file of the MIPS Processor

entity register_file is
port (
 clk,rst,RF_write_en: in std_logic;
 
 IP_in : in std_logic_vector(15 downto 0);
 IP_out : out std_logic_vector(15 downto 0);
 
 RF_A1: in std_logic_vector(2 downto 0);
 RF_D1: out std_logic_vector(15 downto 0);
 RF_A2: in std_logic_vector(2 downto 0);
 RF_D2: out std_logic_vector(15 downto 0);
 RF_A3: in std_logic_vector(2 downto 0);
 RF_D3: in std_logic_vector(15 downto 0)
);
end register_file;


architecture Bhv of register_file is
type reg_type is array (0 to 7 ) of std_logic_vector (15 downto 0);


signal reg_array: reg_type := (0 => x"0008",1 => x"0009",2 => x"0009", 3 =>x"0009", 4 =>x"0009", 5 =>x"0009", 6 =>x"0009", 7 =>x"0009");

	
begin

------------------------------------
 process(clk,rst) 
 begin
 if(rst='1') then
   reg_array(0) <= x"0110"; -- the prefix 'x' denotes that the number is in Hex
   reg_array(1) <= x"0010";
   reg_array(2) <= x"1000";
   reg_array(3) <= x"0110";
   reg_array(4) <= x"0111";
   reg_array(5) <= x"0000";
   reg_array(6) <= x"1110";
   reg_array(7) <= x"0000";
	
 elsif(rising_edge(clk)) then
 
 reg_array(0) <= IP_in;
 
   if(RF_write_en='1') then
    reg_array(to_integer(unsigned(RF_A3))) <= RF_D3;
   end if;
	
	
 end if;
 
 end process;
-----------------------------------
 
 RF_D1 <= reg_array(to_integer(unsigned(RF_A1)));
 
 RF_D2 <= reg_array(to_integer(unsigned(RF_A2)));
 
 
 IP_out <= reg_array(0);

end Bhv;