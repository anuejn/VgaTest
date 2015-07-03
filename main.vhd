library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity main is
	port(
		clk   : in  std_logic;
		vSync : out std_logic;
		hSync : out std_logic;
		r     : out std_logic;
		g     : out std_logic;
		b     : out std_logic;

		up    : in  std_logic;
		down  : in  std_logic
	);
end entity main;

architecture RTL of main is
	signal pixelClock : std_logic;
	signal hState     : std_logic_vector(15 downto 0);
	signal vState     : std_logic_vector(15 downto 0);

	signal rTmp : std_logic;
	signal gTmp : std_logic;
	signal bTmp : std_logic;

	signal width  : integer;
	signal height : integer;

begin
	pll1 : entity work.pll
		port map(
			inclk0 => clk,
			c0     => pixelClock
		);

	vga1 : entity work.vga
		port map(
			pixelClock => pixelClock,
			vSyncPulse => vSync,
			hSyncPulse => hSync,
			vertical   => hState,
			horizontal => vState,
			outWidth   => width,
			outHeight  => height
		);

	picture1 : entity work.picture
		port map(
			vState => vState,
			hState => hState,
			r      => rTmp,
			g      => gTmp,
			b      => bTmp,
			width  => width,
			height => height,
			clk    => clk,
			up     => up,
			down   => down
		);

	multiplexer1 : entity work.colorMultiplexer3bit
		port map(
			rIn    => rTmp,
			gIn    => gTmp,
			bIn    => bTmp,
			width  => width,
			height => height,
			vState => vState,
			hState => hState,
			rOut   => r,
			gOut   => g,
			bOut   => b
		);
end architecture RTL;

