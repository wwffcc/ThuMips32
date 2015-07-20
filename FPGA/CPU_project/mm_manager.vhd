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
           clk_cpu : in  STD_LOGIC;
			  clk_mm:in STD_LOGIC;
			  clk11: in STD_LOGIC;			  
			  
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
				
				DYP1:STD_LOGIC_VECTOR(6 downto 0)
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

component Device_Ram1
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ram1Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram1_Ready : out  STD_LOGIC;
			  Paddr:in STD_LOGIC_VECTOR(19 downto 0);
			  data_in:in STD_LOGIC_VECTOR(31 downto 0);
			  data_out:out STD_LOGIC_VECTOR(31 downto 0);
           Ram1Write : in  STD_LOGIC;
           Ram1Read : in  STD_LOGIC);
end component;
signal ram1_ready:STD_LOGIC:='0';
signal ram1Write:STD_LOGIC:='0';
signal ram1Read:STD_LOGIC:='0';
signal ram1_data:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

component Device_Ram2
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC;
           Ram2_Ready : out  STD_LOGIC;
			  Paddr:in STD_LOGIC_VECTOR(19 downto 0);
			  data_in:in STD_LOGIC_VECTOR(31 downto 0);
			  data_out:out STD_LOGIC_VECTOR(31 downto 0);
           Ram2Write : in  STD_LOGIC;
           Ram2Read : in  STD_LOGIC);
end component;
signal ram2_ready:STD_LOGIC:='0';
signal ram2Write:STD_LOGIC:='0';
signal ram2Read:STD_LOGIC:='0';
signal ram2_data:STD_LOGIC_VECTOR(31 downto 0);

component Device_Flash
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           FlashAddr : out  STD_LOGIC_VECTOR (22 downto 0);
           FlashData : inout  STD_LOGIC_VECTOR (15 downto 0);
           FlashByte : out  STD_LOGIC;
           FlashVpen : out  STD_LOGIC;
           FlashCE : out  STD_LOGIC_VECTOR(2 downto 0);
           FlashOE : out  STD_LOGIC;
           FlashWE : out  STD_LOGIC;
           FlashRP : out  STD_LOGIC;
           FlashWrite : in  STD_LOGIC;
           FlashRead : in  STD_LOGIC;
           Flash_Ready : out  STD_LOGIC;
			  Paddr: in STD_LOGIC_VECTOR(22 downto 0);
           Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal flash_ready:STD_LOGIC:='0';
signal flashWrite:STD_LOGIC:='0';
signal flashRead:STD_LOGIC:='0';
signal flash_data:STD_LOGIC_VECTOR(31 downto 0);

component Device_COM
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
			  Ram1Data:inout STD_LOGIC_VECTOR(31 downto 0);
           COM_Ready : out  STD_LOGIC;
           COM_Write : in  STD_LOGIC;
           COM_Read : in  STD_LOGIC;
			  COM_INT: out STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Status_out:out STD_LOGIC_VECTOR(31 downto 0));
end component;
signal com_ready:STD_LOGIC:='0';
signal comWrite:STD_LOGIC:='0';
signal comRead:STD_LOGIC:='0';
--signal com_Int:STD_LOGIC:='0';
signal com_status:STD_LOGIC_VECTOR(31 downto 0);
signal com_data:STD_LOGIC_VECTOR(31 downto 0);

signal flag:STD_LOGIC_VECTOR(2 downto 0):="111";

