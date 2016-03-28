function quantized = quantize_images(vocab,images,type,step)
    quantized = {};
    for i = 1:size(images,2)
-        class = images{i};
        quantized_class = {};
        for j = 1:size(class,2)
            quantized_class = [quantized_class,quantize_image(vocab,class{j},type,step)];
        end
        quantized{i} = quantized_class;
    end
end