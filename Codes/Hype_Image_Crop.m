clear; clc; close all
filename = 'REFLECTANCE_590'
file = append(filename,".hdr")
hcube = hypercube(file);
masked_hcube = hypercube(file);
rgbImg = colorize(hcube, 'Method', 'rgb', 'ContrastStretching', true);
%rgbImg = imadjustn(rgbImg);
figure(1)
imshow(rgbImg)


mask1 = roipoly(rgbImg);
mask = logical(mask1);

for k = 1:size(hcube.DataCube, 3)
    data = masked_hcube.DataCube(:, :, k) .* mask;
    masked_hcube = assignData(masked_hcube,":",":",k,data);
end

%rgbImg2 = colorize(masked_hcube, 'Method', 'rgb', 'ContrastStretching', true);
new_masked_name = append(filename,"_masked");
enviwrite(masked_hcube,new_masked_name)
%rgbImg = imadjustn(rgbImg);
%figure(2)
