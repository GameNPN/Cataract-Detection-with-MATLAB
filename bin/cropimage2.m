resized_dir = 'Dataset/resized_train';
template_crop_dir = 'Dataset/processed_images4';
crop_dir = 'Dataset/crop_img';

% คำสั่งที่ 1: แปลงภาพทั้งหมดใน resized_dir เป็น grayscale
resized_files = dir(fullfile(resized_dir, '*.png'));
for i = 1:numel(resized_files)
    img = imread(fullfile(resized_dir, resized_files(i).name));
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    imwrite(img_gray, fullfile(resized_dir, resized_files(i).name));
end

% คำสั่งที่ 2-4: เปรียบเทียบและประมวลผลภาพที่ต้องการ
template_files = dir(fullfile(template_crop_dir, '*.png'));
for i = 1:numel(template_files)
    template_img = imread(fullfile(template_crop_dir, template_files(i).name));
    resized_img_path = fullfile(resized_dir, template_files(i).name);
    if exist(resized_img_path, 'file')
        resized_img = imread(resized_img_path);
        if size(resized_img, 3) == 3
            resized_img_gray = rgb2gray(resized_img);
        else
            resized_img_gray = resized_img;
        end
        
        % หาตำแหน่งที่เป็นสีดำของภาพ template ที่ต้องทับกัน
        black_pixels = template_img == 0;
        
        % สร้างภาพใหม่ที่เป็นสีทุก pixel = 127 ที่ขนาดเท่ากับภาพที่นำมา
        new_img = ones(size(resized_img_gray)) * 127;
        
        % คำสั่งที่ 5: ตัดเฉพาะภาพ resized_dir บริเวณตำแหน่งสีดำที่เก็บมา
        new_img(black_pixels) = resized_img_gray(black_pixels);
        
        % คำสั่งที่ 6: บันทึกภาพใหม่ที่ได้ลงใน crop_dir
        imwrite(new_img, fullfile(crop_dir, template_files(i).name));
    end
end
