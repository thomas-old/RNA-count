close all
clear all
%% Read image from a directory 
[file,path] = uigetfile('*.tif');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

% Read the image
img_o = imread(append(path,file));
img = rgb2gray(img_o);
img2 = imadjust(img);

% Laplacian of Guassian filter on the image
img2 = imgaussfilt(img2,4);

%% Thresholding
figure
imhist(img2)

[x,y] = getpts;
line([x x],[0 4000]);

for n=1:length(x)
[L,BW] = mask(x(n), img2, 15, 10);

figure
I4 = labeloverlay(img,BW);
imshowpair(I4,img_o,'montage')
title(['Segmentation with threshold of ',num2str(x(n))])
end
pause;
