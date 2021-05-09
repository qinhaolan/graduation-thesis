format compact
clear
clc
%读取数据
iris = csvread('iris.csv');
% wine=textread('wine.txt'); %#ok<*DTXTRD>
data=iris(:,2:5);
% data=wine(:,2:13);
 [a,b,c]=MFEC(data,3);
 sum(c,2)
