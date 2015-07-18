----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:16 07/15/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( srcA : in  STD_LOGIC_VECTOR (31 downto 0);
           srcB : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOp: in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process(srcA,srcB,ALUOp)
	begin
		case ALUOp is
			when "0000"=>						--ADD
				result<=srcA + srcB;
			when "0001"=>						--SUB
				result<=srcA - srcB;
			when "0010"=>						--AND
				result<=srcA AND srcB;
			when "0011"=>						--OR
				result<=srcA OR srcB;
			when "0100"=>						--NOR
				result<=srcA NOR srcB;
			when "0101"=>						--XOR
				result<=srcA XOR srcB;
			when "0110"=>						--SLL				
				result<=TO_STDLOGICVECTOR(TO_BITVECTOR(srcA) SLL CONV_INTEGER(srcB));
			when "0111"=>						--SRA
				result<=TO_STDLOGICVECTOR(TO_BITVECTOR(srcA) SRA CONV_INTEGER(srcB));
			when "1000"=>						--SRL
				result<=TO_STDLOGICVECTOR(TO_BITVECTOR(srcA) SRL CONV_INTEGER(srcB));
			when "1001"=>						--compare
				if srcA = srcB then
					result<=x"00000000";
				elsif conv_signed(conv_integer(srcA),32) < conv_signed(conv_integer(srcB),32) then
					result<=x"00000001";
				else
					result<=x"FFFFFFFF";
				end if;
			when "1010"=>						--compareu
				if srcA = srcB then
					result<=x"00000000";
				elsif conv_unsigned(conv_integer(srcA),32) < conv_unsigned(conv_integer(srcB),32) then
					result<=x"00000001";
				else
					result<=x"FFFFFFFF";
				end if;
		when others=>
			result<=x"00000000";
		end case;
	end process;

end Behavioral;

