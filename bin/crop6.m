resized_dir = 'Dataset/resized_train';
template_crop_dir = 'Dataset/processed_images4';
crop_dir = 'Dataset/crop_img';

% 1. แปลงภาพทั้งหมดใน resized_dir เป็น grayscale
resized_files = dir(fullfile(resized_dir, '*.png'));
for i = 1:length(resized_files)
    img_path = fullfile(resized_files(i).folder, resized_files(i).name);
    img = imread(img_path);
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img; % ไม่ได้เป็นภาพ RGB จึงไม่ต้องแปลงเป็น grayscale
    end
    imwrite(img_gray, img_path); % เขียนภาพ grayscale ทับที่ภาพเดิม
end

% 2. เอาภาพใน resized_dir ทับด้วย template_crop_dir
for i = 1:length(resized_files)
    img_name = resized_files(i).name;
    template_path = fullfile(template_crop_dir, img_name);
    if exist(template_path, 'file')
        % 3. นำภาพที่ทับกันได้ เก็บตำแหน่งที่เป็นสีดำของภาพ template_crop_dir ที่เอามาทับกัน
        img_resized = imread(fullfile(resized_files(i).folder, img_name));
        img_template = imread(template_path);
        black_pixels = img_template == 0;
        
        % 4. สร้างภาพใหม่ที่เป็น gray image มีค่าสีทุก pixel =127
        img_new = 127 * ones(size(img_resized), 'uint8');
        
        % 5. ตัดเฉพาะภาพ resized_dir บริเวณตำแหน่งสีดำที่เก็บมาลงในภาพในใหม่
        img_new(black_pixels) = img_resized(black_pixels);
        
        % 6. บันทึกภาพใหม่ที่ได้ลงใน crop_dir
        imwrite(img_new, fullfile(crop_dir, img_name));
        
        % เพิ่มตามคำขอ
        % 7. ทับภาพ img_new กับ template โดยที่ชื่อต้องเหมือนกัน
        img_new_template = img_new;
        img_new_template(black_pixels) = img_template(black_pixels);
        
        % 8. บันทึกภาพใหม่ที่ได้ลงใน crop_dir
        imwrite(img_new_template, fullfile(crop_dir, img_name));
    end
end
