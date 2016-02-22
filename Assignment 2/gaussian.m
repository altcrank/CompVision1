function G = gaussian(sigma, kernelLength)
    % Generate coordinates, with the origin in the middle
    halfLength = floor(kernelLength/2);
    if mod(kernelLength,2) == 0
        halfLength = halfLength - 1;
    end
    % In case of even length we need 2 zeros in the middle
    x = [];
    if mod(kernelLength,2) == 0
        x = [-halfLength:0,0:halfLength];
    else
        x = -halfLength:halfLength;
    end
    % Create Gaussian Mask
    G = exp(-(x.^2)/(2*sigma*sigma));
    % Normalize
    G = G / sum(G);
end