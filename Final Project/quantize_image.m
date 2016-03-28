function image_vector = quantize_image(vocab,image_descr)
    image_vector = zeros([size(vocab,2) 1]);
    for d = 1:size(image_descr,2)
        [~,index] = quantize_feature(vocab,image_descr(:,d));
        image_vector(index) = image_vector(index) + 1;
    end
    image_vector = double(image_vector);
end