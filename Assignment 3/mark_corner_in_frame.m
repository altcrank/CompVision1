function frame = mark_corner_in_frame(frame,row,col,window,rgb)
    sf = size(frame);
    [start_row end_row] = patch_coordinates(round(row),window,sf(1));
    [start_col end_col] = patch_coordinates(round(col),window,sf(2));
    if rgb
        frame(start_row:end_row,start_col:end_col,1) = 0;
        frame(start_row:end_row,start_col:end_col,2) = 1;
        frame(start_row:end_row,start_col:end_col,3) = 0;
    else
        frame(start_row:end_row,start_col:end_col) = 1;
    end
end