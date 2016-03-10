function ready = prepare(transform)
    ready(1:2,1:2) = transform(1:2,1:2)';
    ready(:,3) = flipud(transform(:,3));
end