library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity numarator_reversibil is
    Port ( Load : in STD_LOGIC;--ln
            nrSus: in STD_LOGIC;
           CUp : in STD_LOGIC;
           CDn : in STD_LOGIC;
           CLK : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out STD_LOGIC;--ln
           Borrow : out STD_LOGIC;--ln
           Clear : in STD_LOGIC);
end numarator_reversibil;

architecture Behavioral of numarator_reversibil is
component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component MPG;
signal Q_aux_up:STD_LOGIC_VECTOR (3 downto 0):="0000";
signal Q_aux_down:STD_LOGIC_VECTOR (3 downto 0):="1111";
signal CUp_divizat,CDn_divizat: STD_LOGIC;
begin
    mpgCUp:MPG port map(CUp,CLK,CUp_divizat);
    mpgCDn:MPG port map(CDn,CLK,CDn_divizat);
    
    big_process:process(nrSus,Clear,Load,CUp_divizat,CDn_divizat)
    begin
        if nrSus='1' then
            if Clear ='1' then
                Q_aux_up<="0000";
            elsif Load='0' then
                Q_aux_up<=A;
            elsif rising_edge(CUp_divizat) then
                if Q_aux_up < "1111" then
                    Q_aux_up<=Q_aux_up+1;
                else
                    Q_aux_up<="0000";
                end if;
            end if;
        else
            if Clear ='1' then
                Q_aux_down<="1111";
            elsif Load='0' then
                Q_aux_down<=A;
            elsif rising_edge(CDn_divizat) then
                if Q_aux_down > "0000" then
                    Q_aux_down<=Q_aux_down-1;
                else
                    Q_aux_down<="1111";
                end if;
           end if;
        end if;
    end process;
    
    Q<=Q_aux_up when nrSus='1' else Q_aux_down;
    
    Carry<='0' when Q_aux_up="1111" and CUp_divizat='0' else '1';
    Borrow<='0' when Q_aux_down="0000" and CDn_divizat='0' else '1';
    end architecture;