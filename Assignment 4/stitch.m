function transformed = stitch(image1,image2,transform)
    inv_transform = invert(transform);
    % Figure out what matlab magic is the source of this!
    inv_transform = prepare(inv_transform);
    transform = prepare(transform);
    % Figure out boundaries
    s = size(image1);
    img_corners(:,1) = [1 1 1]';
    img_corners(:,2) = [s(1) 1 1]';
    img_corners(:,3) = [1 s(2) 1]';
    img_corners(:,4) = [s(1:2) 1]';
    ts = round(transform * img_corners);
    % Figure out boundaries and translation to fit in one quadrant
    mins = min(ts');
    maxs = max(ts');
    minx = mins(1);
    maxx = maxs(1);
    miny = mins(2);
    maxy = maxs(2);
    deltax = 0;
    deltay = 0;
    if minx < 1
        deltax = 1 - minx;
    end
    if miny < 1
        deltay = 1 - miny;
    end

    s2 = size(image2);
    for row = min(minx,1):max(maxx,s2(1)+deltax)
        for col = min(miny,1):max(maxy,s2(2)+deltay)
            coords2 = [row col];
            coords1 = round(inv_transform * [coords2 1]');
            coords = [row+deltax col+deltay];
            % If within original image
            if all(coords1 > 0) && all(coords1' <= s(1:2))
                % If within both
                if all(coords2 > 0) && all(coords2 <= s2(1:2))
                    transformed(coords(1),coords(2),:) = (image1(coords1(1), coords1(2),:) + image2(row,col,:)) / 2;
                else % only in first
                    transformed(coords(1),coords(2),:) = image1(coords1(1), coords1(2),:);
                end
            else
                % If at least in second
                if all(coords2 > 0) && all(coords2 <= s2(1:2))
                    transformed(coords(1),coords(2),:) = image2(row,col,:);
                end
            end
        end
    end
end