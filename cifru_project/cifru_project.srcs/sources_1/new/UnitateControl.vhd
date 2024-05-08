library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity UnitateControl is
    port (
        clk : in std_logic;
        reset : in std_logic;
        addCifra : in std_logic;
        enableCompare : out std_logic;
        checkedMatch : in std_logic;
        enableAnod1 : out std_logic;
        enableAnod2 : out std_logic;
        enableAnod3 : out std_logic;
        match : in std_logic;
        liberOcupat : inout std_logic;
        liberOcupatLED : out std_logic;
        introduCaractereLED : out std_logic
    );
end UnitateControl;

architecture Behavioral of UnitateControl is
    type state is (LIBER, ASTEPT_CIFRA0, ASTEPT_CIFRA1, ASTEPT_CIFRA2, OCUPAT, ASTEPT_CIFRA3, ASTEPT_CIFRA4, ASTEPT_CIFRA5, ASTEPT_MATCH);

    signal currentState, nextState : state;
begin

    act : process (reset, clk)
    begin
        if reset = '1' then
            currentState <= LIBER;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    changeState : process (currentState, match, checkedMatch)
    begin
        liberOcupat <= '0';
        introduCaractereLED <= '0';
        enableCompare <= '0';
        enableAnod1 <= '0';
        enableAnod2 <= '0';
        enableAnod3 <= '0';
        ----componenet anod

        case currentState is
            when LIBER =>
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA0;
                end if;

            when ASTEPT_CIFRA0 =>
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA1;
                end if;

            when ASTEPT_CIFRA1 =>
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA2;
                end if;

            when ASTEPT_CIFRA2 =>
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                enableAnod3 <= '1';
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
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA4;
                end if;

            when ASTEPT_CIFRA4 =>
                liberOcupat <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA5;
                end if;

            when ASTEPT_CIFRA5 =>
                liberOcupat <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_MATCH;
                end if;
                ---sau un wait 

            when ASTEPT_MATCH =>
                enableCompare <= '1';
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
        liberOcupatLED <= liberOcupat;
    end process;

end Behavioral;