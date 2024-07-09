library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;
entity ALU_2 is
    Port ( A : in  std_logic_vector (15 downto 0);
           Sum : out  std_logic_vector (15 downto 0));
end entity ALU_2;

architecture Behavioral of ALU_2 is
begin
    process(A)
		  variable B : std_logic_vector(15 downto 0) := X"0001";
        variable temp_sum : std_logic_vector(15 downto 0) := (others => '0');
		  variable carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
				temp_sum(i) := A(i) xor B(i) xor '0';
				carry(i) := A(i) and B(i);
		  else 
				temp_sum(i) := A(i) xor B(i) xor carry(i-1);
				carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) xor B(i)));
		  end if;
		end loop L1;
		sum<=temp_sum;
    end process;
end Behavioral;