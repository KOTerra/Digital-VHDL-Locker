library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;
use IEEE.std_logic_unsigned.all;

entity DisplayController is
    port (
        liberOcupat : in std_logic;
        rcdo0, rcdo1, rcdo2 : in std_logic_vector(3 downto 0);
        rccdo0, rccdo1, rccdo2 : in std_logic_vector(3 downto 0);
        displayValue1, displayValue2, displayValue3 : out std_logic_vector(3 downto 0)
    );
end entity;

architecture Behavioral of DisplayController is
begin
    process (liberOcupat, rcdo0, rcdo1, rcdo2, rccdo0, rccdo1, rccdo2)
    begin
        if liberOcupat = '1' then --ocupat
            displayValue1 <= rccdo0;
            displayValue2 <= rccdo1;
            displayValue3 <= rccdo2;
        else --liber
            displayValue1 <= rcdo0;
            displayValue2 <= rcdo1;
            displayValue3 <= rcdo2;

        end if;
    end process;
end Behavioral;