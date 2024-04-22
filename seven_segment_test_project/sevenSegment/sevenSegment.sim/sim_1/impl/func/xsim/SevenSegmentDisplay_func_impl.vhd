-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
-- Date        : Mon Apr 22 20:35:40 2024
-- Host        : POWERSLAVE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/FACULTATE/facultate/anul1/sem2/PSN/proiect/ProiectPSN-Cifru/seven_segment_test_project/sevenSegment/sevenSegment.sim/sim_1/impl/func/xsim/SevenSegmentDisplay_func_impl.vhd
-- Design      : SevenSegmentDisplay
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity SevenSegmentDisplay is
  port (
    clk : in STD_LOGIC;
    enableAnod0 : in STD_LOGIC;
    enableAnod1 : in STD_LOGIC;
    enableAnod2 : in STD_LOGIC;
    displayValue0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    displayValue1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    displayValue2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    anodActiv : out STD_LOGIC_VECTOR ( 7 downto 0 );
    segmentOutLED : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of SevenSegmentDisplay : entity is true;
  attribute \DesignAttr:ENABLE_AIE_NETLIST_VIEW\ : boolean;
  attribute \DesignAttr:ENABLE_AIE_NETLIST_VIEW\ of SevenSegmentDisplay : entity is std.standard.true;
  attribute \DesignAttr:ENABLE_NOC_NETLIST_VIEW\ : boolean;
  attribute \DesignAttr:ENABLE_NOC_NETLIST_VIEW\ of SevenSegmentDisplay : entity is std.standard.true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of SevenSegmentDisplay : entity is "ad2ab43a";
end SevenSegmentDisplay;

architecture STRUCTURE of SevenSegmentDisplay is
begin
\anodActiv_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(0)
    );
\anodActiv_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(1)
    );
\anodActiv_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(2)
    );
\anodActiv_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(3)
    );
\anodActiv_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(4)
    );
\anodActiv_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(5)
    );
\anodActiv_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(6)
    );
\anodActiv_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => anodActiv(7)
    );
\segmentOutLED_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => segmentOutLED(0)
    );
\segmentOutLED_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(1)
    );
\segmentOutLED_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(2)
    );
\segmentOutLED_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(3)
    );
\segmentOutLED_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(4)
    );
\segmentOutLED_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(5)
    );
\segmentOutLED_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => segmentOutLED(6)
    );
end STRUCTURE;
