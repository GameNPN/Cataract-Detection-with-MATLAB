bw_dir = 'Dataset/bw_img';
template_crop_dir = 'Dataset/processed_images4';
crop_dir = 'Dataset/crop_img';

bw_files = dir(fullfile(bw_dir, '*.png'));
for i = 1:length(bw_files)
    img_name = bw_files(i).name;
    template_path = fullfile(template_crop_dir, img_name);
    if exist(template_path, 'file')
        img_bw = imread(fullfile(bw_files(i).folder, img_name));
        img_template = imread(template_path);
        img_new = 127 * ones(size(img_bw), 'uint8');
        for j = 1:numel(img_template) 
            if img_template(j) == 0
                img_new(j) = img_bw(j);
            else
                img_new(j) = 150;
            end
        end
        imwrite(img_new, fullfile(crop_dir, img_name));
    end
end

fprintf("End\n"); % Corrected the print statement
