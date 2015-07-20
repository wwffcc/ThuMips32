----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:00:53 07/19/2015 
-- Design Name: 
-- Module Name:    Clock - Behavioral 
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

entity Clock is
    Port ( clk50 : in  STD_LOGIC;
				clk11:in STD_LOGIC;
				clk_step:in STD_LOGIC;
           clk_cpu : out  STD_LOGIC;
           clk_mm : out  STD_LOGIC;
			  clk_flag:in STD_LOGIC_VECTOR(2 downto 0));
end Clock;

architecture Behavioral of Clock is

signal counter:STD_LOGIC:='0';
begin
	process(clk50)
	begin
		if clk50'event and clk50='1' then		
			counter<=not counter;
		end if;
	end process;
	
	process(clk50,clk11,clk_step,counter,clk_flag)
	begin
		case clk_flag is
			when "000"=>
				clk_cpu<=clk50;
				clk_mm<=counter;
			when "001"=>
				clk_cpu<=clk50;
				clk_mm<=clk11;
			when "010"=>
				clk_cpu<=counter;
				clk_mm<=clk_step;
			when "011"=>
				clk_cpu<=counter;
				clk_mm<=counter;
			when "100"=>
				clk_cpu<=counter;
				clk_mm<=clk11;
			when "101"=>
				clk_cpu<=counter;
				clk_mm<=clk_step;
			when "110"=>
				clk_cpu<=clk_step;
				clk_mm<=clk11;
			when "111"=>
				clk_cpu<=clk_step;
				clk_mm<=clk_step;
			when others=>
				clk_cpu<=clk_step;
				clk_mm<=clk_step;
		end case;
	end process;
	
end Behavioral;

