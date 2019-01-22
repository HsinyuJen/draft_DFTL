run('~/tools/matconvnet-1.0-beta23/matlab/vl_setupnn.m');

addpath('./common_plus/');
addpath('./function/');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 这一大坨都是参数                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                                %
% 数据集的绝对位置　和视频的相对位置                                            %
video_path = 'nightVideos/streetCornerAtNight/';
path_cdnet = '~/dataset/dataset2014/';

im_pa = sprintf('%s%s%s', path_cdnet, video_path,'input/');
gt_pa = sprintf('%s%s%s', path_cdnet, video_path,'groundtruth/');

im_ft = 'jpg';
gt_ft = 'png';

% 网络保存的位置
sv_pa = ['./network/' video_path];

head_num = 1470;
len = 12;

% 放大３倍，XXX 个人严重不同意这么搞，没道理，而且消耗大量的时间
rate = 1;

global g_head_num g_len g_rate g_epoch g_imMean;
g_head_num = head_num;
g_len = len;
g_rate = rate;

g_imMean = getVideoMean_plus(im_pa);
% 网络的循环次数                                                                %
g_epoch = 20;                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 程序运行部分 　　                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 生成训练数据，不存到硬盘                                                      %
%training_data = getTrainingData(im_pa, im_ft, gt_pa, gt_ft, head_num, len, rate);

% 训练网络
%network_training(sv_pa, training_data);
% 测试网络 block_im 就是测试结果

temp = importdata([path_cdnet video_path 'temporalROI.txt']);
head_f = temp(1);
end_f  = temp(2);
length_f = end_f - head_f + 1;
blocks_num = fix(length_f / (len*len));

if ~exist(['./result/' video_path])
    mkdir(['./result/' video_path]);
end

for i = 1:blocks_num
    head_num = head_f + len*len*(i-1);
    testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, head_num, len, rate);
    block_im    = network_testing( sv_pa, testing_data);                           %
    [row_im column_im frames_t] = size(block_im);

    for j = 1:frames_t
        im = uint8(block_im(:,:,j));
        imwrite(im,['./result/' video_path int2str(j+head_num-1) '.bmp'],'bmp');
    end
    i
end

head_num = end_f - len*len + 1;
testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, head_num, len, rate);
block_im    = network_testing( sv_pa, testing_data);                           %
[row_im column_im frames_t] = size(block_im);

for j = 1:frames_t
    im = uint8(block_im(:,:,j));
    imwrite(im,['./result/' video_path int2str(j+head_num-1) '.bmp'],'bmp');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_result =  evaluation_translate(path_cdnet,video_path);
fp = fopen('result.txt', 'a');
fprintf(fp,'%s\n%s\n',video_path,test_result);
fclose(fp);


