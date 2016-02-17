function converted = convert(imagename, space)
  image = im2double(imread(imagename));
  converted = [];
  switch space
      case 'opponent'
          converted = RGB2opponent(image);
      case 'rgb'
          converted = RGB2rgb(image);
      case 'hsv'
          converted = rgb2hsv(image);
      otherwise
          error('Possible color space options are opponent, rgb, hsv.');
  end
  subplot(2,2,1);
  imshow(image);
  subplot(2,2,2);
  imshow(converted(:,:,1));
  subplot(2,2,3);
  imshow(converted(:,:,2));
  subplot(2,2,4);
  imshow(converted(:,:,3));
end