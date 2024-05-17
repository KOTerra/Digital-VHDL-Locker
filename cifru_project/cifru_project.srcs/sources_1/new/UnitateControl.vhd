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
    signal countAdds : integer := 0;
begin

    cntad : process (clk, addCifra, currentState)
    begin
        if currentState = OCUPAT then
            countAdds <= 0;
        end if;

        if addCifra = '1' and rising_edge(clk) then
            countAdds <= countAdds + 1;
        end if;

    end process;

    act : process (clk, reset)
    begin
        if reset = '1' then
            currentState <= LIBER;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    changeState : process (addCifra, currentState, match, checkedMatch)
    begin

        liberOcupat <= '0';
        liberOcupatLED <= '0';
       -- introduCaractereLED <= '0';
        enableCompare <= '0';
        enableAnod1 <= '0';
        enableAnod2 <= '0';
        enableAnod3 <= '0';
        ----componenet anod

        case currentState is
            when LIBER =>
                report "CURRENT STATE: liber" severity note;
                introduCaractereLED <= '0';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA0;
                else
                    nextState <= LIBER;
                end if;

            when ASTEPT_CIFRA0 =>
                report "CURRENT STATE: c0"severity note;
                introduCaractereLED <= '1';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA1;
                end if;

            when ASTEPT_CIFRA1 =>
                report "CURRENT STATE: c1" severity note;
                introduCaractereLED <= '1';
                liberOcupat <= '0';
                liberOcupatLED <= '0';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
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
                if addCifra = '1' then
                    nextState <= OCUPAT;
                end if;

                -----

            when OCUPAT =>
                report "CURRENT STATE: ocupat" severity note;
                report "COUNTED_ADDS: " & integer'image(countAdds) severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA3;
                end if;

            when ASTEPT_CIFRA3 =>
                report "CURRENT STATE: c3"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA4;
                end if;

            when ASTEPT_CIFRA4 =>
                report "CURRENT STATE: c4"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_CIFRA5;
                end if;

            when ASTEPT_CIFRA5 =>
                report "CURRENT STATE: c5"severity note;

                liberOcupat <= '1';
                liberOcupatLED <= '1';
                introduCaractereLED <= '1';
                enableAnod1 <= '1';
                enableAnod2 <= '1';
                if addCifra = '1' then
                    nextState <= ASTEPT_MATCH;
                end if;
                ---sau un wait 

            when ASTEPT_MATCH =>
                report "CURRENT STATE: match" severity note;

                enableCompare <= '1';
                if checkedMatch = '0' then
                    nextState <= ASTEPT_MATCH;
                else
                    if match = '1' then
                        nextState <= LIBER;
                        liberOcupat <= '0';
                        liberOcupatLED <= '0';
                    elsif match = '0' then
                        nextState <= OCUPAT;
                        liberOcupat <= '1';
                        liberOcupatLED <= '1';
                    end if;
                end if;
            when others =>
                nextState <= LIBER;
        end case;
    end process;

end Behavioral;