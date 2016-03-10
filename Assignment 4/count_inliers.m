function [count,inliers] = count_inliers(frames,transformed,matches)
    count = 0;
    inliers = [];
    for match = 1:size(matches,2)
        m = matches(:,match);
        f = frames(1:2,m(2));
        t = transformed(1:2,m(1));
        if norm(t - f) < 10
            count = count + 1;
            inliers(count) = match;
        end
    end
end