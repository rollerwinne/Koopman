clear;close all;clc

options=default_options;
[fun,param,options]=Tent_map(options);

% param.n=1000; %演化格点维度
%param.m=3; %函数格点维度
% param.x0=[rand,rand]; %初始点
% param.times=1; %噪声平均次数
%options.view=[-15,60]; %画图角度
% options.map=jet; %色系


Koopman_basis(fun,param,options);

function [fun,param,options]=Tent_map(options)
alpha=1/2;
D=0;
fun=@(x)awgn((x<alpha)./alpha.*x+(x>=alpha).*(1/(1-alpha)-1/(1-alpha)*x),10*log10(1/D));

param.dim=1;
param.n=1000;
param.m=2;
param.phase=[0,1];
param.x0=linspace(param.phase(1),param.phase(2),param.n);
param.times=1;
param.basis='Gauss';

options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Tent_natural';
options.save.suffix='.png';
end

function [fun,param,options]=Logistic_map(options)
alpha=1/2;D=0;
fun=@(x)awgn((x<alpha)./alpha.*x+(x>=alpha).*(1/(1-alpha)-1/(1-alpha)*x),10*log10(1/D));

param.dim=1;
param.n=1000;
param.m=2;
param.phase=[0,1];
param.x0=linspace(param.phase(1),param.phase(2),param.n);
param.times=1;
param.basis='Gauss';

options.save.enabled=true;
options.save.path='./temp';
options.save.pre='Logistic_Koopman';
options.save.suffix='.png';
end

function options=default_options
options.all=true;
options.view=[-15,60];
options.map=jet;

options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Tent_Koopman';
options.save.suffix='.png';
end