%模糊最大熵聚类
function [A,V,C] = MEC(data, c)
T=100;
F=@(x)x.*log(x);%熵函数
[n, s] = size(data);
% 初始化隶属度矩阵并归一化
A= rand(c, n);
temp = sum(A,1);
for i=1:n
    A(:,i) = A(:,i)./temp(i);
end

L=zeros(c,n);
t=0;
objFcn=zeros(T,1);
V(c,s)=0;

%先计算beta
beta=sum(sum(data,2)/s)/n;
% beta=2;
%循环迭代
while(t<T)
    t=t+1;
    %计算聚类中心
    for i=1:c
        num=zeros(1,s);
        for j=1:n
            num=num+A(i,j)*data(j,:);
        end
        V(i,:)=num/sum(A(i,:));
    end
    %V=A*data./(sum(A ,2)*ones(1,s));
    %计算第i个样本与第k类的距离
    for i=1:n
        for k=1:c
            L(k,i)=mydist(data(i,:),V(k,:));
        end
    end
    %更新隶属度
    L2=L.^2;
    for i=1:n
        num=0;
        for k=1:c
            num=num+exp(-L2(k,i)/beta-1);
        end
        for k=1:c
            A(k,i)=exp((-beta*log(num)-L2(k,i))/beta-1);
        end
    end
    %计算目标函数的值
    objFcn(t) = beta*sum(sum(F(A)))+sum(sum(A.*L2));
end
%绘制结果
temp = sum(A,1);
for i=1:n
    A(:,i) = A(:,i)./temp(i);
end
C=F2Q(A);
myplot(A,objFcn);
end