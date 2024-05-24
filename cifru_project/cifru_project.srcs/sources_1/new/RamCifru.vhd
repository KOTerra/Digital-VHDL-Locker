library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RamCifru is
    port (
        address : in std_logic_vector (1 downto 0);
        writeEnable : in std_logic;
        data : in std_logic_vector (3 downto 0);
        dataOut0 : out std_logic_vector(3 downto 0);
        dataOut1 : out std_logic_vector(3 downto 0);
        dataOut2 : out std_logic_vector(3 downto 0)
    );
end RamCifru;

architecture Behavioral of RamCifru is
    type RamArray is array(0 to 2) of std_logic_vector(3 downto 0);
    signal memory : RamArray := (
       "0000","0000","0000"
    );
begin
    process (address, memory, writeEnable, data)
    begin
        if writeEnable = '1' then --write
            memory(to_integer(unsigned(address))) <= data;
       
            
        end if;
        dataOut0 <= memory(0);
        dataOut1 <= memory(1);
        dataOut2 <= memory(2);
    end process;
end Behavioral;