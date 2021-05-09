format compact
clear
clc
%读取数据
seeds =importdata('seeds.txt');
data=seeds(:,1:7);
[V,U,objFcn]=fcm(data,3);
c=F2Q(U);
myplot(U,objFcn);
sum(c,2)