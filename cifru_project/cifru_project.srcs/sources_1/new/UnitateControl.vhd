library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity UnitateControl is
    port (
        clk : in std_logic;
        reset : in std_logic;
        addCifra : in std_logic := '0';
        enableCompare : out std_logic := '0';
        checkedMatch : in std_logic;
        enableAnod1 : out std_logic := '0';
        enableAnod2 : out std_logic := '0';
        enableAnod3 : out std_logic := '0';
        match : in std_logic;
        liberOcupat : inout std_logic;
        liberOcupatLED : out std_logic;
        introduCaractereLED : out std_logic
    );
end UnitateControl;

architecture Behavioral of UnitateControl is
    type state is (LIBER, ASTEPT_CIFRA0, ASTEPT_CIFRA1, ASTEPT_CIFRA2, OCUPAT, ASTEPT_CIFRA3, ASTEPT_CIFRA4, ASTEPT_CIFRA5, ASTEPT_MATCH);

    signal allowAdd : std_logic := '1';
    signal currentState, nextState : state;
begin

    act : process (clk, reset, nextState)
    begin
        if reset = '1' then
            currentState <= LIBER;
        end if;
        if rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    changeState : process (reset, allowAdd, addCifra, currentState, match, checkedMatch)
    begin

        liberOcupat <= '0';
        liberOcupatLED <= '0';
        -- introduCaractereLED <= '0';
       -- enableCompare <= '0';
        --enableAnod1 <= '0';
        --enableAnod2 <= '0';
        --enableAnod3 <= '0';
        ----componenet anod

        if addCifra = '0' then
            allowAdd <= '1';
        end if;

        case currentState is
            when LIBER =>
                report "CURRENT STATE: liber" severity note;
                introduCaractereLED <= '0';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '0';
                enableAnod2 <= '0';
                enableAnod3 <= '0';

                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA0;
                end if;

            when ASTEPT_CIFRA0 =>
                report "CURRENT STATE: c0"severity note;
                introduCaractereLED <= '1';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '1';
                enableAnod2 <= '0';
                enableAnod3 <= '0';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA1;
                end if;

            when ASTEPT_CIFRA1 =>
                report "CURRENT STATE: c1" severity note;
                introduCaractereLED <= '1';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                enableAnod3 <= '0';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA2;
                end if;

            when ASTEPT_CIFRA2 =>
                report "CURRENT STATE: c2" severity note;
                introduCaractereLED <= '1';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                enableAnod3 <= '1';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= OCUPAT;
                end if;

                -----

            when OCUPAT =>
                report "CURRENT STATE: ocupat" severity note;
                introduCaractereLED <= '0';
                liberOcupat <= '1';
                liberOcupatLED <= '1';
                enableAnod1 <= '0';
                enableAnod2 <= '0';
                enableAnod3 <= '0';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA3;
                end if;

            when ASTEPT_CIFRA3 =>
                report "CURRENT STATE: c3"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '0';
                enableAnod3 <= '0';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA4;
                end if;

            when ASTEPT_CIFRA4 =>
                report "CURRENT STATE: c4"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                enableAnod3 <= '0';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_CIFRA5;
                end if;

            when ASTEPT_CIFRA5 =>
                report "CURRENT STATE: c5"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                enableAnod3 <= '1';
                if addCifra = '1' and allowAdd = '1'then
                    allowAdd <= '0';
                    nextState <= ASTEPT_MATCH;
                end if;
                ---sau un wait 

            when ASTEPT_MATCH =>
                report "CURRENT STATE: match" severity note;

                -- enableCompare <= '1';
                -- if checkedMatch = '0' then
                --     nextState <= ASTEPT_MATCH;
                -- else
                    if match = '1' then
                        nextState <= LIBER;
                        liberOcupat <= '0';
                        liberOcupatLED <= '0';
                    elsif match = '0' then
                        nextState <= OCUPAT;
                        liberOcupat <= '1';
                        liberOcupatLED <= '1';
                    end if;
               -- end if;
            when others =>
                nextState <= LIBER;
        end case;
        if reset = '1' then
            nextState <= LIBER;
        end if;
    end process;

end Behavioral;