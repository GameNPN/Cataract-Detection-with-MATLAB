clc
clear all
close all

% กำหนดไดเร็กทอรีที่มีรูปภาพ
cataract_dir = 'Dataset/train/cataract1';
normal_dir = 'Dataset/train/normal';
resized_dir = 'Dataset/resized_train';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ปรับขนาดแล้ว
if ~exist(resized_dir, 'dir')
    mkdir(resized_dir);
end

% ปรับขนาดและบันทึกภาพจากโฟลเดอร์ต้อกระจก
%cataract_files = dir(fullfile(cataract_dir,'*.png'));
%for i = 1:numel(cataract_files)
    %original_image = imread(fullfile(cataract_dir, cataract_files(i).name));   
    % resized_image = imresize(original_image, [130, 130]);  
% บันทึกภาพที่ปรับขนาดแล้วลงในโฟลเดอร์ resized_train
%[~, name, ext] = fileparts(cataract_files(i).name);
%split_name = strsplit(name, '_');
%image_number = split_name{end}; % ดึงเลขรูปภาพออกมา

%imwrite(resized_image, fullfile(resized_dir, ['cataract_', image_number, ext]));

%end

% ปรับขนาดและบันทึกภาพจากโฟลเดอร์ปกติ
normal_files = dir(fullfile(normal_dir, '*.png'));
for i = 1:numel(normal_files)
   % อ่านภาพต้นฉบับระดับสีเทา
    original_image = imread(fullfile(normal_dir, normal_files(i).name));
    
    % ปรับขนาดรูปภาพเป็น 130x130 พิกเซลโดยยังคงอัตราส่วนไว้
    resized_image = imresize(original_image, [130, 130]);
    
   % บันทึกภาพที่ปรับขนาดแล้วลงในโฟลเดอร์ resized_train
[~, name, ext] = fileparts(normal_files(i).name);
split_name = strsplit(name, '_');
image_number = split_name{end}; % ดึงเลขรูปภาพออกมา

imwrite(resized_image, fullfile(resized_dir, ['normal_', image_number, ext]));
end
