library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

package common is

    --  changeable constants
    constant c_mics: NATURAL := 9; -- the number of microphones
    
    constant c_FPGAclkfreq: natural := 50000000; -- internal FPGA clock frequency (667000000)
    constant c_PDMclkfreq: natural := 2304000; -- desired clock frequency for PDM microphones, this will not be the real clock frequency and depends on FPGA clock
    constant c_PDMmaxdelay: natural:= 100; -- PDM max delay time to valid data in ns

    constant c_CICbits: NATURAL := 16; -- at least 2, but less overflow errors when larger
    constant c_CICtaps: NATURAL := 49;
    constant c_CICorder: NATURAL := 4;
    constant c_CICdecimation: NATURAL := 12;
    constant c_HB11bits: NATURAL := 16;
    constant c_HB11multipliers: NATURAL := 7; 
    constant c_HB19bits: NATURAL := 16;
    constant c_HB19multipliers: NATURAL := 11; 
    constant c_FIR51bits: NATURAL := 16;
    
    constant c_DaS_bits: natural := 16;
    --constant c_delayTableBits: natural := 5;
    constant c_DaSstoredAngles: natural := 64; -- 360, 208, needs to be power of two
    --constant c_DaSangleBits: natural := 9; -- ceil(log2(360))
    --constant c_DaSfreq: natural := 48000; -- c_PDMclkfreq/(c_CICdecimation*4)
    constant c_DaSmaxDelay: natural := 16;
    --constant c_DaSextraDelay: NATURAL := 68;-- ceil(((c_CICorder/c_CICdecimation)+c_CICorder)/4 + ((11/2)+2)/2 + (16/2)+2 + 51+2); -- first output samples of filter pipeline will not be very useful, expressed in DaS clock cycles
    --constant c_DaSoutputReadyCounterbits: NATURAL := 8; -- ceil(log2(c_bufferlength+c_bufferExtraDelay+1))
    constant c_SerialAngles: NATURAL := 16; -- How many angles get calculated with the same hardware,  needs to be power of two
    constant c_DaSsumlength: NATURAL := 64; -- how many squared samples are added together before determining angle? Needs to be power of two
    

    -- calculated constants
    constant c_miccounterbits: NATURAL := integer(ceil(log2(real(c_mics)))); -- 4
    
    constant c_FPGAhalfclkperiod: natural := 500000/(c_FPGAclkfreq/1000000); -- half clock period in ps for simulations
    constant c_PDMclkcountermax: natural := integer(round(real(c_FPGAclkfreq)/(real(2*c_PDMclkfreq)))) - 1;
    constant c_PDMclkcounterbits: NATURAL := integer(ceil(log2(real(c_PDMclkcountermax+1)))); -- 8
    constant c_Sclkdelay_countermax: natural := 4;--(integer(ceil(real((c_PDMmaxdelay * c_FPGAclkfreq)/1000000000)))-1); -- 4
    constant c_Sclkdelay_counterbits: NATURAL := integer(ceil(log2(real(c_Sclkdelay_countermax+1)))); -- 7
    constant c_CICclockdivbits: NATURAL := integer(ceil(log2(real((c_CICdecimation/2)+1)))); -- 3
    constant c_HB11fpgaclkcountermax: natural := (((c_PDMclkcountermax+1)*c_CICdecimation*2)/(c_HB11multipliers))-1;
    constant c_HB11fpgaclkcounterbits: natural := integer(ceil(log2(real(c_HB11fpgaclkcountermax+1)))); 
    constant c_HB11synccountermax: natural := (2*(c_PDMclkcountermax+1)*c_CICdecimation*2)-(c_HB11multipliers*2*(c_HB11fpgaclkcountermax+1)); -- for clock synchronisation
    constant c_HB19fpgaclkcountermax: natural := (((c_PDMclkcountermax+1)*c_CICdecimation*2*2)/(c_HB19multipliers))-1;
    constant c_HB19fpgaclkcounterbits: natural := integer(ceil(log2(real(c_HB19fpgaclkcountermax+1)))); 
    constant c_HB19synccountermax: natural := (2*(c_PDMclkcountermax+1)*c_CICdecimation*2*2)-(c_HB19multipliers*2*(c_HB19fpgaclkcountermax+1)); -- for clock synchronisation
    
    constant c_CICdelaystages: NATURAL := ((c_CICtaps - 1) / c_CICdecimation) + 1; 
    constant c_HB11multiplierIndexBits: NATURAL := integer(ceil(log2(real(c_HB11multipliers))));
    constant c_HB19multiplierIndexBits: NATURAL := integer(ceil(log2(real(c_HB19multipliers))));
   
    constant c_DaSadd1fpgaclkcountermax: natural := (((c_PDMclkcountermax+1)*c_CICdecimation*2*2)/(c_mics * c_SerialAngles))-1; 
    constant c_DaSadd1fpgaclkcounterbits: natural := integer(ceil(log2(real(c_DaSadd1fpgaclkcountermax+1)))); 
     constant c_DaSadd1synccountermax: natural := (2*(c_PDMclkcountermax+1)*c_CICdecimation*2*2)-(c_mics * c_SerialAngles*2*(c_DaSadd1fpgaclkcountermax+1)); -- for clock synchronisation
     constant c_DaSadd1synccounterbits: natural := integer(ceil(log2(real(c_DaSadd1synccountermax+1)))); 
     constant c_DaSadd1counterbits: natural := c_DaSadd1synccounterbits; -- should be largest of c_DaSadd1fpgaclkcounterbits and c_DaSadd1synccounterbits
    constant c_DaSmul2clkcountermax: natural := (c_mics/2)-1;
    constant c_DaSmul2clkcounterbits: natural := integer(ceil(log2(real(c_DaSmul2clkcountermax+1)))); 
    constant c_DaScomp7fpgaclkcountermax: natural := (((c_PDMclkcountermax+1)*c_CICdecimation*2*2*c_SerialAngles)/(c_DaSstoredAngles))-1;
    constant c_DaScomp7fpgaclkcounterbits: natural := integer(ceil(log2(real(c_DaScomp7fpgaclkcountermax+1)))); 
    constant c_DaScomp7synccountermax: natural := (2*(c_PDMclkcountermax+1)*c_CICdecimation*2*2*c_SerialAngles)-(c_DaSstoredAngles*2*(c_DaScomp7fpgaclkcountermax+1)) - 1; -- for clock synchronisation
    constant c_DaSangleIndexBits: natural := integer(ceil(log2(real(c_DaSstoredAngles)))); -- 6
    --constant c_AngleResolution: natural := 360/c_storedAngles;
    constant c_DaSinbufferlength: NATURAL := c_DaSmaxDelay+1; -- input buffer for beamforming
    constant c_SerialAngleBits: NATURAL := integer(ceil(log2(real(c_SerialAngles)))); -- ceil(log2(c_SerialAngles)) -- 4
    constant c_DaSprocessingParts: natural := c_DaSstoredAngles / c_SerialAngles; -- How many independent parts
    constant c_DaSprocessingPartBits: natural := integer(ceil(log2(real(c_DaSprocessingParts))));
    
    
    -- types
    subtype t_DaSsample is signed(c_DaS_bits-1 downto 0); -- 1 sample 
    type t_DaSinput is array(0 to c_mics-1) of t_DaSsample;
    type t_DaSinBuffer is array(0 to c_DaSinbufferlength-1) of t_DaSsample; -- 1 sample buffer per mic

end common;

package body common is
end common;