begin	

	u1:TLB PORT MAP(
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
	
	u2:Rom PORT MAP(
		Paddr=>Paddr(11 downto 0),
      data=>romData
	);
	
	u3:Device_Ram1 PORT MAP(
		rst=>rst,
		  clk=>clk_mm,
		  Ram1Addr=>Ram1Addr,
		  Ram1Data=>Ram1Data,
		  Ram1EN=>Ram1EN,
		  Ram1OE=>Ram1OE,
		  Ram1WE=>Ram1WE,
		  Ram1_Ready=>ram1_ready,
		  Paddr=>Paddr(21 downto 2),
		  data_in=>Data_in,
		  data_out=>ram1_data,
		  Ram1Write=>ram1Write,
		  Ram1Read=>ram1Read
	);
	
	u4:Device_Ram2 PORT MAP(
		rst=>rst,
		  clk=>clk_mm,
		  Ram2Addr=>Ram2Addr,
		  Ram2Data=>Ram2Data,
		  Ram2EN=>Ram2EN,
		  Ram2OE=>Ram2OE,
		  Ram2WE=>Ram2WE,
		  Ram2_Ready=>ram2_ready,
		  Paddr=>Paddr(21 downto 2),
		  data_in=>Data_in,
		  data_out=>ram2_data,
		  Ram2Write=>ram2Write,
		  Ram2Read=>ram2Read
	);
	
	u5:Device_Flash PORT MAP(
		rst=>rst,
		  clk=>clk_mm,
		  FlashAddr=>FlashAddr,
		  FlashData=>FlashData,
		  FlashByte=>FlashByte,
		  FlashVpen=>FlashVpen,
		  FlashCE=>FlashCE,
		  FlashOE=>FlashOE,
		  FlashWE=>FlashWE,
		  FlashRP=>FlashRP,
		  FlashWrite=>flashWrite,
		  FlashRead=>flashRead,
		  Flash_Ready=>flash_ready,
		  Paddr=>Paddr(22 downto 0),
		  Data_in=>Data_in,
		  Data_out=>flash_data
	);
	
	u6:Device_COM PORT MAP(
		rst=>rst,
		  clk=>clk11,
		  data_ready=>data_ready,
		  rdn=>rdn,
		  tbre=>tbre,
		  tsre=>tsre,
		  wrn=>wrn,
		  Ram1Data=>Ram1Data,
		  COM_Ready=>com_ready,
		  COM_Write=>comWrite,
		  COM_Read=>comRead,
		  COM_INT=>com_Int,
		  Data_in=>Data_in,
		  Data_out=>com_data,
		  Status_out=>com_status
	);
	
	flag<="000" when Paddr>=x"1FC00000" and Paddr<=x"1FC00FFF" else
			"001" when Paddr>=x"00000000" and Paddr<=x"003FFFFF" else
			"010" when Paddr>=x"00400000" and Paddr<=x"007FFFFF" else
			"011" when Paddr>=x"1E000000" and Paddr<=x"1EFFFFFF" else
			"100" when Paddr =x"1FD003F8" else
			"101" when Paddr =x"1FD003FC" else
			"111";
	
	process(rst,clk_cpu,MemRead,MemWrite)
	begin
		if rst = '0' or (MemRead = '0' and MemWrite='0') then
			Data_out<=(others=>'0');
			ready<='0';
			mem_error<="00";
			BadVAddr<=x"00000000";
		elsif rising_edge(clk_cpu) then
			if (Vaddr(31)='1' and Status(4)='1' and Status(1)='0' and Status(2)='0')	--user mode but access kseg
				or Vaddr(1 downto 0) /="00" then
				BadVAddr<=Vaddr;
				ready<='1';
				mem_error<="11";
			elsif flag_missing = '1' then						--missing PTE
				BadVAddr<=Vaddr;
				ready<='1';
				mem_error<="01";
			elsif flag_writable = '0' and MemWrite = '1' then
				BadVAddr<=Vaddr;
				ready<='1';
				mem_error<="10";
			else
				mem_error<="00";
				case flag is
					when "000"=>								--Rom
						Data_out<=romData;
						ready<='1';
					when "001"=>								--Ram1
						if MemWrite = '1' then
							ram1Write<='1';
							ram1Read<='0';						
						else
							ram1Read<='1';
							ram1Write<='0';						
						end if;
						if ram1_ready = '1' then
							ready<='1';
							ram1Write<='0';
							ram1Read<='0';
							Data_out<=ram1_data;
						end if;
					when "010"=>								--Ram2
						if MemWrite = '1' then
							ram2Write<='1';
							ram2Read<='0';
						else
							ram2Read<='1';
							ram2Write<='0';						
						end if;
						if ram2_ready = '1' then
							ready<='1';
							ram2Write<='0';
							ram2Read<='0';
							Data_out<=ram2_data;
						end if;
					when "011"=>								--Flash
						if MemWrite = '1' then
							flashWrite<='1';
							flashRead<='0';
						else
							flashRead<='1';
							flashWrite<='0';
						end if;
						if flash_ready = '1' then
							ready<='1';
							flashWrite<='0';
							flashRead<='0';	
							Data_out<=flash_data;
						end if;
					when "100"=>
						if MemWrite = '1' then
							comWrite<='1';
							comRead<='0';
						else
							comRead<='1';
							comWrite<='0';
						end if;
						if com_ready = '1' then
							ready<='1';
							comRead<='0';
							comWrite<='0';
							Data_out<=com_data;
						end if;
					when "101"=>
						if MemWrite = '1' then
							BadVAddr<=Vaddr;
							ready<='1';
							mem_error<="10";
						else
							Data_out<=com_status;
							ready<='1';
						end if;
					when others=>
						ready<='0';
				end case;
			end if;
		end if;				
	end process;
	
end Behavioral;

