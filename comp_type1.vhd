library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity comp_type1 is 
port ( Iword_3to5, Iword_6to8, Iword_9to11 : in std_logic_vector(2 downto 0);
       D1, D2 : out std_logic);
end entity;

architecture COMP of comp_type1 is

begin 

Process(Iword_3to5, Iword_6to8, Iword_9to11)
begin
if (Iword_3to5 = Iword_6to8) then
D2 <= '1';

elsif(Iword_3to5 = Iword_9to11) then
D1 <= '1';

end if;

end process;

end comp;