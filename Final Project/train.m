function [vocab,model] = train(data_path,images_per_class,vocab_size,type,step)
    % Define some constants
    train_substring = '_train';
    model_path = strcat(data_path,'/FeatureData/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    [images,class_names] = load_data(images_path,train_substring);
    % Uncomment to better understand
%     disp(size(images));
%     for i = 1:size(images,2)
%         disp(size(images{i}));
%     end
    % Sample images from every class and build a vocabulary
    [vocab_images,vocab_used] = select_images(images,images_per_class,{});
    vocab_images = flatten(vocab_images);
    vocab = build_visual_vocabulary(vocab_images,vocab_size,type,step);
    save(strcat(model_path,'vocab.mat'),'vocab');
    % Sample images from every class (different from the vocabulary ones)
    [train_images,~] = select_images(images,images_per_class,vocab_used);
    quantized_images = quantize_images(vocab,train_images,type,step);
    [train_data,classes] = prepare_data(quantized_images);
    for class = 1:size(quantized_images,2)
        labels = class == classes;
        labels(labels == 0) = -1;
        % To see options type svmtrain in command window
        model = svmtrain(double(labels),train_data,['-q -s ' num2str(2)]);
        model_name = strcat(class_names{class},'.mat');
        save(strcat(model_path,model_name),'model');
    end

    % Just in case those can speed things up a bit

    %A matlab function libsvmread reads files in LIBSVM format:
    %[label_vector, instance_matrix] = libsvmread('data.txt');
    %Two outputs are labels and instances, which can then be used as inputs
    %of svmtrain or svmpredict.

    %A matlab function libsvmwrite writes Matlab matrix to a file in LIBSVM format:
    %libsvmwrite('data.txt', label_vector, instance_matrix)
end