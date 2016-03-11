function H = compute_transform(frames1,frames2,matches)
    for match = 1:size(matches,2)
        f = frames1(:,matches(1,match));
        A(2*match-1,:) = [f(1) f(2) 0 0 1 0];
        A(2*match,:) = [0 0 f(1) f(2) 0 1];
        f = frames2(:,matches(2,match));
        b(2*match-1,1) = f(1);
        b(2*match,1) = f(2);
    end
    x = pinv(A' * A) * A' * b;
    H(1,:) = [x(1) x(2) x(5)];
    H(2,:) = [x(3) x(4) x(6)];
end