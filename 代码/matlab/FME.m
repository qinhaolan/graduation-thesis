%模糊最大熵模型
function [A,V] = FME(data, c)
% fuzzy c-means algorithm
% 输入： data： 待聚类数据，n行s列，n为数据个数，s为每个数据的特征数
%        c  ：  聚类中心个数
% 输出：  A  :   隶属度矩阵，c行n列，元素uij表示第j个数据隶属于第i类的程度
%        V  ：  聚类中心向量，c行s列，有c个中心，每个中心有s维特征

T = 100;        %#ok<*NASGU> %迭代次数为100
epsm = 1.0e-6;  %收敛精度
m = 2;          %模糊系数值为2
F=@(x)x.*log(x)+(1-x).*log(1-x);
dF=@(x)log(x)-log(1-x);
[n, s] = size(data);
% 初始化隶属度矩阵并归一化
A= rand(c, n);
temp = sum(A,1);
for i=1:n
    A(:,i) = A(:,i)./temp(i);
end
V=zeros(c,s);%聚类中心，
L=zeros(c,n);
t=0;
while(ture)
    t=t+1;
    %更新聚类中心
    A=F(A);
    V=A*data./(sum(A ,2)*ones(1,s));
    for i=1:n
        for k=1:c
            %计算第i个样本与第k类的距离
            L(k,i)=U0(k,i)*mydist(data(i,:),V(k,:));
        end
    end
end
end