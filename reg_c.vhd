library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity reg_c is
port( Cin, C_en, clk : in std_logic; Cout : out std_logic);
end entity;

architecture BCC of reg_c is


begin 
process(clk)
begin
if rising_edge(clk) then
if ( C_en ='1') then
Cout <= Cin;
end if;
end if;

end process;

end BCC;