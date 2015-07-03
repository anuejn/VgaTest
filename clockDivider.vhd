library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity clockDivider is
	Port(
		inClk  : in  std_logic;
		outClk : out std_logic_vector(31 downto 0)
	);
end clockDivider;

architecture dividerByOne of clockDivider is
	signal lastState : std_logic_vector(31 downto 0);
begin
	process(inClk)
	begin
		if inClk'event and (inClk = '0') then
			lastState <= lastState + 1;
		end if;
	end process;

	outClk <= lastState;
end dividerByOne;