run('~/tools/matconvnet-1.0-beta23/matlab/vl_setupnn.m');
addpath('./common_plus/');
addpath('./function/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 参数                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                                %
% 数据集的绝对位置　和视频的相对位置                                            %
video_path = 'baseline/office/';
path_cdnet = '~/dataset/dataset2014/';

im_pa = sprintf('%s%s%s', path_cdnet, video_path,'input/');
gt_pa = sprintf('%s%s%s', path_cdnet, video_path,'groundtruth/');

im_ft = 'jpg';
gt_ft = 'png';

% 网络保存的位置
sv_pa = ['./network/' video_path];

% 测试结果保存路径
if ~exist(['./result/' video_path])
    mkdir(['./result/' video_path]);
end

% 　选择　len * len 帧图像
len = 10;

global g_len g_epoch g_imMean;
g_len = len;
%imMean = getVideoMean_plus(im_pa);
imMean = 0;
g_imMean = imMean;

% 网络的循环次数                                                                %
g_epoch = 20;                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 程序运行部分 　　                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 计算训练样本序列
temp = importdata([path_cdnet video_path 'temporalROI.txt']);
head_f = temp(1);
end_f  = temp(2);
length_f = end_f - head_f + 1;
blocks_num = fix(length_f / (len*len));
array_tr = head_f + fix(blocks_num/2) : blocks_num : head_f + blocks_num*len*len - 1;

% 生成训练数据                                                      %
%training_data = getTrainingData(im_pa, im_ft, gt_pa, gt_ft, array_tr, len,imMean);

% 训练网络
%network_training(sv_pa, training_data);

%***************************************************************************
% 测试网络 block_im 就是测试结果

% 多线程无法传递全局变量

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 保存评估结果
array_training = 1 + fix(blocks_num/2) : blocks_num : blocks_num*len*len;
test_result =  single(evaluation_translate(path_cdnet,video_path,array_training));
fp = fopen('result.txt', 'a');
fprintf(fp,'%s\n%s\n',video_path,test_result);
fclose(fp);

