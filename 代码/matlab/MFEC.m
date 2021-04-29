%模糊最大熵聚类
function [A,V,C] = MFEC(data, c)
T=1000;
m=2;
epsm=0.0001;
[n, s] = size(data);

% 初始化隶属度矩阵并归一化
A= rand(c, n);
temp = sum(A,1);
for i=1:n
    A(:,i) = A(:,i)./temp(i);
end

L=zeros(c,n);

%先计算beta
beta=sum(sum(data,2)/s)/n;

%计算初始聚类中心
V(c,s)=0;
for i=1:c
    V(i,:)=i/c*1/n*sum(data);
end

%循环迭代
t=0;
objFcn=zeros(1,T);
tmp1=0;
tmp2=0;
while(t<T)
    t=t+1;
    
    %计算第i个样本与第k类的距离
    for i=1:n
        for k=1:c
            L(k,i)=mydist(data(i,:),V(k,:));
        end
    end
    %更新隶属度
    Am=A.^(m-1);
    for i=1:n
        num=0;
        for k=1:c
            num=num+exp(-m*Am(k,i)*L(k,i)^2/beta);
        end
        for k=1:c
            A(k,i)=exp(-m*Am(k,i)*L(k,i)^2/beta)/num;
        end
    end
    %更新聚类中心
    Am=A.^m;
    V=Am*data./(sum(Am ,2)*ones(1,s));
    
    %计算目标函数的值
    tmp2=sum(sum(A.*L.^2));
    if (abs(tmp2-tmp1)<epsm)
        break
    end
    tmp1=tmp2;
    objFcn(t)=tmp1;
end
%绘制结果
C=F2Q(A);
myplot(A,objFcn);
end