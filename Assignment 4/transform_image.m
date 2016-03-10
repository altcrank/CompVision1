function transformed = transform_image(image,image2,H)
    s = size(image);
    img_corners(:,1) = [1 1 1]';
    img_corners(:,2) = [s(1) 1 1]';
    img_corners(:,3) = [1 s(2) 1]';
    img_corners(:,4) = [s 1]';
    ts = round(H * img_corners);
    mins = min(ts');
    % Indexing starts from one
    minx = mins(1)-1;
    miny = mins(2)-1;
    for row = 1:size(image,1)
        for col = 1:size(image,2)
            t_coords = round(H * [row col 1]');
            transformed(t_coords(1)-minx,t_coords(2)-miny) = image(row,col);
        end
    end
end