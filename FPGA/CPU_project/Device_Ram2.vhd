----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:47 07/18/2015 
-- Design Name: 
-- Module Name:    Device_Ram2 - Behavioral 
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

entity Device_Ram2 is
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
           Ram2Read : in  STD_LOGIC;
			  bitmap:out STD_LOGIC_VECTOR(3 downto 0)
			  );
end Device_Ram2;

architecture Behavioral of Device_Ram2 is
type ram2_state_type is(ram2_init,ram2_read0,ram2_read1,ram2_read2,ram2_write0,ram2_write1);
signal Ram2_State:ram2_state_type:=ram2_init;
begin
	process(clk,rst,Ram2Write,Ram2Read)
	begin
		if rst = '0' or (Ram2Write= '0' and Ram2Read='0') then
			Ram2EN<='1';
			Ram2_Ready<='0';
			Ram2OE<='1';
			Ram2WE<='1';
			Ram2_State<=ram2_init;
		elsif rising_edge(clk) then
			case Ram2_State is
				when ram2_init=>
					Ram2EN<='0';				--enable ram1
					Ram2OE<='1';
					Ram2WE<='1';
					Ram2_Ready<='0';
					if Ram2Write = '1' then
						Ram2_State<=ram2_write0;
					else
						Ram2_State<=ram2_read0;
					end if;					
				when ram2_write0=>
					Ram2Addr<=Paddr;
					Ram2Data<=data_in;
					Ram2_State<=ram2_write1;
				when ram2_write1=>
					Ram2WE<='0';
					Ram2_Ready<='1';
					Ram2_State<=ram2_init;
				when ram2_read0=>					
					Ram2Addr<=Paddr;
					Ram2Data<=(others=>'Z');
					Ram2_State<=ram2_read1;
				when ram2_read1=>
					Ram2OE<='0';
					Ram2_State<=ram2_read2;
				when ram2_read2=>
					Ram2OE<='1';
					Ram2_Ready<='1';
					data_out<=Ram2Data;
					ram2_state<=ram2_init;
				when others=>
					NULL;					
			end case;
		end if;
	end process;
	
	process(ram2_state)
	begin
		case ram2_state is
			when ram2_init=>bitmap<="0000";
			when ram2_read0=>bitmap<="0001";
			when ram2_read1=>bitmap<="0010";
			when ram2_read2=>bitmap<="0011";
			when ram2_write0=>bitmap<="0100";
			when ram2_write1=>bitmap<="0101";
			when others=>bitmap<="ZZZZ";
		end case;
	end process;
end Behavioral;

