library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity paddle is
	port(
		clk         : in  std_logic;
		speed       : in  integer;
		up          : in  std_logic;
		down        : in  std_logic;
		xPos        : in  integer;

		height      : in  integer;
		width       : in  integer;

		vState      : in  std_logic_vector(15 downto 0);
		hState      : in  std_logic_vector(15 downto 0);
		inPaddle    : out std_logic;

		checkX      : in  std_logic_vector(15 downto 0);
		checkY      : in  std_logic_vector(15 downto 0);
		checkResult : out std_logic;

		picWidth    : in  integer;
		picHeight   : in  integer
	);
end entity paddle;

architecture RTL of paddle is
	signal value : std_logic_vector(15 downto 0);
begin
	paddleCounter_inst : entity work.paddleCounter
		port map(
			up    => up,
			down  => down,
			clk   => clk,
			speed => speed,
			value => value,
			maxY => picHeight - height
			
		);

	rectangle : entity work.rectangle
		port map(
			vState      => vState,
			hState      => hState,
			startX      => xPos,
			startY      => value,
			width       => width,
			height      => height,
			inRectangle => inPaddle
		);

	checkResult <= '1' when (((checkX > xPos) and (checkX < xPos - width)) and ((checkY > value) and (checkY < value - height))) else '0';
end architecture RTL;
