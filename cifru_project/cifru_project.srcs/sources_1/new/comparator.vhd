library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;
use IEEE.std_logic_unsigned.all;

entity comparator is
  port (
  --  enable : in std_logic := '0';
    a1, a2, a3 : in std_logic_vector (3 downto 0);
    b1, b2, b3 : in std_logic_vector (3 downto 0);
   -- checkedMatch : out std_logic := '0';
    match : out std_logic := '0'
  );
end comparator;

architecture Behavioral of comparator is
begin

 -- checkedMatch <= '0';
  process (a1, a2, a3, b1, b2, b3)
  begin
   -- if enable = '1' then
      if a1 = b1 and a2 = b2 and a3 = b3 then
        match <= '1';
      else
        match <= '0';
      end if;
    --  checkedMatch <= '1';
  --  else
   --   checkedMatch <= '0';
  --  end if;
  end process;

end Behavioral;