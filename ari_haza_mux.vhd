library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity ari_haza_mux is 
port(D1_C1, D1_C2, D1_C3: in std_logic; 
     ALU3_C, ALU3_C_EX_MEM, ALU3_C_MEM_WB, ALU1_C, ALU1_C_EX_MEM, ALU1_C_MEM_WB, ZE_9, ZE_9_EX_MEM, ZE_9_MEM_WB: in std_logic_vector(15 downto 0);
	  OPCODE_CZ_RR_EX, OPCODE_CZ_EX_MEM, OPCODE_CZ_MEM_WB: in std_logic_vector(6 downto 0);
	  RFD1 : in std_logic_vector(15 downto 0);
	  RF_D1_RR_EX : out std_logic_vector(15 downto 0));
end entity;

architecture compa of ari_haza_mux is

begin

	process(D1_C1, D1_C2, D1_C3, ALU3_C, ALU1_C, ZE_9, OPCODE_CZ_RR_EX, OPCODE_CZ_EX_MEM, OPCODE_CZ_MEM_WB)
	
		begin
	
			if( D1_C1 ='1') AND (OPCODE_CZ_RR_EX(6 downto 2) = "00010") then  --ADA,Adc,adz,awc
			RF_D1_RR_EX <= ALU3_C;

			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX = "0001111") then  -- acw
			RF_D1_RR_EX <= ALU3_C;

			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX(6 downto 3) = "0000") then  --adi
			RF_D1_RR_EX <= ALU3_C;
			
			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX = "0001100") then  --aca
			RF_D1_RR_EX <= ALU1_C;
			
			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX = "0001110") then  --acc
			RF_D1_RR_EX <= ALU1_C;
		
			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX = "0001101") then  --acz
			RF_D1_RR_EX <= ALU1_C;
			
			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX(6 downto 3) = "0010") then  --ndu,ndc,ndz,ncu,ncc,ncz
			RF_D1_RR_EX <= ALU1_C;
			
			elsif (D1_C1 = '1') AND (OPCODE_CZ_RR_EX(6 downto 3) = "0011") then  --lli
			RF_D1_RR_EX <= ZE_9;
			
			else 
			RF_D1_RR_EX <= rfd1;
			
			end if;
			
			if( D1_C2 ='1') AND (OPCODE_CZ_EX_MEM(6 downto 2) = "00010") then
			RF_D1_RR_EX <= ALU3_C_EX_MEM;

			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM = "0001111") then
			RF_D1_RR_EX <= ALU3_C_EX_MEM;

			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM(6 downto 3) = "0000") then
			RF_D1_RR_EX <= ALU3_C_EX_MEM;
			
			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM = "0001100") then
			RF_D1_RR_EX <= ALU1_C_EX_MEM;
			
			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM = "0001110") then
			RF_D1_RR_EX <= ALU1_C_EX_MEM;
		
			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM = "0001101") then
			RF_D1_RR_EX <= ALU1_C_EX_MEM;
			
			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM(6 downto 3) = "0010") then
			RF_D1_RR_EX <= ALU1_C_EX_MEM;
			
			elsif (D1_C2 = '1') AND (OPCODE_CZ_EX_MEM(6 downto 3) = "0011") then
			RF_D1_RR_EX <= ZE_9_EX_MEM;
			
			else 
			RF_D1_RR_EX <= rfd1;			

			end if;
			
			if( D1_C3 ='1') AND (OPCODE_CZ_MEM_WB(6 downto 2) = "00010") then
			RF_D1_RR_EX <= ALU3_C_MEM_WB;

			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB = "0001111") then
			RF_D1_RR_EX <= ALU3_C_MEM_WB;

			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB(6 downto 3) = "0000") then
			RF_D1_RR_EX <= ALU3_C_MEM_WB;
			
			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB = "0001100") then
			RF_D1_RR_EX <= ALU1_C_MEM_WB;
			
			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB = "0001110") then
			RF_D1_RR_EX <= ALU1_C_MEM_WB;
		
			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB = "0001101") then
			RF_D1_RR_EX <= ALU1_C_MEM_WB;
			
			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB(6 downto 3) = "0010") then
			RF_D1_RR_EX <= ALU1_C_MEM_WB;
			
			elsif (D1_C3 = '1') AND (OPCODE_CZ_MEM_WB(6 downto 3) = "0011") then
			RF_D1_RR_EX <= ZE_9_MEM_WB;
			
			else 
			RF_D1_RR_EX <= rfd1;			

			end if;
			
		end process;
		
end compa;
