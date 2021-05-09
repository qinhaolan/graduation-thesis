format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:5);
Idx=kmeans(data,3)