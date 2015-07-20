----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:01 07/18/2015 
-- Design Name: 
-- Module Name:    Device_COM - Behavioral 
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

entity Device_COM is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
			  Ram1Data:inout STD_LOGIC_VECTOR(31 downto 0);
           COM_Ready : out  STD_LOGIC;
           COM_Write : in  STD_LOGIC;
           COM_Read : in  STD_LOGIC;
			  COM_INT: out STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Status_out:out STD_LOGIC_VECTOR(31 downto 0));
end Device_COM;

architecture Behavioral of Device_COM is
type com_type is(com_init,recv0,recv1,send0,send1,send2,send3);
signal fr_state:com_type:=com_init;
begin
	process(rst,clk,COM_Write,COM_Read)
	begin
		if rst = '0' or (COM_Write = '0' and COM_Read = '0') then
			rdn<='1';
			wrn<='1';
			Ram1Data<=(others=>'Z');
			COM_Ready<='0';
			--Status_out<=(others=>'1');					--can read,and can write
			Data_out<=(others=>'0');
			--COM_INT<='0';									--no com interrupt
			fr_state<=com_init;
		elsif rising_edge(clk) then
			case fr_state is
				when com_init=>
					wrn<='1';
					rdn<='1';
					Ram1Data<=(others=>'Z');
					COM_ready<='0';
					if COM_Write = '1' then
						fr_state<=send0;					
					elsif data_ready = '1' then
						Ram1Data<=(others=>'Z');			
						fr_state<=recv0;
					end if;
				when recv0=>					
					rdn<='0';
					fr_state<=recv1;
				when recv1=>
					rdn<='1';
					Data_out(7 downto 0)<=Ram1Data(7 downto 0);
					Data_out(31 downto 8)<=(others=>'0');
					COM_Ready<='1';
					fr_state<=com_init;
				when send0=>
					if tbre='1' then
						fr_state<=send1;
					end if;
				when send1=>
					if tsre='1' then
						Ram1Data<=Data_in;
						fr_state<=send2;
					end if;
				when send2=>
					wrn<='0';
					fr_state<=send3;
				when send3=>
					wrn<='1';
					Ram1Data<=(others=>'Z');
					COM_Ready<='1';
					fr_state<=com_init;
				when others=>
					NULL;
			end case;
		end if;
	end process;
	
	process(rst,clk)
	begin
		if rst = '0' then
			Status_out<=(others=>'1');
			COM_INT<='0';
		elsif rising_edge(clk) then
			if data_ready = '1' then
				Status_out(0)<='0';					--PC cannot write data
				COM_INT<='1';
			else
				Status_out(0)<='1';
				COM_INT<='0';
			end if;
		end if;
	end process;
end Behavioral;

