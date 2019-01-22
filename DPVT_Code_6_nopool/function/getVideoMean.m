function meanPixel = getVideoMean()

dataType = 'baseline';
dataName = 'highway';
path = ['../CDNetDataset/manual/200frames/' dataType '/' dataName '/input/']
addpath('~/projects/imageprocessing/common')

datainfo = dir([path '*.mat']);
length = size(datainfo,1);
data = [];

for i = 1:length
    fprintf(1,'loading %d \r',i);
    fileName = datainfo(i).name;
    filePath = [path fileName];
    data(:,:,:,i) = single(importdata(filePath));
end

rdata1 = data(:,:,1,470:length);
gdata1 = data(:,:,2,470:length);
bdata1 = data(:,:,3,470:length);
rdata2 = data(:,:,4,470:length);
gdata2 = data(:,:,5,470:length);
bdata2 = data(:,:,6,470:length);
rdata3 = data(:,:,7,470:length);
gdata3 = data(:,:,8,470:length);
bdata3 = data(:,:,9,470:length);
rdata4 = data(:,:,10,470:length);
gdata4 = data(:,:,11,470:length);
bdata4 = data(:,:,12,470:length);
rdata5 = data(:,:,13,470:length);
gdata5 = data(:,:,14,470:length);
bdata5 = data(:,:,15,470:length);

clear data;

avgr1 = mean(mean(mean(rdata1)));
avgg1 = mean(mean(mean(gdata1)));
avgb1 = mean(mean(mean(bdata1)));
avgr2 = mean(mean(mean(rdata2)));
avgg2 = mean(mean(mean(gdata2)));
avgb2 = mean(mean(mean(bdata2)));
avgr3 = mean(mean(mean(rdata3)));
avgg3 = mean(mean(mean(gdata3)));
avgb3 = mean(mean(mean(bdata3)));
avgr4 = mean(mean(mean(rdata4)));
avgg4 = mean(mean(mean(gdata4)));
avgb4 = mean(mean(mean(bdata4)));
avgr5 = mean(mean(mean(rdata5)));
avgg5 = mean(mean(mean(gdata5)));
avgb5 = mean(mean(mean(bdata5)));

meanPixel = zeros(1,1,15);

meanPixel(1,1,1) = avgr1;
meanPixel(1,1,2) = avgg1;
meanPixel(1,1,3) = avgb1;
meanPixel(1,1,4) = avgr2;
meanPixel(1,1,5) = avgg2;
meanPixel(1,1,6) = avgb2;
meanPixel(1,1,7) = avgr3;
meanPixel(1,1,8) = avgg3;
meanPixel(1,1,9) = avgb3;
meanPixel(1,1,10) = avgr4;
meanPixel(1,1,11) = avgg4;
meanPixel(1,1,12) = avgb4;
meanPixel(1,1,13) = avgr5;
meanPixel(1,1,14) = avgg5;
meanPixel(1,1,15) = avgb5;

meanPixel = single(meanPixel);
save('meanPixel.mat','meanPixel');
