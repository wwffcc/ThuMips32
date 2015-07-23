----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:14 07/16/2015 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
    Port ( rst : in  STD_LOGIC;
           clk50 : in  STD_LOGIC;
			  clk11:in STD_LOGIC;    
			  clk_step:in STD_LOGIC;
			  
			  SW: in STD_LOGIC_VECTOR(31 downto 0);
			  LED:out STD_LOGIC_VECTOR(15 downto 0);
			  DYP0:out STD_LOGIC_VECTOR(6 downto 0);
			  DYP1:out STD_LOGIC_VECTOR(6 downto 0);
			  
           Ram1Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC;
			  
			  	FlashAddr : out  STD_LOGIC_VECTOR (22 downto 0);
           FlashData : inout  STD_LOGIC_VECTOR (15 downto 0);
           FlashByte : out  STD_LOGIC;
           FlashVpen : out  STD_LOGIC;
           FlashCE : out  STD_LOGIC_VECTOR(2 downto 0);
           FlashOE : out  STD_LOGIC;
           FlashWE : out  STD_LOGIC;
           FlashRP : out  STD_LOGIC;
			  
			  data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC
			  );
end CPU;

architecture Behavioral of CPU is

component Clock
	Port ( clk50 : in  STD_LOGIC;
				clk11:in STD_LOGIC;
				clk_step:in STD_LOGIC;
           clk_cpu : out  STD_LOGIC;
           clk_mm : out  STD_LOGIC;
			  clk_flag:in STD_LOGIC_VECTOR(2 downto 0));
end component;
signal clk_cpu:STD_LOGIC:='0';
signal clk_mm:STD_LOGIC:='0';
signal clk_com:STD_LOGIC:='0';
signal clk_flag:STD_LOGIC_VECTOR(2 downto 0):="111";

component mm_manager
	Port ( rst : in  STD_LOGIC;
           clk_cpu : in  STD_LOGIC;
			  clk_mm:in STD_LOGIC;
			  clk_com: in STD_LOGIC;			  
			  
			  Status: in STD_LOGIC_VECTOR(31 downto 0);
           MemRead : in  STD_LOGIC;
           MemWrite : in  STD_LOGIC;
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);			---
           Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;											---
			  mem_error : out STD_LOGIC_VECTOR(1 downto 0);				---	
			  BadVAddr:out STD_LOGIC_VECTOR(31 downto 0);
			  
			  --TLB mmu
			  Index : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo0 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo1 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryHi : in  STD_LOGIC_VECTOR (31 downto 0);          
           Vaddr : in  STD_LOGIC_VECTOR (31 downto 0);           
           TLBWrite : in  STD_LOGIC;			  
			  
			  --Ram1 Ram2
			  Ram1Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC;
				
				--Flash
				FlashAddr : out  STD_LOGIC_VECTOR (22 downto 0);
           FlashData : inout  STD_LOGIC_VECTOR (15 downto 0);
           FlashByte : out  STD_LOGIC;
           FlashVpen : out  STD_LOGIC;
           FlashCE : out  STD_LOGIC_VECTOR(2 downto 0);
           FlashOE : out  STD_LOGIC;
           FlashWE : out  STD_LOGIC;
           FlashRP : out  STD_LOGIC;
			  
			  --COM
			  data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
				com_Int:out STD_LOGIC;
				
				DYP1:out STD_LOGIC_VECTOR(6 downto 0);
				bitmap:out STD_LOGIC_VECTOR(15 downto 0);
				SW:in STD_LOGIC_VECTOR(6 downto 0)
			  );
end component;
signal MemWrite:STD_LOGIC:='0';
signal MemRead:STD_LOGIC:='0';
signal Data_out:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal Data_in:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal mm_bitmap:STD_LOGIC_VECTOR(15 downto 0):=x"0000";

component RegistersFile
	Port ( rst : in  STD_LOGIC;
           RegAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RegAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RegDataSrc : in  STD_LOGIC_VECTOR (31 downto 0);
           --RegDataCtrl : in  STD_LOGIC_VECTOR (1 downto 0);
           RegWrite : in  STD_LOGIC;
           RegData1 : out  STD_LOGIC_VECTOR (31 downto 0);
           RegData2 : out  STD_LOGIC_VECTOR (31 downto 0);
           RegDst : in  STD_LOGIC_VECTOR (4 downto 0);
			  SW:in STD_LOGIC_VECTOR(5 downto 0);
			  bitmap:out STD_LOGIC_VECTOR(15 downto 0)
			  );
