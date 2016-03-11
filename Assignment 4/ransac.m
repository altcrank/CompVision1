function [H,inliers] = ransac(frames1,frames2,matches,reps,sample_size)
    sample_size = min(sample_size, size(matches,2));
    best = 0;
    H = [];
    inliers = [];
    for i = 1:reps
        % Pick sample_size points at random
        perm = randperm(size(matches,2));
        perm = perm(1:sample_size);
        H_cur = compute_transform(frames1,frames2,matches(:,perm));
        transformed = transform_frames(frames1,H_cur);
        [inliers_count, inliers_cur] = count_inliers(frames2,transformed,matches);
        if inliers_count > best
            H = H_cur;
            inliers = inliers_cur;
            best = inliers_count;
        end
    end
end