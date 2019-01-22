function patch = img2pix(im_pa,im_ft, head_num, len, rate,im_flag,imMean)

%==============================================================================
% Author: Ryan  
% DATE: 2017/05/17
% inputDir: the Dir of your opt-flow data 
% extention: 'jpg','bmp'
% outputPath: where to save opt-flow image
% dataName: theName of the vedio
% descript: This function will make a new form of pixel-motion data base on videos.
% 
% Reviser: HalfofStupid
% ===========================================================================

if nargin == 4
    rate = 3;
end

if nargin == 3
    rate = 3;
    len = 5;
end

if nargin == 2
    rate = 3;
    len = 5;
    head_num = 800;
end

mask = imread([im_pa '/../ROI.bmp']);
if  mean(mean(mask)) == 255
    f_mask = 0;
else
    f_mask = 1;
end
if strcmp(im_ft,'jpg')
    mask = repmat(mask,[1,1,3]);
end


[fs ffs] = loadFiles_plus(im_pa, im_ft);
ft_idx = head_num:head_num + len^2 - 1;

[row_im column_im byte_im] = size(single(imread(ffs{1})));

block_im = zeros(row_im, column_im, byte_im, len^2);


for i = 1:numel(ft_idx)
    idx = ft_idx(i);

    im = double(imread(ffs{idx}));
    if f_mask == 1
        im(mask ~= 255) = 0;
    end
    block_im(:,:,:,i) = im;
end

% 减去平均图像
if im_flag == 1
    imMean(mask ~= 255) = 0;
    imMean = repmat(imMean,[1,1,1,len*len]);
    block_im = abs(block_im - imMean);
end

block_im = permute(block_im,[4 3 2 1]);
patch = reshape(block_im,len,len,byte_im,row_im*column_im);
patch = uint8(patch);
%[row_t column_t byte_t frames_t] = size(patch);

%re_patch = zeros(row_t*rate, column_t*rate, byte_t, frames_t);

%if rate == 1
%    disp('no need to resize image');
%end

%if im_flag == 1 
    %for i = 1:frames_t
        %mean_im = mean(mean(double(patch(:,:,:,i))));
        %patch(:,:,:,i) = uint8(abs(double(patch(:,:,:,i)) -repmat(mean_im,len,len)));
        %re_patch(:,:,:,i) = imresize(patch(:,:,:,i),rate,'nearest');
    %end
%    re_patch = patch;
%else
%    re_patch = patch;
%end




