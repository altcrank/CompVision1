function quantized = quantize_images(vocab,descriptors)
    quantized = {};
    for i = 1:size(descriptors,2)
        class = descriptors{i};
        quantized_class = {};
        for j = 1:size(class,2)
            quantized_class = [quantized_class,quantize_image(vocab,class{j})];
        end
        quantized{i} = quantized_class;
    end
end