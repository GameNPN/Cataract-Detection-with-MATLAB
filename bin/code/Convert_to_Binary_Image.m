clc
clear all
close all

resized_dir = 'Dataset/resized_train';
bw_dir = 'Dataset/binary_img';

if ~exist(bw_dir, 'dir')
    mkdir(bw_dir);
end

resized_files = dir(fullfile(resized_dir, '*.png'));
for i = 1:length(resized_files) % Correct the loop range
    img_path = fullfile(resized_files(i).folder, resized_files(i).name);
    img = imread(img_path);
    img_gray = rgb2gray(img);
    img_bw = imbinarize(img_gray);
    [~, img_name, img_ext] = fileparts(resized_files(i).name); % Extract image name and extension
    imwrite(img_bw, fullfile(bw_dir, [img_name, img_ext])); % Use img_name and img_ext instead of img_name which is not defined
end
