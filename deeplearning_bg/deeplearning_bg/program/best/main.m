clear all
close all
clc

files = importdata('list.txt');

[row_files column_files] = size(files);

fdata = load(files{1});

[row_data column_data] = size(fdata);


data = zeros(row_data,column_data,row_files);


for i = 1:row_files
    tempdata = load(files{i});
    data(:,:,i) = tempdata;
end

index = isnan(data);
data(index) = -1;

[row column byte] = size(data);

for i = 1:row
    for j = 1:column
        label = 1:byte;
        list = squeeze(data(i,j,:));

        matrix = [list label'];
        temp = sortrows(matrix,-1);

        func(temp,i,j);
    end
end


