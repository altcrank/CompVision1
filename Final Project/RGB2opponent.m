function converted = RGB2opponent(image)
    converted(:,:,1) = (image(:,:,1) - image(:,:,2)) / sqrt(2);
    converted(:,:,2) = (image(:,:,1) + image(:,:,2) - 2 * image(:,:,3)) / sqrt(6);
    converted(:,:,3) = (image(:,:,1) + image(:,:,2) + image(:,:,3)) / sqrt(3);
end