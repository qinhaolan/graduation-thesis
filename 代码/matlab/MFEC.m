%模糊最大熵聚类
function [U,V,C] = MFEC(data, c)
T=1000;
epsm=0.0001;
[n, s] = size(data);

% 初始化隶属度矩阵并归一化
U= rand(c, n);
temp = sum(U,1);
for i=1:n
    U(:,i) = U(:,i)./temp(i);
end

L=zeros(c,n);

%先计算beta
% beta=sum(sum(data,2)/s)/n;
% beta=2*beta^2;
beta=2;
%计算初始聚类中心
V(c,s)=0;

%循环迭代
t=0;
objFcn=zeros(1,T);
tmp1=0;
tmp2=0;
while(t<T)
    t=t+1;
    %更新聚类中心
    V=U*data./(sum(U ,2)*ones(1,s));
    
    %计算第i个样本与第k类的距离
    for i=1:n
        for k=1:c
            L(k,i)=mydist(data(i,:),V(k,:));
        end
    end
    %更新隶属度
    for i=1:n
        num=0;
        for k=1:c
            num=num+exp(-L(k,i)^2/beta);
        end
        for k=1:c
            U(k,i)=exp(-L(k,i)^2/beta)/num;
        end
    end
    
    %计算目标函数的值
    tmp2=sum(sum(-U.*log(U)));
    
    if (abs(tmp2-tmp1)<epsm)
        break
    end
    tmp1=tmp2;
    objFcn(t)=tmp1;
%     objFcn(2,t)=sum(sum(U.*log(U)));
end
%绘制结果
C=F2Q(U);
myplot(U,objFcn);
end