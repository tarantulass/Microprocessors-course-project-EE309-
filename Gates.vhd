library ieee;
use ieee.std_logic_1164.all;
package Gates is

  component AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component AND_2;

  component OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component OR_2;

  component XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component XOR_2;
  

  component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;

	
	component Full_adder is
	port(A,B,Ci:in std_logic;Sum,Co:out std_logic);
	end component Full_adder;

	
end package Gates;

  

library ieee;
use ieee.std_logic_1164.all;
entity AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity AND_2;

architecture Equations of AND_2 is
begin
   Y <= A and B;
end Equations;

  
library ieee;
use ieee.std_logic_1164.all;
entity OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity OR_2;

architecture Equations of OR_2 is
begin
   Y <= A or B;
end Equations;
  

library ieee;
use ieee.std_logic_1164.all;
entity XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity XOR_2;

architecture Equations of XOR_2 is
begin
   Y <= A xor B;
end Equations;
 
  
library ieee;
use ieee.std_logic_1164.all;
entity HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is
begin
   S <= (A xor B);
   C <= (A and B);
end Equations;
 

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all; 

entity Full_adder is
port(A,B,Ci:in std_logic;Sum,Co:out std_logic);
end entity Full_adder;

architecture struct of Full_adder is
signal s1,s2,s3:std_logic;
begin
f1:HALF_ADDER port map(A=>A,B=>B,S=>s1,C=>s2);
f2:HALF_ADDER port map(A=>Ci,B=>s1,S=>Sum,C=>s3);
f3:OR_2 port map(A=>s3,B=>s2,Y=>Co);
end architecture struct;
