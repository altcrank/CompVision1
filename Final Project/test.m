function [ranking,mAP] = test(data_path,vocab_size,type,step,kernel)
    tic;
    % Define some constants
    test_substring = '_test';
    model_path = strcat(data_path,'/FeatureData/');
    feature_path = strcat(model_path,'FeaturesTest/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    [images,class_names,image_names] = load_data(images_path,test_substring);
    descriptors = sift_images(feature_path,images,type,step);
    % Get model names
    vocab_name = strcat(model_path,construct_name('vocab',vocab_size,type,step));
    model_names = get_model_names(model_path,class_names,vocab_size,type,step);
    % If the models do not exist, train them
    if ~models_exist(vocab_name,model_names)
        % the number is images_per_class
        train(data_path,50,vocab_size,type,step);
    end
    % Load vocabulary
    load(vocab_name,'vocab');
    
    quantized_images = quantize_images(vocab,images,type,step);
    [test_data,classes] = prepare_data(quantized_images);
    ranking = {};
    for class = 1:size(quantized_images,2)
        labels = double(class == classes);
        labels(labels == 0) = -1;
        model_name = construct_name(class_names{class},vocab_size,type,step);
        model_name = [num2str(kernel),'_',model_name];
        load(strcat(model_path,model_name),'model');
        % To see options type svmpredict in command window
        [~,~,decision_values] = svmpredict(labels,test_data,model,'-q');
        % Put decision vals and names in array to sort together
        decision_values_cell = num2cell(decision_values);
        class_ranking = [decision_values_cell, flatten(image_names)'];
        % Sorts ranking based on first column. Break ties with second
        % Negative for ascending order
        class_ranking = sortrows(class_ranking,[-1 -2]);
        % Save only sorted image names in ranking
        ranking{class} = class_ranking(:,2);
        mAP(class) = mean_average_precision(decision_values,labels);
    end
    toc;
end