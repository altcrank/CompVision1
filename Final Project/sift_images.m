function descriptors = sift_images(feature_path,images,type,step)
% sift extract SIFT features
% feature_path - path to save/load features from
% images - RGB images to extract SIFT features from
% type - determines whether the features to be greyscale, RGB, rgb or opponent
% step - if 0 - sparse features, else dense with step size 'step'

    % Create path
    if exist(feature_path,'dir') ~= 7
        mkdir(feature_path);
    end
    fname = [type,'_',num2str(step),'.mat'];
    feature_file = strcat(feature_path,fname);
    if exist(feature_file,'file') ~= 2
        descriptors = {};
        for class = 1:size(images,2)
            descr_class = {};
            images_class = images{class};
            for i = 1:length(images_class)
                [~,descr] = sift(images_class{i},type,step);
                if ~numel(descr)
                    continue
                end
                descr_class = [descr_class,descr];
            end
            descriptors{class} = descr_class;
        end
        save(feature_file,'descriptors');
    end
    load(feature_file,'descriptors');
end