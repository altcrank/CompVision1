function [H,inliers] = ransac(image1, image2, frames1, frames2, matches, reps, sub)
    sub = min(sub, size(matches,2));
    best = 0;
    H = [];
    inliers = [];
    for i = 1:reps
        % Pick sub points at random
        perm = randperm(size(matches,2));
        perm = perm(1:sub);
        H_cur = construct_transform(frames1,frames2,matches(:,perm));
        transformed = transform_frames(frames1,H_cur);
%         imshow([image1,image2]);
%         hold on;
%         for point = 1:size(frames1,2)
%             line([frames1(2,point),transformed(2,point)+size(image1,2)],[frames1(1,point),transformed(1,point)],'Color','g');
%         end
%         hold off;
        [inliers_count, inliers_cur] = count_inliers(frames2,transformed,matches);
        if inliers_count > best
            H = H_cur;
            inliers = inliers_cur;
            best = inliers_count;
        end
    end
end