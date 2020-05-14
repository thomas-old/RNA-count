function [L,N] = plot_cc(BW, image)
%PLOT_CC Summary of this function goes here
%   Detailed explanation goes here

figure
imshowpair(BW,image,'montage')

[~,L,N,~] = bwboundaries(BW);
stats = regionprops(BW,'all');
centroids = cat(1, stats.Centroid);
for k = 1 : N
    H= text(centroids(k,1), centroids(k,2),[num2str(k)]);
    set(H,'Color',[1 0 0], 'FontSize', 13)
end

hold off
end

