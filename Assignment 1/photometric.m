function photometric
    %load images
    files = dir('sphere*');
    images = {};
    for file = files'
        images = [images, double(imread(file.name))];
    end

    for i = 1:length(images)
        %im = images{i}
        %disp(size(images{i}))
    end

    %Determine V = kS from source and camera info
    k = 10000;
    Ss = [0,0,1;
        sqrt(1/3),sqrt(1/3),sqrt(1/3);
        -sqrt(1/3),sqrt(1/3),sqrt(1/3);
        sqrt(1/3),-sqrt(1/3),sqrt(1/3);
        -sqrt(1/3),-sqrt(1/3),sqrt(1/3)];
    V = k * Ss;

    s = size(images{1});
    albedos = zeros(s(1), s(2));
    normals = zeros(s(1), s(2), 3);
    % ps = zeros(s(1), s(2));
    % qs = zeros(s(1), s(2));

    for i = 1:s(1)
        for j = 1:s(2)
            ii = [];
            for k = 1:length(images)
                ii = [ii, images{k}(i,j)];
            end
            if ~any(ii)
                albedos(i,j) = 0;
                normals(i,j,:) = [0,0,0];
                continue
            end
            II = diag(ii);
            g = (II * V) \ (II * ii');
            albedos(i,j) = norm(g);
            normals(i,j,:) = g'./albedos(i,j);
        end
    end

    ps = - normals(:,:,1) ./ normals(:,:,3);
    qs = - normals(:,:,2) ./ normals(:,:,3);
    ps(ps~=ps) = 0;
    qs(qs~=qs) = 0;
    ps(ps>1)=1;
    ps(ps<-1)=-1;
    qs(qs>1)=1;
    qs(qs<-1)=-1;

    height_map = zeros(s(1), s(2));

    % for j = 1:s(2)
    %     for i = 2:s(1)
    %         height_map(i,j) = height_map(i-1,j) + qs(i,j);
    %     end
    % end
    % for i = 1:s(1)
    %     for j = 2:s(2)
    %         height_map(i,j) = height_map(i,j-1) + ps(i,j);
    %     end
    % end

    for j = 2:s(1)
        for i = 2:s(2)
            height_map(i,j) = (height_map(i-1,j) + qs(i,j))/2 + ...
                              (height_map(i,j-1) + ps(i,j))/2;
        end
    end

    %quiver3(1:16:512,1:16:512,-height_map(1:16:end,1:16:end),normals(1:16:end,1:16:end,1),normals(1:16:end,1:16:end,2),normals(1:16:end,1:16:end,3))
    quiver3(1:8:512,1:8:512,height_map(1:8:end,1:8:end),normals(1:8:end,1:8:end,1),normals(1:8:end,1:8:end,2),normals(1:8:end,1:8:end,3))
    hold on;
    %mesh(1:16:512,1:16:512,-height_map(1:16:end,1:16:end))
    mesh(1:8:512,1:8:512,height_map(1:8:end,1:8:end))
    hold off;
end