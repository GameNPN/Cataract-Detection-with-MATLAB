clc
clear all
close all
bw_dir = 'Dataset/bw_img';
template_crop_dir = 'Dataset/processed_images4';
test_dir = 'Dataset/test_img';

% img = imread('Dataset/resized_train/cataract_4.png');
% img = imread('Dataset/bw_img/cataract_4.png');

 for i=1:length(bw_dir)
     img_name = bw_dir(i).name;
     fprintf(img_name )
 end

