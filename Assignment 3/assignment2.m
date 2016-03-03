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
    [Ix,Iy] = gradient(image1);
    It = image2 - image1;
    
    s = size(image1);
    window_size = 15;
    for i = 1:fix(s(1)/window_size)
        for j = 1:fix(s(2)/window_size)
            v(i,j,:) = lucas_kanade(Ix,Iy,It,i,j,window_size);
        end
    end
    sv = size(v);
    quiver(1:sv(1),sv(2):-1:1,v(:,:,1),v(:,:,1));
end

