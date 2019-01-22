function [re_filename re_fullname] = loadFiles_plus(path,extention)


global g_height g_width g_imgdeep

if(path(end) ~= '/')
    path = [path '/'];
end

fprintf(1, 'Loading files from %s...\n', path);

files = dir([path '*.' extention]);
files = sort({files.name});

% Number of frames
frames = size(files, 2);

% Get the dimension of one picture
sizes = size(imread([path files{1}]));


if frames < 0
    assert 'error: there is no files in the folder.'
end


% If we only have greyscale
if(length(sizes) == 2)
    sizes(3) = 1; % Pretend we have a third dimension
end 

re_filename = cell(1,frames);
re_fullname  = cell(1,frames);


for tt = 1:frames
    re_filename{tt} = files{tt};
    re_fullname{tt} = [path files{tt}];
end

