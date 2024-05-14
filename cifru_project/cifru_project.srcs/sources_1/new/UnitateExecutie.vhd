library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity UnitateExecutie is
    port (
        clk : in std_logic;
	reset : in std_logic;
        liberOcupat : in std_logic;
        enableAnod1 : in std_logic;
        enableAnod2 : in std_logic;
        enableAnod3 : in std_logic;
        up : in std_logic;
        down : in std_logic;
        enableCompare : in std_logic;
        checkedMatch : out std_logic;
        match : out std_logic;
        anodActiv : out std_logic_vector (7 downto 0);
        segmentOutLED : out std_logic_vector (6 downto 0)
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
            data1 : inout std_logic_vector(3 downto 0);
            data2 : inout std_logic_vector(3 downto 0);
            writeEnableRamCifru : out std_logic;
            writeEnableRamCifreCurente : out std_logic
        );
    end component;

    component RamCifru is
        port (
            address : in std_logic_vector (1 downto 0);
            writeEnable : in std_logic;
            data : in std_logic_vector (3 downto 0);
            dataOut0 : out std_logic_vector(3 downto 0);
            dataOut1 : out std_logic_vector(3 downto 0);
            dataOut2 : out std_logic_vector(3 downto 0));
    end component;

    component RamCifreCurente is
        port (
            address : in std_logic_vector (1 downto 0);
            writeEnable : in std_logic;
            data : in std_logic_vector (3 downto 0);
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

    component DisplayController is
        port (
            liberOcupat : in std_logic;
            rcdo0, rcdo1, rcdo2 : in std_logic_vector(3 downto 0);
            rccdo0, rccdo1, rccdo2 : in std_logic_vector(3 downto 0);
            displayValue1, displayValue2, displayValue3 : out std_logic_vector(3 downto 0)
        );
    end component;

    component SevenSegmentDisplay is
        port (
            clk : in std_logic;
            enableAnod1 : in std_logic;
            enableAnod2 : in std_logic;
            enableAnod3 : in std_logic;
            displayValue1 : in std_logic_vector (3 downto 0);
            displayValue2 : in std_logic_vector (3 downto 0);
            displayValue3 : in std_logic_vector (3 downto 0);
            anodActiv : out std_logic_vector (7 downto 0);
            segmentOutLED : out std_logic_vector (6 downto 0)
        );
    end component;

   
    signal upDebounced : std_logic:='0';
    signal downDebounced : std_logic:='0';
    signal address : std_logic_vector(1 downto 0):="00";
    signal dataIn : std_logic_vector(3 downto 0):="0000";
    signal dataIn1 : std_logic_vector(3 downto 0):="0000";
    signal dataIn2 : std_logic_vector(3 downto 0):="0000";
    signal rcdo0, rcdo1, rcdo2 : std_logic_vector(3 downto 0):="0000";
    signal rccdo0, rccdo1, rccdo2 : std_logic_vector(3 downto 0):="0000";
    signal writeEnableRamCifru : std_logic:='0';
    signal writeEnableRamCifreCurente : std_logic:='0';

    signal sevenSegClk : std_logic;
    signal displayValue1, displayValue2, displayValue3 : std_logic_vector(3 downto 0);

begin
    mpgUp : MPG port map(up, clk, upDebounced);
    mpgDown : MPG port map(up, clk, downDebounced);
    ram_Controller : RamController port map(liberOcupat, enableAnod1, enableAnod2, enableAnod3, upDebounced, downDebounced, address, dataIn1,dataIn2, writeEnableRamCifru, writeEnableRamCifreCurente);

    ram_Cifru : RamCifru port map(address, writeEnableRamCifru, dataIn1, rcdo0, rcdo1, rcdo2);
    ram_CifreCurente : RamCifreCurente port map(address, writeEnableRamCifreCurente, dataIn2, rccdo0, rccdo1, rccdo2);

    comparator_a : comparator port map(enableCompare, rcdo0, rcdo1, rcdo2, rccdo0, rccdo1, rccdo2, checkedMatch, match);

    display_Controller : DisplayController port map(liberOcupat, rcdo0, rcdo1, rcdo2, rccdo0, rccdo1, rccdo2, displayValue1, displayValue2, displayValue3);
    display : SevenSegmentDisplay port map(clk, enableAnod1, enableAnod2, enableAnod3, displayValue1, displayValue2, displayValue3, anodActiv, segmentOutLED); ---display controller select values

end Behavioral;