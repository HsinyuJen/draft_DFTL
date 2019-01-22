function  [] = printCNN(net)
i=0
for i= 1:37
    if (net.layers{i}.type == 'conv')
    size(net.layers{i}.biases)
    size(net.layers{i}.filters)
    fprintf('======================================')
end
end

