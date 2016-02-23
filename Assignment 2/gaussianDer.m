function [imOut Gd] = gaussianDer(image_path,G,sigma)
    image = im2double(imread(image_path));
    x = generateCoordinates(length(G));
    Gd = - x .* G ./ (sigma*sigma);
    imOut = conv1D(image,Gd);
end