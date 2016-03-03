function res = tracking(images_path)
    files = dir(images_path);
    i = 1;
    for file = files'
        rel_name = [images_path,'/',file.name];
        if isdir(rel_name)
            continue
        end
        image = im2double(imread(rel_name));
        if (length(image(1,1,:)) == 3)
            image = rgb2gray(image);
        end
        images(i,:,:) = image;
        i = i + 1;
    end
    
    %Configure those somehow
    thr = 0.00005;
    window = 15;
    sigma = 1;
    [H r c] = harris(images(1,:,:),thr,window,sigma);
    
    rows = r;
    cols = c;
    is = size(images);
    for frame_no = 1:is(1)-1
        image1 = image(frame_no,:,:);
        image2 = image(frame_no+1,:,:);
        for feature = 1:length(r)
            row = rows(feature);
            col = cols(feature);
            v(frame_no,row,col) = lucas_kanade(image1,image2,row,col);
        end
    end
    
end
