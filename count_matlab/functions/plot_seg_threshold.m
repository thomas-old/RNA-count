function plot_seg_threshold(image)
%PLOT_THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
    img_gray = rgb2gray(image);
    img_adjusted = imadjust(img_gray);

    % Laplacian of Guassian filter on the image
    img_filtered = imgaussfilt(img_adjusted,4);

    figure
    imhist(image)
    
    [x,~] = getpts;
    line([x x],[0 4000]);
    
    for n=1:length(x)
        [~,BW] = mask(x(n), img_filtered, 15, 10);
        
        figure
        I4 = labeloverlay(image,BW);
        imshowpair(I4,image,'montage')
        title(['Segmentation with threshold of ',num2str(x(n))])
    end
end

