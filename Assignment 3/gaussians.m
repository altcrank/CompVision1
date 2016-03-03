function [G,Gd] = gaussians(sigma_i,sigma_d,length)
    x = linspace(-(length-1)/2,(length-1)/2,length);
    G = fspecial('gaussian',[1 length],sigma_i);
    Gd = - x .* G ./ (sigma_d*sigma_d);
end