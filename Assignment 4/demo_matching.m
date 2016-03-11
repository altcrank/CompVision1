function matches = demo_matching(image_path1,image_path2)
    % Read images
    [~,image1] = read_image(image_path1);
    [~,image2] = read_image(image_path2);
    % Match keypoints between images
    [matches,~,~] = match_keypoints(image1,image2);
end