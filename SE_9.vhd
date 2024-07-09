library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity SE_9 is 
port (A : in std_logic_vector(8 downto 0); Y: out std_logic_vector(15 downto 0));
end entity;

architecture Sii of SE_9 is

begin

process(A)
begin

--if rising_edge(clk) then
if (A(8) = '0') then 
Y(15 downto 9) <= "0000000";
Y(8 downto 0) <= A;

elsif( A(8) = '1') then
Y(15 downto 9) <= "1111111";
Y(8 downto 0) <= A;

end if;

end process;

end sii;

