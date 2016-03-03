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
    v = VideoWriter('video.avi');
    open(v);
    
    frame = images(1,:,:);
    for feature = 1:length(r)
        frame = insertMarker(frame,[rows(frame),cols(frame)],'star');
    end
    writeVideo(v, frame);
    
    for frame_no = 1:is(1)-1
        image1 = image(frame_no,:,:);
        image2 = image(frame_no+1,:,:);
        frame = image2;
        [Ix,Iy] = gradient(image1);
        It = image2 - image1;
        window_size = 15;
        for feature = 1:length(r)
            row = round(rows(feature));
            col = round(cols(feature));
            [u,v] = lucas_kanade(Ix,Iy,It,row,col,window_size);
            rows(feature) = rows(feature) + u;
            cols(feature) = cols(feature) + v;
            frame = insertMarker(I,[x,y],'star');
        end
        writeVideo(v, frame);
    end
    close(v);
end
