function model_names = get_model_names(model_path,class_names,vocab_size,type,step)
    model_names = {};
    for class = 1:size(class_names,2)
        model_name = construct_name(class_names{class},vocab_size,type,step);
        model_names{class} = strcat(model_path,model_name);
    end
end