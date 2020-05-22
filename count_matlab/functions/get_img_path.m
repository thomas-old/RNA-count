function [img_path] = get_img_path()
%GET_IMG_PATH Summary of this function goes here
%   Detailed explanation goes here
[file,path] = uigetfile('*');
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
end

% Concatenate the image 
img_path = strcat(path,file);

end

