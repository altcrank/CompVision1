function [imOut Gd] = gaussianDer(image_path,G,sigma)
    image = im2double(imread(image_path));
    x = generateCoordinates(length(G));
    if ~isequal(size(x),size(G))
        x = x';
    end
    Gd = - x .* G ./ (sigma*sigma);
    imOut = imfilter(image,Gd);
    % custom implementation
    imOutCustom = conv1D(image,Gd);
    
    subplot(2,2,1);
    imshow(image);
    subplot(2,2,2);
    imshow(imOut);
    subplot(2,2,3);
    imshow(imOutCustom);
    subplot(2,2,4);
    range = linspace(-5*sigma,5*sigma,sigma*100);
    Gdplot = - range .* gaussian(sigma,length(range)) / (sigma*sigma);
    plot(range,Gdplot);
end