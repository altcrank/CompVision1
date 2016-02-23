function imOut = conv1D(image,H)
    s = size(image);
    dim = length(size(image));
    kernelLength = length(H);
    H = repmat(H, dim, 1);
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
            imOut(x,y,:) = sum(f .* H, 2)';
        end
    end 
end