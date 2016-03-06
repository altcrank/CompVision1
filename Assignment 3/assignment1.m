function assignment1
    figure('units','normalized','outerposition',[0 0 1 1]);

    colorImg = im2double(imread('person_toy/00000001.jpg'));
    img = colorImg;
    if (length(img(1,1,:)) == 3)
        img = rgb2gray(img);
    end
    
    [~,rows,cols] = harris(img, 6*10^(-6), 15, 1.5);
    subplot(1,2,1);
    imshow(colorImg);
    title('sigma = 1.5, threshold = 6*10^{(-6)}, window = 15 x 15');
    hold on;
    plot(cols, rows, 'b*');
    hold off;
  
    colorImg = im2double(imread('pingpong/0000.jpeg'));
    img = colorImg;
    if (length(img(1,1,:)) == 3)
        img = rgb2gray(img);
    end
    
    [~,rows,cols] = harris(img, 7*10^(-6), 15, 1.5);
    subplot(1,2,2);
    imshow(colorImg);
    title('sigma = 1.5, threshold = 7*10^{(-6)}, window = 15 x 15');
    hold on;
    plot(cols, rows, 'b*');
    hold off;

end