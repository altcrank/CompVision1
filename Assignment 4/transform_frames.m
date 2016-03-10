function transformed = transform_frames(frames,H)
    for point = 1:size(frames,2)
        f = frames(:,point);
        f = [f(1:2,1);1];
        transformed(:,point) = H * f;
    end
end