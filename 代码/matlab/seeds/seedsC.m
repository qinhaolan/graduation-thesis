format compact
clear
clc
%读取数据
seeds =importdata('seeds.txt');
data=seeds(:,1:7);
% %绘制原始数据
% subplot(2,3,1);
% gscatter(data(:,1),data(:,2),data(:,8)),title('1,2 列')
% subplot(2,3,2);
% gscatter(data(:,1),data(:,3),data(:,8)),title('1,3 列')
% subplot(2,3,3); 
% gscatter(data(:,1),data(:,4),data(:,8)),title('1,4 列')
% subplot(2,3,4);
% gscatter(data(:,2),data(:,3),data(:,8)),title('2,3 列')
% subplot(2,3,5);
% gscatter(data(:,2),data(:,4),data(:,8)),title('2,4 列')
% subplot(2,3,6);
% gscatter(data(:,3),data(:,4),data(:,8)),title(':3,4 列')
 [a,b,c]=MFEC(data,3);
 sum(c,2)