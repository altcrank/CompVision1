function [orig,image] = read_image(image_path)
    % Read original image in orig
    orig = imread(image_path);
    % image should be a grayscale version of orig
    if length(orig(1,1,:)) == 3
        image = rgb2gray(orig);
    else
        image = orig;
    end
end