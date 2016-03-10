function inverted = invert(transform)
    transform = prepare(transform);
    inverted(1:2,1:2) = inv(transform(1:2,1:2));
    inverted(:,3) = - inverted(1:2,1:2) * transform(:,3);
    inverted = prepare(inverted);
end