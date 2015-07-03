library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity picture is
	port (
		vState : in std_logic_vector(15 downto 0);
		hState : in std_logic_vector(15 downto 0);
		r : out std_logic;
		g : out std_logic;
		b : out std_logic;
		
		width : in integer;
		height : in integer;
		clk : in std_logic;
		
		up : in std_logic;
		down : in std_logic
	);
end entity picture;

architecture pong of picture is
	signal blackWhite : std_logic;
	constant paddleWidth : integer := 15;
	constant paddleHeight : integer := 100;
	constant speed : integer := 28;
	constant border : integer := 10;
	
		
begin
	r <= blackWhite;
	g <= blackWhite;
	b <= blackWhite;
	
	paddle_inst : entity work.paddle
		port map(
			clk         => clk,
			speed       => speed,
			up          => up,
			down        => down,
			xPos        => border,
			height      => paddleWidth,
			width       => paddleHeight,
			vState      => vState,
			hState      => hState,
			inPaddle    => blackWhite,
			checkX      => checkX,
			checkY      => checkY,
			checkResult => checkResult
		);
	
end architecture pong;