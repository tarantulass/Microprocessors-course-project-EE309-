library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity reg_z is
port( Zin, Z_en, clk : in std_logic; Zout : out std_logic);
end entity;

architecture Bzz of reg_z is

begin

process(clk)
begin
if rising_edge(clk) then
if ( Z_en ='1') then
Zout <= Zin;
end if;
end if;

end process;

end Bzz;