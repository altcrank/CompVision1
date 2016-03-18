function vocab = build_visual_vocabulary(images,size,type,step)
% build_visual_vocabulary builds a vocabulary of visual words
% i.e. clusters all features of the input images
% images - a cell of size [1 N], containing the N input images
% size - the number of visual words in the vocabulary
% type determines whether the features to be greyscale, RGB, rgb or opponent
% step - if 0 - sparse features, else dense with step size 'step'

    % Collect descriptors from all images
    descriptors = [];
    for i = 1:length(images)
        [~,descr] = sift(images{i},type,step);
        descriptors = [descriptors,descr];
    end
    % vl_kmeans requires 'DATA must be of class SINGLE or DOUBLE'
    data = double(descriptors);
    % But we don't want it to have changed
    assert(all(descriptors(:,1) == data(:,1))');
    % Cluster features
    [vocab,~] = vl_kmeans(data,size);
end