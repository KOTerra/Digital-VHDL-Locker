library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RamController is
    port (
        liberOcupat : in std_logic;
        enableAnod1 : in std_logic;
        enableAnod2 : in std_logic;
        enableAnod3 : in std_logic;
        up : in std_logic;
        down : in std_logic;
        address : out std_logic_vector(1 downto 0);
        data : out std_logic(3 downto 0);
        writeEnableRamCifru : out std_logic;
        writeEnableRamCifreCurente : out std_logic
    );
end RamController;

architecture Behavioral of RamController is
begin
    process (liberOcupat)
    begin
        if liberOcupat = '1' then
            writeEnableRamCifreCurente <= '1';
            writeEnableRamCifru <= '0';
        else
            writeEnableRamCifreCurente <= '0';
            writeEnableRamCifru <= '1';
        end if;
    end process;

    process (enableAnod1, enableAnod2, enableAnod3)
    begin
        if enableAnod3 = '1' and enableAnod2 = '1' and enableAnod1 = '1' then
            address <= "11";
        elsif enableAnod2 = '1' and enableAnod1 = '1' then
            address <= "10";
        elsif enableAnod1 = '1' then
            address <= "01";
        else
            address <= "00";
        end if;
    end process;

    process (up, down)
    begin
        if up = '1' and down = '0' then
            data <= data + 1;
        end if;
        if down = '1' and up = '0' then
            data <= data - 1;
        end if;
    end process;

end Behavioral;