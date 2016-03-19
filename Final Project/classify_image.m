function predicted_label = classify_image(model,vocab,image,true_label,type,step)
    qunatized_image = quantize_image(vocab,image,type,step);
    % To see options type svmpredict in command window
    predicted_label = svmpredict([true_label],qunatized_image',model,'-q');
end