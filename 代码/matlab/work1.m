%FCM聚类
format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:5);
%归一化
% for i=1:4
%     mi=min(iris(:,i+1));
%     ma=max(iris(:,i+1));
%     for j=1:150
%         data(j,i)=(iris(j,i+1)-mi)/(ma-mi);
%     end
% end
[a,b,c]=fcm(data,3)