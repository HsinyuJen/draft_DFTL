
for i = 1:frames_t
    im = uint8(block_im(:,:,i));
    imwrite(im,['./result/' int2str(i) '.bmp'],'bmp');
end
