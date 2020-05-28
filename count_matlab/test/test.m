close all
clear all

%% Global parameters

addpath('functions')

%% Read image from a directory
img_path = get_img_path();

[info, num_images, tiff_stack, Im] = read_tiff_stack(img_path);

figure
imshow(tiff_stack)

%% RGB to gray image
img = rgb2gray(tiff_stack);
figure
imshow(img)

figure
se = strel('disk',20);
Io = imopen(img,se);
subplot(2,2,1);
imshow(Io)
title('Opening')

subplot(2,2,2);
Ie = imerode(img,se);
Iobr = imreconstruct(Ie,img);
imshow(Iobr)
title('Opening-by-Reconstruction')

subplot(2,2,3);
Ioc = imclose(Io,se);
imshow(Ioc)
title('Opening-Closing')

subplot(2,2,4);
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
imshow(Iobrcbr)
title('Opening-Closing by Reconstruction')

%%
img_filtered = imgaussfilt(Iobrcbr,4);
bw = imbinarize(img_filtered);
se = strel('disk',50);
bw = imclose(bw,se);

figure
imshow(imcomplement(bw))
title('Thresholded Opening-Closing by Reconstruction')

figure
L = watershed(imcomplement(bw));
imshow(label2rgb(L,'jet','w')) % Segmented image D (above)