end component;
signal RegAddr1:STD_LOGIC_VECTOR(4 downto 0):="00000";
signal RegAddr2:STD_LOGIC_VECTOR(4 downto 0):="00000";
signal RegDstx:STD_LOGIC_VECTOR(4 downto 0):="00000";
signal RegDataSrcx:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal RegData1:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal RegData2:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal RegWrite:STD_LOGIC:='0';
signal reg_bitmap:STD_LOGIC_VECTOR(15 downto 0):=x"0000";

--CP0
signal Status:STD_LOGIC_VECTOR(31 downto 0):=x"FFFFFFFF";
signal Index:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal EntryLo0:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal EntryLo1:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal EntryHi:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";     
signal BadVAddr:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";     
signal Count:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal Compare:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal Cause:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal EPC:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal EBase:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

--LO,HI
signal LO:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal HI:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

component ALU
	Port ( srcA : in  STD_LOGIC_VECTOR (31 downto 0);
           srcB : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOp: in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal ALUSrcAx:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal ALUSrcBx:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal ALUOp:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal ALUResult:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

component MUL
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (63 downto 0));
end component;
signal MUL_start:STD_LOGIC:='0';				--control mul
signal MULResult:STD_LOGIC_VECTOR(63 downto 0):=(others=>'0');
signal MUL_ready:STD_LOGIC:='0';

component Controller
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           instructions : in  STD_LOGIC_VECTOR (31 downto 0);
           PCWrite : out  STD_LOGIC;
           IorD : out  STD_LOGIC;
           TLBWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           MemDataSrc : out  STD_LOGIC;
			  MemAddrSrc : out STD_LOGIC_VECTOR(1 downto 0);
           IRWrite : out  STD_LOGIC;
           RegDst : out  STD_LOGIC_VECTOR (1 downto 0);
           RegDataSrc : out  STD_LOGIC_VECTOR (2 downto 0);
   --        RegDataCtrl : out  STD_LOGIC_VECTOR (1 downto 0);
           RegWrite : out  STD_LOGIC;
           ALUSrcA : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcB : out  STD_LOGIC_VECTOR (2 downto 0);
           PCSrc : out  STD_LOGIC_VECTOR (2 downto 0);
           PCWriteCond : out  STD_LOGIC_VECTOR (2 downto 0);
           HISrc : out  STD_LOGIC;
           LOSrc : out  STD_LOGIC;
           HIWrite : out  STD_LOGIC;
           LOWrite : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR (3 downto 0);
           ExtendOp : out  STD_LOGIC_VECTOR (2 downto 0);
           ALUOutWrite : out  STD_LOGIC;
           RPCWrite : out  STD_LOGIC;
           CP0Write : out  STD_LOGIC;
			  exc_code: out STD_LOGIC_VECTOR(4 downto 0);
			  EPCWrite: out STD_LOGIC;
			  
			  MUL_start: out STD_LOGIC;
			  MUL_ready: in  STD_LOGIC;
			  Mem_ready:in STD_LOGIC;
			  mem_error:in STD_LOGIC_VECTOR(1 downto 0);
			  timer_Int:in STD_LOGIC;
			  com_Int:in STD_LOGIC;
			  Status:in STD_LOGIC_VECTOR(31 downto 0);
			  set_Cause:out STD_LOGIC;
			  set_EXL:out STD_LOGIC;
			  cause_IP:out STD_LOGIC_VECTOR(5 downto 0);
			  
			  DYP0:out STD_LOGIC_VECTOR(6 downto 0)			  
			  );
end component;
signal instructions:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal PCWrite :STD_LOGIC:='0';
signal IorD :STD_LOGIC:='0';
signal TLBWrite :STD_LOGIC:='0';
--signal MemRead :STD_LOGIC:='0';
--signal MemWrite :STD_LOGIC:='0';
signal MemDataSrc :STD_LOGIC:='0';
signal MemAddrSrc :STD_LOGIC_VECTOR(1 downto 0):="00";
signal IRWrite :STD_LOGIC:='0';
signal RegDst :STD_LOGIC_VECTOR (1 downto 0):="00";
signal RegDataSrc :STD_LOGIC_VECTOR (2 downto 0):="000";
--signal RegDataCtrl :STD_LOGIC_VECTOR (1 downto 0):="00";
--signal RegWrite :STD_LOGIC:='0';
signal ALUSrcA :STD_LOGIC_VECTOR (1 downto 0):="00";
signal ALUSrcB : STD_LOGIC_VECTOR (2 downto 0):="000";
signal PCSrc :STD_LOGIC_VECTOR (2 downto 0):="000";
signal PCWriteCond :STD_LOGIC_VECTOR (2 downto 0):="000";
signal HISrc :STD_LOGIC:='0';
signal LOSrc :STD_LOGIC:='0';
signal HIWrite :STD_LOGIC:='0';
signal LOWrite :STD_LOGIC:='0';
--ALUOp : out  STD_LOGIC_VECTOR (3 downto 0);
signal ExtendOp :STD_LOGIC_VECTOR (2 downto 0):="000";
signal ALUOutWrite :STD_LOGIC:='0';
signal RPCWrite :STD_LOGIC:='0';
signal CP0Write :STD_LOGIC:='0';
signal exc_code:STD_LOGIC_VECTOR(4 downto 0):="00000";
signal EPCWrite:STD_LOGIC:='0';
signal set_Cause: STD_LOGIC:='0';
signal set_EXL: STD_LOGIC:='0';
signal cause_IP: STD_LOGIC_VECTOR(5 downto 0):="000000";

