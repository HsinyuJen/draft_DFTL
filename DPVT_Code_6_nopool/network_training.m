function network_training(sv_pa, imdb)

global g_epoch;
opts.expDir = sv_pa; 
opts.train.batchSize = 200;
opts.train.numEpochs = g_epoch;
opts.train.continue = true;
opts.train.useGpu = true ;
opts.train.learningRate = 1e-3;
opts.train.expDir = opts.expDir ;


net = fcn_init();


[net,info] = cnn_train_adagrad(net, imdb, @getBatch,...
    opts.train,'errorType','euclideanloss',...
    'conserveMemory', true);
end



function [im, labels] = getBatch(imdb, batch)
% --------------------------------------------------------------------
    data    = imdb.images.data;
    labs  = imdb.images.labs;
    meanPixel = imdb.images.meanPixel;
    iminfo = imdb.images.iminfo;
    row = iminfo(1);
    column = iminfo(2);
    
    global g_len;

    for ii = 1:numel(batch)
 %       im_ii = data(:,:,:,batch(ii));
        roi   = labs(:,:,:,batch(ii));

        n = batch(ii);
        x_n = fix((n-1)/column+1);
        y_n = n-column*(x_n-1);

        if x_n>1&&x_n<row&&y_n>1&&y_n<column
            spaNabor = [n-column-1,n-column,n-column+1,n-1,n+1,n+column-1,n+column,n+column+1];
            sampleNabor = spaNabor(randperm(length(spaNabor),3));
        else
            sampleNabor = [n,n,n];
        end

        im_ii(:,:,1:3) = data(:,:,:,n);
        im_ii(:,:,4:6) = data(:,:,:,sampleNabor(1));
        im_ii(:,:,7:9) = data(:,:,:,sampleNabor(2));

        labels_ii = zeros(size(roi,1),size(roi,2));
        labels_ii( roi == 50 )  = 0.25;       %shade
        labels_ii( roi == 170 ) = 0.75;       %object boundary
        labels_ii( roi == 255 ) = 1;          %foreground           
        
        im_large = padarray(im_ii,[5, 5],'symmetric');
        im_e = bsxfun(@minus, im_large, meanPixel);
        
        im(:,:,:,ii) = im_e;
        labels(:,:,1,ii) = labels_ii;
        labels(:,:,2,ii) = double(imdb.mask);
    end
end


