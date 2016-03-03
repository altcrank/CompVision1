function v = lucas_kanade(Ix,Iy,It,i,j,window_size)
    [i_start,i_end] = compute_start_end(i,window_size);
    [j_start,j_end] = compute_start_end(j,window_size);
    
    A(:,1) = get_patch(Ix,i_start,i_end,j_start,j_end); 
    A(:,2) = get_patch(Iy,i_start,i_end,j_start,j_end);
    b = - get_patch(It,i_start,i_end,j_start,j_end);

    M = A' * A;
    sm = size(M);
    if rank(M) < sm(1)
        v = zeros([sm(1) 1]);
    else
        v = M \ (A' * b);
    end
end