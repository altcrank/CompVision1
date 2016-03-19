function m_exist = models_exist(vocab_name,model_names)
    models_exist = 1;
    for i = 1:size(model_names,2)
        if exist(model_names{i},'file') ~= 2
            models_exist = 0;
            break
        end
    end
    m_exist = exist(vocab_name,'file') == 2 || models_exist;
end