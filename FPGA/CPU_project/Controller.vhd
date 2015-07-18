----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:12:09 07/14/2015 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           instructions : in  STD_LOGIC_VECTOR (31 downto 0);
           PCWrite : out  STD_LOGIC;
           IorD : out  STD_LOGIC;
           TLBWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           MemDataSrc : out  STD_LOGIC;
			  MemAddrSrc : out STD_LOGIC_VECTOR(1 downto 0);
           IRWrite : out  STD_LOGIC;
           RegDst : out  STD_LOGIC_VECTOR (1 downto 0);
           RegDataSrc : out  STD_LOGIC_VECTOR (2 downto 0);
           RegDataCtrl : out  STD_LOGIC_VECTOR (1 downto 0);
           RegWrite : out  STD_LOGIC;
           ALUSrcA : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcB : out  STD_LOGIC_VECTOR (2 downto 0);
           PCSrc : out  STD_LOGIC_VECTOR (2 downto 0);
           PCWriteCond : out  STD_LOGIC_VECTOR (2 downto 0);
           HISrc : out  STD_LOGIC;
           LOSrc : out  STD_LOGIC;
           HIWrite : out  STD_LOGIC;
           LOWrite : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR (3 downto 0);
           ExtendOp : out  STD_LOGIC_VECTOR (2 downto 0);
           ALUOutWrite : out  STD_LOGIC;
           RPCWrite : out  STD_LOGIC;
           CP0Write : out  STD_LOGIC;
			  exc_code: out STD_LOGIC_VECTOR(4 downto 0);
			  EPCWrite: out STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

type controller_state is
	(initialize,instruction_fetch, decode, execute,mem_access,write_back,interrupt);
	
signal g_state:controller_state:= initialize;

