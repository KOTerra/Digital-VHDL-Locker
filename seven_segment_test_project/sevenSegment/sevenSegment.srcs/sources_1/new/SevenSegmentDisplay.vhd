----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2024 12:41:00
-- Design Name: 
-- Module Name: SevenSegmentDisplay - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegmentDisplay is
    port (
        clk : in std_logic;
        enableAnod0 : in std_logic := '0';
        enableAnod1 : in std_logic := '0';
        enableAnod2 : in std_logic := '0';
        displayValue0 : in std_logic_vector (3 downto 0) := "0000";
        displayValue1 : in std_logic_vector (3 downto 0) := "0000";
        displayValue2 : in std_logic_vector (3 downto 0) := "0000";
        anodActiv : out std_logic_vector (7 downto 0);
        segmentOutLED : out std_logic_vector (6 downto 0));
end SevenSegmentDisplay;

architecture Behavioral of SevenSegmentDisplay is
    signal countMaxValue : std_logic_vector(1 downto 0) := "00";--nr anozi enabled
    signal count : std_logic_vector(1 downto 0) := "00"; --index anod curent
    signal displayValueAtCount : std_logic_vector(3 downto 0) := "0000"; --val curenta pe anod curent
begin
    process (enableAnod0, enableAnod1, enableAnod2)
    begin
        --count <= "00";
        if enableAnod2 = '1' and enableAnod1 = '1' and enableAnod0 = '1' then
            countMaxValue <= "11";
        elsif enableAnod2 = '0' and enableAnod1 = '1' and enableAnod0 = '1' then
            countMaxValue <= "10";
        elsif enableAnod2 = '0' and enableAnod1 = '0' and enableAnod0 = '1' then
            countMaxValue <= "01";
        elsif enableAnod1 = '1' and enableAnod0 = '1' then
            countMaxValue <= "10";
        elsif enableAnod0 = '1' then
            countMaxValue <= "01";
        else
            countMaxValue <= "00";
        end if;

    end process;

    process (clk, countMaxValue)
    begin
        if rising_edge(clk) then
            count <= count + 1;

            if count = countMaxValue then
                count <= "00";
            end if;
        end if;
    end process;

    process (count, displayValue0, displayValue1, displayValue2)
    begin
        case count is
            when "00" =>
                anodActiv <= "11111111";
            when "01" =>
                anodActiv <= "11111110";
                displayValueAtCount <= displayValue0;
            when "10" =>
                anodActiv <= "11111101";
                displayValueAtCount <= displayValue1;
            when "11" =>
                anodActiv <= "11111011";
                displayValueAtCount <= displayValue2;
            when others =>
                anodActiv <= "11111111";
        end case;

        case displayValueAtCount is
            when "0000" => segmentOutLED <= "0000001"; -- "0"     
            when "0001" => segmentOutLED <= "1001111"; -- "1" 
            when "0010" => segmentOutLED <= "0010010"; -- "2" 
            when "0011" => segmentOutLED <= "0000110"; -- "3" 
            when "0100" => segmentOutLED <= "1001100"; -- "4" 
            when "0101" => segmentOutLED <= "0100100"; -- "5" 
            when "0110" => segmentOutLED <= "0100000"; -- "6" 
            when "0111" => segmentOutLED <= "0001111"; -- "7" 
            when "1000" => segmentOutLED <= "0000000"; -- "8"     
            when "1001" => segmentOutLED <= "0000100"; -- "9" 
            when "1010" => segmentOutLED <= "0000010"; -- a
            when "1011" => segmentOutLED <= "1100000"; -- b
            when "1100" => segmentOutLED <= "0110001"; -- C
            when "1101" => segmentOutLED <= "1000010"; -- d
            when "1110" => segmentOutLED <= "0110000"; -- E
            when "1111" => segmentOutLED <= "0111000"; -- F
            when others => segmentOutLED <= "0000000";
        end case;

    end process;

end Behavioral;