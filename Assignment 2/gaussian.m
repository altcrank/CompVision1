function G = gaussian(sigma,kernelLength)
    % Generate coordinates, with the origin in the middle
    x = linspace(-(kernelLength-1)/2,(kernelLength-1)/2,kernelLength);
    % Create Gaussian Mask
    G = exp(-(x.^2)/(2*sigma*sigma));
    % Normalize
    G = G / sum(G);
end