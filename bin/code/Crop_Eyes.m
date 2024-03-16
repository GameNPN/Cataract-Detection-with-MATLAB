clc
clear all
close all

bw_dir = 'Dataset/binary_img';
crop_dir = 'Dataset/crop_img';

bw_files = dir(fullfile(bw_dir, '*.png'));
for i = 1:length(bw_files)
    img_name = bw_files(i).name;
    img_path = fullfile(bw_dir, img_name);
    template_path = fullfile('Dataset/Template_crop_image', img_name);
    
    if ~isfile(template_path) % ตรวจสอบว่าไฟล์ template มีหรือไม่
        fprintf('No corresponding template found for image: %s\n', img_name);
        continue; % ข้ามไปยังภาพถัดไป
    end
    
    img = imread(img_path);
    grayImage = 255 * uint8(img);
    template = imread(template_path);
    [m, n, ~] = size(grayImage);
    x = grayImage;

    for k = 1:m
        for l = 1:n
            if template(k, l) == 0 
                x(k, l,:) = grayImage(k, l,:);
            else
                x(k, l,:) = 127;
            end
        end
    end
    T = mat2gray(x);
    imwrite(T, fullfile(crop_dir, img_name));
end
