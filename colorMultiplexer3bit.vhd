library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity colorMultiplexer3bit is
	port (
		rIn : in std_logic;
		gIn : in std_logic;
		bIn : in std_logic;
		
		width : in integer;
		height : in integer;
		
		vState : in std_logic_vector(15 downto 0);
		hState : in std_logic_vector(15 downto 0);
		
		rOut : out std_logic;
		gOut : out std_logic;
		bOut : out std_logic
	);
end entity colorMultiplexer3bit;

architecture RTL of colorMultiplexer3bit is
	signal active : std_logic;
	
begin
	active <= '1' when hState < height and vState < width else '0';
	rOut <= rIn when (active = '1') else '0';
	gOut <= gIn when (active = '1') else '0';
	bOut <= bIn when (active = '1') else '0';
end architecture RTL;
