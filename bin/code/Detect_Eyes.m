clc
clear all
close all

% กำหนดไดเร็กทอรีที่มีรูปภาพ
resized_dir = 'Dataset/resized_train';
Detect_Eyes_dir = 'Dataset/Detect_Eyes_image';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ประมวลผลหากไม่มีอยู่
if ~exist(Detect_Eyes_dir, 'dir')
    mkdir(Detect_Eyes_dir);
end

% แสดงรายการไฟล์รูปภาพทั้งหมดในไดเร็กทอรีที่ปรับขนาด
resized_files = dir(fullfile(resized_dir, '*.png'));

% วนซ้ำรูปภาพที่ปรับขนาดแล้ว
for i = 1:numel(resized_files)
    % โหลดภาพ
    filename = fullfile(resized_dir, resized_files(i).name);
    img = imread(filename);
    
    % แปลงภาพให้เป็นโทนสีเทา
    gray = rgb2gray(img);
    
    % แปลงภาพระดับสีเทาเป็นblack and white
    binary_image = imbinarize(gray);
    
    % ทำการตรวจจับขอบโดยใช้อัลกอริธึม Canny
    edges = edge(binary_image, 'canny');
    
    % ค้นหาวงกลมในภาพที่ตรวจพบขอบ
    [centers, radii, metric] = imfindcircles(edges, [10 200], 'ObjectPolarity', 'dark');
    
    % เลือกวงกลมที่มีหน่วยเมตริกสูงสุดเป็นม่านตา
    [~, index] = max(metric);
    iris_center = centers(index, :);
    iris_radius = radii(index);
    
    % วาดม่านตาที่ตรวจพบบนภาพต้นฉบับ
    figure
    imshow(binary_image) % แสดงภาพไบนารี
    hold on
    viscircles(iris_center, iris_radius, 'Color', 'b');
    hold off
    
    % บันทึกภาพที่ปรับขนาดแล้วลงในโฟลเดอร์ processed_dir
    [~, name, ~] = fileparts(resized_files(i).name);
    save_name = fullfile(Detect_Eyes_dir, [name, '_Detect_Eyes.png']);
    saveas(gcf, save_name);
    close(gcf);
end
