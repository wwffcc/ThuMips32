import sys
from struct import unpack


def main():
    global VHD_PRE, VHD_POST
    print VHD_PRE
    with open(sys.argv[1], 'rb') as f:
        i = 0
        while True:
            inst = f.read(4)
            if len(inst) < 4:
                break
            inst = hex(unpack('<I', inst)[0])[2:][:8].zfill(8)
            print 'rom({}) <= x"{}";'.format(i, inst)
            i += 1
    print VHD_POST


VHD_PRE = '''
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:00 07/11/2014 
-- Design Name: 
-- Module Name:    rom - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rom is
    Port ( addr : in  STD_LOGIC_VECTOR (11 downto 0);
           data : out  STD_LOGIC_VECTOR (31 downto 0));
end rom;

architecture Behavioral of rom is
type romarray is array(1023 downto 0) of std_logic_vector(31 downto 0);
signal rom : romarray;

begin
'''
VHD_POST = '''
process(addr, rom)
	begin
		data <= rom(CONV_INTEGER(addr(11 downto 2)));
end process;


end Behavioral;
'''


if __name__ == '__main__':
    main()
