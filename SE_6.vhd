library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity SE_6 is 
port (A : in std_logic_vector(5 downto 0); Y: out std_logic_vector(15 downto 0));
end entity;

architecture SiiI of SE_6 is

begin

process(A)
begin

--if rising_edge(clk) then
if (A(5) = '0') then 
Y(15 downto 6) <= "0000000000";
Y(5 downto 0) <= A;

elsif( A(5) = '1') then
Y(15 downto 6) <= "1111111111";
Y(5 downto 0) <= A;

end if;

end process;

end siiI;

