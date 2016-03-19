function result = flatten(images)
    result = {};
    for i = 1:size(images,2)
        result = [result,images{i}];
    end
end