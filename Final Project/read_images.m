function images = read_images(path)
    images = {};
    files = dir(path);
    for file = files'
        % Because matlab reads in '.' and '..'
        % Also windows to unix leads to weird Thumbs.db files
        if isdir(file.name) || numel(strfind(file.name,'.db'))
            continue
        end
        image = imread([path,'/',file.name]);
        images = [images,image];
    end
end