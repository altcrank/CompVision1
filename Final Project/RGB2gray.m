function converted = RGB2gray(image)
% convert2gray converts an RGB image to grayscale
% Assumes the image is in RGB or is already grayscale
    if length(image(1,1,:)) == 3
        converted = rgb2gray(image);
    else
        converted = image;
    end
end