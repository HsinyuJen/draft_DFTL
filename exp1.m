clear all
close all
clc

data = load('lines.mat');


data = data.lines;

l1 = data{1};
l2 = data{2};
l3 = data{3};


l1 = l1(1:3:120);
l2 = l2(1:3:120);
l3 = l3(1:3:120);

len = max(size(l1));

x = 1:len;


figure
% set(gca,'FontSize',30)
set (gcf,'Position',[0 0 800 600], 'color','w')
plot(x, l2, '-o', 'Color', [0.5 0.5 1], 'LineWidth', 2,'markerfacecolor',[0.5 0.5 1])
hold on
plot(x, l3, '-o', 'Color', [0.5 1 0.5], 'LineWidth', 2,'markerfacecolor',[0.5 1 0.5])
hold on
plot(x, l1, '-o', 'Color', [1 0.5 0.5], 'LineWidth', 2,'markerfacecolor',[1 0.5 0.5])
legend('pixel variation','transfromed variation','groundtruth', 'Location', 'southeast')
ylim([-50 300])

set(gca,'FontName','Times New Roman','FontSize',16)

print(gcf,'-r600','-dpng','lines.png');
%saveas(gcf,'lines.png');
