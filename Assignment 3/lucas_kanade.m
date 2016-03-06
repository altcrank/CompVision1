function v = lucas_kanade(image1_path,image2_path)
    image1 = im2double(imread(image1_path));
    image2 = im2double(imread(image2_path));
    orig_image = image1;
    if (length(image1(1,1,:)) == 3)
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end
    window = 15;
    sigma = 1;
    % Prepare gradients for lucas-kanade
    [Ix,Iy,It] = compute_gradients(image1,image2,sigma,sigma,window);
    
    s = size(image1);
    center = ceil(window/2);
    %Prepare to loop (split into regions)
    rows = center:window:s(1);
    cols = center:window:s(2);
    % Possibly remove last center if region not completely in image
    if rows(end) + center - 1 > s(1)
        rows = rows(1:end-1);
    end
    if cols(end) + center - 1 > s(2)
        cols = cols(1:end-1);
    end
    %loop trough regions and compute velocity vectors
    for row = rows
        for col = cols
            x = floor((row+center)/window);
            y = floor((col+center)/window);
            v(x,y,:) = lucas_kanade_patch(Ix,Iy,It,row,col,window);
        end
    end
    sv = size(v);
    % Plot velocity vectors
    imshow(orig_image);
    hold on;
    quiver(cols,rows,v(:,:,2),v(:,:,1),'r');
    hold off;
end

