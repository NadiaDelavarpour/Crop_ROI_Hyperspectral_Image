clear; clc; close all

hcube = hypercube("REFLECTANCE_590.hdr");  % Load hyperspectral cube

wavelengths = hcube.Wavelength;  % Get the wavelength values

% Convert data to double
data_double = double(hcube.DataCube);

% Apply Savitzky-Golay filter to each spectrum in the hyperspectral cube
smoothed_data = zeros(size(data_double));
window_size = 15;  % Adjust the window size as needed
polynomial_order = 3;  % Adjust the polynomial order as needed

for i = 1:size(data_double, 1)
    for j = 1:size(data_double, 2)
        reflectance_spectrum = data_double(i, j, :);
        reflectance_spectrum = reshape(reflectance_spectrum, [], 1);
        
        smoothed_spectrum = sgolayfilt(reflectance_spectrum, polynomial_order, window_size);
        
        smoothed_data(i, j, :) = smoothed_spectrum;
    end
end

% Create a new hypercube with smoothed data and original wavelengths
smoothed_hcube = hypercube(smoothed_data, wavelengths);

% Display the smoothed hyperspectral cube
rgbImg = colorize(smoothed_hcube, 'Method', 'rgb', 'ContrastStretching', true);
figure(1)
imshow(rgbImg)
