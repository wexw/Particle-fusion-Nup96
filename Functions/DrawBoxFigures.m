%Input y1,y2
x1 = 1.2:2:12.2;
x2 = 0.8:2:10.8;

x = [x1, x2];
y = [y1, y2];

[x, idx] = sort(x);
y = y(:, idx);

boxplot(y1, 'Labels', string(x1),'Positions',x1, 'Colors', ['b'], 'Widths', 0.2,'Symbol', ['+b']);
hold on 
boxplot(y2, 'Labels', string(x2),'Positions',x2, 'Colors', ['r'], 'Widths', 0.2,'Symbol', ['+r']);
hold on 
xticks([1 3 5 7 9 11])
xlim([0 13])
xticklabels({'1','2','3','4','5','6'})
set(gca, 'xticklabel', xticklabels);
xlabel('datasets')
set(gca,'FontSize',16,'FontName','Arial');