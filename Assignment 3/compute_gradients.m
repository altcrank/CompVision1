function [Ix,Iy,It] = compute_gradients(image1,image2,sigma_i,sigma_d,window)
    [~,Gd] = gaussians(sigma_i,sigma_d,window);
    Ix = - imfilter(image2,Gd');
    Iy = - imfilter(image2,Gd);
    %[Iy,Ix] = gradient(image1);
    It = image2 - image1;
end