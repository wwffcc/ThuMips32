----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:36:07 07/15/2015 
-- Design Name: 
-- Module Name:    mm_manager - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mm_manager is
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
end mm_manager;

architecture Behavioral of mm_manager is
--------------component
component TLB
	Port ( rst : in  STD_LOGIC;
           Index : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo0 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo1 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryHi : in  STD_LOGIC_VECTOR (31 downto 0);          
           Vaddr : in  STD_LOGIC_VECTOR (31 downto 0);
           Paddr : out  STD_LOGIC_VECTOR (31 downto 0);
           TLBWrite : in  STD_LOGIC;
           flag_missing : out  STD_LOGIC;
           flag_writable : out  STD_LOGIC);
end component;
signal flag_missing:STD_LOGIC:='0';
signal flag_writable:STD_LOGIC:='0';
signal Paddr:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

component Rom
	Port ( Paddr : in  STD_LOGIC_VECTOR (11 downto 0);
           data : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal romdata:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

signal flag:STD_LOGIC_VECTOR(2 downto 0):="111";

type state_type is (init_state,ram1Read0,ram1Read1,ram1Write0,ram1Write1,
					ram2Read0,ram2Read1,ram2Write0,ram2Write1);
signal cur_state:state_type:=init_state;

begin
	flag<="000" when Paddr>=x"1FC00000" and Paddr<=x"1FC00FFF" else
			"001" when Paddr>=x"00000000" and Paddr<=x"003FFFFF" else
			"010" when Paddr>=x"00400000" and Paddr<=x"007FFFFF" else
			"011" when Paddr>=x"1E000000" and Paddr<=x"1EFFFFFF" else
			"100" when Paddr =x"1FD003F8" else
			"101" when Paddr =x"1FD003FC" else
			"111";
	
	mmu:TLB PORT MAP(
		rst=>rst,
	  Index=>Index,
	  EntryLo0=>EntryLo0,
	  EntryLo1=>EntryLo1,
	  EntryHi=>EntryHi,
	  Vaddr=>Vaddr,
	  Paddr=>Paddr,
	  TLBWrite=>TLBWrite,
	  flag_missing=>flag_missing,
	  flag_writable=>flag_writable
	);
	
	rom_access:Rom PORT MAP(
		Paddr=>Paddr(11 downto 0),
      data=>romData
	);
	
	process(rst,clk,MemRead,MemWrite)
	begin
		if rst = '0' or (MemRead = '0' and MemWrite='0') then
			Data_out<=(others=>'0');
			ready<='0';
			mem_error<="00";
			Ram1EN<='1';
			Ram2EN<='1';
		elsif rising_edge(clk) then
			case flag is
				when "000"=>								--Rom
					data_out<=romData;
					ready<='1';
				when "001"=>								--Ram1
					if MemRead = '1' then					-- read
						case cur_state is
							when init_state=>
								Ram1EN<='0';
								Ram1OE<='1';
								Ram1WE<='1';
								Ram1Addr<=Paddr;
								Ram1Data<=(others=>'Z');
								cur_state<=ram1Read0;
							when ram1Read0=>							
								Ram1OE<='0';
								cur_state<=ram1Read1;
							when ram1Read1=>
								Ram1EN<='1';
								Ram1OE<='1';
								data_out<=Ram1Data;
								ready<='1';
								cur_state<=init_state;
							when others=>NULL;
						end case;
					else											--write
						case cur_state is
							when init_state=>
								Ram1EN<='0';
								Ram1OE<='1';
								Ram1WE<='1';
								Ram1Addr<=Paddr;
								Ram1Data<=data_in;
								cur_state<=ram1Write0;
							when ram1Write0=>
								Ram1WE<='0';
								cur_state<=ram1Write1;
							when ram1Write1=>
								Ram1EN<='1';
								Ram1WE<='1';
								ready<='1';
								cur_state<=init_state;
							when others=>NULL;
						end case;
					end if;
				when "010"=>							--Ram2
					if MemRead = '1' then					-- read
						case cur_state is
							when init_state=>
								Ram2EN<='0';
								Ram2OE<='1';
								Ram2WE<='1';
								Ram2Addr<=Paddr;
								Ram2Data<=(others=>'0');
								cur_state<=ram2Read0;
							when ram2Read0=>							
								Ram2OE<='0';
								cur_state<=ram2Read1;
							when ram2Read1=>
								Ram2EN<='1';
								Ram2OE<='1';
								data_out<=Ram2Data;
								ready<='1';
								cur_state<=init_state;
							when others=>NULL;
						end case;
					else											--write
						case cur_state is
							when init_state=>
								Ram2EN<='0';
								Ram2OE<='1';
								Ram2WE<='1';
								Ram2Addr<=Paddr;
								Ram2Data<=data_in;
								cur_state<=ram2Write0;
							when ram2Write0=>
								Ram2WE<='0';
								cur_state<=ram2Write1;
							when ram2Write1=>
								Ram2EN<='1';
								Ram2WE<='1';
								ready<='1';
								cur_state<=init_state;
							when others=>NULL;
						end case;
					end if;
				when others=>
					NULL;
			end case;
		end if;
		
		case cur_state is
		when init_state=> DYP1<=not "1000000";
		when ram1Read0=> DYP1<=not "1111001";
		when ram1Read1=> DYP1<=not "0100100";
		when ram1Write0=> DYP1<=not "0110000";
		when ram1Write1=> DYP1<=not "0011001";
		when ram2Read0=> DYP1<=not "0010010";
		when ram2Read1=> DYP1<=not "0000010";
		when ram2Write0=> DYP1<=not "1111000";
		when ram2Write1=> DYP1<=not "0000000";
--		when ST9=> DYP0<=not "0010000";
--		when TT0=> DYP0<=not "1000000";
--		when TT1=> DYP0<=not "1111001";
--		when TT2=> DYP0<=not "0100100";
--		when TT3=> DYP0<=not "0110000";
--		when TT4=> DYP0<=not "0011001";
--		when TT5=> DYP0<=not "0010010";
		when others=> DYP1<=not "1111111";
		end case;
		
	end process;
	
end Behavioral;

