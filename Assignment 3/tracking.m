function video_filename = tracking(images_path, threshold, window, sigma)
    %Read images
    [original_images,rgb] = read_images(images_path);
    % Get working images - grayscale
    if rgb
        images = convert_to_grayscale(original_images);
    else
        images = original_images;
    end
    
    %Open a video file for writing
    video_filename = [images_path,'.avi']; 
    v = VideoWriter(video_filename);
    open(v);
    
    %thr = 0.00005;
    %window = 15;
    %sigma = 1;
    % Detect corners using Harris corner detector
    [~,r,c] = harris(squeeze(images(1,:,:)),threshold,window,sigma);
    % Copy rows and columns so that you don't change the original returned
    % ones
    rows = r;
    cols = c;
    
    frame = select_frame(original_images,1,rgb);
    % Mark corners on frame
    for feature = 1:length(r)
        frame = mark_corner_in_frame(frame,rows(feature),cols(feature),5,rgb);
    end
    % write frame in video
    writeVideo(v,frame);
    
    is = size(images);
    for frame_no = 1:is(1)-1
        % get two subsequent frames
        image1 = squeeze(images(frame_no,:,:));
        image2 = squeeze(images(frame_no+1,:,:));
        % get frame
        frame = select_frame(original_images,frame_no+1,rgb);
        
        % Prepare gradients for lucas-kanade
        [G, Gd] = gaussians(1,1,15);
        Ix = - imfilter(image1,Gd');
        Iy = - imfilter(image1,Gd);
        %[Iy,Ix] = gradient(image1);
        It = image2 - image1;
        
        % Do lucas-kanade for each corner
        for feature = 1:length(r)
            row = round(rows(feature));
            col = round(cols(feature));
            u = lucas_kanade(Ix,Iy,It,row,col,window);
            rows(feature) = rows(feature) + u(1);
            cols(feature) = cols(feature) + u(2);
            % mark corner in frame
            frame = mark_corner_in_frame(frame,rows(feature),cols(feature),5,rgb);
        end
        % write frame in video
        writeVideo(v, frame);
    end
    close(v);
    %implay(video_filename);
end
