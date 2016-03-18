function selected = select_images(images,images_per_class)
    selected = {};
    if images_per_class < 1
        for i = 1:1:size(images,2)
            selected = [selected,images{i}];
        end
    else
        for i = 1:1:size(images,2)
            % Pick images_per_class images at random
            images_class = images{i};
            perm = randperm(size(images_class,2));
            perm = perm(1:min(images_per_class,length(perm)));
            for j = 1:length(perm)
                selected = [selected,images_class{perm(j)}];
            end
        end
    end
end