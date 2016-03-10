function out = stitch(image_path1,image_path2)
    % Read images
    image1 = imread(image_path1);
    image2 = imread(image_path2);
    
    H = align(image_path1,image_path2);
    
    A = stitch_transform(image1,image2,H);
    
    HI = invert(H);
    B = stitch_transform(image2,image1,HI);
    
    subplot(1,2,1);
    imshow(A);
    subplot(1,2,2);
    imshow(B);
end