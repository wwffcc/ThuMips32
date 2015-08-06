----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:31 07/16/2015 
-- Design Name: 
-- Module Name:    flashAndram - Behavioral 
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

entity flashAndram is
    Port ( rst : in  STD_LOGIC;
           clk11 : in  STD_LOGIC;
			  clk50: in STD_LOGIC;
			  SW: in STD_LOGIC_VECTOR(31 downto 0);
			  LED: out STD_LOGIC_VECTOR(15 downto 0);
			  DYP0:out STD_LOGIC_VECTOR(6 downto 0);
			  DYP1:out STD_LOGIC_VECTOR(6 downto 0);
			  
           Ram1Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram1EN : out  STD_LOGIC;
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram2Addr : out  STD_LOGIC_VECTOR (19 downto 0);
           Ram2Data : inout  STD_LOGIC_VECTOR (31 downto 0);
           Ram2EN : out  STD_LOGIC;
           Ram2OE : out  STD_LOGIC;
           Ram2WE : out  STD_LOGIC;
			  
			  FlashAddr:out STD_LOGIC_VECTOR(22 downto 0);
			  FlashData:inout STD_LOGIC_VECTOR(15 downto 0);
			  FlashCE:out STD_LOGIC_VECTOR(2 downto 0);
			  FlashByte:out STD_LOGIC;
			  FLashRP:out STD_LOGIC;
			  FlashOE:out STD_LOGIC;
			  FlashWE:out STD_LOGIC;
			  FlashVPEN:out STD_LOGIC;
			  
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC);
end flashAndram;

architecture Behavioral of flashAndram is
signal recv_byte:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal Paddr:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal flag:STD_LOGIC_VECTOR(1 downto 0):="11";					--00 ram1;01 ram2;10 flash

type flashAndram_state is (init_state,recv0,ctrl,send0,send1,send2,send3,ram1_save0,ram1_save1,ram2_save0,ram2_save1,
									ram_save,flash_save0,check_state,ram1_check0,ram1_check1,ram1_check2,ram1_check3,ram2_check0,
								ram2_check1,ram2_check2,ram2_check3,flash_check0,send_check0,send_check1,send_check2,send_check3,
								flash_cash0,flash_cash1,flash_cash2,flash_cash3,flash_cash4,flash_ready0,flash_ready1,flash_ready2,flash_ready3,	
								flash_ready4,flash_write0,flash_write1,flash_write2,flash_write3,flash_write4,
								flash_check1,flash_check2,flash_check3,flash_check4,flash_check5);
signal fr_state:flashAndram_state:=init_state;
signal flash_state:flashAndram_state:=init_state;

signal cond:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal cond2:STD_LOGIC_VECTOR(1 downto 0):="00";
signal flag_next:STD_LOGIC_VECTOR(1 downto 0):="11";
signal final_addr:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal temp_data:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal cond3:STD_LOGIC_VECTOR(2 downto 0):="000";

