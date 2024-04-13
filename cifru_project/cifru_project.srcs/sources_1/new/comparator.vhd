library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity comparator is
Port (
a1,a2,a3: in std_logic_vector (3 downto 0);  
b1,b2,b3: in std_logic_vector (3 downto 0);  
MATCH : out std_logic      
 );
end comparator;

architecture Behavioral of comparator is
component RamCifru is
    port (
      a_ram : in BIT_VECTOR (1 downto 0);
      cs_ram : in STD_LOGIC;
      we : in STD_LOGIC;
      d_ram : inout BIT_VECTOR (3 downto 0)
    );
  end component;

  component RamCifreCurente is
    port (
      a_ram : in BIT_VECTOR (1 downto 0);
      cs_ram : in STD_LOGIC;
      we : in STD_LOGIC;
      d_ram : inout BIT_VECTOR (3 downto 0)
    );
  end component;
  -- Signals for connecting components
  signal ram1_data : std_logic_vector(3 downto 0);  -- Data from RAM 1
  signal ram2_data : std_logic_vector(3 downto 0);  -- Data from RAM 2
  signal match_out : std_logic;                     -- Output indicating match
begin
 -- Instantiate the RAM modules
  U1: RamCifru port map (
    a_ram =>'0',
    cs_ram => '1',
    we => '1',
    d_ram => ram1_data
  );

  U2: RamCifreCurente port map (
    a_ram =>'0',
    cs_ram => '1',
    we => '1',
    d_ram => ram2_data
  );

process(clk)
  begin
    -- No need to check for rising edge (clock is always running)
    match_out <= ram1_data = ram2_data;
  end process;
  
--MATCH <= (to_integer(unsigned(a1)) = to_integer(unsigned(b1))) and (to_integer(unsigned(a2)) = to_integer(unsigned(b2))) and (to_integer(unsigned(a3)) = to_integer(unsigned(b3)));

end Behavioral;
