% กำหนดไดเร็กทอรีที่มีรูปภาพ
resized_dir = 'Dataset/resized_train';
processed_dir = 'Dataset/processed_images2';

% สร้างไดเร็กทอรีสำหรับรูปภาพที่ประมวลผลหากไม่มีอยู่
if ~exist(processed_dir, 'dir')
    mkdir(processed_dir);
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
    
    % ตรวจสอบว่ามีวงกลมที่ตรวจพบหรือไม่
    if ~isempty(centers)
        % เลือกวงกลมที่มีหน่วยเมตริกสูงสุดเป็นม่านตา
        [~, index] = max(metric);
        iris_center = centers(index, :);
        iris_radius = radii(index);
        
        % ตั้งค่าพารามิเตอร์สำหรับการตัดภาพ
        x = round(iris_center(1) - iris_radius);
        y = round(iris_center(2) - iris_radius);
        width = round(2 * iris_radius);
        height = round(2 * iris_radius);
        
        % ตรวจสอบว่าข้อมูลตัวเลขไม่เป็น NaN หรือไม่
        if ~any(isnan([x, y, width, height]))
            % ตัดภาพเอาส่วนในวงกลมสีฟ้าเท่านั้น
            cropped_img = imcrop(binary_image, [x, y, width, height]);
            
            % แสดงภาพที่ตัดแล้ว
            figure
            imshow(cropped_img);
            
            % บันทึกภาพที่ปรับขนาดและตัดแล้วลงในโฟลเดอร์ processed_dir
            [~, name, ~] = fileparts(resized_files(i).name);
            save_name = fullfile(processed_dir, [name, '_processed.png']);
            imwrite(cropped_img, save_name);
            
            close(gcf);
        else
            disp('Invalid parameters for cropping.');
        end
    else
        disp('No circle detected.');
    end
end

