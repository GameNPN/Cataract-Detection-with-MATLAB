% กำหนดไดเร็กทอรีที่มีรูปภาพ
crop_dir = 'Dataset/crop_img';

% ดึงรายชื่อของไฟล์ทั้งหมดใน crop_dir
files_crop = dir(fullfile(crop_dir, '*.png'));

% สร้างตัวแปรเพื่อเก็บผลลัพธ์
total_black_pixels = zeros(length(files_crop), 1);
total_white_pixels = zeros(length(files_crop), 1);

% ลูปเข้าไปในแต่ละภาพใน crop_dir
for i = 1:length(files_crop)
    % อ่านภาพ
    img = imread(fullfile(crop_dir, files_crop(i).name));
    
    % แปลงภาพเป็น grayscale
    img_gray = rgb2gray(img);
    
    % นับจำนวนพิกเซลที่มีค่าสีเป็น 0 (สีดำ) และ 255 (สีขาว)
    total_black_pixels(i) = sum(img_gray(:) == 0);
    total_white_pixels(i) = sum(img_gray(:) == 255); % สมมติว่าสีขาวมีค่าเป็น 255
    
    % หาค่าสัดส่วนของพิกเซลสีดำต่อทั้งหมด
    black_percentage = total_black_pixels(i) / numel(img_gray);
    
    % หาค่าสัดส่วนของพิกเซลสีขาวต่อทั้งหมด
    white_percentage = total_white_pixels(i) / numel(img_gray);
    
    % ถ้าจำนวนพิกเซลสีดำมากกว่า จำนวนพิกเซลสีขาว
    if black_percentage > white_percentage
        % แสดงภาพนี้ออกมา
        imshow(img);
        title('Normal'); % ตั้งชื่อภาพว่า Normal
        drawnow;
    end
end