begin
	process(rst,clk)
	begin
		if rst = '0' then
			g_state<=initialize;
		elsif rising_edge(clk) then
			case g_state is
				when initialize=>
					g_state<=instruction_fetch;
					PCWrite<='0';
				   IorD<='0';
				   TLBWrite<='0';
				   MemRead<='0';
				   MemWrite<='0';
				   MemDataSrc<='0';
					MemAddrSrc<="00";
				   IRWrite<='0';
				   RegDst<="00";
				   RegDataSrc<="000";
				   RegDataCtrl<="00";
				   RegWrite<='0';
				   ALUSrcA<="00";
				   ALUSrcB<="000";
					ALUOp<="0000";
					ExtendOp<="000";
				   PCSrc<="000";
				   PCWriteCond<="000";
				   HISrc<='0';
				   LOSrc<='0';
				   HIWrite<='0';
				   LOWrite<='0';
				   ALUOutWrite<='0';
				   RPCWrite<='0';
				   CP0Write<='0';
					exc_code<="00000";
					EPCWrite<='0';
				when instruction_fetch=>
					g_state<=decode;
					PCWrite<='0';
				   IorD<='0';
				   TLBWrite<='0';
				   MemRead<='1';
				   MemWrite<='0';
				   MemDataSrc<='0';
					MemAddrSrc<="00";
				   IRWrite<='1';
				   RegDst<="00";
				   RegDataSrc<="000";
				   RegDataCtrl<="00";
				   RegWrite<='0';
					ExtendOp<="000";
				   ALUSrcA<="00";
				   ALUSrcB<="000";
					ALUOp<="0000";
				   PCSrc<="000";
				   PCWriteCond<="000";
				   HISrc<='0';
				   LOSrc<='0';
				   HIWrite<='0';
				   LOWrite<='0';
				   ALUOutWrite<='0';
				   RPCWrite<='0';
				   CP0Write<='0';
					exc_code<="00000";
					EPCWrite<='0';
				when decode=>
					g_state<=execute;
					PCWrite<='1';				   
				   MemRead<='0';				 
				   IRWrite<='0';
					ExtendOp<="010";
					ALUSrcA<="00";
				   ALUSrcB<="010";
					ALUOp<="0000";
					PCSrc<="000";
				when execute=>
					PCWrite<='0';
					g_state<=write_back;
					case instructions(31 downto 26) is
						when "001001"=>									--ADDIU
							--g_state<=write_back;
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when "000000"=>
							if instructions(10 downto 6) = "00000" then
								case instructions(5 downto 0) is
									when "100001"=>						--ADDU										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0000";
									when "101010"=>						--SLT										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="1001";
									when "101011"=>						--SLTU										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="1010";
									when "100011"=>						--SUBU										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0001";
									when "011000"=>
										if instructions(15 downto 11) = "00000" then				--MULT											
											HISrc<='1';
											LOSrc<='1';
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "010010"=>
										if instructions(25 downto 16) = "0000000000" then				--MFLO											
											RegDst<="00";
											RegDataSrc<="001";
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "010000"=>
										if instructions(25 downto 16) = "0000000000" then				--MFHI											
											RegDst<="00";
											RegDataSrc<="010";
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "010011"=>
										if instructions(20 downto 11) = "0000000000" then				--MTLO											
											LOSrc<='0';
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "010001"=>
										if instructions(20 downto 11) = "0000000000" then				--MTHI											
											HISrc<='0';
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "001001"=>
										if instructions(20 downto 16) = "00000" then				--JALR											
											RegDst<="00";
											RegDataSrc<="100";
											PCSrc<="011";
											RPCWrite<='1';
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "001000"=>
										if instructions(20 downto 11) = "0000000000" then				--JR											
											PCSrc<="011";
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when "100100"=>							--AND										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0010";		
									when "100111"=>							--NOR										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0100";
									when "100101"=>							--OR										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0011";		
									when "100110"=>							--XOR										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="01";
										ALUSrcB<="001";
										ALUOp<="0101";		
									when "000100"=>							--SLLV										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="10";
										ALUSrcB<="100";
										ALUOp<="0110";										
									when "000111"=>							--SRAV										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="10";
										ALUSrcB<="100";
										ALUOp<="0111";
									when "000110"=>							--SRLV										
										RegDst<="00";
										RegDataSrc<="000";
										ALUSrcA<="10";
										ALUSrcB<="100";
										ALUOp<="1000";
									when "001100"=>
										if instructions(25 downto 11) = "000000000000000" then		--SYSCALL
											g_state<=interrupt;
											exc_code<="01000";
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
									when others=>
										if instructions(5 downto 0) = "000000" OR instructions(5 downto 0) = "000011"    
											OR instructions(5 downto 0) = "000010" then
											g_state<=instruction_fetch;
										else
											g_state<=interrupt;
											exc_code<="01010";
										end if;
								end case;
							elsif instructions(25 downto 21) = "00000" then
								case instructions(5 downto 0) is
								when "000000"=>   					--SLL									
									RegDst<="00";
									RegDataSrc<="000";
									ExtendOp<="100";
									ALUSrcA<="10";
									ALUSrcB<="010";
									ALUOp<="0110";
								when "000011"=> 						--SRA									
									RegDst<="00";
									RegDataSrc<="000";
									ExtendOp<="100";
									ALUSrcA<="10";
									ALUSrcB<="010";
									ALUOp<="0111";
								when "000010"=> 						--SRL									
									RegDst<="00";
									RegDataSrc<="000";
									ExtendOp<="100";
									ALUSrcA<="10";
									ALUSrcB<="010";
									ALUOp<="1000";
								when others=>
									g_state<=interrupt;
									exc_code<="01010";
								end case;
							else													
								g_state<=interrupt;
								exc_code<="01010";
							end if;						
						when "001010"=>									--SLTI							
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="1001";
						when "001011"=>									--SLTIU							
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="001";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="1010";
						when "000100"=>									--BEQ							
							ALUSrcA<="01";
							ALUSrcB<="001";
							ALUOp<="1001";
							PCSrc<="001";
							ALUOutWrite<='1';
							PCWriteCond<="001";
						when "000001"=>									
							case instructions(20 downto 16) is
							when "00001"=>						--BGEZ
								ALUSrcA<="01";
								ALUSrcB<="011";
								ALUOp<="1001";
								PCSrc<="001";
								ALUOutWrite<='1';
								PCWriteCond<="010";
							when "00000"=>						--BLTZ
								ALUSrcA<="01";
								ALUsrcB<="011";
								ALUOp<="1001";
								PCSrc<="001";
								ALUOutWrite<='1';
								PCWriteCond<="101";
							when others=>
								g_state<=interrupt;
								exc_code<="01010";
							end case;
						when "000111"=>									
							if instructions(20 downto 16) = "00000" then			--BGTZ								
								ALUSrcA<="01";
								ALUsrcB<="011";
								ALUOp<="1001";
								PCSrc<="001";
								ALUOutWrite<='1';
								PCWriteCond<="011";
							else
								g_state<=interrupt;
								exc_code<="01010";
							end if;
						when "000110"=>
							if instructions(20 downto 16) = "00000" then			--BLEZ								
								ALUSrcA<="01";
								ALUsrcB<="011";
								ALUOp<="1001";
								PCSrc<="001";
								ALUOutWrite<='1';
								PCWriteCond<="100";
							else
								g_state<=interrupt;
								exc_code<="01010";
							end if;						
						when "000101"=>								--BNE							
							ALUSrcA<="01";
							ALUsrcB<="001";
							ALUOp<="1001";
							PCSrc<="001";
							ALUOutWrite<='1';
							PCWriteCond<="110";
						when "000010"=>								--J							
							ExtendOp<="011";
							PCSrc<="010";						
						when "000011"=>								--JAL							
							RegDst<="10";
							RegDataSrc<="100";
							ExtendOp<="011";
							PCSrc<="010";
							RPCWrite<='1';
						when "100011"=>								--LW
							g_state<=mem_access;
							IorD<='1';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when "101011"=>								--SW						
							g_state<=mem_access;
							IorD<='1';
							MemDataSrc<='0';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when "100000"=>								--LB
							g_state<=mem_access;
							MemAddrSrc<="01";
							IorD<='1';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when "100100"=>								--LBU
							g_state<=mem_access;
							MemAddrSrc<="01";
							IorD<='1';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when "101000"=>								--SB
							g_state<=mem_access;
							MemAddrSrc<="01";
							IorD<='1';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";				
						when "001100"=>								--ANDI							
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="001";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0010";
						when "001111"=>
							if instructions(25 downto 21) = "00000" then   --LUI								
								RegDst<="01";
								RegDataSrc<="101";	
							else
								g_state<=interrupt;
								exc_code<="01010";
							end if;
						when "001101"=>									--ORI						
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="001";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0011";
						when "001110"=>									--XORI							
							RegDst<="01";
							RegDataSrc<="000";
							ExtendOp<="001";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0101";
						when "101111"=>									--NOP
							g_state<=instruction_fetch;
						when "010000"=>
							if instructions(25 downto 0)="10000000000000000000011000" then --ERET								
								PCSrc<="100";
							elsif instructions(25 downto 0)="10000000000000000000000010" then --TLBWI								
								TLBWrite<='1';
							elsif instructions(25 downto 21) = "00000" AND instructions(10 downto 0)="00000000000" then --MFC0
								RegDst<="01";
								RegDataSrc<="110";
							elsif instructions(25 downto 21)="00100" AND instructions(10 downto 0)="00000000000" then --MTC0
								CP0Write<='1';
							else
								g_state<=interrupt;
								exc_code<="01010";
							end if;
						when "100101"=>                       --LHU
							g_state<=mem_access;
							MemAddrSrc<="10";
							IorD<='1';
							ExtendOp<="000";
							ALUSrcA<="01";
							ALUSrcB<="010";
							ALUOp<="0000";
						when others=>
							g_state<=interrupt;
							exc_code<="01010";
					end case;
				when mem_access=>
					g_state<=write_back;
					case instructions(31 downto 26) is
						when "100011"=>							--LW				--wait to be modified
							MemRead<='1';
							RegDst<="01";
							RegDataSrc<="011";
						when "101011"=>							--SW
							MemWrite<='1';
							g_state<=instruction_fetch;
						when "100000"=>							--LB
							MemRead<='1';
							RegDst<="01";
							RegDataSrc<="011";
							RegDataCtrl<="01";
						when "100100"=>							--LBU
							MemRead<='1';
							RegDst<="01";
							RegDataSrc<="011";
							RegDataCtrl<="10";
						when "101000"=>							--SB
							MemRead<='1';
							MemDataSrc<='1';				
						when "100101"=>							--LHU
							MemRead<='1';
							RegDst<="01";
							RegDataSrc<="011";
							RegDataCtrl<="11";
						when others=>
							null;
					end case;
				when write_back=>					
					g_state<=instruction_fetch;
					case instructions(31 downto 26) is
						when "001001"=>									--ADDIU
							RegWrite<='1';
						when "000000"=>
							if instructions(10 downto 6) = "00000" then
								case instructions(5 downto 0) is
									when "100001"=>						--ADDU										
										RegWrite<='1';
									when "101010"=>						--SLT										
										RegWrite<='1';
									when "101011"=>						--SLTU										
										RegWrite<='1';
									when "100011"=>						--SUBU										
										RegWrite<='1';
									when "011000"=>						--MULT
										HIWrite<='1';
										LOWrite<='1';
									when "010010"=>		      		--MFLO											
										RegWrite<='1';										
									when "010000"=>      				--MFHI											
										RegWrite<='1';
									when "010011"=>      				--MTLO											
											LOWrite<='1';										
									when "010001"=>      				--MTHI											
											HIWrite<='1';										
									when "001001"=>               	--JALR											
											PCWrite<='1';
											RegWrite<='1';
											RPCWrite<='0';																					
									when "001000"=>      				--JR											
											PCWrite<='1';									
									when "100100"=>							--AND										
										RegWrite<='1';
									when "100111"=>							--NOR										
										RegWrite<='1';
									when "100101"=>							--OR										
										RegWrite<='1';
									when "100110"=>							--XOR										
										RegWrite<='1';
									when "000100"=>							--SLLV										
										RegWrite<='1';
									when "000111"=>							--SRAV										
										RegWrite<='1';
									when "000110"=>							--SRLV																			
										RegWrite<='1';																											
									when others=>
										null;
								end case;
							else
								case instructions(5 downto 0) is
								when "000000"=>   					--SLL									
									RegWrite<='1';
								when "000011"=> 						--SRA									
									RegWrite<='1';
								when "000010"=> 						--SRL									
									RegWrite<='1';
								when others=>
									null;
								end case;							
							end if;						
						when "001010"=>									--SLTI							
							RegWrite<='1';
						when "001011"=>									--SLTIU							
							RegWrite<='1';
						when "000100"=>									--BEQ							
							ALUOutWrite<='0';
						when "000001"=>									
							case instructions(20 downto 16) is
							when "00001"=>						--BGEZ								
								ALUOutWrite<='0';
							when "00000"=>						--BLTZ
								ALUOutWrite<='0';
							when others=>
								null;
							end case;
						when "000111"=>						--BGTZ								
							ALUOutWrite<='0';							
						when "000110"=>         			--BLEZ								
							ALUOutWrite<='0';							
						when "000101"=>								--BNE							
							ALUOutWrite<='0';
						when "000010"=>								--J							
							PCWrite<='1';				
						when "000011"=>								--JAL							
							PCWrite<='1';
							RegWrite<='1';
							RPCWrite<='0';
						when "100011"=>								--LW
							MemRead<='0';
							RegWrite<='1';
