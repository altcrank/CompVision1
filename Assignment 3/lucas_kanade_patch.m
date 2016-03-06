function v = lucas_kanade_patch(Ix,Iy,It,row,col,window)
    [n,m] = size(Ix);
    [start_row,end_row] = patch_coordinates(row,window,n);
    [start_col,end_col] = patch_coordinates(col,window,m);
    
    A(:,1) = patch_vector(Ix,start_row,end_row,start_col,end_col); 
    A(:,2) = patch_vector(Iy,start_row,end_row,start_col,end_col);
    b = - patch_vector(It,start_row,end_row,start_col,end_col);

    M = A' * A;
    sm = size(M);
    if rank(M) < sm(1)
        v = zeros([sm(1) 1]);
    else
        %v = M \ (A' * b);
        v = (pinv(M) * A') * b;
    end
end