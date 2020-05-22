close all
clear all

% https://blogs.mathworks.com/steve/2006/06/02/cell-segmentation/

%% Global parameters

addpath('functions')

%% Read image from a directory
img_path = get_img_path();

[info, num_images, tiff_stack, Im, Im_original] = read_tiff_stack(img_path);

%% RGB to gray image
% img = rgb2gray(tiff_stack);

img = imadd(Im_original{2}, Im_original{3});
img = Im_original{2};
img = imadjust(img);

figure
imshow(img)

se = strel('disk',50);
Io = imopen(img,se);
Ie = imerode(img,se);
Iobr = imreconstruct(Ie,img);
Ioc = imclose(Io,se);

Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

figure; imshow(Iobrcbr);
%%
img_filtered = imgaussfilt(Iobrcbr,6);
bw = imbinarize(img_filtered);

% figure; imshow(bw);
% title('Thresholded Opening-Closing by Reconstruction')

se = strel('disk',30);
bw3 = imclose(bw, se);
% figure; imshow(bw3)

bw4 = imfill(bw3,'holes');
% figure; imshow(bw4)

bw4_perim = bwperim(bw4);
overlay1 = imoverlay(img, bw4_perim, [.3 1 .3]);
figure; imshow(overlay1)

%%
nuclei_img = imgaussfilt(imadjust(Im{1}),4);
mask_em = imbinarize(nuclei_img);
overlay2 = imoverlay(Iobrcbr, bw4_perim | mask_em, [.3 1 .3]);
figure; imshow(overlay2)

%%
I_eq_c = imcomplement(img_filtered);
I_mod = imimposemin(I_eq_c, ~bw4 | mask_em);
L = watershed(I_mod);
plot_seg(L, img);
