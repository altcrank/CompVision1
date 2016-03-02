function [ It ] = lucas_kanade(image1_path,image2_path)
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
    [Ix Iy] = gradient(image1);
    It = image2 - image1;
    
    s = size(image1);
    window_size = 15;
    for i = 1:fix(s(1)/window_size)
        for j = 1:fix(s(2)/window_size)
            [i_start i_end] = compute_start_end(i,window_size);
            [j_start j_end]  = compute_start_end(j,window_size);
            A(:,1) = get_patch(Ix,i_start,i_end,j_start,j_end);
            A(:,2) = get_patch(Iy,i_start,i_end,j_start,j_end);
            b = - get_patch(It,i_start,i_end,j_start,j_end);
            
            M = A' * A;
            sm = size(M);
            if rank(M) < sm(1)
                v(i,j,:) = zeros([sm(1) 1]);
            else
                v(i,j,:) = (A' * A) \ (A' * b);
            end
        end
    end
    sv = size(v);
    quiver(1:sv(1),sv(2):-1:1,v(:,:,1),v(:,:,1));
end

