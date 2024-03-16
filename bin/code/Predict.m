clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;

crop_dir = 'Dataset/crop_img';
result_dir = 'Dataset/result_img';

if ~exist(result_dir, 'dir')
    mkdir(result_dir);
end


    pre_true = 0;
    pre_false = 0;
    
files_crop = dir(fullfile(crop_dir, '*.png'));
% ลูปเข้าไปในแต่ละภาพใน crop_dir
for i = 1:length(files_crop)
    % อ่านภาพ
    img = imread(fullfile(crop_dir, files_crop(i).name));
    
    % นับจำนวนพิกเซลที่มีค่าสีเป็น 0 (สีดำ) และ 255 (สีขาว)
    total_black_pixels(i) = sum(img(:) == 0);
    total_white_pixels(i) = sum(img(:) == 255); % สมมติว่าสีขาวมีค่าเป็น 255
    
    % กำหนด title ของภาพ

    if total_black_pixels(i) > total_white_pixels(i)
        title_text = 'Normal';
        pre_false = pre_false + 1;
    else
        title_text = 'Cataract';
        pre_true = pre_true + 1;
    end
    
    % เพิ่มชื่อไฟล์ลงในภาพ
    filename_text = files_crop(i).name;
    
    % เพิ่ม title_text หลังชื่อไฟล์
    filename_text_with_title = [filename_text, '_', title_text, '.png']; % ระบุส่วนขยายของไฟล์เป็น '.png'
    
    % บันทึกภาพที่ปรับขนาดแล้วลงใน result_dir
    imwrite(img, fullfile(result_dir, filename_text_with_title));
    
    % แสดงผลลัพธ์
    fprintf('Image: %s\n', files_crop(i).name);
    fprintf('Number of black pixels: %d\n', total_black_pixels(i));
    fprintf('Number of white pixels: %d\n', total_white_pixels(i));
    fprintf('Title: %s\n', title_text);
    fprintf('Filename with title: %s\n', filename_text_with_title);
end
fprintf('True is %d image\n',pre_true);
fprintf('Flase is %d image\n',pre_false);
