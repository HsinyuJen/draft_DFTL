clear all
close all
%clc


threshold_fg = 0.1;

avg_all = [];
avg_nor = [];

all_entry = [];
nor_entry = [];

result = [];
videos = {};

% D:/dataset/homography_multi/PTZ/continuousPan/truthimg
% D:/dataset/homography_multi/PTZ/continuousPan/similar

all_result = [];

path_sim = '~/dataset/homography_multi/PTZ/continuousPan/similar';
path_sim = '~/dataset/homography_multi/PTZ/continuousPan/fgimg';
path_sim = '~/dataset/result/translate';
path_sim = '~/dataset/result/PETS2006_q';
path_sim = '~/dataset/Pixels_900_3n/test/save2';
format_sim = 'png';


%path_tru = 'D:/dataset/FBMS_Testset/Testset/cars1/GroundTruth';
path_tru = '~/dataset/PTZ/continuousPan/groundtruth';
path_tru = '~/dataset/dataset2014/baseline/highway/groundtruth'
path_tru = '/home/renxinyu/dataset/dataset2014/baseline/PETS2006/groundtruth';
path_tru = '~/dataset/Pixels_900_3n/groundtruth/save2';
path_msk = path_tru;
format_tru = 'png';


addpath('~/projects/imageprocessing/common/');

[files_tru data_tru] = loadData_plus(path_tru,format_tru);
[files_sim data_sim] = loadData_plus(path_sim,format_sim);

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

re = TP / (TP + FN)
pr = TP / (TP + FP)

Precision = pr;
Recall = re;

f_means = (2 * Precision * Recall) / (Precision + Recall)

result = [result ; re pr f_means];
videos = {videos{:}, {path_sim}};

% 68252503

%%%
%%%
