----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:38 07/19/2015 
-- Design Name: 
-- Module Name:    Extend - Behavioral 
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

entity Extend is
    Port ( instruction : in  STD_LOGIC_VECTOR (25 downto 0);
				ExtendOp: in STD_LOGIC_VECTOR(2 downto 0);
           immediate : out  STD_LOGIC_VECTOR (31 downto 0));
end Extend;

architecture Behavioral of Extend is

begin
	process(ExtendOp,instruction)
	begin
		case ExtendOp is
			when "000"=>
				immediate(15 downto 0)<=instruction(15 downto 0);
				immediate(31 downto 16)<=(others=>instruction(15));
			when "001"=>
				immediate(15 downto 0)<=instruction(15 downto 0);
				immediate(31 downto 16)<=(others=>'0');
			when "010"=>
				immediate(1 downto 0)<="00";
				immediate(17 downto 2)<=instruction(15 downto 0);
				immediate(31 downto 18)<=(others=>instruction(15));
			when "011"=>
				immediate(1 downto 0)<="00";
				immediate(27 downto 2)<=instruction;
				immediate(31 downto 28)<=(others=>instruction(25));
			when "100"=>
				immediate(4 downto 0)<=instruction(10 downto 6);
				immediate(31 downto 5)<=(others=>'0');
			when others=>
				immediate(15 downto 0)<=instruction(15 downto 0);
				immediate(31 downto 16)<=(others=>instruction(15));
		end case;
	end process;
end Behavioral;