component Extend
	Port ( instruction : in  STD_LOGIC_VECTOR (25 downto 0);
				ExtendOp: in STD_LOGIC_VECTOR(2 downto 0);
           immediate : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal immediate:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

signal com_Int:STD_LOGIC:='0';			--com interrupt
signal timer_Int:STD_LOGIC:='0';			--timer interrupt
--signal timer_ready:STD_LOGIC:='0';		--mark the handle of timer

signal Vaddr:STD_LOGIC_VECTOR (31 downto 0):=x"BFC00000";           
--signal TLBWrite:STD_LOGIC:='0';			  
--signal MemRead:STD_LOGIC:='0';
--signal MemWrite:STD_LOGIC:='0';
--signal Data_in:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
--signal Data_out:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal ready:STD_LOGIC:='0';
signal mem_error:STD_LOGIC_VECTOR(1 downto 0):="00";

--signal HISrc:STD_LOGIC:='0';
--signal LOSrc:STD_LOGIC:='0';
signal ALUOut:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

signal PC:STD_LOGIC_VECTOR(31 downto 0):=x"BFC00000";
--signal RA:STD_LOGIC_VECTOR(31 downto 0):=x"BFC00000";
signal RPC:STD_LOGIC_VECTOR(31 downto 0):=x"BFC00000";

signal C:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";			--CP0 register

type debug_state is(debug_init,debug1);
signal d_state:debug_state:=debug_init;
signal breakpoint:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal enable_debug:STD_LOGIC:='0';

signal CP0_bitmap:STD_LOGIC_VECTOR(15 downto 0):=x"0000";
signal ctrl_bitmap:STD_LOGIC_VECTOR(15 downto 0):=x"0000";
signal host_bitmap:STD_LOGIC_VECTOR(15 downto 0):=x"0000";
--mm_bitmap
--reg_bitmap
begin	
	
	process(rst,SW(23),clk_step)
	begin
		if rst = '0' then
			enable_debug<='0';
			breakpoint<=x"00000000";
			d_state<=debug_init;
		elsif rising_edge(clk_step) then
			case d_state is
				when debug_init=>
					breakpoint<=SW;
					enable_debug<='1';
					d_state<=debug1;					
				when debug1=>					
					if SW(23) ='1' then
						enable_debug<='0';
						breakpoint<=x"00000000";
						d_state<=debug_init;						
					end if;
			end case;
		end if;
	end process;
	
	--clk_flag<="111";
	process(PC,breakpoint,enable_debug)
	begin
		clk_flag<="111";
		if PC = breakpoint and enable_debug='1' then
			clk_flag<="111";
		--else
		--	clk_flag
		end if;
	end process;
		
	process(enable_debug,SW)
	begin
		if enable_debug = '0' then
			LED<=x"0000";
		else
			case SW(10 downto 8) is
				when "000"=>
					LED<=ctrl_bitmap;
				when "001"=>					
					LED<=mm_bitmap;
				when "010"=>
					LED<=reg_bitmap;
				when "011"=>
					LED<=host_bitmap;
				when "100"=>
					LED<=CP0_bitmap;
				when others=>
					LED<=(others=>'0');
			end case;
		end if;
	end process;	
	
	--EBase<=x"80000000";	

	u0:Clock PORT MAP(
		clk50=>clk50,
			clk11=>clk11,
			clk_step=>clk_step,
		  clk_cpu=>clk_cpu,
		  clk_mm=>clk_mm,
		  clk_flag=>clk_flag
	);
	
	u1:mm_manager PORT MAP(
		rst=>rst,
      clk_cpu=>clk_cpu,
		clk_mm=>clk_mm,
		clk_com=>clk_com,			  
		Status=>Status,
		  MemRead=>MemRead,
		  MemWrite=>MemWrite,
		  Data_out=>Data_out,
		  Data_in=>Data_in,
		  ready=>ready,
		  mem_error=>mem_error,
		  BadVAddr=>BadVAddr,		  
		  --TLB mmu
		  Index=>Index,
		  EntryLo0=>EntryLo0,
		  EntryLo1=>EntryLo1,
		  EntryHi=>EntryHi,
		  Vaddr=>Vaddr,
		  TLBWrite=>TLBWrite,		  
		  --Ram1 Ram2
		  Ram1Addr=>Ram1Addr,
		  Ram1Data=>Ram1Data,
		  Ram1EN=>Ram1EN,
		  Ram1OE=>Ram1OE,
		  Ram1WE=>Ram1WE,
		  Ram2Addr=>Ram2Addr,
		  Ram2Data=>Ram2Data,
		  Ram2EN=>Ram2EN,
		  Ram2OE=>Ram2OE,
		  Ram2WE=>Ram2WE,			
			--Flash
			FlashAddr=>FlashAddr,
		  FlashData=>FlashData,
		  FlashByte=>FlashByte,
		  FlashVpen=>FlashVpen,
		  FlashCE=>FlashCE,
		  FlashOE=>FlashOE,
		  FlashWE=>FlashWE,
		  FlashRP=>FlashRP,		  
		  --COM
		  data_ready=>data_ready,
		  rdn=>rdn,
		  tbre=>tbre,
		  tsre=>tsre,
		  wrn=>wrn,
		  com_Int=>com_Int,
		  
		  DYP1=>DYP1,
			bitmap=>mm_bitmap,
			SW=>SW(6 downto 0)
	);
	
	u2:RegistersFile PORT MAP(
		rst=>rst,
		  RegAddr1=>RegAddr1,
		  RegAddr2=>RegAddr2,
		  RegDataSrc=>RegDataSrcx,
		  RegData1=>RegData1,
		  RegData2=>RegData2,
		  RegDst=>RegDstx,
		  RegWrite=>RegWrite,
		  SW=>SW(5 downto 0),
		  bitmap=>reg_bitmap
	);
	
	u3:ALU PORT MAP(
		 srcA=>ALUSrcAx,
       srcB=>ALUSrcBx,
		 ALUOp=>ALUOp,
       result=>ALUResult
	);
	
	u4:MUL PORT MAP(
		rst=>rst,
      clk=>clk_cpu,
      start=>MUL_start,
      A=>RegData1,
      B=>RegData2,
      ready=>MUL_ready,
      R=>MULResult
	);
	
	u5:Controller PORT MAP(
		rst=>rst,
      clk=>clk_cpu,
		  instructions=>instructions,
		  PCWrite=>PCWrite,
		  IorD=>IorD,
		  TLBWrite=>TLBWrite,
		  MemRead=>MemRead,
		  MemWrite=>MemWrite,
		  MemDataSrc=>MemDataSrc,
		  MemAddrSrc=>MemAddrSrc,
		  IRWrite=>IRWrite,
		  RegDst=>RegDst,
		  RegDataSrc=>RegDataSrc,
		  
		  RegWrite=>RegWrite,
		  ALUSrcA=>ALUSrcA,
		  ALUSrcB=>ALUSrcB,
		  PCSrc=>PCSrc,
		  PCWriteCond=>PCWriteCond,
		  HISrc=>HISrc,
		  LOSrc=>LOSrc,
		  HIWrite=>HIWrite,
		  LOWrite=>LOWrite,
		  ALUOp=>ALUOp,
		  ExtendOp=>ExtendOp,
		  ALUOutWrite=>ALUOutWrite,
		  RPCWrite=>RPCWrite,
		  CP0Write=>CP0Write,
		  exc_code=>exc_code,
		  EPCWrite=>EPCWrite,
		  
		  MUL_start=>MUL_start,
		  MUL_ready=>MUL_ready,
		  Mem_ready=>ready,
		  mem_error=>mem_error,
		  timer_Int=>timer_Int,
		  com_Int=>com_Int,
		  Status=>Status,
		  set_Cause=>set_Cause,
			set_EXL=>set_EXL,
			cause_IP=>cause_IP,
			
		 DYP0=>DYP0
	);
	
	u6:Extend PORT MAP(
		 instruction=>instructions(25 downto 0),
		ExtendOp=>ExtendOp,
        immediate=>immediate
	);
	
	process(rst,clk_cpu)
	begin
		if rst = '0' then
			timer_Int<='0';
			Count<=(others=>'0');
			Compare<=x"02FAF080";						--Compare			
		elsif rising_edge(clk_cpu) then
			Count<=Count+1;
			if Count = Compare then
				timer_Int<='1';							
				Count<=(others=>'0');
			end if;
			if Status(1)='1' then
				timer_Int<='0';
			end if;
		end if;
	end process;
	
--	process(ALUOutWrite)
--	begin		
--		if rising_edge(ALUOutWrite) then
--			ALUOut<=ALUResult;
--		end if;
--	end process;
	process(ALUOutWrite,clk_cpu)
	begin
		if rising_edge(clk_cpu) then
			if ALUOutWrite = '1' then
				ALUOut<=ALUResult;
			end if;
		end if;
	end process;
	
----	process(EPCWrite)
----	begin
----		if rising_edge(EPCWrite) then
----			EPC<=PC-4;													--EPC
----		end if;
----	end process;	
--	
	process(rst,PCWrite,PCWriteCond,PCSrc)						--update PC
	begin
		if rst = '0' then
			--PC<=x"BFC00000";
			PC<=SW;														--debug
		elsif rising_edge(PCWrite) then
			case PCWriteCond is
				when "000"=>
					case PCSrc is
						when "000"=>PC<=ALUResult;
						when "001"=>PC<=ALUOut;
						when "010"=>PC<=immediate;
						when "011"=>PC<=RegData1;
						when "100"=>PC<=EPC;
						when others=>NULL;				
					end case;
				when "001"=>										--BEQ
					if ALUResult = 0 then
						PC<=ALUOut;
					end if;
				when "010"=>										--BGEZ
					if ALUResult = 0 or ALUResult(31)='1' then		--ALUResult<=0
						PC<=ALUOut;
					end if;
				when "011"=>										--BGTZ
					if ALUResult(31)='1' then
						PC<=ALUOut;
					end if;
				when "100"=>										--BLEZ
					if ALUResult = 0 or ALUResult(31)='0' then
						PC<=ALUOut;
					end if;
				when "101"=>
					if ALUResult(31)='0' then							--BLTZ
						PC<=ALUOut;
					end if;
				when "110"=>										--BNE
					if ALUResult/=0 then
						PC<=ALUOut;
					end if;
				when "111"=>										--interrupt
					PC<=EBase+x"00000180";
				when others=>NULL;
			end case;
		end if;
	end process;
	
	process(MemAddrSrc,IorD,PC,ALUResult)
	begin
		case IorD is
			when '0'=>
				Vaddr<=PC;
			when '1'=>
				Vaddr<=ALUResult;
				case MemAddrSrc is				
					when "01"=>						
						Vaddr(1)<='0';				
					when "10"=>
						Vaddr(1 downto 0)<="00";
					when others=>null;
				end case;
			when others=>NULL;			
		end case;
	end process;
	
	process(MemDataSrc,ALUResult,RegData2,Data_out)
	begin
		case MemDataSrc is
			when '0'=>
				Data_in<=RegData2;				--[Rt]
			when '1'=>								--SB
				Data_in<=Data_out;
				case ALUResult(1 downto 0) is
					when "00"=>
						Data_in(7 downto 0)<=RegData2(7 downto 0);
					when "01"=>
						Data_in(15 downto 8)<=RegData2(7 downto 0);
					when "10"=>
						Data_in(23 downto 16)<=RegData2(7 downto 0);
					when "11"=>
						Data_in(31 downto 24)<=RegData2(7 downto 0);
					when others=>
						NULL;
				end case;				
			when others=>NULL;
		end case;
	end process;
	
	process(IRWrite)
	begin
		if rising_edge(IRWrite) then
			instructions<=Data_out;			
		end if;
	end process;
	
	RegAddr1<=instructions(25 downto 21);
	RegAddr2<=instructions(20 downto 16);
	
	process(RegDst,instructions)
	begin
		RegDstx<="00000";
		--RA<=RA;
		case RegDst is
			when "00"=>
				RegDstx<=instructions(15 downto 11);
			when "01"=>
				RegDstx<=instructions(20 downto 16);
			when "10"=>
				RegDstx<="11111";
			when others=>NULL;
		end case;
	end process;
	
	process(RPCWrite)
	begin
		if rising_edge(RPCWrite) then
			RPC<=PC;
		end if;
	end process;
	
--	with RegDataSrc select
--		RegDataSrcx<=
--					ALUResult	when "000",
--					LO				when "001",
--					HI				when "010",
--					Data_out		when "011",
--					RPC			when "100",
--					immediate(15 downto 0) & x"0000" when "101",
--					C				when "110",
--					x"FFFFFFFF"	when "111";
	process(RegDataSrc,ALUResult,LO,HI,Data_out,RPC,immediate,RegData2,C,instructions)
	begin
		case RegDataSrc is
			when "000"=>
					RegDataSrcx<=ALUResult;
			when "001"=>
					RegDataSrcx<=LO;
			when "010"=>
					RegDataSrcx<=HI;
			when "011"=>
					--RegDataSrcx<=Data_out;
					case ALUResult(1 downto 0) is
						when "00"=>
							RegDataSrcx(7 downto 0)<=Data_out(7 downto 0);
							if instructions(28)='0' then
								RegDataSrcx(31 downto 8)<=(others=>Data_out(7));
							else
								RegDataSrcx(31 downto 8)<=(others=>'0');
							end if;
						when "01"=>
							RegDataSrcx(7 downto 0)<=Data_out(15 downto 8);							
							if instructions(28)='0' then							--LB
								RegDataSrcx(31 downto 8)<=(others=>Data_out(15));
							else
								RegDataSrcx(31 downto 8)<=(others=>'0');
							end if;
						when "10"=>
							RegDataSrcx(7 downto 0)<=Data_out(23 downto 16);
							if instructions(28)='0' then
								RegDataSrcx(31 downto 8)<=(others=>Data_out(23));
							else
								RegDataSrcx(31 downto 8)<=(others=>'0');
							end if;
						when "11"=>
							RegDataSrcx(7 downto 0)<=Data_out(31 downto 24);
							if instructions(28)='0' then
								RegDataSrcx(31 downto 8)<=(others=>Data_out(31));						
							else
								RegDataSrcx(31 downto 8)<=(others=>'0');
							end if;
						when others=>NULL;
					end case;
			when "100"=>
					RegDataSrcx<=RPC;
			when "101"=>
					RegDataSrcx(31 downto 16)<=immediate(15 downto 0);
					RegDataSrcx(15 downto 0)<=(others=>'0');
					--RegDataSrcx(15 downto 0)<=RegData2(15 downto 0);
			when "110"=>
					RegDataSrcx(31 downto 0)<=C;
			when others=>
					RegDataSrcx(31 downto 0)<=ALUResult;
		end case;
	end process;
	
	with ALUSrcA select
		ALUSrcAx<=
					PC				when "00",
					RegData1		when "01",
					RegData2		when "10",
					EBase			when "11";
	
	with ALUSrcB select
		ALUSrcBx<=
					x"00000004"	when "000",
					RegData2		when "001",
					immediate	when "010",
					x"00000000" when "011",
					RegData1		when "100",
					x"00000180"	when "101",
					x"00000000" when others;
	
	process(HIWrite)
	begin
		if rising_edge(HIWrite) then
			case HISrc is
				when '0'=>
					HI<=RegData1;
				when '1'=>
					HI<=MULResult(63 downto 32);
				when others=>
					null;
			end case;
		end if;
	end process;
	
	process(LOWrite)
	begin
		if rising_edge(LOWrite) then
			case LOSrc is
				when '0'=>
					LO<=RegData1;
				when '1'=>
					LO<=MULResult(31 downto 0);
				when others=>NULL;
			end case;
		end if;
	end process;
	
	process(rst,clk_cpu)--,CP0Write,set_Cause,set_EXL)
	begin
		if rst = '0' then
			Index<=(others=>'0');
			EntryLo0<=(others=>'0');
			EntryLo1<=(others=>'0');
			EntryHi<=(others=>'0');
			Status<=(others=>'1');
			EBase<=x"80000000";
			Cause<=(others=>'0');
			EPC<=(others=>'0');
		elsif rising_edge(clk_cpu) then
			if CP0Write='1' then
				case instructions(15 downto 11) is
					when "00000"=>								--Index		0
						Index<=RegData2;
					when "00010"=>								--EntryLo0  2
						EntryLo0<=RegData2;
					when "00011"=>								--EntryLo1	3
						EntryLo1<=RegData2;
					when "01001"=>								--BadVAddr	9
						NULL;--BadVAddr<=RegData2;
					when "01010"=>								--Count		10
						NULL;
					when "01011"=>								--EntryHi	11
						EntryHi<=RegData2;
					when "01100"=>								--compare	12
						NULL;
					when "01101"=>								--Status		13
						Status<=RegData2;
					when "01111"=>								--Cause 		15
						Cause<=RegData2;					
					when "10000"=>								--EPC			16
						Cause<=RegData2;
					when "10010"=>								--EBase		18
						Cause<=EBase;
					when others=>NULL;
				end case;	
			else
				if set_Cause = '1' then
					Cause(6 downto 2)<=exc_code;
					Cause(15)<=Cause_IP(5);
					Cause(10)<=Cause_IP(0);
				end if;
				if set_EXL = '1' then
					Status(1)<='1';
				else
					Status(1)<='0';
				end if;
				if EPCWrite = '1' then
					EPC<=PC-4;
				end if;
			end if;
		end if;
	end process;		
	
	with instructions(15 downto 11) select
		C<=
			Index							when "00000",
			EntryLo0						when "00010",
			EntryLo1						when "00011",
			BadVAddr						when "01001",
			Count							when "01010",
			EntryHi						when "01011",
			compare						when "01100",
			Status						when "01101",
			Cause							when "01111",
			EPC							when "10000",
			EBase							when "10010",
			x"00000000"					when others;
			
	process(SW(4 downto 0))
	begin
		if SW(4) = '0' then
			case SW(3 downto 0) is
				when "0000"=>
					CP0_bitmap<=Index(15 downto 0);
				when "0001"=>
					CP0_bitmap<=EntryLo0(15 downto 0);
				when "0010"=>
					CP0_bitmap<=EntryLo1(15 downto 0);
				when "0011"=>
					CP0_bitmap<=BadVAddr(15 downto 0);
				when "0100"=>
					CP0_bitmap<=Count(15 downto 0);
				when "0101"=>
					CP0_bitmap<=EntryHi(15 downto 0);
				when "0110"=>
					CP0_bitmap<=compare(15 downto 0);
				when "0111"=>
					CP0_bitmap<=Status(15 downto 0);
				when "1000"=>
					CP0_bitmap<=Cause(15 downto 0);
				when "1001"=>
					CP0_bitmap<=EPC(15 downto 0);
				when "1010"=>
					CP0_bitmap<=EBase(15 downto 0);
				when "1011"=>
					CP0_bitmap<=LO(15 downto 0);
				when "1100"=>
					CP0_bitmap<=HI(15 downto 0);
				when "1101"=>
					CP0_bitmap<=PC(15 downto 0);
				when "1110"=>
					CP0_bitmap<=RPC(15 downto 0);
				when "1111"=>
					CP0_bitmap<=ALUOut(15 downto 0);
				when others=>
					CP0_bitmap<=(others=>'0');
			end case;
		else
			case SW(3 downto 0) is
				when "0000"=>
					CP0_bitmap<=Index(31 downto 16);
				when "0001"=>
					CP0_bitmap<=EntryLo0(31 downto 16);
				when "0010"=>
					CP0_bitmap<=EntryLo1(31 downto 16);
				when "0011"=>
					CP0_bitmap<=BadVAddr(31 downto 16);
				when "0100"=>
					CP0_bitmap<=Count(31 downto 16);
				when "0101"=>
					CP0_bitmap<=EntryHi(31 downto 16);
				when "0110"=>
					CP0_bitmap<=compare(31 downto 16);
				when "0111"=>
					CP0_bitmap<=Status(31 downto 16);
				when "1000"=>
					CP0_bitmap<=Cause(31 downto 16);
				when "1001"=>
					CP0_bitmap<=EPC(31 downto 16);
				when "1010"=>
					CP0_bitmap<=EBase(31 downto 16);
				when "1011"=>
					CP0_bitmap<=LO(31 downto 16);
				when "1100"=>
					CP0_bitmap<=HI(31 downto 16);
				when "1101"=>
					CP0_bitmap<=PC(31 downto 16);
				when "1110"=>
					CP0_bitmap<=RPC(31 downto 16);
				when "1111"=>
					CP0_bitmap<=ALUOut(31 downto 16);
				when others=>
					CP0_bitmap<=(others=>'0');
			end case;
		end if;
	end process;
	
	process(SW(4 downto 0))
	begin
		ctrl_bitmap<=(others=>'0');
		case SW(4 downto 0) is
			when "00000"=>
				ctrl_bitmap(0)<=PCWrite;
			when "00001"=>
				ctrl_bitmap(0)<=IorD;
			when "00010"=>
				ctrl_bitmap(0)<=TLBWrite;
			when "00011"=>
				ctrl_bitmap(0)<=MemRead;
			when "00100"=>
				ctrl_bitmap(0)<=MemWrite;
			when "00101"=>
				ctrl_bitmap(0)<=MemDataSrc;
			when "00110"=>
				ctrl_bitmap(1 downto 0)<=MemAddrSrc;
			when "00111"=>
				ctrl_bitmap(0)<=IRWrite;
			when "01000"=>
				ctrl_bitmap(1 downto 0)<=RegDst;
			when "01001"=>
				ctrl_bitmap(2 downto 0)<=RegDataSrc;
			when "01010"=>
				ctrl_bitmap(0)<=RegWrite;	
			when "01011"=>
				ctrl_bitmap(1 downto 0)<=ALUSrcA;
			when "01100"=>
				ctrl_bitmap(2 downto 0)<=ALUSrcB;
			when "01101"=>
				ctrl_bitmap(2 downto 0)<=PCSrc;
			when "01110"=>
				ctrl_bitmap(2 downto 0)<=PCWriteCond;
			when "01111"=>
				ctrl_bitmap(0)<=HISrc;
			when "10000"=>
				ctrl_bitmap(0)<=LOSrc;
			when "10001"=>
				ctrl_bitmap(0)<=HIWrite;
			when "10010"=>
				ctrl_bitmap(0)<=LOWrite;
			when "10011"=>
				ctrl_bitmap(3 downto 0)<=ALUOp;
			when "10100"=>
				ctrl_bitmap(2 downto 0)<=ExtendOp;
			when "10101"=>
				ctrl_bitmap(0)<=ALUOutWrite;
			when "10110"=>
				ctrl_bitmap(0)<=RPCWrite;
			when "10111"=>
				ctrl_bitmap(0)<=CP0Write;
			when "11000"=>
				ctrl_bitmap(4 downto 0)<=exc_code;
			when "11001"=>
				ctrl_bitmap(0)<=EPCWrite;
			when "11010"=>
				ctrl_bitmap(0)<=set_Cause;
			when "11011"=>
				ctrl_bitmap(0)<=set_EXL;
			when "11100"=>
				ctrl_bitmap(5 downto 0)<=cause_IP;	
			when "11101"=>
				ctrl_bitmap(0)<=timer_Int;	
				ctrl_bitmap(1)<=com_Int;
			when "11110"=>
				ctrl_bitmap(1 downto 0)<=mem_error;
			when others=>
				ctrl_bitmap<=(others=>'0');
		end case;
	end process;
	
	process(SW(5 downto 0))
	begin
		case SW(5 downto 3) is
			when "000"=>
				if SW(0) = '0' then
					host_bitmap<=instructions(15 downto 0);
				else
					host_bitmap<=instructions(31 downto 16);
				end if;
			when "001"=>
				case SW(2) is
					when '0'=>
						if SW(0) = '0' then
							host_bitmap<=Data_in(15 downto 0);
						else
							host_bitmap<=Data_in(31 downto 16);
						end if;
					when '1'=>
						if SW(0) = '0' then
							host_bitmap<=Data_out(15 downto 0);
						else
							host_bitmap<=Data_out(31 downto 16);
						end if;
					when others=>host_bitmap<=(others=>'0');
				end case;
			when "010"=>
				case SW(2 downto 0) is
					when "000"=>
						host_bitmap(4 downto 0)<=RegDstx;
						host_bitmap(15 downto 5)<=(others=>'0');
					when "010"=>
						host_bitmap<=RegDataSrcx(15 downto 0);
					when "011"=>
						host_bitmap<=RegDataSrcx(31 downto 16);
					when "100"=>
						host_bitmap<=RegData1(15 downto 0);
					when "101"=>
						host_bitmap<=RegData1(31 downto 16);
					when "110"=>
						host_bitmap<=RegData2(15 downto 0);
					when "111"=>
						host_bitmap<=RegData2(31 downto 16);
					when others=>
						host_bitmap<=(others=>'0');
				end case;
			when "011"=>
				if SW(2) = '0' then
					if SW(1)='0' then
						if SW(0)='0' then
							host_bitmap<=ALUSrcAx(15 downto 0);
						else
							host_bitmap<=ALUSrcAx(31 downto 16);
						end if;
					else
						if SW(0)='0' then
							host_bitmap<=ALUSrcBx(15 downto 0);
						else
							host_bitmap<=ALUSrcBx(31 downto 16);
						end if;
					end if;	
				else
					if SW(0)='0' then
						host_bitmap<=ALUResult(15 downto 0);
					else
						host_bitmap<=ALUResult(31 downto 16);
					end if;
				end if;
			when "100"=>
				if SW(2)='0' then
					host_bitmap(0)<=MUL_start;
					host_bitmap(1)<=MUL_ready;
					host_bitmap(15 downto 2)<=(others=>'0');
				else
					case SW(1 downto 0) is
						when "00"=>
							host_bitmap<=MULResult(15 downto 0);
						when "01"=>
							host_bitmap<=MULResult(31 downto 16);
						when "10"=>
							host_bitmap<=MULResult(47 downto 32);
						when "11"=>
							host_bitmap<=MULResult(63 downto 48);
						when others=>
							host_bitmap<=(others=>'0');
					end case;
				end if;
			when "101"=>				
				case SW(1 downto 0) is
					when "00"=>
						host_bitmap<=immediate(15 downto 0);
					when "01"=>
						host_bitmap<=immediate(31 downto 16);
					when "10"=>
						host_bitmap<=C(15 downto 0);
					when "11"=>
						host_bitmap<=C(31 downto 16);
					when others=>
						host_bitmap<=(others=>'0');
				end case;													
			when others=>host_bitmap<=(others=>'0');
		end case;
	end process;
	
end Behavioral;

