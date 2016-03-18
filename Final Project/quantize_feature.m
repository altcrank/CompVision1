function word = quantize_feature(vocab,feature)
    word = vocab(:,1);
    smallest_dist = norm(vocab(:,1) - feature);
    for w = 2:size(vocab,2)
        dist = norm(vocab(:,w) - feature);
        if dist < smallest_dist
            smallest_dist = dist;
            word = vocab(:,w);
        end
    end
end