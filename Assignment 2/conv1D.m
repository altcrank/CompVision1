function imOut = conv1D(image,H)
    s = size(image);
    dim = length(image(1,1,:));
    kernelLength = length(H);
    sh = size(H);
    transpose = sh(2) == 1;
    if transpose
        H = H';
    end
    H = repmat(H, dim, 1);
    for x = 1:s(1)
        for y = 1:s(2)
            t = y;
            if transpose
                t = x;
            end
            k = t + generateCoordinates(kernelLength);
            % clamp padding
            k = max(k,1);
            if transpose
                k = min(k,s(1));
            else
                k = min(k,s(2));
            end
            f = [];
            for i = 1:length(k)
                if transpose
                    f(:,i) = image(k(i),y,:);
                else
                    f(:,i) = image(x,k(i),:);
                end
            end
            imOut(x,y,:) = sum(f .* H, 2);
        end
    end 
end