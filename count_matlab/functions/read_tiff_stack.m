function [info, num_images, tiff_stack, Im, Im_original] = read_tiff_stack(img_path)
%READ_TIFF_STACK read tiff file and return the stacked image
% img_path = path of the image
% info = info of the tiff file 
% num_images = number of channel in the image
% tiff_stack = stacked image of all the channel
% Im = array of the images in each channel. Size of array is equal to num_images

info = imfinfo(img_path);
num_images = numel(info);
A = imread(img_path, 1, 'Info', info);

tiff_stack = imadjust(A);
Im{1} = tiff_stack;
Im_original{1} = A;
for k = 2:num_images
    A = imread(img_path, k, 'Info', info);
    img_adjusted = imadjust(A);
    tiff_stack = cat(3, tiff_stack, img_adjusted);
    Im{k} = img_adjusted;
    Im_original{k} = A;
end

end

