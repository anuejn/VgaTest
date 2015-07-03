library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity rectangle is
	port (
		vState : in std_logic_vector(15 downto 0);
		hState : in std_logic_vector(15 downto 0);
		
		startX : in integer;
		startY : in std_logic_vector(15 downto 0);
		width : in integer;
		height : in integer;
		inRectangle : out std_logic
	);
end entity rectangle;

architecture RTL of rectangle is
	
begin
	inRectangle <= '1' when (((vState > startX) and (vState < startX - width)) and ((hState > startY) and (hState < startY - height))) else '0';
end architecture RTL;
