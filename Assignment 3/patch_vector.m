function patch = patch_vector(I_derivative,start_row,end_row,start_col,end_col)
    patch_matrix = I_derivative(start_row:end_row,start_col:end_col);
    patch = reshape(patch_matrix',[numel(patch_matrix) 1]);
end