library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.ALL;

entity PE_ADDER is
	port (PE_ADDER_MUX : IN STD_LOGIC_VECTOR(15 downto 0);
			D1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			D2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			x: Out std_logic);
end PE_ADDER;


architecture aayush of PE_ADDER is
	begin
		x <= '0';
		D1(15 DOWNTO 0) <= PE_ADDER_MUX(15 DOWNTO 0);
		
		process(PE_ADDER_MUX)
		variable B : std_logic_vector(15 downto 0) := X"0001";
        variable temp_sum : std_logic_vector(15 downto 0) := (others => '0');
		  variable carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
				temp_sum(i) := PE_ADDER_MUX(i) xor B(i) xor '0';
				carry(i) := PE_ADDER_MUX(i) and B(i);
		  else 
				temp_sum(i) := PE_ADDER_MUX(i) xor B(i) xor carry(i-1);
				carry(i) := (PE_ADDER_MUX(i) and B(i)) or (carry(i-1) and (PE_ADDER_MUX(i) xor B(i)));
		  end if;
		end loop L1;
		D2<=temp_sum;
    end process;
			
end aayush;

