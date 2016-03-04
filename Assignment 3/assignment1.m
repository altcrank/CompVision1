function assignment1
    
    colorImg = im2double(imread('person_toy/00000001.jpg'));
    img = colorImg;
    if (length(img(1,1,:)) == 3)
        img = rgb2gray(img);
    end
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    %[~,rows,cols] = harris(img, 1*10^(-7), 15, 2);
    %[~,rows,cols] = harris(img, 1*10^(-6), 15, 1);
    
    
    [~,rows,cols] = harris(img, 1*10^(-6), 15, 2);
    subplot(2,2,1);
    imshow(colorImg);
    hold on;
    plot(cols, rows, 'b*');
    hold off;
    
    [~,rows,cols] = harris(img, 1*10^(-7), 15, 2);
    subplot(2,2,2);
    imshow(colorImg);
    hold on;
    plot(cols, rows, 'b*');
    hold off;
    
    [~,rows,cols] = harris(img, 1*10^(-6), 15, 2);
    subplot(2,2,3);
    imshow(colorImg);
    hold on;
    plot(cols, rows, 'b*');
    hold off;
    
    [~,rows,cols] = harris(img, 1*10^(-6), 15, 1);
    subplot(2,2,4);
    imshow(colorImg);
    hold on;
    plot(cols, rows, 'b*');
    hold off;
    
    disp('Press any key to continue with the other image');
    %pause;
    
%harris('pingpong/0000.jpeg', 0.0000005, 10, 2);
    
    
end