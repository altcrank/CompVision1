function [selected,used] = select_images(images,images_per_class,blacklist)
    selected = {};
    used = {};
    if images_per_class < 1
        % All images, regardless of blacklist
        % Leave indices empty
        selected = images;
    else
        for i = 1:1:size(images,2)
            % Pick images_per_class images at random
            images_class = images{i};
            if numel(blacklist)
                blacklist_class = blacklist{i};
            else
                blacklist_class = [];
            end
            perm = randperm(size(images_class,2));
            sample_size = min(images_per_class,length(perm));
            class_indices = [];
            class_selected = {};
            % Pick only ones that are not blacklisted
            for j = 1:sample_size
                if any(perm(j) == blacklist_class)
                    continue
                end
                class_selected = [class_selected,images_class{perm(j)}];
                class_indices = [class_indices,perm(j)];
            end
            % In case there weren't enough not blacklisted fill up
            % with blacklisted ones after all
            for j = 1:sample_size-length(class_selected)
                class_selected = [class_selected,images_class{blacklist_class(j)}];
                class_indices = [class_indices,blacklist_class(j)];
            end
            selected{i} = class_selected;
            used{i} = class_indices;
        end
    end
end