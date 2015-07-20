----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:37:13 07/19/2015 
-- Design Name: 
-- Module Name:    RegistersFile - Behavioral 
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

entity RegistersFile is
    Port ( rst : in  STD_LOGIC;
           RegAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RegAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RegDataSrc : in  STD_LOGIC_VECTOR (31 downto 0);
           --RegDataCtrl : in  STD_LOGIC_VECTOR (1 downto 0);
           RegWrite : in  STD_LOGIC;
           RegData1 : out  STD_LOGIC_VECTOR (31 downto 0);
           RegData2 : out  STD_LOGIC_VECTOR (31 downto 0);
           RegDst : in  STD_LOGIC_VECTOR (4 downto 0));
end RegistersFile;

architecture Behavioral of RegistersFile is

type regArray is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
signal reg:regArray:=(others=>(others=>'0'));

begin
	
	RegData1<=reg(CONV_INTEGER(RegAddr1));
	RegData2<=reg(CONV_INTEGER(RegAddr2));
	
	process(rst,RegWrite)
	begin
		if rst = '0' then
			reg<=(others=>(others=>'0'));
		elsif rising_edge(RegWrite) then
			reg(CONV_INTEGER(RegDst))<=RegDataSrc;
			reg(0)<=(others=>'0');									--R0
		end if;
	end process;

end Behavioral;

