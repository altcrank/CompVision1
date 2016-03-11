function [matches,frames1,frames2] = match_keypoints(image1,image2)
    % Get SIFT descriptors
    [frames1,descriptors1] = vl_sift(im2single(image1));
    [frames2,descriptors2] = vl_sift(im2single(image2));
    % Each column of frame (4xnum_features) gives an elipse of center
    % f(1:2), scale f(3), and orientation f(4)
    
    % Match descriptors
    [matches,~] = vl_ubcmatch(descriptors1,descriptors2);
    % Matches (2xdescr_count) has columns of indices of matching descr.
    % Scores - L2 dist between them
end