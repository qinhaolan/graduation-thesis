format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
data=iris(:,2:5);
[a,b,c]=MEC(data,3);
sum(c,2)
