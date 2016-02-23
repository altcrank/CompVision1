function imOut = gaussianConv1D(image,sigma,kernelLength)
    G = gaussian(sigma, kernelLength);
    imOut = conv1D(image,G);
end