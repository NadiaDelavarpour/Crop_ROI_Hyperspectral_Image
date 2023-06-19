clear; clc; close all

hcube = hypercube("REFLECTANCE_590.hdr");  % Load hyperspectral cube from 395 to 1100 nm

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

% Display the truncated hyperspectral cube
rgbImg = colorize(truncated_hcube, 'Method', 'rgb', 'ContrastStretching', true);
figure(1)
imshow(rgbImg)