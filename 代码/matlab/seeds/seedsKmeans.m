format compact
clear
clc
%读取数据
seeds =importdata('seeds.txt');
data=seeds(:,1:7);
Idx=kmeans(data,3);