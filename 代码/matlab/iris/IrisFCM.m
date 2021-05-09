%%%计算智能assignment,使用FCM和anfis对鸢尾花进行聚类分析
format compact
clear
clc
iris = csvread('iris.csv');
iris = iris(randperm(size(iris, 1)), :);  %打乱数据集

[row, col] = size(iris);
iris_train = iris(1:uint8(row*0.8), :);  %拆分数据集
iris_test = iris(uint8(row*0.8)+1:end, :);

setosaIndex = iris(:,5)==1;
versicolorIndex = iris(:,5)==2;
virginicaIndex = iris(:,5)==3;

setosa = iris(setosaIndex,:);
versicolor = iris(versicolorIndex,:);
virginica = iris(virginicaIndex,:);

Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];  %以不同的“特征对”聚类


Nc = 3;  %聚类中心个数
M = 2.0; %分割矩阵的指数
maxIter = 100;  %最大迭代次数
minImprove = 1e-5;  %迭代停止的误差条件
clusteringOptions = [M maxIter minImprove false];

%配置初始FIS参数
genOpt = genfisOptions('FCMClustering', 'FISType','sugeno');  %使用Sugeno推理
genOpt.NumClusters = Nc;  %聚类中心个数
genOpt.Exponent = clusteringOptions(1); 
genOpt.MaxNumIteration = clusteringOptions(2);
genOpt.MinImprovement = clusteringOptions(3);
genOpt.Verbose = clusteringOptions(4);

inputData = iris_train(:,1:size(iris,2)-1);
outputData = iris_train(:,size(iris,2));
infis = genfis(inputData,outputData,genOpt);  %定义初始FCM模糊系统

%配置anfis训练参数
opt = anfisOptions('InitialFIS',infis);
opt.EpochNumber = 150;             % 最大训练轮数
opt.ErrorGoal = 1e-5;
opt.DisplayANFISInformation = 0;  % 打印模糊推理系统的信息
opt.DisplayErrorValues = 1;       % 打印每一个epoch的训练误差
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 1;
opt.ValidationData = iris_test;  % 设置验证数据

[fis,trainError,stepSize,chkFIS,chkError] = anfis(iris_train,opt);  %训练FIS,返回验证结果

% % 训练前模糊系统输出与真值的均方误差
% trainout1 = evalfis(iris_train(:, 1:4), infis);
% trainRMSE1 = norm(trainout1-iris_train(:, 5))/sqrt(length(trainout1))
% testout1 = evalfis(iris_test(:, 1:4), infis);
% testRMSE1 = norm(testout1-iris_test(:, 5))/sqrt(length(testout1))
% 
% % 训练后模糊系统输出与真值的均方误差
% trainout2 = evalfis(iris_train(:, 1:4), fis);
% trainRMSE2 = norm(trainout2-iris_train(:, 5))/sqrt(length(trainout2))
% testout2 = evalfis(iris_test(:, 1:4), fis);
% testRMSE2 = norm(testout2-iris_test(:, 5))/sqrt(length(testout2))

[minChkErr, n] = min(chkError);   % 返回验证数据的最小误差,及其对应的训练epoch数

s = ['\leftarrow 最小误差为', num2str(minChkErr),',epoch=', num2str(n)];
figure,
plot(trainError, 'linewidth', 1.5), hold on,
plot(chkError, 'linewidth', 2), 
xlabel('迭代次数');
ylabel('均方误差');
text(n, minChkErr, s, 'FontWeight','bold','FontSize', 14);
legend('训练误差', '测试误差', 'Location', 'best');
set(gca,'FontSize',16);


%%%%%% 分类结果可视化 %%%%%%%
[centers,U,obj_fcn] = fcm(iris,Nc,clusteringOptions);  
% % center:迭代后得到的聚类中心;U:隶属度矩阵; obj_fcn:目标函数在迭代过程中的值

%按照不同的“特征对”区分,画出样本的分布
figure('NumberTitle', 'off', 'Name','样本分布')
for i = 1:6
    x = pairs(i,1); 
    y = pairs(i,2);   
    subplot(2,3,i)
    plot([setosa(:,x) versicolor(:,x) virginica(:,x)],
         [setosa(:,y) versicolor(:,y) virginica(:,y)], '.')
    xlabel(Characteristics{x})
    ylabel(Characteristics{y})
end
for i = 1:6
    subplot(2,3,i);
    for j = 1:Nc
        x = pairs(i,1);
        y = pairs(i,2);
        text(centers(j,x),centers(j,y),int2str(j),'FontWeight','bold','FontSize', 14);
    end
end

% 因为样本顺序被打乱,可通过将隶属度值从大到小排列观察区分度
U(1,:) = sort(U(1,:),'descend');
U(2,:) = sort(U(2,:), 'descend');
U(3,:) = sort(U(3,:), 'descend');
figure('NumberTitle', 'off', 'Name','样本隶属度') ;
subplot(3,1,1);
plot(U(1,:),'-b');
title('隶属度矩阵值')
ylabel('第一类')
set(gca,'FontSize',16);
subplot(3,1,2);
plot(U(2,:),'-r');
ylabel('第二类')
set(gca,'FontSize',16);
subplot(3,1,3);
plot(U(3,:),'-g');
xlabel('样本数')
ylabel('第三类')
set(gca,'FontSize',16);