function re_block = pix2img_plus(iminfo, patches_map, rate)

[row_t column_t byte_t frames_t] = size(patches_map);

% [row_im column_im byte_im] = iminfo;
row_im      = iminfo(1);
column_im   = iminfo(2);
byte_im     = iminfo(3);

len = (row_t/rate)^2;
re_block = zeros(row_im, column_im, len);

count = 1;

for j = 1:rate:column_t
    for i = 1:rate:row_t
        data = patches_map(i:i+rate-1,j:j+rate-1,:);
        data = mean(data,1);
        data = mean(data,2);

        im = reshape(data, column_im, row_im);
        im = im';
        
        re_block(:,:,count) = im;

        count = count + 1;
    end
end
