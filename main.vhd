library ieee;
use ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity main is
	port(clock,clear : IN STD_LOGIC);
end entity;

architecture struct of main is

component ADD is
	port(A, B: in std_logic_vector(15 downto 0);
		 S: out std_logic_vector(15 downto 0); 
		 C: out std_logic);
end component ADD;

component ALU1 is
	port(opcode:IN std_logic_vector(3 downto 0);
	Cbar:IN std_logic;
	CZ :IN std_logic_vector(1 downto 0);
	ALU1A,ALU1B:IN std_logic_vector(15 downto 0);
	ALU1C:OUT std_logic_vector(15 downto 0);
	ALU1Z,ALU1CY:OUT std_logic);
end component;

component ALU3_A_Mux is
port ( RF_D1, ALU1_C, SE_9, SE_6: in std_logic_vector(15 downto 0); 
       opcode: in std_logic_vector(3 downto 0); 
		 CCZ: in std_logic_vector(2 downto 0);
		 Mux_out : out std_logic_vector(15 downto 0));
end component;

component ALU3_B_Mux is
port ( RF_D2, ALU2_C, SE_9, SE_6, ZE_1: in std_logic_vector(15 downto 0); 
       opcode: in std_logic_vector(3 downto 0); 
		 CCZ: in std_logic_vector(2 downto 0);
		 Mux_out : out std_logic_vector(15 downto 0));
end component;

component ALU_2 is
    Port ( A : in  std_logic_vector (15 downto 0);
           Sum : out  std_logic_vector (15 downto 0));
end component ALU_2;

component ALU_3 is
    port (A: in std_logic_vector(15 downto 0);
			 B: in std_logic_vector(15 downto 0);
			 sum: out std_logic_vector(15 downto 0);
			 carry: out std_logic;
			 Z: out std_logic);
end component ALU_3;

component ari_haza_mux is 
port(D1_C1, D1_C2, D1_C3: in std_logic; 
     ALU3_C, ALU3_C_EX_MEM, ALU3_C_MEM_WB, ALU1_C, ALU1_C_EX_MEM, ALU1_C_MEM_WB, ZE_9, ZE_9_EX_MEM, ZE_9_MEM_WB: in std_logic_vector(15 downto 0);
	  OPCODE_CZ_RR_EX, OPCODE_CZ_EX_MEM, OPCODE_CZ_MEM_WB: in std_logic_vector(6 downto 0);
	  RFD1 : in std_logic_vector(15 downto 0);
	  RF_D1_RR_EX : out std_logic_vector(15 downto 0));
end component ari_haza_mux;

component branch_mux is
	port(opcode:IN std_logic_vector(3 downto 0);
	ALU1Cy,ALU1Z:IN std_logic;
	ALU3C,ALU2C: IN std_logic_vector(15 downto 0);
	IP_in:out std_logic_vector(15 downto 0);
	valid:out std_logic);
end component;

component comp_type1 is 
port ( Iword_3to5, Iword_6to8, Iword_9to11 : in std_logic_vector(2 downto 0);
       D1, D2 : out std_logic);
end component;

component comp_type2 is 
port(Iword_9_11 , Iword2_9_11, Iword2_6_8 : in std_logic_vector(2 downto 0); y: out std_logic);
end component comp_type2;

component Decoder is

	port(Imem:in std_logic_vector(15 downto 0);
	reg_CY,reg_Z:in std_logic;
	Dmem_read, REGCY_WRITE, REGZ_WRITE,Dmem_write, ip_write, temp_write,rf_write: out std_logic
	);
end component Decoder;

component dflipflop is
	port( clk, D : in std_logic; Q : out std_logic);
end component;

component DMem_A1_MUX is
	port(PE_Add : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_A1_out: out std_logic_vector(15 downto 0));
end component DMem_A1_MUX;

component DMem_A2_MUX is
	port(PE_Add : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_A2_out: out std_logic_vector(15 downto 0));
end component DMem_A2_MUX;

component DMem_D2_MUX is
	port(RF_D1 : in std_logic_vector(15 downto 0);
	     RF_D2 : in std_logic_vector(15 downto 0);
		  opcode  : in std_logic_vector(3 downto 0);
		  DMem_D2_MUX: out std_logic_vector(15 downto 0));
end component DMem_D2_MUX;

