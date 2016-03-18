function [word,index] = quantize_feature(vocab,feature)
    % Because vocabulary was used with DOUBLE data
    feat = double(feature);
    % Set first to be closest
    word = vocab(:,1);
    index = 1;
    smallest_dist = norm(vocab(:,1) - feat);
    % Find actual closest
    for w = 2:size(vocab,2)
        dist = norm(vocab(:,w) - feat);
        if dist < smallest_dist
            smallest_dist = dist;
            word = vocab(:,w);
            index = w;
        end
    end
end