----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:31:21 07/18/2015 
-- Design Name: 
-- Module Name:    Device_Flash - Behavioral 
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

entity Device_Flash is
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
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  bitmap:out STD_LOGIC_VECTOR(3 downto 0)
			  );
end Device_Flash;

architecture Behavioral of Device_Flash is
type flash_state_type is (flash_init,flash_cash0,flash_cash1,flash_cash2,flash_cash3,flash_cash4,
							flash_write0,flash_write1,flash_write2,flash_write3,flash_write4,
							flash_ready0,flash_ready1,flash_ready2,flash_ready3,flash_ready4,
							flash_check0,flash_check1,flash_check2,flash_check3,flash_check4,flash_check5);

signal flash_state:flash_state_type:=flash_init;
signal cond_flash:STD_LOGIC_VECTOR(1 downto 0):="00";
begin
	FlashCE <= "000";
	FlashVPEN <= '1';
	FlashRP <= '1';
	FlashBYTE <= '1';
	
	process(rst,clk,FlashWrite,FlashRead)
	begin
		if rst = '0' or (FlashWrite='0' and FlashRead='0') then			
			Flash_Ready<='0';
			FlashWE<='1';
			FlashOE<='1';
			cond_flash<="00";			
			flash_state<=flash_init;
		elsif rising_edge(clk) then
			case flash_state is
				when flash_init=>
					Flash_Ready<='0';
					FlashOE<='1';
					FlashWE<='0';
					cond_flash<="00";					
					if FlashWrite = '1' then
						if Paddr(16 downto 1) = 0 then				--first block,erase it
							flash_state<=flash_cash0;
						else								
							flash_state<=flash_write0;
						end if;							
					else
						flash_state<=flash_check0;							
					end if;					
				when flash_cash0=>
					FlashData<=x"0020";								--erase
					flash_state<=flash_cash1;
				when flash_cash1=>
					FlashWE<='1';												
					flash_state<=flash_cash2;
				when flash_cash2=>
					FlashWE<='0';
					flash_state<=flash_cash3;
				when flash_cash3=>
					FlashData<=x"00D0";
					FlashAddr<=Paddr(22 downto 1) & '0';
					flash_state<=flash_cash4;
				when flash_cash4=>
					FlashWE<='1';
					flash_state<=flash_ready0;
				when flash_ready0=>
					FlashWE<='0';						
					FlashData<=x"0070";
					flash_state<=flash_ready1;
				when flash_ready1=>
					FlashWE<='1';
					flash_state<=flash_ready2;
				when flash_ready2=>
					FlashData<=(others=>'Z');						
					flash_state<=flash_ready3;
				when flash_ready3=>
					FlashOE<='0';
					flash_state<=flash_ready4;
				when flash_ready4=>
					FlashOE<='1';						
					if FlashData(7)='1' then
						if cond_flash = "10" then
							flash_state<=flash_init;
							Flash_Ready<='1';
						else
							flash_state<=flash_write0;							
							FlashWE<='0';						--pre config
						end if;
					else
						flash_state<=flash_ready0;
					end if;
				when flash_write0=>
					FlashData<=x"0040";						
					flash_state<=flash_write1;
				when flash_write1=>
					FlashWE<='1';
					flash_state<=flash_write2;
				when flash_write2=>						
					FlashWE<='0';
					flash_state<=flash_write3;
				when flash_write3=>
					case cond_flash is
						when "00"=>
							FlashAddr<=Paddr(22 downto 1) & '0';							
							FlashData<=Data_in(15 downto 0);								
						when "01"=>
							FlashAddr<=(Paddr(22 downto 1)+1) & '0';							
							FlashData<=Data_in(31 downto 16);						
						when others=>
							NULL;
					end case;						
					flash_state<=flash_write4;
				when flash_write4=>
					FlashWE<='1';
					cond_flash<=cond_flash+1;
					flash_state<=flash_ready0;																			
				when flash_check0=>
					Flash_Ready<='0';						
					FlashData<=x"00FF";
					flash_state<=flash_check1;
				when flash_check1=>
					FlashWE<='1';
					flash_state<=flash_check2;
				when flash_check2=>
					FlashOE<='0';
					FlashAddr<=Paddr(22 downto 2) & "00";					
					FlashData<=(others=>'Z');						
					flash_state<=flash_check3;
				when flash_check3=>
					FlashOE<='1';
					Data_out(15 downto 0)<=FlashData;
					flash_state<=flash_check4;
				when flash_check4=>
					FlashOE<='0';
					FlashAddr<=Paddr(22 downto 2) & "10";					
					FlashData<=(others=>'Z');						
					flash_state<=flash_check5;
				when flash_check5=>
					FlashOE<='1';
					Data_out(31 downto 16)<=FlashData;
					Flash_Ready<='1';
					flash_state<=flash_init;					
				when others=>
					NULL;
			end case;
		end if;
	end process;
	
	process(flash_state)
	begin
		case flash_state is
			when flash_init=>bitmap<="0000";
			when flash_cash0=>bitmap<="1011";
			when flash_cash1=>bitmap<="1100";
			when flash_cash2=>bitmap<="1101";
			when flash_cash3=>bitmap<="1110";
			when flash_cash4=>bitmap<="1111";
			when flash_ready0=>bitmap<="1111";
			when flash_ready1=>bitmap<="1110";
			when flash_ready2=>bitmap<="1101";
			when flash_ready3=>bitmap<="1100";
			when flash_ready4=>bitmap<="1011";
			when flash_write0=>bitmap<="0001";
			when flash_write1=>bitmap<="0010";
			when flash_write2=>bitmap<="0011";
			when flash_write3=>bitmap<="0100";
			when flash_write4=>bitmap<="0101";
			when flash_check0=>bitmap<="0110";
			when flash_check1=>bitmap<="0111";
			when flash_check2=>bitmap<="1000";
			when flash_check3=>bitmap<="1001";
			when flash_check4=>bitmap<="1010";
			when flash_check5=>bitmap<="1011";
			when others=>bitmap<="ZZZZ";
		end case;
	end process;
end Behavioral;