component D_MEM is
port ( clk, DMem_en : in std_logic;
       DM_a1: in std_logic_vector(15 downto 0);
		 DM_a2: in std_logic_vector(15 downto 0);
		 DM_d2: in std_logic_vector(15 downto 0);
		 DM_d1: out std_logic_vector(15 downto 0));
		 
end component D_MEM;

component IP_MUX_2 is
	port(ALU_2_c : in std_logic_vector(15 downto 0);
	     ALU_3_c : in std_logic_vector(15 downto 0);
		  RF_D2   : in std_logic_vector(15 downto 0);
		  IP_MUX  : in std_logic_vector(15 downto 0);
		  IP : in std_logic_vector(15 downto 0);
		  VO : in std_logic;
		  opcode_if_id  : in std_logic_vector(3 downto 0);
		  opcode_id_rr  : in std_logic_vector(3 downto 0);
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		  IP_MUX2_out: out std_logic_vector(15 downto 0));
end component IP_MUX_2;

component I_MEM is 
	port( clk:in std_logic;Imem_in : in std_logic_vector(15 downto 0); Imem_out : out std_logic_vector(15 downto 0));
end component I_MEM;

component jump_haza_mux1 is
	port(
			S : in std_logic;
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		   V: out std_logic);
end component jump_haza_mux1;

component jump_haza_mux2 is
	port(
			S : in std_logic;
		  opcode_id_rr  : in std_logic_vector(3 downto 0);
		  opcode_rr_ex  : in std_logic_vector(3 downto 0);
		   V: out std_logic);
end component jump_haza_mux2;

component Lw_haza_mux is 
port(X, Y, Z, VO: in std_logic;
	  OPCODE_IF_ID, OPCODE_ID_RR, OPCODE_RR_EX, OPCODE_EX_MEM, OPCODE_MEM_WB: in std_logic_vector(3 downto 0);
	  stall_if_id : out std_logic);
end component;

component Lw_haza_mux2 is 
port(X, Y, Z: in std_logic;
	  OPCODE_ID_RR, OPCODE_RR_EX, OPCODE_EX_MEM, OPCODE_MEM_WB: in std_logic_vector(3 downto 0);
	  stall_id_rr : out std_logic);
end component;

component MUX_C_Z is
	port(opcode: in std_logic_vector(3 downto 0);
	     con : in std_logic;
		  cz : in std_logic_vector(1 downto 0);
		  alu_1_carry : in std_logic;
		  alu_3_carry : in std_logic;
		  alu_1_zero  :  in std_logic;
		  alu_3_zero  : in std_logic;
		  c_out:  out std_logic;
		  z_out : out std_logic);
end component MUX_C_Z;

component PE is
	port (PE_MUX :IN STD_LOGIC_VECTOR(7 downto 0);
        PE_MOD : OUT STD_LOGIC_VECTOR(7 downto 0);    
		  PE_OUT : OUT STD_LOGIC_VECTOR(2 downto 0);
        PEO : OUT STD_LOGIC;
		  VO : OUT STD_LOGIC);
end component PE;

component PE_ADDER is
	port (PE_ADDER_MUX : IN STD_LOGIC_VECTOR(15 downto 0);
			D1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			D2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			x: Out std_logic);
end component PE_ADDER;

component PE_ADDER_MUX is
	port(RF_D1 : in std_logic_vector(15 downto 0);
	     D2 : in std_logic_vector(15 downto 0);
		  x : in std_logic;
		  PE_ADDER_MUX_OUT: out std_logic_vector(15 downto 0));
end component;

component PE_MUX is
	port(ID_0_7 : in std_logic_vector(7 downto 0);
	     PE_MOD : in std_logic_vector(7 downto 0);
		  PEO : in std_logic;
		  PE_MUX_OUT: out std_logic_vector(7 downto 0));
end component;

component register_file is
port (
 clk,rst,RF_write_en: in std_logic;
 
 IP_in : in std_logic_vector(15 downto 0);
 IP_out : out std_logic_vector(15 downto 0);
 
 RF_A1: in std_logic_vector(2 downto 0);
 RF_D1: out std_logic_vector(15 downto 0);
 RF_A2: in std_logic_vector(2 downto 0);
 RF_D2: out std_logic_vector(15 downto 0);
 RF_A3: in std_logic_vector(2 downto 0);
 RF_D3: in std_logic_vector(15 downto 0)
);
end component register_file;

