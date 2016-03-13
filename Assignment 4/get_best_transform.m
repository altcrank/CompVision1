function transform = get_best_transform(image1,image2)
    % Match keypoints
    [matches,frames1,frames2] = match_keypoints(image1,image2);
    % Compute best transform
    transform = ransac(frames1,frames2,matches,50,10);
end