function assignment1
    
    img = im2double(imread('person_toy/00000001.jpg'));
    if (length(img(1,1,:)) == 3)
        img = rgb2gray(img);
    end
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    [~,rows,cols] = harris(img, 0.0000005, 15, 2);
    subplot(2,2,1);
    imshow(img);
    hold on;
    plot(cols, rows, 'g*');
    hold off;
    
    [~,rows,cols] = harris(img, 0.0000005, 15, 2);
    subplot(2,2,2);
    imshow(img);
    hold on;
    plot(cols, rows, 'g*');
    hold off;
    
    [~,rows,cols] = harris(img, 0.0000005, 15, 2);
    subplot(2,2,3);
    imshow(img);
    hold on;
    plot(cols, rows, 'g*');
    hold off;
    
    [~,rows,cols] = harris(img, 0.0000005, 15, 2);
    subplot(2,2,4);
    imshow(img);
    hold on;
    plot(cols, rows, 'g*');
    hold off;
    
%harris('pingpong/0000.jpeg', 0.0000005, 10, 2);
    
    
end