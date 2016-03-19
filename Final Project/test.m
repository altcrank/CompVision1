function [predicted_label,accuracy,decision_values] = test(data_path,type,step)
    % Define some constants
    test_substring = '_test';
    model_path = strcat(data_path,'/FeatureData/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    [images,class_names] = load_data(images_path,test_substring);
    load(strcat(model_path,'vocab.mat'),'vocab');

    % To debug use same images for everything (in select_images as well)
%     [train_images,~] = select_images(images,1,{});
%     quantized_images = quantize_images(vocab,train_images,type,step);
    quantized_images = quantize_images(vocab,images,type,step);

    [test_data,classes] = prepare_data(quantized_images);
    for class = 1:size(quantized_images,2)
        labels = class == classes;
        labels(labels == 0) = -1;
        model_name = strcat(class_names{class},'.mat');
        load(strcat(model_path,model_name),'model');
        % To see options type svmpredict in command window
        [predicted_label,accuracy,decision_values] = svmpredict(double(labels),test_data,model,'-q');
    end
end