library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RamCifru is
    port (
        address : in std_logic_vector (1 downto 0); 
        writeEnable : in std_logic; 
        data : inout std_logic_vector (3 downto 0)); 
end RamCifru;

architecture Behavioral of RamCifru is
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
    end process;
end Behavioral;