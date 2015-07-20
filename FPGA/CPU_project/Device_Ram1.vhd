----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:53 07/18/2015 
-- Design Name: 
-- Module Name:    Device_Ram1 - Behavioral 
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

entity Device_Ram1 is
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
end Device_Ram1;

architecture Behavioral of Device_Ram1 is
type ram1_state_type is(ram1_init,ram1_read0,ram1_read1,ram1_read2,ram1_write0,ram1_write1);
signal Ram1_State:ram1_state_type:=ram1_init;
begin
	process(clk,rst,Ram1Write,Ram1Read)
	begin
		if rst = '0' or (Ram1Write= '0' and Ram1Read='0') then
			Ram1EN<='1';
			Ram1_Ready<='0';
			Ram1OE<='1';
			Ram1WE<='1';
			Ram1_State<=ram1_init;
		elsif rising_edge(clk) then
			case Ram1_State is
				when ram1_init=>
					Ram1EN<='0';				--enable ram1
					Ram1OE<='1';
					Ram1WE<='1';
					if Ram1Write = '1' then						
						Ram1_State<=ram1_write0;
					else						
						Ram1_State<=ram1_read0;
					end if;					
				when ram1_write0=>
					Ram1Addr<=Paddr;
					Ram1Data<=data_in;
					Ram1_State<=ram1_write1;
				when ram1_write1=>
					Ram1WE<='0';
					Ram1_Ready<='1';
					Ram1_State<=ram1_init;
				when ram1_read0=>					
					Ram1Addr<=Paddr;
					Ram1Data<=(others=>'Z');
					Ram1_State<=ram1_read1;
				when ram1_read1=>
					Ram1OE<='0';
					Ram1_State<=ram1_read2;
				when ram1_read2=>
					Ram1OE<='1';
					data_out<=Ram1Data;
					ram1_state<=ram1_init;
				when others=>
					NULL;					
			end case;
		end if;
	end process;

end Behavioral;