--						when "101011"=>								--SW						
--							null;
						when "100000"=>								--LB
							MemRead<='0';
							RegWrite<='1';							
						when "100100"=>								--LBU
							MemRead<='0';
							RegWrite<='1';
						when "101000"=>								--SB
							MemRead<='0';
							MemWrite<='1';							
						when "001100"=>								--ANDI							
							RegWrite<='1';
						when "001111"=>                        --LUI								
							RegWrite<='1';								
						when "001101"=>									--ORI						
							RegWrite<='1';
						when "001110"=>									--XORI							
							RegWrite<='1';
--						when "101111"=>									--NOP
--							g_state<=instruction_fetch;
						when "010000"=>
							if instructions(25 downto 0)="10000000000000000000011000" then --ERET								
								PCWrite<='1';
							elsif instructions(25 downto 0)="10000000000000000000000010" then --TLBWI								
								TLBWrite<='0';
							elsif instructions(25 downto 21) = "00000" AND instructions(10 downto 0)="00000000000" then --MFC0
								RegWrite<='1';
							else										 --MTC0
								CP0Write<='0';							
							end if;
						when "100101"=>                       --LHU
							MemRead<='0';
							RegWrite<='1';
						when others=>
							null;
					end case;	
				when interrupt=>									--exception
					g_state<=instruction_fetch;					
				when others=>null;
			end case;
		end if;
	end process;

end Behavioral;

