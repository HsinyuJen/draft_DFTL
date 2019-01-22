video = 'baseline/highway';
path_in = ['~/dataset/dataset2014/' video '/input/']
path_gt = ['~/dataset/dataset2014/' video '/groundtruth/']
path_re = ['./result/' video '/'];

addpath('~/projects/imageprocessing/common/');

[files_gt data_gt] = loadData_plus(path_gt,'png');
[files_re data_re] = loadData_num(path_re,'bmp',470);
[files_in data_in] = loadData_plus(path_in,'jpg');


% 截取测试的真实样本
data_gt  = data_gt(:,:,:,801:1000);
data_in  = data_in(:,:,:,801:1000);
% 截取有效的预测图
data_re  = data_re(:,:,:,331:530); 
size(data_re)
gt = data_gt(135,125,:,:);
in = data_in(135,125,:,:);
re = data_re(135,125,:,:);

in = mean(in,3);

gt = squeeze(gt);
in = squeeze(in);
re = squeeze(re);


lines = {gt,in,re};
save('lines.mat','lines');
%{
size(gt)
size(in)
size(re)
y = 1:50;
plot(y,gt,'-ro','LineWidth',5);
hold on;
plot(y,re,'-go','LineWidth',5);
hold on;
plot(y,in,'-bo','LineWidth',5)
hold;
print (gcf,'-dpng','lines.png');
max(max(max(max(gt))))
max(max(max(max(re))))
max(max(max(max(in))))

%}
