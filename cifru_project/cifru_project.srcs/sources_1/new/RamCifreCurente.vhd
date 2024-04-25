library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RamCifreCurente is
    port (
        address : in std_logic_vector (1 downto 0); --Adresele
        writeEnable : in std_logic; -- Semnal validare scriere, �Write Enable"
        data : inout std_logic_vector (3 downto 0); -- Ie?iri de date (bidirectional)
        dataOut0 : out std_logic_vector(3 downto 0);
        dataOut1 : out std_logic_vector(3 downto 0);
        dataOut2 : out std_logic_vector(3 downto 0)
    );
end RamCifreCurente;

architecture Behavioral of RamCifreCurente is
    type RamArray is array(0 to 2) of std_logic_vector(3 downto 0);
    signal memory : RamArray := (
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00"
    );
begin
    process (address, writeEnable, data)
    begin
        if writeEnable = '0' then --read
            memory(to_integer(unsigned(address))) <= data;
        else --write
            data <= memory(to_integer(unsigned(address)));
        end if;
        dataOut0 <= memory("00");
        dataOut1 <= memory("01");
        dataOut2 <= memory("11");
    end process;

end Behavioral;