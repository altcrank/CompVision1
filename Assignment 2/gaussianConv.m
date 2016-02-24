function imOut = gaussianConv(im_path,sigma_x,sigma_y)
    % read image
    image = im2double(imread(im_path));
    
    %We have to either convert it to RGB or do conv on all channels
    %separately
    %image = rgb2gray(image);
    dim = length(image(1,1,:));
    kernelLength = 11;
    
    % convolution with 1D filters
    % get vertical gaussian
    Gx = gaussian(sigma_x, kernelLength);
    % get horizontal gaussian
    Gy = gaussian(sigma_y, kernelLength);
    for i = 1:dim
        imOut(:,:,i) = conv2(Gx,Gy,image(:,:,i),'same');
    end
    disp(imOut);
    
    % convolution with 2D filter
    Gxy = Gx' * Gy;
    for i = 1:dim
        imOut2D(:,:,i) = conv2(image(:,:,i),Gxy,'same');
    end
    
    %subplot(1,3,1);
    %imshow(image);
    %subplot(1,3,2);
    imshow(imOut);
    %subplot(1,3,3);
    %imshow(imOut2D);
end