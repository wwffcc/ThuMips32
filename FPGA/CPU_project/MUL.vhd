----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:20:53 07/15/2015 
-- Design Name: 
-- Module Name:    MUL - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUL is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (63 downto 0));
end MUL;

architecture Behavioral of MUL is
type state_type is(ST0,ST1,ST2);
signal cond: STD_LOGIC_VECTOR(4 downto 0):="00000";
signal ans: STD_LOGIC_VECTOR(63 downto 0):=x"0000000000000000";
signal c:STD_LOGIC:='0';
signal state:state_type:=ST0;
begin
	process(rst,clk,start)
	begin
		if rst = '0' then
			cond<="00000";
			ans<=(others=>'0');
			c<='0';
			state<=ST0;			
			ready<='0';
			R<= (others=>'0');
		elsif start = '0' then
			cond<="00000";
			ans<=(others=>'0');
			c<='0';
			state<=ST0;
			ready<='0';
		elsif clk'event and clk='1'then
			case state is
				when ST0=>
					ans(63 downto 32)<=x"00000000";
					ans(31 downto 0)<=B;
					c<='0';
					ready<='0';					
					state<=ST1;					
				when ST1=>
					if ans(0) = '0' and c = '1' then					
						ans(63 downto 32)<= ans(63 downto 32) + A;
					elsif ans(0) = '1' and c = '0' then
						ans(63 downto 32)<= ans(63 downto 32) - A;
					else
						null;
					end if;
					cond <= cond+"00001";
					state<=ST2;
				when ST2=>
					if cond = "00000" then
						R(62 downto 0)<=ans(63 downto 1);
						R(63)<=ans(63);
						ready<='1';
						state<=ST0;
					else
						c <= ans(0);
						ans(62 downto 0) <= ans(63 downto 1);						
						state<=ST1;
					end if;					
				when others=>
					null;
			end case;
		end if;
	end process;
end Behavioral;


