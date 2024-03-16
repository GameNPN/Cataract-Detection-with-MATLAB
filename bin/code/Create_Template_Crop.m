clc
clear all
close all

% กำหนดไดเร็กทอรีที่มีรูปภาพ
resized_dir = 'Dataset/resized_train';
template_dir = 'Dataset/Template_crop_image';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ประมวลผลหากไม่มีอยู่
if ~exist(template_dir, 'dir')
    mkdir(template_dir);
end

% แสดงรายการไฟล์รูปภาพทั้งหมดในไดเร็กทอรีที่ปรับขนาด
resized_files = dir(fullfile(resized_dir, '*.png'));

% วนซ้ำรูปภาพที่ปรับขนาดแล้ว
for i = 1:numel(resized_files)
    % โหลดภาพ
    filename = fullfile(resized_dir, resized_files(i).name);
    img = imread(filename);
    
    % แปลงภาพให้เป็นโทนส์เทา
    gray = rgb2gray(img);
    
    % แปลงภาพระดับสีเทาเป็นblack and white
    binary_image = imbinarize(gray);
    
    % ทำการตรวจจับขอบโดยใช้อัลกอริธึม Canny
    edges = edge(binary_image, 'canny');
    
    % ค้นหาวงกลมในภาพที่ตรวจพบขอบ
    [centers, radii, metric] = imfindcircles(edges, [10 200], 'ObjectPolarity', 'dark');
    
    % ตรวจสอบว่ามีวงกลมถูกพบจริงหรือไม่
    if ~isempty(centers)
        % เลือกวงกลมที่มีหน่วยเมตริกสูงสุดเป็นม่านตา
        [~, index] = max(metric);
        iris_center = centers(index, :);
        iris_radius = radii(index);
        
% คำนวณระยะทางจากจุดกึ่งกลางของภาพ
[X, Y] = meshgrid(1:size(img, 2), 1:size(img, 1));
distance_from_center = sqrt((X - iris_center(1)).^2 + (Y - iris_center(2)).^2);

% สร้างภาพใหม่ที่มีขนาดเท่ากับภาพต้นฉบับและเติมสีขาว
new_image = ones(size(img, 1), size(img, 2));

% กำหนดสีของพิกเซลภายในวงกลมให้เป็นสีดำ
new_image(distance_from_center <= iris_radius) = 0;

% บันทึกภาพที่ปรับขนาดแล้วลงในโฟลเดอร์ processed_dir
[~, name, ext] = fileparts(resized_files(i).name);
save_name = fullfile(template_dir, [name, ext]); % ใช้ชื่อเดิมและนามสกุลเดิมของภาพต้นฉบับ
imwrite(new_image, save_name);

    else
        disp(['No circle detected in ', filename]);
    end
end

