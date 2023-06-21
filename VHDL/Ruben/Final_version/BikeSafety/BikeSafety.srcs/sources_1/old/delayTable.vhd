library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common.all;

package delayTable is
    subtype t_delay is natural;
    type t_delayTableCol is array(0 to c_mics-1) of t_delay; -- use first column to specify angle
    type t_delayTable is array (0 to c_DaSstoredAngles - 1) of t_delayTableCol;
    constant delayTable: t_delayTable := (
        0 => (16,15,13,11,7,4,1,0,0), -- 32 => (0,0,1,4,7,11,13,15,16), 
        1 => (16,15,14,11,8,5,2,0,0), -- 31 => (0,0,2,5,8,11,14,15,16), 
        2 => (15,15,14,12,9,6,3,0,0), -- 30 => (0,0,3,6,9,12,14,15,15), 
        3 => (15,15,14,12,9,6,3,1,0), -- 29 => (0,1,3,6,9,12,14,15,15), 
        4 => (15,15,15,13,10,7,4,1,0), -- 28 => (0,1,4,7,10,13,15,15,15), 
        5 => (14,15,14,13,10,7,4,1,0), -- 27 => (0,1,4,7,10,13,14,15,14), 
        6 => (13,14,14,13,11,8,4,1,0), -- 26 => (0,1,4,8,11,13,14,14,13), 
        7 => (12,14,14,13,11,8,5,2,0), -- 25 => (0,2,5,8,11,13,14,14,12), 
        8 => (11,13,13,13,11,8,5,2,0), -- 24 => (0,2,5,8,11,13,13,13,11), 
        9 => (10,12,13,12,11,8,5,2,0), -- 23 => (0,2,5,8,11,12,13,12,10), 
        10 => (8,11,12,12,11,8,5,2,0), -- 22 => (0,2,5,8,11,12,12,11,8), 
        11 => (7,9,11,11,10,8,5,2,0), -- 21 => (0,2,5,8,10,11,11,9,7), 
        12 => (5,8,10,11,10,8,5,2,0), -- 20 => (0,2,5,8,10,11,10,8,5), 
        13 => (4,7,9,10,9,8,5,2,0), -- 19 => (0,2,5,8,9,10,9,7,4), 
        14 => (2,5,8,9,9,8,5,2,0), -- 18 => (0,2,5,8,9,9,8,5,2), 
        15 => (1,4,6,8,8,7,5,2,0), -- 17 => (0,2,5,7,8,8,6,4,1), 
        16 => (0,2,5,7,7,7,5,2,0), -- 16 => (0,2,5,7,7,7,5,2,0), 
        17 => (0,2,5,7,8,8,6,4,1), 
        18 => (0,2,5,8,9,9,8,5,2), 
        19 => (0,2,5,8,9,10,9,7,4), 
        20 => (0,2,5,8,10,11,10,8,5), 
        21 => (0,2,5,8,10,11,11,9,7), 
        22 => (0,2,5,8,11,12,12,11,8), 
        23 => (0,2,5,8,11,12,13,12,10), 
        24 => (0,2,5,8,11,13,13,13,11), 
        25 => (0,2,5,8,11,13,14,14,12), 
        26 => (0,1,4,8,11,13,14,14,13), 
        27 => (0,1,4,7,10,13,14,15,14), 
        28 => (0,1,4,7,10,13,15,15,15), 
        29 => (0,1,3,6,9,12,14,15,15), 
        30 => (0,0,3,6,9,12,14,15,15), 
        31 => (0,0,2,5,8,11,14,15,16), 
        32 => (0,0,1,4,7,11,13,15,16), 
        33 => (0,0,1,3,6,10,13,15,16), -- 63 => (16,15,13,10,6,3,1,0,0) 
        34 => (0,0,0,3,6,9,12,14,15), -- 62 => (15,14,12,9,6,3,0,0,0), 
        35 => (0,0,0,2,5,8,11,14,15), -- 61 => (15,14,11,8,5,2,0,0,0), 
        36 => (0,0,0,2,4,7,11,13,15), -- 60 => (15,13,11,7,4,2,0,0,0), 
        37 => (0,0,0,1,3,7,10,13,15), -- 59 => (15,13,10,7,3,1,0,0,0), 
        38 => (0,0,0,0,3,6,9,12,14), -- 58 => (14,12,9,6,3,0,0,0,0), 
        39 => (1,0,0,0,2,5,8,11,14), -- 57 => (14,11,8,5,2,0,0,0,1), 
        40 => (1,0,0,0,1,4,7,11,13), -- 56 => (13,11,7,4,1,0,0,0,1), 
        41 => (2,0,0,0,1,3,6,10,13), -- 55 => (13,10,6,3,1,0,0,0,2), 
        42 => (3,0,0,0,0,3,6,9,12), -- 54 => (12,9,6,3,0,0,0,0,3), 
        43 => (3,1,0,0,0,2,5,8,11), -- 53 => (11,8,5,2,0,0,0,1,3), 
        44 => (4,2,0,0,0,1,4,7,11), -- 52 => (11,7,4,1,0,0,0,2,4), 
        45 => (5,2,0,0,0,1,3,7,10), -- 51 => (10,7,3,1,0,0,0,2,5), 
        46 => (6,3,0,0,0,0,3,6,9), -- 50 => (9,6,3,0,0,0,0,3,6), 
        47 => (6,3,1,0,0,0,2,5,8), -- 49 => (8,5,2,0,0,0,1,3,6), 
        48 => (7,4,1,0,0,0,1,4,7), -- 48 => (7,4,1,0,0,0,1,4,7), 
        49 => (8,5,2,0,0,0,1,3,6), 
        50 => (9,6,3,0,0,0,0,3,6), 
        51 => (10,7,3,1,0,0,0,2,5), 
        52 => (11,7,4,1,0,0,0,2,4), 
        53 => (11,8,5,2,0,0,0,1,3), 
        54 => (12,9,6,3,0,0,0,0,3), 
        55 => (13,10,6,3,1,0,0,0,2), 
        56 => (13,11,7,4,1,0,0,0,1), 
        57 => (14,11,8,5,2,0,0,0,1), 
        58 => (14,12,9,6,3,0,0,0,0), 
        59 => (15,13,10,7,3,1,0,0,0), 
        60 => (15,13,11,7,4,2,0,0,0), 
        61 => (15,14,11,8,5,2,0,0,0), 
        62 => (15,14,12,9,6,3,0,0,0), 
        63 => (16,15,13,10,6,3,1,0,0) 
);
end delayTable;

package body delayTable is
end delayTable;