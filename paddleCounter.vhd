library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity paddleCounter is
	port(
		up    : in  std_logic;
		down  : in  std_logic;
		clk   : in  std_logic;
		speed : in  integer;
		value : out std_logic_vector(15 downto 0);
		maxY  : in  integer
	);
end entity paddleCounter;

architecture RTL of paddleCounter is
	signal slowClks      : std_logic_vector(31 downto 0);
	signal selectedClk   : std_logic;
	signal internalValue : std_logic_vector(15 downto 0);

begin
	cDiv : entity work.clockDivider
		port map(
			inClk  => clk,
			outClk => slowClks
		);

	selectedClk <= slowClks(speed); --here you can control the speed

	process(selectedClk) is
	begin
		if selectedClk'event and selectedClk = '0' then
			if (up = '1') then
				internalValue <= internalValue + 1;
			elsif (down = '1') then
				internalValue <= internalValue - 1;
			end if;
		end if;
	end process;

	value <= internalValue;

end architecture RTL;
