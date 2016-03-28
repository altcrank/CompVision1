function converted = RGB2(space,image)
  switch space
      case 'grey'
          converted = RGB2gray(image);
      case 'RGB'
          converted = image;
      case 'norm_rgb'
          converted = RGB2rgb(image);
      case 'opponent'
          converted = RGB2opponent(image);
      otherwise
          error('Possible color space options are grey, RGB, norm_rgb, and opponent.');
  end
end