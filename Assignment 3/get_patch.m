function patch = get_patch(Ix,x_start,x_end,y_start,y_end)
    patch_matrix = Ix(x_start:x_end,y_start:y_end);
    patch = reshape(patch_matrix',[numel(patch_matrix) 1]);
end