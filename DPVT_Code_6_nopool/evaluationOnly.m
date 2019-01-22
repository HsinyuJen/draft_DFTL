run('~/tools/matconvnet-1.0-beta23/matlab/vl_setupnn.m');

addpath('./common_plus/');
addpath('./function/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 参数                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                                %
% 数据集的绝对位置　和视频的相对位置                                            %
video_path = 'lowFramerate/port_0_17fps/';
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
%g_imMean = imMean;

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
blocks_num = fix((length_f-1) / (len*len)) + 1;
n_length_f = blocks_num*len*len;
array_tr = head_f + fix(blocks_num/2) : blocks_num : head_f + blocks_num*len*len - 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 保存评估结果
array_training = 1 + fix(blocks_num/2) : blocks_num : blocks_num*len*len;
n_array_training = array_training(array_training()<length_f+1);
test_result =  single(evaluation_translate(path_cdnet,video_path,n_array_training));
fp = fopen('result.txt', 'a');
fprintf(fp,'%s\n%s\n',video_path,test_result);
fclose(fp);

