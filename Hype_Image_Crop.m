clear; clc; close all

hcube = hypercube("REFLECTANCE_590.hdr");
masked_hcube = hypercube("REFLECTANCE_590.hdr");
rgbImg = colorize(hcube, 'Method', 'rgb', 'ContrastStretching', true);
%rgbImg = imadjustn(rgbImg);
figure(1)
imshow(rgbImg)

mask = roipoly(rgbImg);
mask = logical(mask);

for k = 1:size(hcube.DataCube, 3)
    data = masked_hcube.DataCube(:, :, k) .* mask;
    masked_hcube = assignData(masked_hcube,":",":",k,data);
end

rgbImg2 = colorize(masked_hcube, 'Method', 'rgb', 'ContrastStretching', true);
%rgbImg = imadjustn(rgbImg);
figure(2)
imshow(rgbImg2)