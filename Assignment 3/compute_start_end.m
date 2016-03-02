function [i_start,i_end] = compute_start_end(i,window)
    i_end = i * window;
    i_start = i_end - window + 1;
end