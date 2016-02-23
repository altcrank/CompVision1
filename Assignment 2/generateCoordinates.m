function x = generateCoordinates(length)
    halfLength = floor(length/2);
    if mod(length,2) == 0
        halfLength = halfLength - 1;
    end
    % In case of even length we need 2 zeros in the middle
    x = [];
    if mod(length,2) == 0
        x = [-halfLength:0,0:halfLength];
    else
        x = -halfLength:halfLength;
    end
end