function demo_plot_matches(image_path1,image_path2)
    % Read images
    [orig1,image1] = read_image(image_path1);
    [orig2,image2] = read_image(image_path2);
    % Match keypoints
    [matches,frames1,frames2] = match_keypoints(image1,image2);
    
    % Plot images with connected matches
    % 1. Permute matches to get random ones
    perm = randperm(size(matches,2));
    % 2. Show images next to each other
    imshow([orig1,orig2]);
    % 3. Connect matches with lines of different colours
    colormap = 'brmygc';
    len = length(colormap);
    hold on;
    for match = 1:min(50,length(perm))
        line([frames1(2,perm(match)),frames2(2,perm(match))+size(orig1,2)],[frames1(1,perm(match)),frames2(1,perm(match))],'Color',colormap(mod(match,len)+1));
    end
    hold off;
end