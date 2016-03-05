function frame = select_frame(images,no,rgb)
    % Select frame
    if rgb
        frame = images(no,:,:,:);
    else
        frame = images(no,:,:);
    end
    % Convert from [1 n m] to [n m]
    frame = squeeze(frame);
end