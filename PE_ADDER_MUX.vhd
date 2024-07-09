library ieee;
use ieee.std_logic_1164.all;

entity PE_ADDER_MUX is
	port(RF_D1 : in std_logic_vector(15 downto 0);
	     D2 : in std_logic_vector(15 downto 0);
		  x : in std_logic;
		  PE_ADDER_MUX_OUT: out std_logic_vector(15 downto 0));
end entity;

architecture abc of PE_ADDER_MUX is
	
begin

	pqr: for i in 15 downto 0 generate
	PE_ADDER_MUX_OUT(i) <= (D2(i) and not(x) ) or (RF_D1(i) and x);
	end generate pqr;	

end abc;