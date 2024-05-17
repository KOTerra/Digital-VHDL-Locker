library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity MPG is
  port (
    btn : in std_logic;
    clk : in std_logic;
    debounced : out std_logic 
  );
end MPG;

architecture Behavioral of MPG is

  signal cnt : integer := 0;
  signal Q1 : std_logic;
  signal Q2 : std_logic;
  signal Q3 : std_logic;
begin
  process (clk)
  begin
    if rising_edge(clk) then

      cnt <= cnt + 1;
      if cnt = 5 then --65536
        cnt<=1;
      end if;
    end if;
  end process;

  process (btn, clk)
  begin
    if rising_edge(clk) then
      if cnt = 4 then  --65535
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

    debounced <= not Q3 and Q2;

  end process;

end Behavioral;

---asta e furat de pe net oricum nu merge
-- ENTITY MPG IS
--   GENERIC(
--     clk_freq    : INTEGER := 50_000_000;  --system clock frequency in Hz
--     stable_time : INTEGER := 10);         --time button must remain stable in ms
--   PORT(
--     button  : IN  STD_LOGIC;  --input signal to be debounced
--     clk     : IN  STD_LOGIC;  --input clock
--     debounced  : OUT STD_LOGIC); --debounced signal
-- END MPG;

-- ARCHITECTURE logic OF debounce IS
--   SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0); --input flip flops
--   SIGNAL counter_set : STD_LOGIC;                    --sync reset to zero
-- BEGIN

--   counter_set <= flipflops(0) xor flipflops(1);  --determine when to start/reset counter

--   PROCESS(clk, reset_n)
--     VARIABLE count :  INTEGER RANGE 0 TO clk_freq*stable_time/1000;  --counter for timing
--   BEGIN
--     IF(reset_n = '0') THEN                        --reset
--       flipflops(1 DOWNTO 0) <= "00";                 --clear input flipflops
--       debounced <= '0';                                 --clear debounced register
--     ELSIF(clk'EVENT and clk = '1') THEN           --rising clock edge
--       flipflops(0) <= button;                        --store button value in 1st flipflop
--       flipflops(1) <= flipflops(0);                  --store 1st flipflop value in 2nd flipflop
--       If(counter_set = '1') THEN                     --reset counter because input is changing
--         count := 0;                                    --clear the counter
--       ELSIF(count < clk_freq*stable_time/1000) THEN  --stable input time is not yet met
--         count := count + 1;                            --increment counter
--       ELSE                                           --stable input time is met
--         debounced <= flipflops(1);                        --output the stable value
--       END IF;    
--     END IF;
--   END PROCESS;

-- END logic;