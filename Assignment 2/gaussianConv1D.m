function imOut = gaussianConv1D(image,sigma,kernelLength)
    s = size(image);
    dim = length(image(1,1,:));
    % apply horizontal first - sigma_y
    G = gaussian(sigma, kernelLength);
    G = repmat(G, dim, 1);
    for x = 1:s(1)
        for y = 1:s(2)
            k = y + generateCoordinates(kernelLength);
            % clamp padding
            k = max(k,1);
            k = min(k,s(2));
            f = [];
            for i = 1:length(k)
                f(:,i) = image(x,k(i),:);
            end
            imOut(x,y,:) = sum(f .* G, 2)';
        end
    end
end