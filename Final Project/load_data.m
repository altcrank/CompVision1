function [images,classes,image_names] = load_data(path,type)
    %load images
    files = dir(path);
    images = {};
    class_no = 1;
    classes = {};
    image_names = {};
    for file = files'
        index = strfind(file.name,type);
        % If not the right type of folder continue
        if ~numel(index)
            continue
        end
        classes{class_no} = file.name(1:index-1); %name of the class
        [class,class_names] = read_images(strcat(path,file.name));
        images{class_no} = class;
        image_names{class_no} = class_names;
        class_no = class_no+1;
    end
end