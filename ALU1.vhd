library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU1 is
	port(opcode:IN std_logic_vector(3 downto 0);
	Cbar:IN std_logic;
	CZ :IN std_logic_vector(1 downto 0);
	ALU1A,ALU1B:IN std_logic_vector(15 downto 0);
	ALU1C:OUT std_logic_vector(15 downto 0);
	ALU1Z,ALU1CY:OUT std_logic);
end entity;


architecture structure of ALU1 is

----------------------------------------------------------------------------------------------------------------------------------------------------
component ADD is
	port(A,B:IN std_logic_vector(15 downto 0); S: out std_logic_vector(15 downto 0);C:out std_logic);
end component ADD;
----------------------------------------------------------------------------------------------------------------------------------------------------

signal ALU1AC,ALU1BC: std_logic_vector(15 downto 0);
signal NAND16,ADD16,ACC16,NCU16,sub16: std_logic_vector(15 downto 0);
signal carry:std_logic_vector(4 downto 0);
signal zflag,cy: std_logic;
signal ble,blt,beq,aca,awc : std_logic;

begin

N1:for i in 15 downto 0 generate
	ALU1AC(i) <= not(ALU1A(i));
end generate N1;

N2:for i in 15 downto 0 generate
	ALU1BC(i) <= not(ALU1B(i));
end generate N2;

A1:ADD port map(A => ALU1A,B => ALU1B,S => Add16,C =>carry(0));
A2:ADD port map(A => ALU1AC,B => ALU1BC,S => NAND16, C=>carry(1));
A4:ADD port map(A => ALU1A,B => ALU1BC,S => ACC16,C =>carry(2));
A5:ADD port map(A => ALU1AC,B => ALU1B,S => NCU16, C=>carry(3));
A3:ADD port map(A => ACC16,B => x"0001",S => SUB16,C =>carry(4));
blt <= opcode(3)and opcode(0) and not(opcode(1)) and not(opcode(2));
ble <= opcode(3)and not(opcode(0)) and opcode(1) and not(opcode(2));
beq <= opcode(3) and not(opcode(1)) and not(opcode(2)) and not(opcode(0));
aca <= Cbar and opcode(0) and NOT(CZ(0) AND CZ(1)) and not(opcode(1)) and not(opcode(2)) and not(opcode(3));
awc <= not(Cbar) and opcode(0) and CZ(0) AND CZ(1) and not(opcode(1)) and not(opcode(2)) and not(opcode(3));

z:process(ALU1A,ALU1B) is
begin
	if ALU1A = ALU1B then
		zflag <= '1';
	else
		zflag <= '0';
	end if;
end process z;

cyflag_process: process(carry(2), carry(0), aca, awc,sub16,beq,ble,blt)
begin 
    if (aca and carry(2)) = '1' or (awc and carry(0)) = '1' or ((ble or blt or beq) and sub16(15)) = '1' then
        cy <= '1';
    else
        cy <= '0';
    end if;
end process cyflag_process;


calc:process(Cbar,ALU1B,ALU1A,NCU16,cz,ADD16,ACC16,opcode,aca,awc,beq,blt,ble,cy,zflag) is
begin
--awc
    if awc = '1'  then
        ALU1C <= ADD16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;		  
--NDU,--
    elsif (not(Cbar)and opcode(1) and not(opcode(0) or opcode(2) or opcode(3))) = '1' then
        ALU1C <= NAND16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;
--NCU,--		  
    elsif (Cbar and opcode(1) and not(opcode(1) or opcode(2) or opcode(3))) = '1' then
        ALU1C <= NCU16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;
		
--aca,acc,acz
    elsif aca = '1' then
        ALU1C <= ACC16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;
--ACW
    elsif (Cbar and opcode(0) and CZ(0) AND CZ(1) and not(opcode(1) or opcode(2) or opcode(3))) = '1'then
        ALU1C <= ACC16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;
		  
--beq,ble,blt
    elsif (beq or ble or blt) = '1' then
        ALU1C <= SUB16;
		  ALU1Z <= zflag;
		  ALU1CY <= cy;

    else
        ALU1C <= (others => '0'); -- Default value when none of the conditions match
		  ALU1CY <= '0';
		  ALU1z <= '0';
    end if;
end process calc;



end structure;