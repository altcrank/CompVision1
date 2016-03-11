function transform = demo_align(image_path1,image_path2)
    % Read images
    [orig1,image1] = read_image(image_path1);
    [orig2,image2] = read_image(image_path2);
    
    % Get the best transformation between images
    % Matches SIFT descriptors and performs RANSAC
    transform = get_best_transform(image1,image2);
    
    % For comparison with the matlab functions
    %T = maketform('affine', [transform(1,:)', transform(2,:)', [0; 0; 1]]);
    %B = imtransform(image1, T);
    %subplot(1,2,1);
    %imshow(B);
    
    % Transform image1 to image2
    transformed1 = transform_image(orig1,transform);
    
    % Transform image2 to image1
    inv_transform = invert(transform);
    transformed2 = transform_image(orig2,inv_transform);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(1,2,1);
    imshow(transformed1);
    title([image_path1,' aligned to ',image_path2]);
    subplot(1,2,2);
    imshow(transformed2);
    title([image_path2,' aligned to ',image_path1]);
end