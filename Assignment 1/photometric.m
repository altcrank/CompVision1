function photometric
    %load images
    files = dir('sphere*');
    images = {};
    for file = files'
        images = [images, double(imread(file.name))];
    end

    %Hardcode V = kS
    %It is important that the light source vectors have the same magnitude
    k = 300;
    Ss = [0,0,1;
        sqrt(1/3),sqrt(1/3),sqrt(1/3);
        -sqrt(1/3),sqrt(1/3),sqrt(1/3);
        sqrt(1/3),-sqrt(1/3),sqrt(1/3);
        -sqrt(1/3),-sqrt(1/3),sqrt(1/3)];
    V = k * Ss;
    
    %Initialize the albedos and normals matrices
    s = size(images{1});
    albedos = zeros(s);
    normals = zeros(s(1), s(2), 3);
    
    for i = 1:s(1)
        for j = 1:s(2)
            pixel_vector = [];
            for k = 1:length(images)
                pixel_vector = [pixel_vector, images{k}(i,j)];
            end
            % A 0*g=0 equation is not well defined and slows the
            % computations
            if ~any(pixel_vector)
                albedos(i,j) = 0;
                normals(i,j,:) = [0,0,0];
                continue
            end
            pixel_matrix = diag(pixel_vector);
            g = (pixel_matrix * V) \ (pixel_matrix * pixel_vector');
            albedos(i,j) = norm(g);
            normals(i,j,:) = g'./albedos(i,j);
        end
    end

    % Compute derivatives
    ps = - normals(:,:,1) ./ normals(:,:,3);
    qs = - normals(:,:,2) ./ normals(:,:,3);
    % Get rid of NaNs due to division by zero
    ps(ps~=ps) = 0;
    qs(qs~=qs) = 0;
    %Smooth a little bit. In a way, make sure the integrability test holds
    ps(ps>1)=1;
    ps(ps<-1)=-1;
    qs(qs>1)=1;
    qs(qs<-1)=-1;

    %Instantiate the height_map
    height_map = zeros(s);

    % Propagating the y derivatives only in the first column doesn't really
    % make sense. I believe they should be propagated everywhere.
%    for j = 1:s(2)
%         for i = 2:s(1)
%             height_map(i,j) = height_map(i-1,j) + qs(i,j);
%         end
%     end
%     for i = 1:s(1)
%         for j = 2:s(2)
%             height_map(i,j) = height_map(i,j-1) + ps(i,j);
%         end
%     end

    % Propagating both derivatives this way lead to the smoothest results
    for i = 2:s(1)
        height_map(i,1) = height_map(i-1,1) + qs(i,1);
        height_map(1,i) = height_map(1,i-1) + ps(1,i);
    end
    for j = 2:s(1)
        for i = 2:s(2)
            height_map(i,j) = (height_map(i-1,j) + ps(i,j))/2 + ...
                              (height_map(i,j-1) + qs(i,j))/2;
        end
    end

    % Plot the surface normals (subsample so it's faster and prettier)
    quiver3(1:8:512,1:8:512,height_map(1:8:end,1:8:end),normals(1:8:end,1:8:end,1),normals(1:8:end,1:8:end,2),normals(1:8:end,1:8:end,3))
    hold on;
    % Plot the height map (subsample so it's faster and prettier)
    mesh(1:8:512,1:8:512,height_map(1:8:end,1:8:end))
    hold off;
    %imshow(albedos, [])
end