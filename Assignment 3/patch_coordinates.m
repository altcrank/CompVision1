function [start,ending] = patch_coordinates(center,window,edge)
    w = floor(window/2);
    start = max(1, center-w);
    ending = min(edge, center+w);
end