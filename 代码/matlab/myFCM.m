format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:6);
%归一化
% for i=1:4
%     mi=min(iris(:,i+1));
%     ma=max(iris(:,i+1));
%     for j=1:150
%         data(j,i)=(iris(j,i+1)-mi)/(ma-mi);
%     end
% end
%绘制原始数据
subplot(2,3,1);
gscatter(data(:,1),data(:,2),data(:,5)),title('1,2 列')
subplot(2,3,2);
gscatter(data(:,1),data(:,3),data(:,5)),title('1,3 列')
subplot(2,3,3); 
gscatter(data(:,1),data(:,4),data(:,5)),title('1,4 列')
subplot(2,3,4);
gscatter(data(:,2),data(:,3),data(:,5)),title('2,3 列')
subplot(2,3,5);
gscatter(data(:,2),data(:,4),data(:,5)),title('2,4 列')
subplot(2,3,6);
gscatter(data(:,3),data(:,4),data(:,5)),title('choose:3,4 列')
%matlab2tikz("yuanshishuju.tex");
% data=iris(:,2:5);
%[a,b,c]=fcm1(data,3);
% U=FME(data,3);
