function converted = RGB2(space,image)
  switch space
      case 'grey'
          converted = RGB2gray(image);
      case 'RGB'
          converted = image;
      case 'rgb'
          converted = RGB2rgb(image);
      case 'opponent'
          converted = RGB2opponent(image);
      otherwise
          error('Possible color space options are grey, RGB, rgb, and opponent.');
  end
end