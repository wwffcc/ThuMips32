----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:58 07/23/2015 
-- Design Name: 
-- Module Name:    p_MUL - Behavioral 
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

entity p_MUL is
	Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (63 downto 0));
end p_MUL;

architecture Behavioral of p_MUL is
signal condi : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal ans : STD_LOGIC_VECTOR (63 downto 0);
	
component p_multiplier is
	PORT (
		clk : in  STD_LOGIC;
      A : in  STD_LOGIC_VECTOR (31 downto 0);
      B : in  STD_LOGIC_VECTOR (31 downto 0);
      p : out  STD_LOGIC_VECTOR (63 downto 0)
	);
end component;
	
begin
	m:p_multiplier PORT MAP(
		clk=>clk,
		A=>A,
		B=>B,
		p=>ans
	);

process(clk, start, A, B, RST)
	begin
		if rst = '0' then
			condi <= "0000";
			ready <= '0';
			R <= (others => '0');
		elsif start = '0' then
			condi <= "0000";
			ready <= '0';
		elsif clk'event and clk = '1' then
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

