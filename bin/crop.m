resized_dir = 'Dataset/resized_train';
template_crop = 'Dataset/processed_images4';
crop_img = 'Dataset/crop_img';

% หาชื่อไฟล์ทั้งหมดใน resized_dir
files_resized = dir(fullfile(resized_dir, '*.png'));

% หาชื่อไฟล์ทั้งหมดใน template_crop
files_template = dir(fullfile(template_crop, '*.png'));

% ลูปเข้าไปในแต่ละไฟล์ของ resized_dir
for i = 1:length(files_resized)
    % ชื่อไฟล์ที่กำลังพิจารณา
    filename = files_resized(i).name;
    
    % ตรวจสอบว่ามีไฟล์ในทั้งสองโฟลเดอร์หรือไม่
    if ~any(strcmp({files_template.name}, filename))
        % ข้ามไปทำงานกับไฟล์ถัดไป
        continue;
    end
    
    % อ่านรูปภาพจาก resized_dir
    img = imread(fullfile(resized_dir, filename));
    
    % แปลงรูปภาพเป็น binary image
    binary_img = im2bw(img);
    
    % อ่าน template จาก template_crop
    template = imread(fullfile(template_crop, filename));
    
    % ค้นหาตำแหน่งของภาพที่มีสีดำใน template_crop
    black_pixels = template == 0;
    
    % ครอปภาพ binary_img ตามตำแหน่งที่เก็บมาจาก template_crop
    cropped_img = binary_img;
    cropped_img(~black_pixels) = 0;
    
    % บันทึกรูปภาพที่ทับ template เข้าไปใน crop_img
    imwrite(cropped_img, fullfile(crop_img, filename));
end

