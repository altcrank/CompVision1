function mAP = mean_average_precision(decision_values,labels)
    ranking = [decision_values,labels];
    ranking = sortrows(ranking,[-1 -2]);
    ranked_labels = ranking(:,2);
    mAP = 0;
    correct = 0;
    for i = 1:size(ranked_labels,1)
        if ranked_labels(i) == 1
            correct = correct + 1;
            mAP = mAP + (correct / i);
        end
    end
    if correct
        mAP = mAP / correct;
    end
end