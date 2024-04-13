
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity UnitateControl is
    port (
        clk : in std_logic;
        reset : in std_logic;
        addCifra : in std_logic;
        checkedMatch : in std_logic;
        match : in std_logic;
        liberOcupat : out std_logic;
        introduCaractere : out std_logic;
        displayValue1 : in std_logic_vector (3 downto 0);
        displayValue2 : in std_logic_vector (3 downto 0);
        displayValue3 : in std_logic_vector (3 downto 0);
        anodActiv : out std_logic_vector (7 downto 0);
        segmentLED : out std_logic_vector (6 downto 0));
end UnitateControl;

architecture Behavioral of UnitateControl is
    type state is (LIBER, ASTEPT_CIFRA0, ASTEPT_CIFRA1, ASTEPT_CIFRA2, OCUPAT, ASTEPT_CIFRA3, ASTEPT_CIFRA4, ASTEPT_CIFRA5, ASTEPT_MATCH);

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

    changeState : process (currentState, addCifra, match, checkedMatch, liberOcupat, introduCaractere, displayValue1, displayValue2, displayValue3)
    begin
        addCifra <= '0';
        --match <= '0';
        liberOcupat <= '0';
        introduCaractere <= '0';
        displayValue1 <= '0';
        displayValue2 <= '0';
        displayValue3 <= '0';
        enableCatod1 <= '0';
        enableCatod2 <= '0';
        enableCatod3 <= '0';
        ----componenet anod

        case currentState is
            when LIBER =>
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA0;
                end if;

            when ASTEPT_CIFRA0 =>
                introduCaractere <= '1';
                enableCatod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA1;
                end if;

            when ASTEPT_CIFRA1 =>
                introduCaractere <= '1';
                enableCatod1 <= '1';
                enableCatod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA2;
                end if;

            when ASTEPT_CIFRA2 =>
                introduCaractere <= '1';
                enableCatod1 <= '1';
                enableCatod2 <= '1';
                enableCatod3 <= '1';
                if addCifra = '1' then
                    nextState <= OCUPAT;
                end if;

                -----

            when OCUPAT =>
                liberOcupat <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA3;
                end if;

            when ASTEPT_CIFRA3 =>
                liberOcupat <= '1';
                introduCaractere <= '1';
                enableCatod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA4;
                end if;

            when ASTEPT_CIFRA3 =>
                liberOcupat <= '1';
                introduCaractere <= '1';
                enableCatod1 <= '1';
                enableCatod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA5;
                end if;

            when ASTEPT_CIFRA3 =>
                liberOcupat <= '1';
                introduCaractere <= '1';
                enableCatod1 <= '1';
                enableCatod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_MATCH;
                end if;

            when ASTEPT_MATCH =>
                if checkedMatch = '0' then
                    nextState <= ASTEPT_MATCH;
                else
                    if match = '1' then
                        nextState <= LIBER;
                    elsif match = '0' then
                        nextState <= OCUPAT;
                    end if;
                end if;
            when others =>
                nextState <= LIBER;
        end case;
    end process;

end Behavioral;