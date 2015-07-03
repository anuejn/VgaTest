library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity vga is
	port (
		pixelClock : in std_logic; -- 40Mhz for 800 x 600 @ 60Hz
		vSyncPulse : out std_logic;
		hSyncPulse : out std_logic;
		vertical : out std_logic_vector(15 downto 0);
		horizontal : out std_logic_vector(15 downto 0);
		
		outWidth : out integer;
		outHeight : out integer
	);
end entity vga;

architecture RTL of vga is
	constant hPic : integer := 800;
	constant hFront : integer := 40;
	constant hSync : integer := 128;
	constant hBack : integer := 88;
	
	constant vPic : integer := 600;
	constant vFront : integer := 1;
	constant vSync : integer := 4;
	constant vBack : integer := 23;
	
	constant width : integer := hPic + hFront + hSync + hBack;
	constant height : integer := vPic + vFront + vSync + vBack;
	
	signal vState : std_logic_vector(15 downto 0);
	signal hState : std_logic_vector(15 downto 0);
begin
	process(pixelClock) is
	begin
		if pixelClock'event and (pixelClock = '1') then
			if(hState < width) then
				hState <= hState + 1;
			else
				hState <= (others => '0');
				if(vState < height) then
					vState <= vState + 1;
				else
					vState <= (others => '0');
				end if;
			end if;
			
			-- now the Horizantal timing
			if(hState < hPic) then --picture

			elsif(hState < (hPic + hFront)) then --Front Porch

			elsif(hState < (hPic + hFront + hSync)) then --Sync Pulse
				hSyncPulse <= '1';--begin horizontal sync pulse
			else --Back Porch
				hSyncPulse <= '0';--end horizontal sync pulse
			end if;
			-- end of the horizontal timing
			
			-- now the Vertical timing
			if(vState < vPic) then --picture
				
			elsif((vState < (vPic + vFront))) then --Front Porch

			elsif((vState < (vPic + vFront + vSync))) then --Sync Pulse
					vSyncPulse <= '1';--begin vertical sync pulse
			else --Back Porch
					vSyncPulse <= '0';--end vertical sync pulse
			end if;
			-- end of the Vertical timing
		end if;
	end process;
	
	horizontal <= hState;
	vertical <= vState; 
	
	outWidth <= width;
	outHeight <= height;

end architecture RTL;
