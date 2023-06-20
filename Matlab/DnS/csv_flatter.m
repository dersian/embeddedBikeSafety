%delayTable = readtable('delayTables/delayTable_48kHz_9mics_r60.csv');
micSignals = readtable('Sources/DaS_output.csv');
array = table2array(micSignals);
flatted = reshape(array.',1,[]);
out = transpose(flatted);
%writematrix(out,'delayTableFlat.txt');
writematrix(out,'Sources/Matlab_output_flat.txt');
