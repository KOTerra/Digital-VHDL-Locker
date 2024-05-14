
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity testbench is
    --  Port ( );
end testbench;

architecture Behavioral of testbench is
    component cifru is
        port (
            clk : in std_logic;
            reset : in std_logic;
            up, down, addCifra : in std_logic;
            liberOcupatLED : out std_logic;
            introduCaractereLED : out std_logic;
            anodActiv : out std_logic_vector (7 downto 0);
            segmentOutLED : out std_logic_vector (6 downto 0)
        );

    end component;

    signal clk_tb : std_logic;
    signal reset_tb : std_logic;
    signal up_tb, down_tb, addCifra_tb : std_logic;
    signal liberOcupatLED_tb : std_logic;
    signal introduCaractereLED_tb : std_logic;
    signal anodActiv_tb : std_logic_vector (7 downto 0);
    signal segmentOutLED_tb : std_logic_vector (6 downto 0);

begin
    test : cifru port map(clk_tb, reset_tb, up_tb, down_tb, addCifra_tb, liberOcupatLED_tb, introduCaractereLED_tb, anodActiv_tb, segmentOutLED_tb);

    simClock : process
    begin
        lp : loop
            clk_tb <= '0';
            wait for 1ns;
            clk_tb <= '1';
            wait for 1ns;
        end loop;
    end process;

    ---------

    testprocess : process
    begin
        addCifra_tb <= '1';
        wait for 100ns;
        addCifra_tb <= '0';
        wait for 100ns;
        addCifra_tb <= '1';
        wait for 100ns;
        addCifra_tb <= '0';
        wait for 100ns;
        addCifra_tb <= '1';
        wait for 100ns;
        addCifra_tb <= '0';
        wait for 100ns;
        addCifra_tb <= '1';
        wait for 100ns;
        addCifra_tb <= '0';
        wait for 100ns;
        addCifra_tb <= '1';
        wait for 100ns;
        addCifra_tb <= '0';

    end process;

end Behavioral;