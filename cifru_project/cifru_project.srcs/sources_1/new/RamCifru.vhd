library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity RamCifru is
    Port ( a_ram : in BIT_VECTOR (1 downto 0); --Adresele
           cs_ram : in STD_LOGIC;  -- Semnal selec?ie cip, „Chip Select"
           we : in STD_LOGIC; -- Semnal validare scriere, „Write Enable"
           d_ram : inout BIT_VECTOR (3 downto 0));  -- Ie?iri de date (bidirectional)
end RamCifru;

architecture Behavioral of RamCifru is

begin


end Behavioral;
