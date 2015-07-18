----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:43:04 07/16/2015 
-- Design Name: 
-- Module Name:    device_Ram - Behavioral 
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

entity device_Ram is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  Ram1Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC;
           Paddr : in  STD_LOGIC_VECTOR (31 downto 0);
           MemRead : in  STD_LOGIC;
           MemWrite : in  STD_LOGIC;
           --Data : inout  STD_LOGIC_VECTOR (31 downto 0);
			  Data_in: in STD_LOGIC_VECTOR(31 downto 0);
			  Data_out: out STD_LOGIC_VECTOR(31 downto 0);
           ready : out  STD_LOGIC);
end device_Ram;

architecture Behavioral of device_Ram is

type state_type is (ST0,RM0,RM1,WT0,WT1);
signal state:state_type:=ST0;
signal flag:STD_LOGIC:='0';

begin
	flag<='1' when Paddr>=x"00400000" else '0';			--'0' Ram1;'1' Ram2
	
	process(rst,clk)
	begin
		if rst = '0' then
			state<=ST0;
			ready<='0';
			Ram1EN<='1';
			Ram2EN<='1';
			Ram1WE<='1';
			Ram1OE<='1';
			Ram2WE<='1';
			Ram2OE<='1';
			Data_out<=(others=>'0');
		elsif MemRead = '0' and MemWrite = '0' then
			state<=ST0;
			ready<='0';
			Ram1EN<='1';
			Ram2EN<='1';
			Ram1WE<='1';
			Ram1OE<='1';
			Ram2WE<='1';
			Ram2OE<='1';
			Data_out<=(others=>'0');
		elsif rising_edge(clk) then
			if MemRead = '1' then
				case state is
					when ST0=>						
						if flag = '0' then												--Ram1
							Ram1EN<='0';
							Ram1WE<='1';
							Ram1OE<='1';
							Ram1Addr<=Paddr(21 downto 2);
							Ram1Data<=(others=>'Z');
						else																	--Ram2
							Ram2EN<='0';
							Ram2WE<='1';
							Ram2OE<='1';
							Ram2Addr<=Paddr(21 downto 2);
							Ram2Data<=(others=>'Z');
						end if;
						state<=RM0;
					when RM0=>
						if flag = '0' then
							Ram1OE<='0';
						else
							Ram2OE<='0';
						end if;
						state<=RM1;
					when RM1=>
						if flag = '0' then
							Data_out<=Ram1Data;
							Ram1OE<='1';
							Ram1EN<='1';
						else
							Data<=Ram2Data;
							Ram2OE<='1';
							Ram2EN<='1';
						end if;
						state<=ST0;
						ready<='1';
					when others=>
						null;
				end case;
			elsif MemWrite='1' then						--write memory
				case state is
					when ST0=>
						if flag = '0' then					--write ram1
							Ram1EN<='0';
							Ram1WE<='1';
							Ram1OE<='1';
							Ram1Addr<=Paddr;
							Ram1Data<=data_in;
						else
							Ram2EN<='0';
							Ram2WE<='1';
							Ram2OE<='1';
							Ram2Addr<=Paddr;
							Ram2Data<=data_in;						
						end if;						
						state<=WT0;
					when WT0=>
						if flag = '0' then
							Ram1WE<='0';
						else
							Ram2WE<='0';
						end if;
						state<=WT1;
					when WT1=>
						if flag = '0' then
							Ram1WE<='1';
							Ram1EN<='1';
						else
							Ram2WE<='1';
							Ram2EN<='1';
						end if;
						state<=ST0;
						ready<='1';
					when others=>
						null;
				end case;		
			end if;
		end if;
	end process;
end Behavioral;

