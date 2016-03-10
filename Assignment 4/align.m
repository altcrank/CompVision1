function H = align(image_path1, image_path2)
    % Read images
    image1 = imread(image_path1);
    if length(image1(1,1,:)) == 3
        image1 = rgb2gray(image1);
    end
    image2 = imread(image_path2);
    if length(image2(1,1,:)) == 3
        image2 = rgb2gray(image2);
    end

    % Get SIFT descriptors
    [frames1, descriptors1] = vl_sift(im2single(image1));
    [frames2, descriptors2] = vl_sift(im2single(image2));
    % Each column of frame (4xnum_features) gives an elipse of center
    % f(1:2), scale f(3), and orientation f(4)
    
    % Match descriptors
    [matches, scores] = vl_ubcmatch(descriptors1,descriptors2);
    % Matches (2xdescr_count) has columns of indices of matching descr.
    % Scores - L2 dist between them
    
    H = ransac(image1, image2, frames1, frames2, matches,1000,10);
    % not quite sure why, but need to reverse angle of rotation
    % try working in cartesian, and not image coord system.
    H(1,2) = -H(1,2);
    H(2,1) = -H(2,1);
    
    transformed_image1 = transform_image(image1,image2,H);
    imshow(transformed_image1);
end