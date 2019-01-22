%clc
function [result ] = evaluation_translate(path_cdnet,video_path,array_tr)

threshold_fg = 0.6;

avg_all = [];
avg_nor = [];

all_entry = [];
nor_entry = [];

result = [];
videos = {};

% D:/dataset/homography_multi/PTZ/continuousPan/truthimg
% D:/dataset/homography_multi/PTZ/continuousPan/similar

all_result = [];

%path_sim = '~/dataset/homography_multi/PTZ/continuousPan/similar';
%path_sim = '~/dataset/homography_multi/PTZ/continuousPan/fgimg';
%path_sim = '~/dataset/result/translate';
%path_sim = '~/dataset/result/PETS2006_q';
path_sim = ['./result/' video_path ];
format_sim = 'bmp';


%path_tru = 'D:/dataset/FBMS_Testset/Testset/cars1/GroundTruth';
%path_tru = '/home/renxinyu/dataset/dataset2014/baseline/PETS2006/groundtruth';
%path_tru = '~/dataset/Pixels_900_3n/groundtruth/save2';

path_tru =['~/dataset/dataset2014/' video_path 'groundtruth']
path_tru1 =['~/dataset/dataset2014/' video_path 'groundtruth']
path_msk = path_tru1;
format_tru = 'png';


addpath('~/projects/imageprocessing/common/');

temp = importdata([path_cdnet video_path '/temporalROI.txt']);
head_f = temp(1);
end_f  = temp(2);
length_f = end_f - head_f + 1;

[files_tru data_tru] = loadData_plus(path_tru,format_tru);
[files_sim data_sim] = loadData_num(path_sim,format_sim,head_f);
% 截取测试的真实样本
files_tru = files_tru(head_f:end_f);
data_tru  = data_tru(:,:,:,head_f:end_f);
% 截取有效的预测图
files_sim = files_sim(1:length_f); 
data_sim  = data_sim(:,:,:,1:length_f); 

size(data_tru)
size(data_sim)
data_tru(:,:,:,array_tr)=0;
data_sim(:,:,:,array_tr)=0;

im = [];
% if size(files_smi) ~= size(files_tru)
%    im(:,:) =   
% end

re_simvalue = evaluate_cdn_similarity(files_sim,data_sim,files_tru,data_tru,threshold_fg);

data = re_simvalue;

TP = data(1);
FP = data(2);
FN = data(3);
TN = data(4);

re = single(TP / (TP + FN))
pr = single(TP / (TP + FP))

Precision = pr;
Recall = re;

f_means = single((2 * Precision * Recall) / (Precision + Recall))

result = [result ; re pr f_means];
result = single(result);
videos = {videos{:}, {path_sim}};

% 68252503

%%%
%%%
