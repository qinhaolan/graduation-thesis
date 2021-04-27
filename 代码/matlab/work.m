format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:5);
%归一化
[a,b,c]=fcm1(data,3);

