%% Question before Summer vacation
% 随机梯度算法并不随机 https://www.cnblogs.com/lliuye/p/9451903.html
% 
% 约束条件写到argmin中
% 

%% 2019.7.7
% 1.鲁棒性决定分界点(加噪声)
% 2.用不同的精度(本征函数的个数)去逐步精确本征函数的划分

%% Summer vacation task
% 随机梯度算法 
% 写报告for SVG
% 论文结构

%% 2019.8.26 Lecture for Domenico
% 1.报告中描述基函数不够清晰(slides需要改进)
% 2.为什么要取这样(高斯 or else)的基函数,为什么这么取基函数就是对的(正交的投影更有效,但是也不一定正交,函数空间尽可能完备)
% 3.本征函数的极小值点为什么反映的边界点,极大值点能反映出什么性质(interval 中间 ,有可能跟周期轨道有关)
% 4.这种做法具有鲁棒性吗,加了噪声会不会有好的划分

%% 2019.8.31 Discuss with Lan
% 1.本征函数加了噪声
% 2.加了噪声还能不能通过argmin来找到"结构简单"的本征函数

% 噪声的分辨率和基函数的分辨率
% robustness 基函数 噪声 系统不一样

%% 2019.9.7
% 基函数比较胖的地方对应边界变化小
% 自动画出分界线
% 能不能断定单调区间的个数
% 确认分界点的层次
% 自动加上边界点的位置

%% 2019.9.24
% 一个点演化多步求解
% Henon map的尝试

%% 中期问题 2019.11.13
% 1.如何精确的用一些随机梯度下降算法求得精简的本征值。以及如何跳出局部最优解。
% 2.随着基函数的增多,本征函数的划分也变得更精确,如何通过粗粒度的划分来实现细粒度的划分。
% 3.如果原方程加了噪声,会对Koopman算符本征函数有何影响。
% 4.Koopman算符的本征函数是否具有鲁棒性。
% 5.如何确定边界点的层次。
% 6.能否用通用的方法画出动力学系统的分界线。
% 7.本征函数的最大值最小值分别表示什么含义。
% 8.基函数的变化是如何影响本征函数的。
% 以上都是在课题中遇到的问题,今后会继续加强对这些问题的思考与完善,并将这些思考过程择重点记录到论文中.

%% 2019.9.24
% 老师的记录
% (0706) 1.鲁棒性决定分界点 2.精度不同下的本征值
% (0924) 1.一维多峰情况(判别),层次的判别 
% 2.最大值,最小值
% 3.噪声大->噪声小,分辨率提高

% 基和基之间的关联 基函数个数的选取n 8 16 32 consitrant
% 基函数的变化对本征函数的影响

