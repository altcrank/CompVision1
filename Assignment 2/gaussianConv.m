function imOut = gaussianConv(im_path,sigma_x,sigma_y)
    % read image
    image = im2double(imread(im_path));
    
    %We have to either convert it to RGB or do conv on all channels
    %separately
    %image = rgb2gray(image);
    dim = length(size(image));
    kernelLength = 11;
    
    % convolution with 1D filters
    % get vertical gaussian
    Gx = gaussian(sigma_x, kernelLength);
    % get horizontal gaussian
    Gy = gaussian(sigma_y, kernelLength);
    for i = 1:dim
        imOut(:,:,i) = conv2(Gx,Gy,image(:,:,i),'same');
    end
    
    % convolution with 2D filter
    Gxy = Gx' * Gy;
    for i = 1:dim
        imOut2D(:,:,i) = conv2(image(:,:,i),Gxy,'same');
    end
    
    % From scratch implementation
    % apply horizontal first - sigma_y
    imOutCustom = gaussianConv1D(image,sigma_y, kernelLength);
    % apply vertical next - sigma_x
    imOutCustom = gaussianConv1D(permute(imOutCustom, [2 1 3]),sigma_x, kernelLength);
    % the second 1D returns a "transpose" since it gets a "transpose"
    % "transpose" it back
    imOutCustom = permute(imOutCustom, [2 1 3]);
    
    subplot(2,2,1);
    imshow(image);
    subplot(2,2,2);
    imshow(imOut);
    subplot(2,2,3);
    imshow(imOut2D);
    subplot(2,2,4);
    imshow(imOutCustom);
end