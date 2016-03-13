function transform = demo_align(image_path1,image_path2)
    % Read images
    [orig1,image1] = read_image(image_path1);
    [orig2,image2] = read_image(image_path2);
    
    % Get the best transformation between images
    % Matches SIFT descriptors and performs RANSAC
    transform = get_best_transform(image1,image2);
    
    % For comparison with the matlab functions
    %T = maketform('affine', [transform(1,:)', transform(2,:)', [0; 0; 1]]);
    
    % Transform image1 to image2
    transformed1 = transform_image(orig1,transform);
    %matlab_transformed1 = imtransform(orig1,T);
    
    % Transform image2 to image1
    inv_transform = invert(transform);
    %inv_T = maketform('affine', [inv_transform(1,:)', inv_transform(2,:)', [0; 0; 1]]);
    
    transformed2 = transform_image(orig2,inv_transform);
    %matlab_transformed2 = imtransform(orig2,inv_T);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(1,2,1);
    imshow(transformed1);
    %imshow(matlab_transformed1);
    title([image_path1,' aligned to ',image_path2]);
    subplot(1,2,2);
    imshow(transformed2);
    %imshow(matlab_transformed2);
    title([image_path2,' aligned to ',image_path1]);
end