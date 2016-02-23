function imOut = gaussianConv1D(image,sigma,kernelLength,vertical)
    G = gaussian(sigma, kernelLength);
    if vertical
        G = G';
    end
    imOut = conv1D(image,G);
end