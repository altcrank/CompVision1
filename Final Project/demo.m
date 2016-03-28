function demo(img_per_class,vocab_size,color_type,sift,kernel)
% img_per_class - number of training images used per class
% vocab_size    - size of vocabulary (k for k-means)
% color_type    - for greyscale: 'grey'
%                 for RGB: 'RGB'
%                 for normalized RGB (rgb): 'norm_rgb'
%                 for opponent: 'opponent'
% sift          - for sparse sift: 0
%                 for dense sift: step size (10 used)
% kernel        - for linear: 0
%                 for polynomial: 1
%                 for radial: 2
%                 for sigmoid: 3

    % train vocabulary and classifier
    train('Caltech4',img_per_class,vocab_size,color_type,sift,kernel);
    
    % test on test set (50 images per class)
    [ranking,mAP] = test('Caltech4',vocab_size,color_type,sift,kernel);
    results = construct_name('results',vocab_size,color_type,sift,kernel);
    map = construct_name('map',vocab_size,color_type,sift,kernel);
    path = 'Caltech4/Results/';
    save(strcat(path,results),'ranking');
    save(strcat(path,map),'mAP');
    
    % write results to HTML according to template
    results2html(img_per_class,vocab_size,color_type,sift,kernel);
end