signal flashWrite:STD_LOGIC:='0';
signal flashRead:STD_LOGIC:='0';
signal flashReady:STD_LOGIC:='0';
signal cond_flash:STD_LOGIC_VECTOR(1 downto 0):="00";
signal flashDatax:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal cond4:STD_LOGIC_VECTOR(1 downto 0):="00";
--signal flashAddrx:STD_LOGIC_VECTOR(22 downto 0):=(others=>'0');
begin
	--Paddr<= recv_byte when cond = "0100" else Paddr;

	--flag_next<="11" when rst = '0' else
	--				flag when cond = "0101" else flag_next;
	
	FlashCE <= "000";
	FlashVPEN <= '1';
	FlashRP <= '1';
	FlashBYTE <= '1';	
	
	process(rst,clk11)
	begin
		if rst = '0' then
			recv_byte<=(others=>'0');
			Paddr<=x"00000000";			
			flag<="11";
			--flag_next<="11";
			wrn<='1';
			rdn<='1';
			Ram1EN<='1';
			Ram2EN<='1';
			Ram1WE<='1';
			Ram1OE<='1';
			Ram2WE<='1';
			Ram2OE<='1';
			Ram1Data<=(others=>'Z');
			Ram2Data<=(others=>'Z');
			flashWrite<='0';
			flashRead<='0';
			fr_state<=init_state;
			cond<="0000";
			cond2<="00";
			cond3<="000";
			flag_next<="11";
			LED<=(others=>'0');
			final_addr<=(others=>'0');
		elsif rising_edge(clk11) then
			case fr_state is
				when init_state=>	
					wrn<='1';
					rdn<='1';
					Ram1EN<='1';									
					flashWrite<='0';
					flashRead<='0';
					if data_ready = '1' then
						rdn<='0';
						fr_state<=recv0;
					end if;																
				when recv0=>					
					rdn<='1';
					case cond2 is
						when "00"=>
							recv_byte(7 downto 0)<=Ram1Data(7 downto 0);
						when "01"=>
							recv_byte(15 downto 8)<=Ram1Data(7 downto 0);
						when "10"=>
							recv_byte(23 downto 16)<=Ram1Data(7 downto 0);
						when "11"=>
							recv_byte(31 downto 24)<=Ram1Data(7 downto 0);
						when others=>
							NULL;							
					end case;
					if cond = "0000" then						
						fr_state<=ctrl;
					else
						fr_state<=send0;
					end if;
				when ctrl=>
					flag<=recv_byte(1 downto 0);
					fr_state<=send0;
				when send0=>					
					Ram1EN<='1';
					if tbre='1' then
						fr_state<=send1;
					end if;					
				when send1=>
					if tsre='1' then
						Ram1Data<=x"00000023";
						fr_state<=send2;
					end if;					
				when send2=>
					wrn<='0';
					fr_state<=send3;					
				when send3=>					
					wrn<='1';
					Ram1Data<=(others=>'Z');
					--fr_state<=init_state;					
					--cond<=cond+1;								
					cond2<=cond2+1;
					case cond is
						when "0000"=>cond<=cond+1;cond2<=cond2;
						when "0001"=>cond<=cond+1;
						when "0010"=>cond<=cond+1;
						when "0011"=>cond<=cond+1;
						when "0100"=>
							Paddr<=recv_byte;
							flag_next<=flag;
							cond<=cond+1;
						when others=>
							--Paddr<=Paddr+1;	
								NULL;
					end case;
					if cond2 = "11" then
						case flag_next is
							when "00"=>
								fr_state<=ram1_save0;
							when "01"=>
								fr_state<=ram2_save0;
							when "10"=>
								fr_state<=flash_save0;
							when "11"=>
								if cond = "0101" then
									fr_state<=check_state;
									final_addr<=recv_byte;
								else
									fr_state<=init_state;
								end if;
							when others=>
								fr_state<=init_state;
						end case;					
					else
						fr_state<=init_state;
					end if;
				when ram1_save0=>
					rdn<='1';
					wrn<='1';
					Ram1EN<='0';
					Ram1WE<='1';
					Ram1OE<='1';
					Ram1Addr<=Paddr(21 downto 2);
					Ram1Data<=recv_byte;
					fr_state<=ram1_save1;
				when ram1_save1=>
					Ram1WE<='0';
					fr_state<=ram_save;
				when ram_save=>
					Ram1EN<='1';
					Ram2EN<='1';
					Ram1WE<='1';
					Ram2WE<='1';
					Ram1Data<=(others=>'Z');
					Ram2Data<=(others=>'Z');
					fr_state<=init_state;
					Paddr<=Paddr+4;
					recv_byte<=(others=>'0');
				when ram2_save0=>
					rdn<='1';
					wrn<='1';
					Ram2EN<='0';
					Ram2WE<='1';
					Ram2OE<='1';
					Ram2Addr<=Paddr(21 downto 2);
					Ram2Data<=recv_byte;
					fr_state<=ram2_save1;
				when ram2_save1=>
					Ram2WE<='0';
					fr_state<=ram_save;	
				when flash_save0=>					
					flashWrite<='1';
					if flashReady = '1' then
						fr_state<=init_state;
						Paddr<=Paddr+4;
						recv_byte<=(others=>'0');
						flashWrite<='0';						
					end if;					
				when check_state=>
					--final_addr<=recv_byte;					
					if Paddr>=0 and Paddr<=x"003FFFFF" then
						fr_state<=ram1_check0;
					elsif Paddr<=x"007FFFFF" then
						fr_state<=ram2_check0;
					elsif Paddr>=x"1E000000" and Paddr<=x"1EFFFFFF" then
						fr_state<=flash_check0;
					else
						fr_state<=init_state;
					end if;
					cond3<="000";
				when ram1_check0=>
					wrn<='1';
					rdn<='1';
					Ram1EN<='0';
					Ram1WE<='1';
					Ram1OE<='1';
					Ram1Data<=(others=>'Z');
					Ram1Addr<=Paddr(21 downto 2);
					fr_state<=ram1_check1;
				when ram1_check1=>
					Ram1OE<='0';
					fr_state<=ram1_check2;
				when ram1_check2=>
					Ram1OE<='1';
					Ram1EN<='1';
					wrn<='1';
					rdn<='1';
					temp_data<=Ram1Data;	
					fr_state<=send_check0;
				when flash_check0=>
					flashRead<='1';
					if flashReady = '1' then
						flashRead<='0';
						flashWrite<='0';
						temp_data<=flashDatax;
						fr_state<=send_check0;
					end if;
				when send_check0=>
					if tbre = '1' then
						fr_state<=send_check1;
					end if;
				when send_check1=>
					if tsre='1' then
						case cond3 is
							when "000"=>
								Ram1Data(7 downto 0)<=temp_data(7 downto 0);
															fr_state<=send_check2;
							when "001"=>
								Ram1Data(7 downto 0)<=temp_data(15 downto 8);
															fr_state<=send_check2;
							when "010"=>
								Ram1Data(7 downto 0)<=temp_data(23 downto 16);
															fr_state<=send_check2;
							when "011"=>
								Ram1Data(7 downto 0)<=temp_data(31 downto 24);
															fr_state<=send_check2;
							when others=>
								fr_state<=check_state;	
						end case;
						Ram1Data(31 downto 8)<=x"000000";
						cond3<=cond3+1;
						--Ram1Data<=temp_data;
						--fr_state<=send_check2;
					end if;
				when send_check2=>
					wrn<='0';
					fr_state<=send_check3;
				when send_check3=>
					wrn<='1';
					Ram1Data<=(others=>'Z');
					Ram1EN<='1';
					if cond3 = "100" then
						if Paddr = final_addr then
							fr_state<=init_state;
						else
							Paddr<=Paddr+4;
							fr_state<=check_state;
						end if;
					else
						fr_state<=send_check0;
					end if;						
				when ram2_check0=>
					wrn<='1';
					rdn<='1';
					Ram2EN<='0';
					Ram2WE<='1';
					Ram2OE<='1';
					Ram2Data<=(others=>'Z');
					Ram2Addr<=Paddr(21 downto 2);
					fr_state<=ram2_check1;
				when ram2_check1=>
					Ram2OE<='0';
					fr_state<=ram2_check2;
				when ram2_check2=>
					Ram2OE<='1';
					Ram2EN<='1';
					wrn<='1';
					rdn<='1';
					temp_data<=Ram2Data;	
					fr_state<=send_check0;								
				when others=>NULL;
			end case;
		end if;		

		case fr_state is
		when init_state=> DYP0<=not "1000000";
		when recv0=> DYP0<=not "1111001";
		when ctrl=> DYP0<=not "0100100";
		when send0=> DYP0<=not "0110000";
		when send1=> DYP0<=not "0011001";
		when send2=> DYP0<=not "0010010";
		when send3=> DYP0<=not "0000010";
		when flash_save0=> DYP0<=not "1111000";
		when flash_check0=> DYP0<=not "0000000";
		when ram2_check1=> DYP0<=not "0010000";
		when ram2_check2=> DYP0<=not "0001000";
		when ram2_check3=> DYP0<=not "0000011";
		when send_check0=> DYP0<=not "1000110";
		when send_check1=> DYP0<=not "0100001";
		when send_check2=> DYP0<=not "0000110";
		when send_check3=> DYP0<=not "0001110";
		when others=> DYP0<=not "1111111";
		end case;
		
		case SW(15 downto 0) is
			when "0000000000000001"=>LED<=recv_byte(15 downto 0);
			when "0000000000000010"=>LED<=recv_byte(31 downto 16);
			when "0000000000000100"=>LED<=Paddr(15 downto 0);
			when "0000000000001000"=>LED<=Paddr(31 downto 16);
			when "0000000000010000"=>LED<=final_addr(15 downto 0);
			when "0000000000100000"=>LED<=final_addr(31 downto 16);
			--when "0000000001000000"=>LED(15 downto 0)<=flashAddrx(15 downto 0);
			when "0000000010000000"=>LED(0)<=flashWrite;LED(1)<=flashRead;LED(2)<=flashReady;LED(15 downto 3)<=(others=>'0');
			when "0000000100000000"=>LED(1 downto 0)<=cond2;LED(15 downto 2)<=(others=>'0');
			when "0000001000000000"=>LED(1 downto 0)<=flag_next;LED(15 downto 2)<=(others=>'0');
			when "0000010000000000"=>LED(0)<=data_ready;LED(15 downto 1)<=(others=>'0');
			when "0000100000000000"=>LED<=temp_data(15 downto 0);
			when "0001000000000000"=>LED<=temp_data(31 downto 16);
			when "0010000000000000"=>LED(1 downto 0)<=cond_flash;LED(15 downto 2)<=(others=>'0');
			when "0100000000000000"=>LED<=flashDatax(15 downto 0);
			when "1000000000000000"=>LED<=flashDatax(31 downto 16);
			when others=>LED<=FlashData(15 downto 0);
		end case;
