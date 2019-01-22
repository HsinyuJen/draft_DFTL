function re_imdb = getTrainingData(im_pa, im_ft, gt_pa, gt_ft, array_tr, len, imMean)


patches_im = img2pix_plus(im_pa, im_ft, array_tr, len, 1,imMean);
patches_gt = img2pix_plus(gt_pa, gt_ft, array_tr, len, 0,imMean);


[fs ffs] = loadFiles_plus(im_pa, im_ft);
[row_im column_im byte_im] = size(imread(ffs{1}));


[row_t column_t byte_t frames_t] = size(patches_im);

imdb.images.data        = single(patches_im);
imdb.images.labs        = single(patches_gt);
imdb.images.meanPixel   = single(getVidMeans(patches_im));
imdb.images.set         = single(ones(1,frames_t));
imdb.images.iminfo      = single([row_im column_im byte_im]);

imdb.mask        = single(ones(row_t,column_t));

re_imdb = imdb;

