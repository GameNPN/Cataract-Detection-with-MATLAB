f = dir('Dataset/train/cataract2/*.jpg');
fil = {f.name};  

changenamefile_dir = 'Dataset/changenamefile';
% สร้างไดเร็กทอรีสำหรับรูปภาพที่ปรับขนาดแล้ว
if ~exist(changenamefile_dir, 'dir')
    mkdir(changenamefile_dir);
end

for k = 1:numel(fil)
    file = fil{k};
    
    % ตรวจสอบว่าไฟล์ .jpg ที่กำลังจะอ่านมีอยู่จริงหรือไม่
    if exist(fullfile('Dataset/train/cataract2', file), 'file')
        new_file = strrep(file, '.jpg', '.png');
        im = imread(fullfile('Dataset/train/cataract2', file));
        % ตรวจสอบว่าการอ่านไฟล์รูปภาพสำเร็จหรือไม่
        if ~isempty(im)
            imwrite(im, fullfile(changenamefile_dir, new_file));
        else
            disp(['Error reading image: ', file]);
        end
    else
        disp(['File not found: ', file]);
    end
end
