function imOut = gaussianConv(im_path,sigma_x,sigma_y)
    % read image
    image = im2double(imread(im_path));
    kernelLength = 11;
    % apply horizontal first - sigma_y
    imOut = gaussianConv1D(image,sigma_y, kernelLength);
    % apply vertical next - sigma_x
    imOut = gaussianConv1D(permute(imOut, [2 1 3]),sigma_x, kernelLength);
    % the second 1D returns a "transpose" since it gets a "transpose"
    % "transpose" it back
    imOut = permute(imOut, [2 1 3]);
end