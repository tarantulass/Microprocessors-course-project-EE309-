library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity I_MEM is 
port( clk:in std_logic;Imem_in : in std_logic_vector(15 downto 0); Imem_out : out std_logic_vector(15 downto 0));
end entity I_MEM;

architecture Bhv of I_MEM is
type reg_type is array (0 to 65535) of std_logic_vector (15 downto 0);


signal address : std_logic_vector(15 downto 0);
signal reg_array: reg_type := (0 => x"1221",
                               1 => x"1020",
										 2 => x"0009",
										 3 => x"0009",
										 4 => x"0009", 
										 5 => x"0009",
										 6 => x"0009",
										 7 => x"0009",
										 others => x"0000");

begin
process(clk,Imem_in)
begin
if rising_edge(clk) then 
Address  <= Imem_in;
end if;
end process;

Imem_out <= reg_array(to_integer(unsigned(Address)));

end bhv;