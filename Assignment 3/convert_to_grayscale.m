function images = convert_to_grayscale(rgb_images)
    s = size(rgb_images);
    for i = 1:s(1)
        images(i,:,:) = rgb2gray(squeeze(rgb_images(i,:,:,:)));
    end
end