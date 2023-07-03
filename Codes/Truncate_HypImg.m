clear; clc; close all
hdr_img = dir('*.hdr');

for i = 1: length(hdr_img)
    name = hdr_img(i).name;
    hcube = hypercube(name);  % Load hyperspectral cube from 395 to 1100 nm
    wavelengths = hcube.Wavelength;  % Get the wavelength values

    % Find the indices corresponding to the desired wavelength range
    start_index = find(wavelengths >= 400, 1);
    end_index = find(wavelengths <= 900, 1, 'last');

    % Truncate the wavelength range
    truncated_wavelengths = wavelengths(start_index:end_index);

    % Truncate the hyperspectral cube data
    truncated_data = hcube.DataCube(:,:,start_index:end_index);

    % Create a new hypercube with truncated data and wavelengths
    truncated_hcube = hypercube(truncated_data, truncated_wavelengths);
    [name,corr_name] = fileparts(name);
 

    Truncated_name = append(corr_name, "_truncated");
    enviwrite( truncated_hcube, Truncated_name)
end