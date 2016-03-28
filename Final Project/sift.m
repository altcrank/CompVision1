function [frames,descr] = sift(image,type,step)
% sift extract SIFT features
% image - an RGB image to extract SIFT features from
% type - determines whether the features to be greyscale, RGB, rgb or opponent
% step - if 0 - sparse features, else dense with step size 'step'

    % Guard from color spaces and original grey image
    if ~strcmp(type,'grey') && (length(image(1,1,:)) ~= 3)
        frames = [];
        descr = [];
        return
    end
    % Trasform image to appropriate channels
    working_image = RGB2(type,image);
    channels_count = length(working_image(1,1,:));
    % For sparse SIFT extract frames from greyscale
    if ~step
        grey = RGB2('grey',image);
        frames = vl_sift(single(grey));
        % Sort frames in order of increasing scale
        % Otherwise vl_sift will mess up the order
        frames = sortrows(frames',3)';
    end
    % Extract features from every channel
    for channel = 1:channels_count
        if step
            [frames,ch_descr(:,:,channel)] = vl_dsift(single(working_image(:,:,channel)),'step',step);
        else
            [~,ch_descr(:,:,channel)] = vl_sift(single(working_image(:,:,channel)),'frames',frames);
        end
    end
    % Combine same frame descriptors
    if channels_count == 1
        descr = squeeze(ch_descr(:,:,1));
    else
        for feature = 1:size(ch_descr,2)
            descr(:,feature) = [ch_descr(:,feature,1);ch_descr(:,feature,2);ch_descr(:,feature,3)];
        end
    end
end