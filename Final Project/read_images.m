function [images,image_names] = read_images(path)
    images = {};
    image_names = {};
    files = dir(path);
    for file = files'
        % Because matlab reads in '.' and '..'
        % Also windows to unix leads to weird Thumbs.db files
        if isdir(file.name) || numel(strfind(file.name,'.db'))
            continue
        end
        image_name = [path,'/',file.name];
        image = imread(image_name);
        images = [images,image];
        image_names = [image_names,image_name];
    end
end