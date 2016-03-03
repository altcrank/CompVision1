function res = tracking(images_path)
    files = dir(images_path);
    i = 1;
    filenames = [];
    rgb = 0;
    for file = files'
        rel_name = [images_path,'/',file.name];
        if isdir(rel_name)
            continue
        end
        image = im2double(imread(rel_name));
        if (length(image(1,1,:)) == 3)
            original_images(i,:,:,:) = image;
            image = rgb2gray(image);
            rgb = 1;
        else
            original_images(i,:,:) = image;
        end
        images(i,:,:) = image;
        i = i + 1;
    end
    
    %Configure those somehow
    thr = 0.00005;
    window = 15;
    sigma = 1;
    
    %[H r c] = harris(images(1,:,:),thr,window,sigma);
    [H r c] = harris([images_path,'/',files(3).name],thr,window,sigma);
    
    rows = r;
    cols = c;
    is = size(images);
    v = VideoWriter('video.avi');
    open(v);
    
    if rgb
        frame = original_images(1,:,:,:);
        sf = size(frame);
        frame = reshape(frame, sf(2:end));
    else
        frame = original_images(1,:,:);
        sf = size(frame);
        frame = reshape(frame, sf(2:end));
    end
    sf = size(frame);
    for feature = 1:length(r)
        [start_row end_row] = patch_coordinates(round(rows(feature)),5,sf(1));
        [start_col end_col] = patch_coordinates(round(cols(feature)),5,sf(2));
        if rgb
            %disp(size(frame(start_row:end_row,start_col:end_col,:)));
            %disp(size([0 1 0]));
            %frame(start_row:end_row,start_col:end_col,:) = [0 1 0];
            frame(start_row:end_row,start_col:end_col,1) = 0;
            frame(start_row:end_row,start_col:end_col,2) = 1;
            frame(start_row:end_row,start_col:end_col,3) = 0;
        else
            frame(start_row:end_row,start_col:end_col) = 1;
        end
    end
    writeVideo(v,frame);
    
    for frame_no = 1:is(1)-1
        image1 = images(frame_no,:,:);
        image2 = images(frame_no+1,:,:);
        if rgb
            frame = original_images(frame_no,:,:,:);
            sf = size(frame);
            frame = reshape(frame, sf(2:end));
        else
            frame = original_images(frame_no,:,:);
            sf = size(frame);
            frame = reshape(frame, sf(2:end));
        end
        [Ix,Iy] = gradient(image2);
        It = image2 - image1;
        window_size = 15;
        for feature = 1:length(r)
            row = round(rows(feature));
            col = round(cols(feature));
            u = lucas_kanade(Ix,Iy,It,row,col,window_size);
            disp(u);
            rows(feature) = rows(feature) + u(1);
            cols(feature) = cols(feature) + u(2);
            if rgb
                sf = size(frame);
                [start_row end_row] = patch_coordinates(round(rows(feature)),5,sf(1));
                [start_col end_col] = patch_coordinates(round(cols(feature)),5,sf(2));
                if rgb
                    %frame(start_row:end_row,start_col:end_col,:) = [0 1 0];
                    frame(start_row:end_row,start_col:end_col,1) = 0;
                    frame(start_row:end_row,start_col:end_col,2) = 1;
                    frame(start_row:end_row,start_col:end_col,3) = 0;
                else
                    frame(start_row:end_row,start_col:end_col) = 1;
                end
            end
        end
        writeVideo(v, frame);
    end
    close(v);
end
