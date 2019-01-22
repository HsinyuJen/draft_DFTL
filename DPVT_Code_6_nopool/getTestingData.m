function re_imdb = getTestingData(im_pa, im_ft, gt_pa, gt_ft, array_test, len, imMean)


patches_im = img2pix_plus(im_pa, im_ft, array_test, len, 1, imMean);
%patches_gt = img2pix_plus(gt_pa, gt_ft, head_num, len, rate,0);
patches_gt = [];

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

