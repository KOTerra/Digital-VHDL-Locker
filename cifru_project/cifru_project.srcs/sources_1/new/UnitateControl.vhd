
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity UnitateControl is
    port (
        clk : in std_logic;
        reset : in std_logic;
        addCifra : in std_logic;
        match : in std_logic;
        liber_ocupat : inout std_logic;
        introdu_caractere : inout std_logic;
        displayValue1 : in std_logic_vector (3 downto 0);
        displayValue2 : in std_logic_vector (3 downto 0);
        displayValue3 : in std_logic_vector (3 downto 0);
        anodActiv : out std_logic_vector (7 downto 0);
        segmentLED : out std_logic_vector (6 downto 0));
end UnitateControl;

architecture Behavioral of UnitateControl is
    type state is (LIBER, ASTEPT_CIFRA0, ASTEPT_CIFRA1, ASTEPT_CIFRA2, OCUPAT, ASTEPT_CIFRA3, ASTEPT_CIFRA4, ASTEPT_CIFRA5);

    signal currentState, nextState : state;
    signal enableCatod1, enableCatod2, enableCatod3 : std_logic;
begin

    act : process (reset, clk)
    begin
        if reset = '1' then
            currentState <= LIBER;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    changeState : process (currentState, addCifra, match, displayValue1, displayValue2, displayValue3)
    begin
        addCifra <= '0';
        match <= '0';
        displayValue1 <= '0';
        displayValue2 <= '0';
        displayValue3 <= '0';
        enableCatod1 <= '0';
        enableCatod2 <= '0';
        enableCatod3 <= '0';

        case currentState is
            when LIBER =>
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA0;
                end if;
            when ASTEPT_CIFRA0 =>
                enableCatod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA1;
                end if;

            when others =>
                nextState <= LIBER;
        end case;
    end process;

end Behavioral;