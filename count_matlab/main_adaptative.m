close all
clear all

% https://blogs.mathworks.com/steve/2006/06/02/cell-segmentation/

%% Global parameters

addpath('functions')

%% Read image from a directory
img_path = get_img_path();

[info, num_images, tiff_stack, Im, Im_original] = read_tiff_stack(img_path);

% Show gray images from the stack
for n=1:num_images
    subplot(1,num_images,n);
    imshow(Im{n});
    title(["Channel: ",num2str(n)]);
end

%% Specify the channel to segment
segmentation_ch = 2;
nuclei_ch = 1;

%% Image processing

img = Im_original{segmentation_ch};
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

%% Image segmentation
img_filtered = imgaussfilt(Iobrcbr,6);
bw = imbinarize(img_filtered);

se = strel('disk',30);
bw3 = imclose(bw, se);

bw4 = imfill(bw3,'holes');

bw4_perim = bwperim(bw4);
overlay1 = imoverlay(img, bw4_perim, [.3 1 .3]);
figure; imshow(overlay1)

%% Get markers using nuclei channel 
nuclei_img = imgaussfilt(imadjust(Im{nuclei_ch}),4);
mask_em = imbinarize(nuclei_img);
overlay2 = imoverlay(Iobrcbr, bw4_perim | mask_em, [.3 1 .3]);

%% Watershed segmentation with markers
I_eq_c = imcomplement(img_filtered);
I_mod = imimposemin(I_eq_c, ~bw4 | mask_em);
L = watershed(I_mod);
plot_seg(L, img);

L(L==1) = 0;

%% Read image from a directory
spot_count_channel = 2;

% Laplacian of Guassian filter on the image
img_d = double(Im{spot_count_channel});
img_filtered = LOG_filter(img_d);
% Normalize img2
img_filtered = img_filtered/max(img_filtered(:));

figure; imshow(img_filtered);
%% Plot histogram of the image for threshold intensity selection
tune_spot_counting = true;

if tune_spot_counting ~= 0
plot_spot_threshold(img_filtered)
end

%% RNA Count for each segmented region
threshold = 0.3;
[count, stats] = count_segmentation(L, img, threshold, 0.3); 