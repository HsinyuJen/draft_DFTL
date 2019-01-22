function re_mean = getVideoMean_plus(data)

rdata1 = data(:,:,1,:);
gdata1 = data(:,:,2,:);
bdata1 = data(:,:,3,:);

avgr1 = mean(mean(mean(rdata1)));
avgg1 = mean(mean(mean(gdata1)));
avgb1 = mean(mean(mean(bdata1)));
meanPixel = zeros(1,1,3);

meanPixel(1,1,1) = avgr1;
meanPixel(1,1,2) = avgg1;
meanPixel(1,1,3) = avgb1;
meanPixel(1,1,4) = avgr1;
meanPixel(1,1,5) = avgg1;
meanPixel(1,1,6) = avgb1;
meanPixel(1,1,7) = avgr1;
meanPixel(1,1,8) = avgg1;
meanPixel(1,1,9) = avgb1;

re_mean = single(meanPixel);

