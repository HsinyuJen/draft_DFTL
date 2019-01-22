function meanPixel = getVideoMean_plus(path_input)

path = path_input;

addpath('~/projects/imageprocessing/common')

datainfo = dir([[path '/'] '*.jpg']);
[row_im column_im byte_im] = size(imread([path '/' datainfo(1).name]));
length = size(datainfo,1);
data = zeros(row_im, column_im, byte_im, length);
n=3;
if length>5000
n=6;
end

for i = 1:n:length
    fprintf(1,'loading %d \r',i);
    fileName = datainfo(i).name;
    filePath = [path '/' fileName];
    data(:,:,:,i) =single( imread(filePath));
end

meanPixel = mean(data,4);

%save('meanPixel.mat','meanPixel');
