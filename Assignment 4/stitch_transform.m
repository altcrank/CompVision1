function transformed = stitch_transform(image1,image2,H)
    % not quite sure why, but need to reverse angle of rotation
    H = prepare(H);
    % Figure out boundaries
    s = size(image1);
    img_corners(:,1) = [1 1 1]';
    img_corners(:,2) = [s(1) 1 1]';
    img_corners(:,3) = [1 s(2) 1]';
    img_corners(:,4) = [s(1) s(2) 1]';
    ts = round(H * img_corners);
    mins = min(ts');
    % Indexing starts from one
    minx = min(mins(1)-1,0);
    miny = min(mins(2)-1,0);

    for row = 1:size(image1,1)
        for col = 1:size(image1,2)
            t_coords = round(H * [row col 1]');
            transformed(t_coords(1)-minx,t_coords(2)-miny,:) = (image1(row,col,:));
        end
    end
    
    for row = 1:size(image2,1)
        for col = 1:size(image2,2)
            if all([row-minx, col-miny] < [size(transformed,1) size(transformed,2)])
                 if transformed(row-minx,col-miny,:) == 0
                    transformed(row-minx,col-miny,:) = image2(row,col,:);
                else
                    transformed(row-minx,col-miny,:) = (transformed(row-minx,col-miny,:) + image2(row,col,:))/2;
                end
            else
                transformed(row-minx,col-miny,:) = image2(row,col,:);
            end
        end
    end
end