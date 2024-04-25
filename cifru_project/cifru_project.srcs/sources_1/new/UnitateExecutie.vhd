
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity UnitateExecutie is
    port (
        clk : in std_logic;
        liberOcupat : in std_logic;
        enableAnod1 : in std_logic;
        enableAnod2 : in std_logic;
        enableAnod3 : in std_logic;
        up : in std_logic;
        down : in std_logic;
        enableCompare : in std_logic;
        checkedMatch : out std_logic;
        match : out std_logic
    );
end UnitateExecutie;

architecture Behavioral of UnitateExecutie is

    component MPG is
        port (
            btn : in std_logic;
            clk : in std_logic;
            debounced : out std_logic);
    end component;

    component RamController is
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
    end component;

    component RamCifru is
        port (
            address : in std_logic_vector (1 downto 0);
            writeEnable : in std_logic;
            data : inout std_logic_vector (3 downto 0);
            dataOut0 : out std_logic_vector(3 downto 0);
            dataOut1 : out std_logic_vector(3 downto 0);
            dataOut2 : out std_logic_vector(3 downto 0));
    end component;

    component RamCifreCurente is
        port (
            address : in std_logic_vector (1 downto 0);
            writeEnable : in std_logic;
            data : inout std_logic_vector (3 downto 0);
            dataOut0 : out std_logic_vector(3 downto 0);
            dataOut1 : out std_logic_vector(3 downto 0);
            dataOut2 : out std_logic_vector(3 downto 0));
    end component;

    component comparator is
        port (
            enable : in std_logic;
            a1, a2, a3 : in std_logic_vector (3 downto 0);
            b1, b2, b3 : in std_logic_vector (3 downto 0);
            checkedMatch : out std_logic;
            match : out std_logic
        );
    end component;

    signal match : std_logic;
    signal upDebounced : std_logic;
    signal downDebounced : std_logic;
    signal address : std_logic_vector(1 downto 0);
    signal dataIn : std_logic_vector(3 downto 0);
    signal rcdo0, rcdo1, rcdo2 : std_logic_vector(3 downto 0);
    signal rccdo0, rccdo1, rccdo2 : std_logic_vector(3 downto 0);
    signal writeEnableRamCifru : std_logic;
    signal writeEnableRamCifreCurente : std_logic;

begin
    mpgUp : MPG port map(up, clk, upDebounced);
    mpgDown : MPG port map(up, clk, downDebounced);
    ramController : RamController port map(liberOcupatt, enableAnod1, enableAnod2, enableAnod3, upDebounced, downDebounced, address, dataIn, writeEnableRamCifru, writeEnableRamCifreCurente);

    ramCifru : RamCifru port map(address, writeEnableRamCifru, dataIn, rcdo0, rcdo1, rcdo2);
    ramCifreCurente : RamCifreCurente port map(address, writeEnableRamCifreCurente, dataIn, rccdo0, rccdo1, rccdo2);

    comparator : comparator port map(enableCompare, rcdo0, rcdo1, rcdo2, rccdo0, rccdo1, rccdo2, checkedMatch, match);
end Behavioral;