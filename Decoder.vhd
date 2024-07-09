library ieee;
use ieee.std_logic_1164.all;

entity Decoder is

	port(Imem:in std_logic_vector(15 downto 0);
	reg_CY,reg_Z:in std_logic;
	Dmem_read, REGCY_WRITE, REGZ_WRITE,Dmem_write, ip_write, temp_write,rf_write: out std_logic
	);
end entity Decoder;

architecture struct of Decoder is
signal rf_read:std_logic;

begin 

	
	decode:process(Imem,reg_CY,reg_Z)
	variable opcode:std_logic_vector(3 downto 0);
	begin
		opcode:= Imem(15 downto 12);

		case opcode is
		
----------------------------------------ADA--------------------------------		
		
			when "0001" =>              
				if Imem(2) = '0' and Imem(1 downto 0) = "00" then
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= '1';
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------ADC------------------------------	
				elsif Imem(2) = '0' and Imem(1 downto 0) = "10" then
				
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_CY;
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------ADZ------------------------------	
				elsif Imem(2) = '0' and Imem(1 downto 0) = "01" then
				
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_Z;
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------AWC------------------------------	
				elsif Imem(2) = '0' and Imem(1 downto 0) = "11" then
								
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_Z;
					rf_read <= '1';
					temp_write <= '0';
				
				
----------------------------------------ACA------------------------------	
				elsif Imem(2) = '1' and Imem(1 downto 0) = "00" then
			
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= '1';
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------ACC------------------------------	
				elsif Imem(2) = '1' and Imem(1 downto 0) = "10" then
								
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_CY;
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------ACZ------------------------------	

				elsif Imem(2) = '1' and Imem(1 downto 0) = "01" then
			
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_Z;
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------ACW------------------------------				
				elsif Imem(2) = '1' and Imem(1 downto 0) = "11" then
				
					ip_write <= '0';
					REGCY_WRITE <= '1';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= '1';
					rf_read <= '1';
					temp_write <= '0';
					
				else 
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '0';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_read <= '0';
					rf_write <= '0';
					temp_write <= '0'; 
					
				end if;
	
----------------------------------------NDU------------------------------		
	
	
			when "0010" =>
				if Imem(2) = '0' and Imem(1 downto 0) = "00" then
			
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= '1';
					rf_read <= '1';
					temp_write <= '0';
----------------------------------------NDC------------------------------	
				elsif Imem(2) = '0' and Imem(1 downto 0) = "10" then
			
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_CY;
					rf_read <= '1';
					temp_write <= '0';
				
----------------------------------------NDZ------------------------------					
				elsif Imem(2) = '0' and Imem(1 downto 0) = "01" then
				
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_Z;
					rf_read <= '1';
					temp_write <= '0';
					
				
----------------------------------------NCU------------------------------	
				elsif Imem(2) = '1' and Imem(1 downto 0) = "00" then
			
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= '1';
					rf_read <= '1';
					temp_write <= '0';
				
----------------------------------------NCC------------------------------		
				elsif Imem(2) = '1' and Imem(1 downto 0) = "10" then
			
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_CY;
					rf_read <= '1';
					temp_write <= '0';
				
----------------------------------------NCZ------------------------------	
				elsif Imem(2) = '1' and Imem(1 downto 0) = "01" then
			
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '1';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_write <= reg_Z;
					rf_read <= '1';
					temp_write <= '0';
					
				else 
					ip_write <= '0';
					REGCY_WRITE <= '0';
					REGZ_WRITE <= '0';
					Dmem_write <= '0';
					Dmem_read <= '0';
					rf_read <= '0';
					rf_write <= '0';
					temp_write <= '0'; 
					
				end if;

----------------------------------------ADI------------------------------	
	
			when "0000" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '1';
				REGZ_WRITE <= '1';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '1';
				rf_read <= '1';
				temp_write <= '0';

----------------------------------------LLI------------------------------	
	
	
			when "0011" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '1';
				rf_read <= '0';
				temp_write <= '0';
				
	
----------------------------------------LW------------------------------	
	
	
			when "0100" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '1';
				Dmem_write <= '0';
				Dmem_read <= '1';
				rf_write <= '1';
				rf_read <= '1';
				temp_write <= '0';
				
				
----------------------------------------SW------------------------------	


			when "0101" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '1';
				Dmem_read <= '0';
				rf_write <= '0';
				rf_read <= '1';
				temp_write <= '0';
				
				
----------------------------------------BEQ------------------------------	
	
	
			when "1000" => 
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '0';
				rf_read <= '1';
				temp_write <= '0';
				
				
----------------------------------------BLT------------------------------	
	
	
			when "1001" =>
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '0';
				rf_read <= '1';
				temp_write <= '0';           
				
				
----------------------------------------BLE------------------------------	
	
	
			when "1010" =>
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '0';
				rf_read <= '1';
				temp_write <= '0'; 
				
				
----------------------------------------JAL------------------------------	
	
	
			when "1100" =>
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '1';
				rf_read <= '0';
				temp_write <= '0'; 
				
				
----------------------------------------JLR------------------------------	
	
	
			when "1101" =>
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_write <= '1';
				rf_read <= '1';
				temp_write <= '0'; 
				
----------------------------------------JRI------------------------------	
	
	
			when "1111" =>
			
				ip_write <= '1';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '1';
				rf_read <= '1';
				rf_write <= '0';
				temp_write <= '0'; 
				
-----------------------------------------SM------------------------------------

			when "0111" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '1';
				Dmem_read <= '0';
				rf_read <= '1';
				rf_write <= '0';
				temp_write <= '1'; 
				
-----------------------------------------LM------------------------------------

				
			when "0110" =>
			
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '1';
				rf_read <= '1';
				rf_write <= '1';
				temp_write <= '1'; 
				
				
			when others =>
				ip_write <= '0';
				REGCY_WRITE <= '0';
				REGZ_WRITE <= '0';
				Dmem_write <= '0';
				Dmem_read <= '0';
				rf_read <= '0';
				rf_write <= '0';
				temp_write <= '0'; 
				
			
-------------------------------------------------------------------------------

		end case;
	
	end process decode;
	
end struct;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		