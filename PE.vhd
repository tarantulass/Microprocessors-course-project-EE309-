library ieee;
use ieee.std_logic_1164.all;

entity PE is
	port (PE_MUX :IN STD_LOGIC_VECTOR(7 downto 0);
        PE_MOD : OUT STD_LOGIC_VECTOR(7 downto 0);    
		  PE_OUT : OUT STD_LOGIC_VECTOR(2 downto 0);
        PEO : OUT STD_LOGIC;
		  VO : OUT STD_LOGIC);
end PE;


architecture behave of PE is

  begin
    process (PE_MUX)
    begin
	 
      if PE_MUX(0) = '1' then
		
        PE_OUT <= "111";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 downto 1) <= PE_MUX(7 downto 1);
		  PE_MOD(0) <= '0';
		  
		  
      elsif PE_MUX(1) = '1' then
		
        PE_OUT <= "110";
        VO <= '1';
		  PEO <= '1';
		  PE_MOD(7 DOWNTO 2) <= PE_MUX(7 DOWNTO 2);
		  PE_MOD(1) <= '0';
		  PE_MOD(0) <= PE_MUX(0);
      
		
		elsif PE_MUX(2) = '1' then
      
		  PE_OUT <= "101";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 DOWNTO 3) <= PE_MUX(7 DOWNTO 3);
		  PE_MOD(2) <= '0';
		  PE_MOD(1 DOWNTO 0) <= PE_MUX(1 DOWNTO 0);


		  elsif PE_MUX(3) = '1' then

        PE_OUT <= "100";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 DOWNTO 4) <= PE_MUX(7 DOWNTO 4);
		  PE_MOD(3) <= '0';
		  PE_MOD(2 DOWNTO 0) <= PE_MUX(2 DOWNTO 0);
		  

		  elsif PE_MUX(4) = '1' then

        PE_OUT <= "011";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 DOWNTO 5) <= PE_MUX(7 DOWNTO 5);
		  PE_MOD(4) <= '0';
		  PE_MOD(3 DOWNTO 0) <= PE_MUX(3 DOWNTO 0);


		  elsif PE_MUX(5) = '1' then

        PE_OUT <= "010";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 DOWNTO 6) <= PE_MUX(7 DOWNTO 6);
		  PE_MOD(5) <= '0';
		  PE_MOD(4 DOWNTO 0) <= PE_MUX(4 DOWNTO 0);


		  elsif PE_MUX(6) = '1' then

        PE_OUT <= "001";
        PEO <= '1';
		  VO <= '1';
		  PE_MOD(7 DOWNTO 7) <= PE_MUX(7 DOWNTO 7);
		  PE_MOD(6) <= '0';
		  PE_MOD(5 DOWNTO 0) <= PE_MUX(5 DOWNTO 0);


		  elsif PE_MUX(7) = '1' then

        PE_OUT <= "000";
        PEO <= '1';
		  VO <= '1';
		--  PE_MOD(7 DOWNTO 5) <= PE_MUX(7 DOWNTO 5);
		  PE_MOD(7) <= '0';
		  PE_MOD(6 DOWNTO 0) <= PE_MUX(6 DOWNTO 0);


		  else
        PE_OUT <= "000";
		  PEO <= '0';
		  VO <= '0';
		  PE_MOD(7 DOWNTO  0) <= PE_MUX(7 DOWNTO 0);
      end if;
    end process;
end behave;