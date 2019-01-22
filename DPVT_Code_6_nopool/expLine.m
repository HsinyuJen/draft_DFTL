function [] =  expLine(video_path,path_cdnet)
run('~/tools/matconvnet-1.0-beta23/matlab/vl_setupnn.m');

addpath('./common_plus/');
addpath('./function/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 参数                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                                %
% 数据集的绝对位置　和视频的相对位置                                            %

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

% 生成训练数据                                                      %
training_data = getTrainingData(im_pa, im_ft, gt_pa, gt_ft, array_tr, len,imMean);

% 训练网络
network_training(sv_pa, training_data);

%***************************************************************************
% 测试网络 block_im 就是测试结果

% 多线程无法传递全局变量
CoreNum = 2;
if matlabpool('size')<=0
    matlabpool('open','local',CoreNum);
else
    disp('matlabpool already started');
end

%if mod(length_f,len*len)~=0
%    n_head_f = end_f - len*len*blocks_num + 1;
%    parfor i = 1:blocks_num
%        array_test   = n_head_f + i - 1 : blocks_num : end_f;
%        testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, array_test, len,imMean);
%        block_im     = network_testing(sv_pa, testing_data);                           %
%        [row_im column_im frames_t] = size(block_im);
%
%        disp('\nSaving result...\n');
%        for j = 1:frames_t
%            im = uint8(block_im(:,:,j));
%            imwrite(im,['./result/' video_path int2str(array_test(j)) '.bmp'],'bmp');
%        end
%    end
%end

parfor i = 1:blocks_num
    array_test   = head_f + i - 1 : blocks_num : head_f + blocks_num*len*len - 1;
    testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, array_test, len,imMean);
    block_im     = network_testing(sv_pa, testing_data);                           %
    [row_im column_im frames_t] = size(block_im);

    disp('\nSaving result...\n');
    for j = 1:frames_t
        im = uint8(block_im(:,:,j));
        imwrite(im,['./result/' video_path int2str(array_test(j)) '.bmp'],'bmp');
    end
    fprintf('\n%d / %d\n',i,blocks_num); 
end

% 多线程关闭
matlabpool close;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 保存评估结果
array_training = 1 + fix(blocks_num/2) : blocks_num : blocks_num*len*len;
n_array_training = array_training(array_training()<length_f+1);
test_result =  single(evaluation_translate(path_cdnet,video_path,n_array_training));
fp = fopen('result.txt', 'a');
fprintf(fp,'%s\n%s\n',video_path,test_result);
fclose(fp);

