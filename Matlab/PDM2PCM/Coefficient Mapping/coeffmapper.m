HBF1_coeff = load('HBF1.mat');
mapped_coeff = zeros(length(HBF1_coeff.coeff), 1);
max_coeff = max(HBF1_coeff.coeff);
for i = 1:length(HBF1_coeff.coeff)
    mapped_coeff(i, 1) = round((HBF1_coeff.coeff(i)/max_coeff)*63);
end    
writeHandle = fopen("HBF1_coeffs.txt", 'wt');
if writeHandle > 0
    fprintf(writeHandle,'%d,', mapped_coeff);
    fclose(writeHandle);
end

HBF2_coeff = load('HBF2.mat');
mapped_coeff = zeros(length(HBF2_coeff.coeff), 1);
max_coeff = max(HBF2_coeff.coeff);
for i = 1:length(HBF2_coeff.coeff)
    mapped_coeff(i, 1) = round((HBF2_coeff.coeff(i)/max_coeff)*63);
end    
writeHandle = fopen("HBF2_coeffs.txt", 'wt');
if writeHandle > 0
    fprintf(writeHandle,'%d,', mapped_coeff);
    fclose(writeHandle);
end

FIR_coeff = load('FIR.mat');
mapped_coeff = zeros(length(FIR_coeff.coeff.Numerator), 1);
max_coeff = max(FIR_coeff.coeff.Numerator);
for i = 1:length(FIR_coeff.coeff.Numerator)
    mapped_coeff(i, 1) = round((FIR_coeff.coeff.Numerator(i)/max_coeff)*63);
end    
writeHandle = fopen("FIR_coeffs.txt", 'wt');
if writeHandle > 0
    fprintf(writeHandle,'%d,', mapped_coeff);
    fclose(writeHandle);
end