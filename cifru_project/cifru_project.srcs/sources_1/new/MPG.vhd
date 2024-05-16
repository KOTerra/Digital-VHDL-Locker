library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MPG is
  port (
    btn : in std_logic;
    clk : in std_logic;
    debounced : out std_logic
  );
end MPG;

architecture Behavioral of MPG is

  signal cnt : std_logic_vector(15 downto 0) := x"0000";
  signal Q1 : std_logic;
  signal Q2 : std_logic;
  signal Q3 : std_logic;
begin
  process (clk)
  begin
    if rising_edge(clk) then
      cnt <= cnt + 1;
    end if;
  end process;

  process (clk)
  begin
    if rising_edge(clk) then
      if cnt = x"FFFF" then
        Q1 <= btn;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if rising_edge(clk) then
      Q2 <= Q1;
      Q3 <= Q2;
    end if;

  end process;

  debounced <= not Q3 and Q2;

end Behavioral;