clear all

% กำหนดไดเร็กทอรีที่มีรูปภาพ
crop_dir = 'Dataset/crop_img';
result_dir = 'Dataset/result_img1';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ปรับขนาดแล้ว
if ~exist(result_dir, 'dir')
    mkdir(result_dir);
end

% ดึงรายชื่อของไฟล์ทั้งหมดใน crop_dir
files_crop = dir(fullfile(crop_dir, '*.png'));

% สร้างตัวแปรเพื่อเก็บผลลัพธ์
total_black_pixels = zeros(length(files_crop), 1);
total_white_pixels = zeros(length(files_crop), 1);

% ลูปเข้าไปในแต่ละภาพใน crop_dir
for i = 1:length(files_crop)
    % อ่านภาพ
    img = imread(fullfile(crop_dir, files_crop(i).name));
    
    % นับจำนวนพิกเซลที่มีค่าสีเป็น 0 (สีดำ) และ 255 (สีขาว)
    total_black_pixels(i) = sum(img_gray(:) == 0);
    total_white_pixels(i) = sum(img_gray(:) == 255); % สมมติว่าสีขาวมีค่าเป็น 255
    
    % กำหนด title ของภาพ
    if total_black_pixels(i) > total_white_pixels(i)
        title_text = 'Normal';
        
        % บันทึกภาพที่ปรับขนาดแล้วลงใน result_dir
        imwrite(img, fullfile(result_dir, files_crop(i).name));
    else
        title_text = 'Cataract';
        
        % เพิ่มข้อความในรูปภาพ
        img_with_text = insertText(img, [10 10], title_text, 'FontSize', 16, 'TextColor', 'red', 'BoxColor', 'white');
        
        % บันทึกภาพที่มีข้อความลงใน result_dir
        imwrite(img_with_text, fullfile(result_dir, files_crop(i).name));
        
        % ใช้ text function แทน insertText
        img_with_text = insertText(img, [10 10], title_text, 'FontSize', 16, 'Color', 'red');
        
        % บันทึกภาพที่มีข้อความลงใน result_dir
        imwrite(img_with_text, fullfile(result_dir, files_crop(i).name));
    end
    
    % แสดงผลลัพธ์
    fprintf('Image: %s\n', files_crop(i).name);
    fprintf('Number of black pixels: %d\n', total_black_pixels(i));
    fprintf('Number of white pixels: %d\n', total_white_pixels(i));
    fprintf('Title: %s\n', title_text);
end