component reg_c is
port( Cin, C_en, clk : in std_logic; Cout : out std_logic);
end component;

component reg_z is
port( Zin, Z_en, clk : in std_logic; Zout : out std_logic);
end component;

component Reg_ex_mem is
port (clk, v, stall : in std_logic; Iword_in, ALU1C_IN,ALU2c_in,ALU3C_IN,RF_D1,RF_D2,ZE9,pe_adder_o1 : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU1C_OUT,ALU2c_out,ALU3C_out,RF_D1_out,RF_D2_out,ZE9_out,pe_adder_o1_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end component;

component Reg_ID_RR is
port (clk, v, stall : in std_logic; Iword_in, ALU2c_in : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU2c_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end component;

component Reg_IF_ID is
port (clk, v, stall : in std_logic; Iword_in, ALU2c_in : in std_logic_vector(15 downto 0);
        Iword_out, ALU2c_out: out std_logic_vector(15 downto 0));
end component;

component Reg_mem_wb is
port (clk, v, stall : in std_logic; Iword_in, ALU1C_IN,ALU2c_in,ALU3C_IN,ZE9,Dmem_d1 : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU1C_OUT,ALU2c_out,ALU3C_out,ZE9_out,Dmem_d1_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end component;

component Reg_RR_EX is
port (clk, v, stall : in std_logic; Iword_in, ALU2c_in,RF_D1,RF_D2,SE6,ZE9,SE9 : in std_logic_vector(15 downto 0);
		pe_in:in std_logic_vector(2 downto 0);control_sig_in: in std_logic_vector(6 downto 0);
        Iword_out, ALU2c_out,RF_D1_out,RF_D2_out,SE6_out,ZE9_out,SE9_out: out std_logic_vector(15 downto 0);
		   pe_out: out std_logic_vector(2 downto 0); control_sig_out: out std_logic_vector(6 downto 0));
end component;

component RF_A2 is
	port(opcode:IN std_logic_vector(3 downto 0);Imem_6_8,PE_out:IN std_logic_vector(2 downto 0);RFA2:out std_logic_vector(2 downto 0));
end component;

component RF_A3 is
	port(opcode:IN std_logic_vector(3 downto 0);Imem_6_8,Imem_3_5,Imem_9_11,PE_out:IN std_logic_vector(2 downto 0)
	;RFA3:out std_logic_vector(2 downto 0));
end component;

component RF_D3 is
	port(opcode:IN std_logic_vector(3 downto 0);Cbar:In std_logic;CZ:IN std_logic_vector(1 downto 0);
	ZE9,ALU1C,ALU2C,ALU3C,Dmem_D1:IN std_logic_vector(15 downto 0);RFD3:out std_logic_vector(15 downto 0));
end component;

component SE_6 is 
port ( A : in std_logic_vector(5 downto 0); Y: out std_logic_vector(15 downto 0));
end component;

component SE_9 is 
port (A : in std_logic_vector(8 downto 0); Y: out std_logic_vector(15 downto 0));
end component;

component Temp is 
port ( clk, temp_w_en : in std_logic;
       t_in : in std_logic_vector(15 downto 0);
		 t_out : out std_logic_vector(15 downto 0));
end component Temp;

component ZE_1 is
	port(
		A: in std_logic;
		B: out std_logic_vector(15 downto 0)
	);
end component ZE_1;


component ZE_9 is
	port(
		A: in std_logic_vector(8 downto 0);
		B: out std_logic_vector(15 downto 0)
	);
end component ZE_9;

signal ipmux2_in,ipmux2_out : std_logic_vector(15 downto 0);
signal imem_out : std_logic_vector(15 downto 0);
signal alu2_out : std_logic_vector(15 downto 0);
signal ipmux_branch_in : std_logic_vector(15 downto 0);
signal iword_id_out,iword_rr_out,iword_ex_out,Iword_mem_out: std_logic_vector(15 downto 0);
signal pe_mux_out:std_logic_vector(7 downto 0);

signal  PE_MOD : STD_LOGIC_VECTOR(7 downto 0);    
signal  PE_OUT,pe_rr_out,pe_ex_out : STD_LOGIC_VECTOR(2 downto 0);
signal  PEO : STD_LOGIC := '0';
signal  VO : STD_LOGIC := '0';
signal Dmem_read, REGCY_WRITE, REGZ_WRITE,Dmem_write, ip_write, temp_write,rf_write: std_logic;
signal ALU2_id_out,ALU2_rr_out,ALU2_ex_out,ALU2_mem_out:std_logic_vector(15 downto 0);

signal RF_A2_out: std_logic_vector(2 downto 0);
signal control_sig,control_rr_out,control_ex_out : std_logic_vector(6 downto 0);
signal ze9_rr_out,se9_rr_out,se6_rr_out,ze9_ex_out,se9_ex_out,se6_ex_out: std_logic_vector(15 downto 0);
signal rfd1,rfd2,RF_D1_rr_out,RF_D2_rr_out,RF_D1_ex_out,RF_D2_ex_out: std_logic_vector(15 downto 0);
signal alu3a_mux_out,alu3b_mux_out:std_logic_vector(15 downto 0);
signal alu1_ex_cy,alu3_ex_cy,alu1_ex_z,alu3_ex_z,c_out,z_out,regc_ex_out :std_logic;
signal alu3c_ex_out:std_logic_vector(15 downto 0);

signal x : std_logic :='0';
signal x_lw,y_lw,z_lw : std_logic ;
signal alu1c_ex_out:std_logic_vector(15 downto 0);
signal pE_ADDER_MUX_OUT,d1,d2,d2_temp: std_logic_vector(15 downto 0);
signal valid :std_logic;
--hazard and rfd1 muxes check

signal ALU1C_mem_OUT,ALU3C_mem_out,RF_D1_mem_out,RF_D2_mem_out,ZE9_mem_out,d1_mem_out:std_logic_vector(15 downto 0);
signal pe_mem_out,pe_wb_out:std_logic_vector(2 downto 0);
signal control_mem_out,control_wb_out:std_logic_vector(6 downto 0);
signal dmem_a1_out,dmem_a2_out,dmem_d2_out,dmem_mem_d1_out:std_logic_vector(15 downto 0);
signal Iword_wb_out, ALU1C_wb_OUT,ALU2_wb_out,ALU3C_wb_out,ZE9_wb_out,Dmem_wb_d1_out:std_logic_vector(15 downto 0);
signal rfa3:std_logic_vector(2 downto 0);
signal rfd3:std_logic_vector(15 downto 0);
signal d1_c1,d2_c1,d1_c2,d2_c2,d1_c3,d2_c3:std_logic; 
signal OPCODE_CZ_ex,OPCODE_CZ_mem,OPCODE_CZ_wb:std_logic_vector(6 downto 0);
signal stall_if_id,stall_id_rr,vaidity_if_id,regz_ex_out,vaidity_id_rr :std_logic;
signal alu2c_ex_out,ze_1_ex_out:std_logic_vector(15 downto 0);

begin

--	ip_write ,REGCY_WRITE,REGZ_WRITE,Dmem_write,	Dmem_read,rf_write,temp_write ; order
control_sig(6) <= ip_write;
control_sig(5) <= REGCY_WRITE;
control_sig(4) <= REGZ_WRITE;
control_sig(3) <= Dmem_write;
control_sig(2) <= Dmem_read;
control_sig(1) <= rf_write;
control_sig(0) <= temp_write;

opcode_cz_ex(6 downto 3) <= iword_ex_out(15 downto 12);
opcode_cz_ex(2) <= iword_ex_out(2);
opcode_cz_ex(1 downto 0) <= iword_ex_out(1 downto 0);

opcode_cz_mem(6 downto 3) <= iword_ex_out(15 downto 12);
opcode_cz_mem(2) <= iword_ex_out(2);
opcode_cz_mem(1 downto 0) <= iword_ex_out(1 downto 0);

opcode_cz_wb(6 downto 3) <= iword_ex_out(15 downto 12);
opcode_cz_wb(2) <= iword_ex_out(2);
opcode_cz_wb(1 downto 0) <= iword_ex_out(1 downto 0);


a1:register_file port map(clock,clear,control_wb_out(1),ipmux2_in,ipmux2_out,iword_rr_out(11 downto 9),rfd1,rf_a2_out,rfd2,rfa3,rfd3);
a2:I_mem port map(clock,ipmux2_out,imem_out);
a3:ALU_2 port map(ipmux2_out,alu2_out);
a4:ip_mux_2 port map(alu2_out,alu3c_ex_out,RF_D2_rr_out,ipmux_branch_in,ipmux2_out,vo,iword_id_out(15 downto 12),iword_rr_out(15 downto 12),iword_ex_out(15 downto 12),ipmux2_in);
a5:branch_mux port map(iword_ex_out(15 downto 12),alu1_ex_cy,alu1_ex_z,alu3c_ex_out,alu2_out,ipmux_branch_in,valid);
a6:reg_if_id port map(clock,vaidity_if_id,stall_if_id,imem_out,alu2_out,iword_id_out,ALU2_id_out);

------------------------------------------------------------------------------------------------------------------------------------

a7:pe_mux port map(iword_id_out(7 downto 0),pe_mod,peo,pe_mux_out);
a8:pe port map(pe_mux_out,pe_mod,pe_out,peo,vo);
a9:decoder port map(iword_id_out,regc_ex_out,regz_ex_out,Dmem_read, REGCY_WRITE, REGZ_WRITE,Dmem_write, ip_write, temp_write,rf_write);
a10:lw_haza_mux port map(x_lw,y_lw,z_lw,vo,iword_id_out(15 downto 12),iword_rr_out(15 downto 12),iword_ex_out(15 downto 12),iword_mem_out(15 downto 12),iword_wb_out(15 downto 12),stall_if_id);
a11:reg_id_rr port map(clock,vaidity_id_rr,stall_id_rr,iword_id_out,ALU2_id_out,pe_out,control_sig,iword_rr_out,ALU2_rr_out,pe_rr_out,control_rr_out);
a12:rf_a2 port map(iword_rr_out(15 downto 12),iword_rr_out(8 downto 6),pe_rr_out,rf_a2_out);
a13:ze_9 port map(iword_rr_out(8 downto 0),ze9_rr_out);
a14:se_9 port map(iword_rr_out(8 downto 0),se9_rr_out);
a15:se_6  port map(iword_rr_out(5 downto 0),se9_rr_out);
a16:lw_haza_mux2 port map(x_lw,y_lw,z_lw,iword_rr_out(15 downto 12),iword_ex_out(15 downto 12),iword_mem_out(15 downto 12),iword_wb_out(15 downto 12),stall_id_rr);



a43:comp_type2 port map(iword_rr_out(11 downto 9),iword_id_out(11 downto 9),iword_id_out(8 downto 6),x_lw);
a44:comp_type2 port map(iword_ex_out(11 downto 9),iword_id_out(11 downto 9),iword_id_out(8 downto 6),y_lw);
a45:comp_type2 port map(iword_mem_out(11 downto 9),iword_id_out(11 downto 9),iword_id_out(8 downto 6),z_lw);

a46: jump_haza_mux1 port map(valid,iword_ex_out(15 downto 12),vaidity_id_rr);
a47: jump_haza_mux2 port map(valid,iword_rr_out(15 downto 12),iword_ex_out(15 downto 12),vaidity_if_id);


-------------------------------------------------------------------------------------------------------------------------------------
a17:ari_haza_mux port map(d1_c1,d1_c2,d1_c3,alu3c_ex_out,alu3c_mem_out,alu3c_wb_out,alu1c_ex_out,alu1c_mem_out,alu1c_wb_out,ze9_ex_out,ze9_mem_out,ze9_wb_out,OPCODE_CZ_ex,OPCODE_CZ_mem,OPCODE_CZ_wb,rfd1, RF_D1_rr_out);
a42:ari_haza_mux port map(d2_c1,d2_c2,d2_c3,alu3c_ex_out,alu3c_mem_out,alu3c_wb_out,alu1c_ex_out,alu1c_mem_out,alu1c_wb_out,ze9_ex_out,ze9_mem_out,ze9_wb_out,OPCODE_CZ_ex,OPCODE_CZ_mem,OPCODE_CZ_wb,rfd2, RF_D2_rr_out);

 
a39:comp_type1 port map(iword_ex_out(5 downto 3),iword_rr_out(8 downto 6),iword_rr_out(11 downto 9),d1_c1,d2_c1);
a40:comp_type1 port map(iword_mem_out(5 downto 3),iword_rr_out(8 downto 6),iword_rr_out(11 downto 9),d1_c2,d2_c2);
a41:comp_type1 port map(iword_wb_out(5 downto 3),iword_rr_out(8 downto 6),iword_rr_out(11 downto 9),d1_c3,d2_c3);

a18:reg_rr_ex port map(clock,'1','0',iword_rr_out,alu2_rr_out,RF_D1_RR_out,RF_D2_rr_out,se6_rr_out,ze9_rr_out,se9_rr_out,pe_rr_out,
						control_rr_out,iword_ex_out,ALU2_ex_out,RF_D1_ex_out,RF_D2_ex_out,SE6_ex_out,ZE9_ex_out,SE9_ex_out,pe_ex_out,control_ex_out);


a19:alu1 port map(iword_ex_out(15 downto 12),iword_ex_out(2),iword_ex_out(1 downto 0),rf_d1_ex_out,rf_d2_ex_out,alu1c_ex_out,alu1_ex_z,alu1_ex_cy);
a20:alu3_a_mux port map(rf_d1_ex_out,alu1c_ex_out,se9_ex_out,se6_ex_out,iword_ex_out(15 downto 12),iword_ex_out(2 downto 0),alu3a_mux_out);
a21:alu3_b_mux port map(rf_d2_ex_out,alu2c_ex_out,se9_ex_out,se6_ex_out,ze_1_ex_out,iword_ex_out(15 downto 12),iword_ex_out(2 downto 0),alu3b_mux_out);

a22:alu_3 port map(alu3a_mux_out,alu3b_mux_out,alu3c_ex_out,alu3_ex_cy,alu3_ex_z);

a23:mux_c_z port map(iword_ex_out(15 downto 12),iword_ex_out(2),iword_ex_out(1 downto 0),alu1_ex_cy,alu3_ex_cy,alu1_ex_z,alu3_ex_z,c_out,z_out);
a24: reg_c port map(c_out,'1',clock,regc_ex_out);
a25: reg_z port map(z_out,'1',clock,regz_ex_out);
a26: ze_1 port map(regc_ex_out,ze_1_ex_out);
a27: pe_adder_mux port map(rf_d1_ex_out,d2_temp,x, PE_ADDER_MUX_OUT);

a29:pe_adder port map(pE_ADDER_MUX_OUT,d1,d2,x);
a30:temp port map(clock,'1',d2,d2_temp);

a31:Reg_ex_mem port map(clock,'1','0',iword_ex_out,alu1c_ex_out,alu2_ex_out,alu3c_ex_out,rf_d1_ex_out,rf_d2_ex_out,ze9_ex_out,d1,pe_ex_out,control_ex_out,
						Iword_mem_out, ALU1C_mem_OUT,ALU2_mem_out,ALU3C_mem_out,RF_D1_mem_out,RF_D2_mem_out,ZE9_mem_out,d1_mem_out,pe_mem_out,control_mem_out);

a32:dmem_a1_mux port map(d1_mem_out,alu3c_mem_out,iword_mem_out(15 downto 12),DMem_A1_out);
a33:dmem_a2_mux port map(d1_mem_out,alu3c_mem_out,iword_mem_out(15 downto 12),DMem_A2_out);
a34:dmem_d2_mux port map(RF_D1_mem_out,RF_D2_mem_out,iword_mem_out(15 downto 12),dmem_d2_out);

a35:d_mem port map(clock,'1',DMem_A1_out,DMem_A2_out,DMem_A2_out,dmem_mem_d1_out);


a36:reg_mem_wb port map(clock,'1','0',iword_mem_out,alu1c_mem_out,alu2_mem_out,alu3c_mem_out,ze9_mem_out,dmem_mem_d1_out,pe_mem_out,control_mem_out,
					        Iword_wb_out, ALU1C_wb_OUT,ALU2_wb_out,ALU3C_wb_out,ZE9_wb_out,Dmem_wb_d1_out,pe_wb_out,control_wb_out);

a37:rf_a3 port map(iword_wb_out(15 downto 12),iword_wb_out(8 downto 6),iword_wb_out(5 downto 3),iword_wb_out(11 downto 9),pe_wb_out,rfa3);

a38:rf_d3 port map(iword_wb_out(15 downto 12),iword_wb_out(2),iword_wb_out(1 downto 0),ZE9_wb_out,alu1c_wb_out,alu2_wb_out,alu3c_wb_out,dmem_wb_d1_out,rfd3);



end architecture struct;

