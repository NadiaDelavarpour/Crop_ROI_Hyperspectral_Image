clear; clc; close all

filename = 'REFLECTANCE_590';
file = append(filename, ".hdr");
hcube = hypercube(file);
masked_hcube = hypercube(file);
rgbImg = colorize(hcube, 'Method', 'rgb', 'ContrastStretching', true);

figure(1)
imshow(rgbImg)

i = 1;
roiSize = [100, 100]; % Specify the desired size of the ROI

while i <= 5
    try
        [x, y] = ginput(1);
        roi = imrect(gca, [x, y, roiSize(2), roiSize(1)]);

        % Get the position of the selected region
        roiPosition = round(getPosition(roi));

        % Create a logical matrix with the same size as the original image
        mask = false(size(rgbImg, 1), size(rgbImg, 2));

        % Set the corresponding region in the mask to true
        mask(roiPosition(2):(roiPosition(2)+roiPosition(4)-1), roiPosition(1):(roiPosition(1)+roiPosition(3)-1)) = true;

        for k = 1:size(hcube.DataCube, 3)
            % Check if mask and data dimensions are compatible
            if isequal(size(mask), size(masked_hcube.DataCube(:, :, k)))
                data = masked_hcube.DataCube(:, :, k) .* mask;
                masked_hcube = assignData(masked_hcube, ":", ":", k, data);
            else
                error("Arrays have incompatible sizes for this operation.");
            end
        end

        new_masked_name = append(filename, "_masked_", string(i));
        enviwrite(masked_hcube, new_masked_name)
        i = i + 1;
    catch ME
        % Display the error message
        disp(ME.message);
        disp('Please try again.');
    end
end
