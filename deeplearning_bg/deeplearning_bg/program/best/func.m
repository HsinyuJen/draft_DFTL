function [] = func(temp,i,j)

files   = importdata('list.txt');
videos  = importdata('index.txt');

str = sprintf('%s ',videos{i});

if j == 1
%    disp('re');
    str = sprintf('%s %s',str,'re');
end

if j == 2
%    disp('pr');
    str = sprintf('%s %s',str,'pr');
end

if j == 3
%    disp('fm');
    str = sprintf('%s %s',str,'fm');
end

str = sprintf('%s %s %.4f %s %.4f %s %.4f %s %.4f',str,files{temp(1,2)},temp(1,1),files{temp(2,2)},temp(2,1),files{temp(3,2)},temp(3,1),files{temp(4,2)},temp(4,1));

if j == 3
    disp(str);
end
