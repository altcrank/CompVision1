function [images,rgb] = read_images(images_path)
    files = dir(images_path);
    i = 1;
    rgb = 0;
    for file = files'
        rel_name = [images_path,'/',file.name];
        % Because matlab reads in '.' and '..'
        if isdir(rel_name)
            continue
        end
        % Read next image
        image = im2double(imread(rel_name));
        if (length(image(1,1,:)) == 3)
            images(i,:,:,:) = im2double(imread(rel_name));
            rgb = 1;
        else
            images(i,:,:) = im2double(imread(rel_name));
        end
        i = i + 1;
    end 
end