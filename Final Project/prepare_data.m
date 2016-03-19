function [data,classes] = prepare_data(quantized_images)
    data = [];
    classes = [];
    for class = 1:size(quantized_images,2)
        quantized_class = quantized_images{class};
        for i = 1:size(quantized_class,2)
            data = [data;quantized_class{i}'];
            classes = [classes;class];
        end
    end
end