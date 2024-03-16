% กำหนดไดเร็กทอรีที่มีรูปภาพ
cataract_dir = 'Dataset/train/cataract2';
normal_dir = 'Dataset/train/normal';
resized_dir = 'Dataset/resized_train';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ปรับขนาดแล้ว
if ~exist(resized_dir, 'dir')
    mkdir(resized_dir);
end

% ปรับขนาดและบันทึกภาพจากโฟลเดอร์ต้อกระจก
cataract_files_png = dir(fullfile(cataract_dir, '*.png')); % เลือกไฟล์ .png
cataract_files_jpg = dir(fullfile(cataract_dir, '*.jpg')); % เลือกไฟล์ .jpg
cataract_files = [cataract_files_png; cataract_files_jpg]; % รวมไฟล์ .png และ .jpg เข้าด้วยกัน
for i = 1:numel(cataract_files)
    % เช็คนามสกุลไฟล์
    [~,~,ext] = fileparts(cataract_files(i).name);
    if ~(strcmpi(ext, '.png') || strcmpi(ext, '.jpg'))
        continue; % ข้ามไฟล์ที่ไม่ใช่ .png หรือ .jpg
    end
    % อ่านภาพต้นฉบับระดับสีเทา
    original_image = imread(fullfile(cataract_dir, cataract_files(i).name));
    
    % ปรับขนาดรูปภาพเป็น 130x130 พิกเซลโดยยังคงอัตราส่วนไว้
    resized_image = imresize(original_image, [130, 130]);
    
% บันทึกภาพที่ปรับขนาดแล้วลงในโฟลเดอร์ resized_train
[~, name, ext] = fileparts(cataract_files(i).name);
split_name = strsplit(name, '_');
image_number = split_name{end}; % ดึงเลขรูปภาพออกมา

imwrite(resized_image, fullfile(resized_dir, ['cataract_', image_number, ext]));

end

% ปรับขนาดและบันทึกภาพจากโฟลเดอร์ปกติ
normal_files_png = dir(fullfile(normal_dir, '*.png')); % เลือกไฟล์ .png
normal_files_jpg = dir(fullfile(normal_dir, '*.jpg')); % เลือกไฟล์ .jpg
normal_files = [normal_files_png; normal_files_jpg]; % รวมไฟล์ .png และ .jpg เข้าด้วยกัน
for i = 1:numel(normal_files)
    % เช็คนามสกุลไฟล์
    [~,~,ext] = fileparts(normal_files(i).name);
    if ~(strcmpi(ext, '.png') || strcmpi(ext, '.jpg'))
        continue; % ข้ามไฟล์ที่ไม่ใช่ .png หรือ .jpg
    end
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
