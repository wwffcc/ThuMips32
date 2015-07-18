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
           clk : in  STD_LOGIC;
			  
           --SW : in  STD_LOGIC_VECTOR (31 downto 0);
           LED : out  STD_LOGIC_VECTOR (15 downto 0);
			  DYP0: out STD_LOGIC_VECTOR (6 downto 0);
			  DYP1: out STD_LOGIC_VECTOR (6 downto 0);
			  
           Ram1Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is

component mm_manager
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           MemRead : in  STD_LOGIC;
           MemWrite : in  STD_LOGIC;
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);			---
           Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;											---
			  mem_error : out STD_LOGIC_VECTOR(1 downto 0);				---
			  
			  --DYP0: out STD_LOGIC_VECTOR (6 downto 0);
			  DYP1: out STD_LOGIC_VECTOR (6 downto 0);
			  
			  --TLB mmu
			  Index : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo0 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo1 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryHi : in  STD_LOGIC_VECTOR (31 downto 0);          
           Vaddr : in  STD_LOGIC_VECTOR (31 downto 0);           
           TLBWrite : in  STD_LOGIC;			  
			  
			  --Ram1 Ram2
			  Ram1Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC						 
			  );
end component;

signal Index:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal EntryLo0:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal EntryLo1:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal EntryHi:STD_LOGIC_VECTOR (31 downto 0):=x"00000000";          
signal Vaddr:STD_LOGIC_VECTOR (31 downto 0):=x"BFC00000";           
signal TLBWrite:STD_LOGIC:='0';			  
signal MemRead:STD_LOGIC:='0';
signal MemWrite:STD_LOGIC:='0';
signal Data_in:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal Data_out:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal ready:STD_LOGIC:='0';
signal mem_error:STD_LOGIC_VECTOR(1 downto 0):="00";

type cpu_state_type is (ST0,ST1,ST2);
signal cpu_state:cpu_state_type:=ST0;

begin
	u1:mm_manager PORT MAP(
		rst=>rst,
		  clk=>clk,
		  MemRead=>MemRead,
		  MemWrite=>MemWrite,
		  Data_out=>Data_out,
		  Data_in=>Data_in,
		  ready=>ready,
		  mem_error=>mem_error,
		  
		  --DYP0=>DYP0,
		  DYP1=>DYP1,
		  
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
		  Ram2WE=>Ram2WE
	);
	
	process(rst,clk)
	begin
		if rst = '0' then
			MemRead<='0';
			MemWrite<='0';
			Data_in<=(others=>'0');
			Index<=(others=>'0');
			EntryLo0<=(others=>'0');
         EntryLo1<=(others=>'0');
         EntryHi<=(others=>'0');
         Vaddr<=x"BFC00000";
         TLBWrite<='0';
		elsif clk'event and clk = '1' then
			case cpu_state is
				when ST0=>
					MemRead<='1';
					if ready='1' then
						LED<=data_out(15 downto 0);
						cpu_state<=ST1;
					end if;
				when ST1=>
					MemRead<='0';
					cpu_state<=ST0;
					Vaddr<=Vaddr+x"00000004";
				when others=>NULL;
			end case;
		end if;
		
		case cpu_state is
			when ST0=> DYP0<=not "1000000";
			when ST1=> DYP0<=not "1111001";
--			when ST2=> DYP0<=not "0100100";
--			when ST3=> DYP0<=not "0110000";
--			when ST4=> DYP0<=not "0011001";
--			when RT2=> DYP0<=not "0010010";
--			when RT3=> DYP0<=not "0000010";
--			when RT4=> DYP0<=not "1111000";
	--		when ST8=> DYP0<=not "0000000";
	--		when ST9=> DYP0<=not "0010000";
	--		when TT0=> DYP0<=not "1000000";
	--		when TT1=> DYP0<=not "1111001";
	--		when TT2=> DYP0<=not "0100100";
	--		when TT3=> DYP0<=not "0110000";
	--		when TT4=> DYP0<=not "0011001";
	--		when TT5=> DYP0<=not "0010010";
			when others=> DYP0<=not "1111111";
		end case;
	end process;
end Behavioral;

