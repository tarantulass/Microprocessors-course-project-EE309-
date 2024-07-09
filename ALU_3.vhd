library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;
entity ALU_3 is
    port (
			 A: in std_logic_vector(15 downto 0);
			 B: in std_logic_vector(15 downto 0);
			 sum: out std_logic_vector(15 downto 0);
			 carry: out std_logic;
			 Z: out std_logic);
end entity ALU_3;

architecture Behavioral of ALU_3 is
begin
    process(A,B)
		  variable temp_sum : std_logic_vector(15 downto 0) := (others => '0');
		  variable temp_carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
  	      temp_sum(i) := A(i) xor B(i) xor '0';
		  temp_carry(i) := A(i) and B(i);
	  else 
	    temp_sum(i) := A(i) xor B(i) xor temp_carry(i-1);
		 temp_carry(i) := (A(i) and B(i)) or (temp_carry(i-1) and (A(i) xor B(i)));
	  end if;
	end loop L1;
		sum<=temp_sum;
		carry<=temp_carry(15);
		
		if temp_sum = x"0000" then 
			Z<='1';
		else
			Z<='0';
		end if;
    end process;
end Behavioral;
