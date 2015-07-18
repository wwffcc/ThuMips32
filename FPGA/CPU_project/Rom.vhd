----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:24 07/16/2015 
-- Design Name: 
-- Module Name:    Rom - Behavioral 
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

entity Rom is
    Port ( Paddr : in  STD_LOGIC_VECTOR (11 downto 0);
           data : out  STD_LOGIC_VECTOR (31 downto 0));
end Rom;

architecture Behavioral of Rom is
type RomArray is array(1023 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
signal rom:RomArray:=(others=>(others=>'0'));
begin

rom(0) <= x"3c1d8070";
rom(1) <= x"3c08bfd0";
rom(2) <= x"350803f8";
rom(3) <= x"ad000000";
rom(4) <= x"0ff00008";
rom(5) <= x"00000000";
rom(6) <= x"0bf00006";
rom(7) <= x"00000000";
rom(8) <= x"27bdffe0";
rom(9) <= x"3c02be00";
rom(10) <= x"3c06c270";
rom(11) <= x"afbf001c";
rom(12) <= x"24430034";
rom(13) <= x"8c450000";
rom(14) <= x"00462021";
rom(15) <= x"24420004";
rom(16) <= x"ac850000";
rom(17) <= x"1443fffb";
rom(18) <= x"00000000";
rom(19) <= x"3c038070";
rom(20) <= x"3c02464c";
rom(21) <= x"8c640000";
rom(22) <= x"2442457f";
rom(23) <= x"10820003";
rom(24) <= x"00000000";
rom(25) <= x"0bf00047";
rom(26) <= x"00000000";
rom(27) <= x"8c62001c";
rom(28) <= x"9465002c";
rom(29) <= x"00621021";
rom(30) <= x"00052940";
rom(31) <= x"00452821";
rom(32) <= x"3c063d90";
rom(33) <= x"3c07be00";
rom(34) <= x"0045182b";
rom(35) <= x"1060001d";
rom(36) <= x"00000000";
rom(37) <= x"24440020";
rom(38) <= x"00401821";
rom(39) <= x"0064402b";
rom(40) <= x"11000007";
rom(41) <= x"00000000";
rom(42) <= x"00664021";
rom(43) <= x"8d080000";
rom(44) <= x"24630004";
rom(45) <= x"ac68fffc";
rom(46) <= x"0bf00027";
rom(47) <= x"00000000";
rom(48) <= x"8c430008";
rom(49) <= x"8c490014";
rom(50) <= x"8c420004";
rom(51) <= x"00694821";
rom(52) <= x"00e21021";
rom(53) <= x"0069402b";
rom(54) <= x"11000007";
rom(55) <= x"00000000";
rom(56) <= x"8c480000";
rom(57) <= x"24630004";
rom(58) <= x"ac68fffc";
rom(59) <= x"24420004";
rom(60) <= x"0bf00035";
rom(61) <= x"00000000";
rom(62) <= x"00801021";
rom(63) <= x"0bf00022";
rom(64) <= x"00000000";
rom(65) <= x"3c028070";
rom(66) <= x"8c590018";
rom(67) <= x"0320f809";
rom(68) <= x"00000000";
rom(69) <= x"0bf00019";
rom(70) <= x"00000000";
rom(71) <= x"0bf00047";
rom(72) <= x"00000000";
rom(73) <= x"00000000";
rom(74) <= x"00000000";
rom(75) <= x"00000000";

data<=rom(CONV_INTEGER(Paddr(11 downto 2)));

process
begin
for i in 76 to 1023 LOOP
		rom(i)<=(others=>'0');
	end LOOP;
end process;

end Behavioral;

