library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_unsigned.all;
entity RamController is
    port (
        clk : in std_logic;
        liberOcupat : in std_logic;
        enableAnod1 : in std_logic;
        enableAnod2 : in std_logic;
        enableAnod3 : in std_logic;
        up : in std_logic := '0';
        down : in std_logic := '0';
        address : out std_logic_vector(1 downto 0) := "00";
        data1 : inout std_logic_vector(3 downto 0) := "0000";
        data2 : inout std_logic_vector(3 downto 0) := "0000";
        writeEnableRamCifru : out std_logic;
        writeEnableRamCifreCurente : out std_logic
    );
end RamController;

architecture Behavioral of RamController is
    signal aux : std_logic_vector(3 downto 0) := "0000";
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
            address <= "10";
        elsif enableAnod3 = '0' and enableAnod2 = '1' and enableAnod1 = '1' then
            address <= "01";
        elsif enableAnod3 = '0' and enableAnod2 = '0' and enableAnod1 = '1' then
            address <= "00";
        elsif enableAnod2 = '1' and enableAnod1 = '1' then
            address <= "01";
        elsif enableAnod1 = '1' then
            address <= "00";
        else
            address <= "00";
        end if;
    end process;

    process (liberOcupat, up, down)
    begin
        -- if up='1' then
        --     report "UP" severity note;
        -- end if;

        if liberOcupat = '0' and rising_edge(up) and down = '0' then
            data1 <= data1 + 1;

            report "RAM_CONTROLLER: data1U=" & integer'image(to_integer(unsigned(data1))) severity note;
        end if;
        if liberOcupat = '0' and rising_edge(down) and up = '0' then
            data1 <= data1 - 1;

            report "RAM_CONTROLLER: data1D=" & integer'image(to_integer(unsigned(data1))) severity note;
        end if;
        if liberOcupat = '1' and rising_edge(up) and down = '0' then
            data2 <= data2 + 1;

            report "RAM_CONTROLLER: data2U=" & integer'image(to_integer(unsigned(data2))) severity note;
        end if;
        if liberOcupat = '1' and rising_edge(down) and up = '0' then
            data2 <= data2 - 1;

            report "RAM_CONTROLLER: data2D=" & integer'image(to_integer(unsigned(data2))) severity note;
        end if;

    end process;

end Behavioral;