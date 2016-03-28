function train(data_path,vocab_size,type,step)
    tic;
    % Define some constants
    train_substring = '_train';
    model_path = strcat(data_path,'/FeatureData/');
    feature_path = strcat(model_path,'Features/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    [images,class_names,~] = load_data(images_path,train_substring);
    descriptors = sift_images(feature_path,images,type,step);
    % Build a vocabulary
    vocab = build_visual_vocabulary(descriptors,vocab_size);
    vocab_name = strcat(model_path,construct_name('vocab',vocab_size,type,step));
    save(vocab_name,'vocab');
    % Sample images from every class (different from the vocabulary ones)
    quantized_images = quantize_images(vocab,descriptors);
    [train_data,classes] = prepare_data(quantized_images);
    for class = 1:size(quantized_images,2)
        labels = double(class == classes);
        labels(labels == 0) = -1;
        % To see options type svmtrain in command window
        model = svmtrain(labels,train_data,['-q -t ' num2str(0)]);
        model_name = construct_name(class_names{class},vocab_size,type,step);
        save(strcat(model_path,model_name),'model');
    end

    % Just in case those can speed things up a bit

    %A matlab function libsvmread reads files in LIBSVM format:
    %[label_vector, instance_matrix] = libsvmread('data.txt');
    %Two outputs are labels and instances, which can then be used as inputs
    %of svmtrain or svmpredict.

    %A matlab function libsvmwrite writes Matlab matrix to a file in LIBSVM format:
    %libsvmwrite('data.txt', label_vector, instance_matrix)
    toc;
end