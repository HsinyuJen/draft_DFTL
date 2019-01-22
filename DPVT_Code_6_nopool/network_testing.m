function re_block = network_testing(net_pa, imdb)

patches_im = imdb.images.data;
patches_gt = imdb.images.labs;

 g_epoch = 20;
ffs_net = sprintf([net_pa 'net-epoch-%i.mat'], g_epoch);
net = load(ffs_net);
net = net.net;
net.layers{end} = struct('name', 'data_hat_sigmoid', ...
    'type', 'sigmoid'         );

net       = vl_simplenn_move(net,'gpu');
meanPixel = getVidMeans(patches_im);

[row_t column_t byte_t frames_t] = size(patches_im);


patches_map = patches_gt;



row  = imdb.images.iminfo(1);
column  = imdb.images.iminfo(2);

for kk = 1:frames_t
%    im = patches_im(:,:,:,kk);
   
        n = kk;
        x_n = fix((n-1)/column+1);
        y_n = n-column*(x_n-1);

        if x_n>1&&x_n<row&&y_n>1&&y_n<column
            spaNabor = [n-column-1,n-column,n-column+1,n-1,n+1,n+column-1,n+column,n+column+1];
            sampleNabor = spaNabor(randperm(length(spaNabor),3));
        else
            sampleNabor = [n,n,n];
        end

        im(:,:,1:3) = patches_im(:,:,:,n);
        im(:,:,4:6) = patches_im(:,:,:,sampleNabor(1));
        im(:,:,7:9) = patches_im(:,:,:,sampleNabor(2));
    
    im_large = padarray(im,[5,5],'symmetric');
    im_large = bsxfun(@minus, im_large, meanPixel);
    im_large = gpuArray(im_large);
    
    A = vl_simplenn_fake(net, im_large);
    B = gather(A(end).x);
    
    map_im = uint8(B * 255);    

    patches_map(:,:,:,kk) = map_im;
end

 g_rate = 1;
re_block = pix2img_plus(imdb.images.iminfo, patches_map, g_rate);
