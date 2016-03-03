function H = harris(fileName, threshold, window, sigma)
    img = im2double(rgb2gray(imread(fileName)));

    kSize = 11;   
    [G, Gx, Gy] = gaussians(kSize, sigma);    
    Ix = imfilter(img, Gx);
    Iy = imfilter(img, Gy);
    
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix .* Iy;
    
    % (maybe separate gaussians)
    A = imfilter(Ix2, G);
    B = imfilter(Ixy, G);
    C = imfilter(Iy2, G);
    
    H = (A.*C - B.^2) - 0.04 .* ((A + C).^2);

    [n, m] = size(H);
    w = floor(window/2);
    rows = [];
    cols = [];
    for row = w+1:(n-w)
        for col = w+1:(m-w)
           start_row = max(1, row - w);
           start_col = max(1, col - w);
           end_row = min(n, row + w);
           end_col = min(m, col + w);
           nbh = H(start_row:end_row,start_col:end_col);
           if( H(row,col) == max(max(nbh)) && (H(row,col) > threshold) )
               rows = [rows row];
               cols = [cols col];
           end
        end
    end
    
    max(max(H))
    %imshow('pingpong/0000.jpeg');
    imshow(img);
    hold on;
    plot(cols, rows, 'g*');
    hold off;
end