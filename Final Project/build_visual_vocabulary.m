function vocab = build_visual_vocabulary(descriptors_cell,vocab_size)
% build_visual_vocabulary builds a vocabulary of visual words
% i.e. clusters all features of the input images
% images - a cell of size [1 N], containing the N input images
% size - the number of visual words in the vocabulary
% type determines whether the features to be greyscale, RGB, rgb or opponent
% step - if 0 - sparse features, else dense with step size 'step'

    % Collect descriptors from all images
    descriptors = [];
    for class = 1:size(descriptors_cell,2)
        descriptors_class = descriptors_cell{class};
        for image = 1:size(descriptors_class,2)
%             disp(class);
%             disp(image);
%             disp(size(descriptors));
%             disp(size(descriptors_class{image}));
            descriptors = [descriptors,descriptors_class{image}];
        end
    end
    % vl_kmeans requires 'DATA must be of class SINGLE or DOUBLE'
    data = double(descriptors);
    % But we don't want it to have changed
    assert(all(descriptors(:,1) == data(:,1))');
    % Cluster features
    [vocab,~] = vl_kmeans(data,vocab_size);
end