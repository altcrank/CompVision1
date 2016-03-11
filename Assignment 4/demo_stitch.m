function demo_stitch(image_path1,image_path2)
    % Read images
    [orig1,image1] = read_image(image_path1);
    [orig2,image2] = read_image(image_path2);
    
    % Get the best transformation between images
    % Matches SIFT descriptors and performs RANSAC
    transform = get_best_transform(image1,image2);
    
    first_stiched_to_second = stitch(orig1,orig2,transform);
    
    inv_transform = invert(transform);
    second_stiched_to_first = stitch(orig2,orig1,inv_transform);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(1,2,1);
    imshow(first_stiched_to_second);
    title([image_path1,' stitched to ',image_path2]);
    subplot(1,2,2);
    imshow(second_stiched_to_first);
    title([image_path2,' stitched to ',image_path1]);
end