function converted = RGB2rgb(image)
    converted(:,:,1) = image(:,:,1) ./ (image(:,:,1) + image(:,:,2) + image(:,:,3));
    converted(:,:,2) = image(:,:,2) ./ (image(:,:,1) + image(:,:,2) + image(:,:,3));
    converted(:,:,3) = image(:,:,3) ./ (image(:,:,1) + image(:,:,2) + image(:,:,3));
end