clear; clc; close all;

% Input and output directories
hdr_img = dir('*.hdr');
for i = 1: length(hdr_img)
    name = hdr_img(i).name;
    hcube = hypercube(name);
    wavelengths = hcube.Wavelength;
    spectral_data = hcube.DataCube;
    md = hcube.Metadata;
    corrected_hypercube_snv = snv(spectral_data);
    snv_wavelengths = hcube.Wavelength;
    
    snv_hcube = hypercube(corrected_hypercube_snv, snv_wavelengths);
    [name,corr_name] = fileparts(name);
 

    snv_name = append(corr_name, "_snv");
    enviwrite(snv_hcube, snv_name)
end






function data_snv = snv(input_data)
    % A correction technique which is done on each individual spectrum,
    % a reference spectrum is not required

    % Convert input_data to a MATLAB array
    input_data = double(input_data);
    
    % Define a new array and populate it with the corrected data
    data_snv = zeros(size(input_data));
    
    for i = 1:size(data_snv, 1)
        % Apply correction
        data_snv(i, :) = (input_data(i, :) - mean(input_data(i, :))) / std(input_data(i, :));
    end
end