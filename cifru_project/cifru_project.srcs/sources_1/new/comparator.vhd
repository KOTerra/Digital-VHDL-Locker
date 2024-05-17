library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;
use IEEE.std_logic_unsigned.all;

entity comparator is
  port (
    enable : in std_logic;
    a1, a2, a3 : in std_logic_vector (3 downto 0);
    b1, b2, b3 : in std_logic_vector (3 downto 0);
    checkedMatch : out std_logic := '0';
    match : out std_logic := '0'
  );
end comparator;

architecture Behavioral of comparator is
  signal s1, s2, s3 : std_logic;
begin
  process (enable, a1, a2, a3, b1, b2, b3)
  begin
    s1 <= '1';
    s2 <= '1';
    s3 <= '1';
    checkedMatch <= '0';
    if enable = '1' then
      if a1 = b1 then
        s1 <= '1';
      end if;
      if a2 = b2 then
        s2 <= '1';
      end if;
      if a3 = b3 then
        s3 <= '1';
      end if;

      match <= s1 and s2 and s3;
      checkedMatch <= '1';
    end if;
  end process;

end Behavioral;