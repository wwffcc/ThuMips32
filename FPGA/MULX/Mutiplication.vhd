----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:42 07/01/2014 
-- Design Name: 
-- Module Name:    multiplication - Behavioral 
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

entity multiplication is
    Port ( RST : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           start : in  STD_LOGIC;
           ready : out  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           R : out  STD_LOGIC_VECTOR (63 downto 0));
end multiplication;

architecture Behavioral of multiplication is
	signal condi : STD_LOGIC_VECTOR (3 downto 0) := "0000";
	signal ans : STD_LOGIC_VECTOR (63 downto 0);
	
	component Mutiplier is
	PORT (
		clk : in  STD_LOGIC;
      A : in  STD_LOGIC_VECTOR (31 downto 0);
      B : in  STD_LOGIC_VECTOR (31 downto 0);
      p : out  STD_LOGIC_VECTOR (63 downto 0)
	);
	end component;
	
begin

	multiplier1 : Mutiplier PORT MAP(
		clk => CLK,
		A => A,
		B => B,
		p => ans
	);

process(CLK, start, A, B, RST)
	begin
		if RST = '0' then
			condi <= "0000";
			ready <= '0';
			R <= (others => '0');
		elsif start = '0' then
			condi <= "0000";
			ready <= '0';
		elsif CLK'event and CLK = '1' then
			if condi < 14 then
				condi <= condi + 1;
			elsif condi = 14 then
				R <= ans;
				condi <= condi + 1;
			elsif condi = 15 then
				ready <= '1';
				condi <= condi + 1;
			end if;
		end if;
end process;

end Behavioral;

