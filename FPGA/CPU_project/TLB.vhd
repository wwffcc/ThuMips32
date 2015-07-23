----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:26:07 07/15/2015 
-- Design Name: 
-- Module Name:    TLB - Behavioral 
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

entity TLB is
    Port ( rst : in  STD_LOGIC;
           Index : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo0 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryLo1 : in  STD_LOGIC_VECTOR (31 downto 0);
           EntryHi : in  STD_LOGIC_VECTOR (31 downto 0);          
           Vaddr : in  STD_LOGIC_VECTOR (31 downto 0);
           Paddr : out  STD_LOGIC_VECTOR (31 downto 0);
           TLBWrite : in  STD_LOGIC;
           flag_missing : out  STD_LOGIC;
           flag_writable : out  STD_LOGIC;
			  SW:in STD_LOGIC_VECTOR(5 downto 0);
			  bitmap:out STD_LOGIC_VECTOR(15 downto 0)
			  );
end TLB;

architecture Behavioral of TLB is
type TLBArray is array(15 downto 0) of STD_LOGIC_VECTOR(62 downto 0);
signal tlb:TLBArray:=(others=>(others=>'0'));

begin
	process(Vaddr,tlb)
	begin
		Paddr<=(others=>'0');
		flag_writable<='0';
		if Vaddr>=x"80000000" and Vaddr<x"C0000000" then				--kseg0 or kseg1
			Paddr(28 downto 0)<=Vaddr(28 downto 0);
			Paddr(31 downto 29)<="000";
			flag_missing<='0';
			flag_writable<='1';
		else		
			Paddr<=Vaddr;
																				--kuseg or kseg2
--			flag_missing<='1';
--			Paddr(11 downto 0)<=Vaddr(11 downto 0);						--Page table
--			for i in 0 to 15 LOOP												--search for PTE
--				if tlb(i)(62 downto 44) = Vaddr(31 downto 13) then
--					if Vaddr(12)='0' and tlb(i)(23)='1' then				--even PTE,and page is valid
--						Paddr(31 downto 12)<=tlb(i)(43 downto 24);
--						flag_missing<='0';
--						flag_writable<=tlb(i)(22);
--						exit;
--					elsif Vaddr(12)='1' and tlb(i)(1)='1' then			--odd PTE,and page is valid
--						Paddr(31 downto 12)<=tlb(i)(21 downto 2);
--						flag_missing<='0';
--						flag_writable<=tlb(i)(0);
--						exit;
--					end if;
--				end if;
--			end LOOP;
		end if;
	end process;
	
	process(rst,TLBWrite)
	begin
		if rst='0' then
			tlb<=(others=>(others=>'0'));
		elsif rising_edge(TLBWrite) then
			tlb(CONV_INTEGER(Index(3 downto 0)))(62 downto 44)<=EntryHi(31 downto 13);
			tlb(CONV_INTEGER(Index(3 downto 0)))(43 downto 24)<=EntryLo0(25 downto 6);
			tlb(CONV_INTEGER(Index(3 downto 0)))(23)<=EntryLo0(1);
			tlb(CONV_INTEGER(Index(3 downto 0)))(22)<=EntryLo0(2);
			tlb(CONV_INTEGER(Index(3 downto 0)))(21 downto 2)<=EntryLo1(25 downto 6);			
			tlb(CONV_INTEGER(Index(3 downto 0)))(1)<=EntryLo1(1);
			tlb(CONV_INTEGER(Index(3 downto 0)))(0)<=EntryLo1(2);
		end if;
	end process;
	
	process(SW,tlb)
	begin
		case SW(5 downto 4) is
			when "00"=>
				bitmap<=tlb(CONV_INTEGER(SW(3 downto 0)))(15 downto 0);
			when "01"=>
				bitmap<=tlb(CONV_INTEGER(SW(3 downto 0)))(31 downto 16);
			when "10"=>
				bitmap<=tlb(CONV_INTEGER(SW(3 downto 0)))(47 downto 32);
			when "11"=>
				bitmap(14 downto 0)<=tlb(CONV_INTEGER(SW(3 downto 0)))(62 downto 48);
				bitmap(15)<='0';
			when others=>
				bitmap<=(others=>'0');
		end case;
	end process;
end Behavioral;

