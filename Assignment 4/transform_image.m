function transformed = transform_image(image,H)
    HI = invert(H);
    % Figure out what matlab magic is the source of this!
    HI = prepare(HI);
    H = prepare(H);
    % Figure out boundaries
    s = size(image);
    img_corners(:,1) = [1 1 1]';
    img_corners(:,2) = [s(1) 1 1]';
    img_corners(:,3) = [1 s(2) 1]';
    img_corners(:,4) = [s(1:2) 1]';
    ts = round(H * img_corners);
    mins = min(ts');
    maxs = max(ts');
    minx = mins(1);
    maxx = maxs(1);
    miny = mins(2);
    maxy = maxs(2);
    
    s = size(image);
    for row = minx:maxx
        for col = miny:maxy
            im_coords = round(HI * [row col 1]');
            % If within original image
            if all(im_coords > 0) && all(im_coords' <= s(1:2))
                transformed(row-minx+1,col-miny+1,:) = image(im_coords(1), im_coords(2),:);
            end
        end
    end
end