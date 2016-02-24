function [imOut Gd] = gaussianDer(image_path,G,sigma)
    image = im2double(imread(image_path));
    kernelLength = length(G);
    x = linspace(-(kernelLength-1)/2,(kernelLength-1)/2,kernelLength);
    if ~isequal(size(x),size(G))
        x = x';
    end
    Gd = - x .* G ./ (sigma*sigma);
    %disp(Gd);
    imOut = imfilter(image,Gd);
    
    %subplot(1,3,1);
    %imshow(image);
    %subplot(1,3,2);
    imshow(imOut);
    %subplot(1,3,3);
    %range = linspace(-5*sigma,5*sigma,sigma*100);
    %Gdplot = - range .* gaussian(sigma,length(range)) / (sigma*sigma);
    %plot(range,Gdplot);
    %line(xlim,[0 0],'Color',[0.5 0.5 0.5 0.5]);
    %line([0 0],ylim,'Color',[0.5 0.5 0.5 0.5]);
    %xlabel('x');
    %ylabel('Derivative of Gaussian');
end