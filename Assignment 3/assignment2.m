function v = assignment2(image1_path,image2_path)
    image1 = im2double(imread(image1_path));
    image2 = im2double(imread(image2_path));
    if (length(image1(1,1,:)) == 3)
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end
    %Derivatives of Gaussian look ok only if negated
    %Gd = gaussianDer(sigma_i,sigma_d,kernel_size);
    %Ix = imfilter(image2,-Gd);
    %Iy = imfilter(image2,-Gd');
    %Compute spatial and temporal derivatives
    [Ix,Iy] = gradient(image2);
    It = image2 - image1;
    
    s = size(image1);
    window = 15;
    center = ceil(window/2);
    rows = center:window:s(1);
    if rows(end) + center - 1 > s(1);
        rows = rows(1:end-1);
    end
    cols = center:window:s(2);
    if cols(end) + center - 1 > s(2);
        cols = cols(1:end-1);
    end
    for row = rows
        for col = cols
            x = floor((row+center)/window);
            y = floor((col+center)/window);
            v(x,y,:) = lucas_kanade(Ix,Iy,It,row,col,window);
        end
    end
    sv = size(v);
    quiver(1:sv(1),sv(2):-1:1,v(:,:,1),v(:,:,1));
end

