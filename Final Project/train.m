function train(data_path,images_per_class,vocab_size,type,step,kernel)
    tic;
    % Define some constants
    train_substring = '_train';
    model_path = strcat(data_path,'/FeatureData/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    [images,class_names,~] = load_data(images_path,train_substring);
    % Sample images from every class and build a vocabulary
    [vocab_images,vocab_used] = select_images(images,images_per_class,{});
    vocab_images = flatten(vocab_images);
    vocab = build_visual_vocabulary(vocab_images,vocab_size,type,step);
    vocab_name = strcat(model_path,construct_name('vocab',vocab_size,type,step,kernel));
    save(vocab_name,'vocab');
    % Sample images from every class (different from the vocabulary ones)
    [train_images,~] = select_images(images,images_per_class,vocab_used);
    quantized_images = quantize_images(vocab,train_images,type,step);
    [train_data,classes] = prepare_data(quantized_images);
    for class = 1:size(quantized_images,2)
        labels = double(class == classes);
        labels(labels == 0) = -1;
        % To see options type svmtrain in command window
        model = svmtrain(labels,train_data,['-q -t ' num2str(kernel)]);
        model_name = construct_name(class_names{class},vocab_size,type,step,kernel);
        save(strcat(model_path,model_name),'model');
    end
    toc;
end