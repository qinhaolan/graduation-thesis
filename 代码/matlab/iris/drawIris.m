format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:6);
v=[ 5.0136 3.3903 1.5369 0.2781;
    6.4737 2.9437 5.1910 1.8012;
    6.0922 2.8186 4.6775 1.5731];
%绘制原始数据
subplot(2,3,1);
gscatter(data(:,1),data(:,2),data(:,5)),title('1,2 列')
hold on
plot(v(:,1),v(:,2),'*');
subplot(2,3,2);
gscatter(data(:,1),data(:,3),data(:,5)),title('1,3 列')
hold on
plot(v(:,1),v(:,3),'*');
subplot(2,3,3); 
gscatter(data(:,1),data(:,4),data(:,5)),title('1,4 列')
hold on
plot(v(:,1),v(:,4),'*');
subplot(2,3,4);
gscatter(data(:,2),data(:,3),data(:,5)),title('2,3 列')
hold on
plot(v(:,2),v(:,3),'*');
subplot(2,3,5);
gscatter(data(:,2),data(:,4),data(:,5)),title('2,4 列')
hold on
plot(v(:,2),v(:,4),'*');
subplot(2,3,6);
gscatter(data(:,3),data(:,4),data(:,5)),title(':3,4 列')
hold on
plot(v(:,3),v(:,4),'*');
%matlab2tikz("yuanshishuju.tex");
% data=iris(:,2:5);
%[a,b,c]=fcm1(data,3);
% U=FME(data,3);