--		case SW(15 downto 0) is
--			when "0000000000000001"=>LED<="0000000000000001";
--			when "0000000000000010"=>LED<="0000000000000010";
--			when "0000000000000100"=>LED<="0000000000000100";
--			when "0000000000001000"=>LED<="0000000000001000";
--			when "0000000000010000"=>LED<="0000000000010000";
--			when "0000000000100000"=>LED<="0000000000100000";
--			when "0000000001000000"=>LED<="0000000001000000";
--			when "0000000010000000"=>LED<="0000000010000000";
--			when "0000000100000000"=>LED<="0000000100000000";
--			when "0000001000000000"=>LED<="0000001000000000";
--			when "0000010000000000"=>LED<="0000010000000000";
--			when others=>NULL;
--		end case;
		

	end process;
	
	process(rst,clk11)			--flash
		begin
			if rst = '0' or (flashWrite='0' and flashRead = '0') then
				flashReady<='0';
				FlashOE<='1';
				FlashWE<='1';
				flashDatax<=(others=>'0');
				cond_flash<="00";
				cond4<="00";
				flash_state<=init_state;
			elsif rising_edge(clk11) then
				case flash_state is
					when init_state=>
						flashReady<='0';
						FlashOE<='1';
						FlashWE<='0';
						cond_flash<="00";
						cond4<="00";
						if flashWrite = '1' then
							if Paddr(16 downto 1) = 0 then				--first block								
								flash_state<=flash_cash0;
							else								
								flash_state<=flash_write0;
							end if;							
						else
							flash_state<=flash_check0;							
						end if;					
					when flash_cash0=>
						FlashData<=x"0020";								--erase
						flash_state<=flash_cash1;
					when flash_cash1=>
						FlashWE<='1';												
						flash_state<=flash_cash2;
					when flash_cash2=>
						FlashWE<='0';
						flash_state<=flash_cash3;
					when flash_cash3=>
						FlashData<=x"00D0";
						FlashAddr<=Paddr(22 downto 1) & '0';
						flash_state<=flash_cash4;
					when flash_cash4=>
						FlashWE<='1';
						flash_state<=flash_ready0;
					when flash_ready0=>
						FlashWE<='0';						
						FlashData<=x"0070";
						flash_state<=flash_ready1;
					when flash_ready1=>
						FlashWE<='1';
						flash_state<=flash_ready2;
					when flash_ready2=>
						FlashData<=(others=>'Z');						
						flash_state<=flash_ready3;
					when flash_ready3=>
						FlashOE<='0';
						flash_state<=flash_ready4;
					when flash_ready4=>
						FlashOE<='1';						
						if FlashData(7)='1' then
							if cond_flash = "10" then
								flash_state<=init_state;
								flashReady<='1';
							else
								flash_state<=flash_write0;							
								FlashWE<='0';						--pre config
							end if;
						else
							flash_state<=flash_ready0;
						end if;
					when flash_write0=>
						FlashData<=x"0040";						
						flash_state<=flash_write1;
					when flash_write1=>
						FlashWE<='1';
						flash_state<=flash_write2;
					when flash_write2=>						
						FlashWE<='0';
						flash_state<=flash_write3;
					when flash_write3=>
						case cond_flash is
							when "00"=>
								FlashAddr<=Paddr(22 downto 1) & '0';
								--flashAddrx<=Paddr(22 downto 1) & '0';					--debug
								FlashData<=recv_byte(15 downto 0);								
							when "01"=>
								FlashAddr<=(Paddr(22 downto 1)+1) & '0';
								--flashAddrx<=(Paddr(22 downto 1)+1) & '0';				--debug
								FlashData<=recv_byte(31 downto 16);						
							when others=>
								NULL;
						end case;						
						flash_state<=flash_write4;
					when flash_write4=>
						FlashWE<='1';
						cond_flash<=cond_flash+1;
						flash_state<=flash_ready0;																			
					when flash_check0=>
						flashReady<='0';						
						FlashData<=x"00FF";
						flash_state<=flash_check1;
					when flash_check1=>
						FlashWE<='1';
						flash_state<=flash_check2;
					when flash_check2=>
						FlashOE<='0';
						FlashAddr<=Paddr(22 downto 2) & "00";
						--flashAddrx<=Paddr(22 downto 2) & "00";							--debug
						FlashData<=(others=>'Z');						
						flash_state<=flash_check3;
					when flash_check3=>
						FlashOE<='1';
						flashDatax(15 downto 0)<=FlashData;
						flash_state<=flash_check4;
					when flash_check4=>
						FlashOE<='0';
						FlashAddr<=Paddr(22 downto 2) & "10";
						--flashAddrx<=Paddr(22 downto 2) & "10";							--debug
						FlashData<=(others=>'Z');						
						flash_state<=flash_check5;
					when flash_check5=>
						FlashOE<='1';
						flashDatax(31 downto 16)<=FlashData;
						flashReady<='1';
						flash_state<=init_state;					
					when others=>
						NULL;
				end case;
			end if;
			
		case flash_state is
		when init_state=> DYP1<=not "1000000";					--0
		when flash_cash0=> DYP1<=not "1111001";				--1
		when flash_cash1=> DYP1<=not "0100100";				--2
		when flash_cash2=> DYP1<=not "0110000";				--3
		when flash_cash3=> DYP1<=not "0011001";				--4
		when flash_cash4=> DYP1<=not "0010010";				--5
		when flash_ready0=> DYP1<=not "0000010";				--6
		when flash_ready1=> DYP1<=not "1111000";				--7
		when flash_ready2=> DYP1<=not "0000000";				--8
		when flash_ready3=> DYP1<=not "0010000";				--9
		when flash_check0=> DYP1<=not "0001000";				--A
		when flash_check1=> DYP1<=not "0000011";				--b
		when flash_check2=> DYP1<=not "1000110";				--C
		when flash_check3=> DYP1<=not "0100001";				--d
		when flash_check4=> DYP1<=not "0000110";
		when flash_check5=> DYP1<=not "0001110";
		when others=> DYP1<=not "1111111";
		end case;
			
		end process;
	
end Behavioral;

