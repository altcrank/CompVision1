function train(data_path,images_per_class,vocab_size,type,step)
    % Define some constants
    train_substring = '_train';
    model_path = strcat(data_path,'/FeatureData/');
    images_path = strcat(data_path,'/ImageData/');
    % Load images in a cell of cells - one for each image class
    images = load_data(images_path,train_substring);
    % Uncomment to better understand
%     disp(size(images));
%     for i = 1:size(images,2)
%         disp(size(images{i}));
%     end
    train_images = select_images(images,images_per_class);
    vocab = build_visual_vocabulary(train_images,vocab_size,type,step);
end