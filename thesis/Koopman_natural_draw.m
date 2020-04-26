clear;close all;clc

options=default_options;
[fun,param,options]=Intermittency(options);

% param.n=1000; %�ݻ����ά��
param.m=2; %�������ά��
% param.x0=[rand,rand]; %��ʼ��
% param.times=1; %����ƽ������
options.view=[-15,60]; %��ͼ�Ƕ�
% options.map=jet; %ɫϵ

Koopman_natural(fun,param,options);

function [fun,param,options]=Intermittency(options)
fun=@(x)x./(1-x)*(x<=0.5)+(1-x)/x*(x>0.5);
param.n=1000;
param.m=2;
param.x0=rand;
param.times=1;
end

function [fun,param,options]=Tent_map(options)
fun=@(x)x./(1-x)*(x<=0.5)+(1-x)/x*(x>0.5);
param.n=1000;
param.m=2;
param.x0=rand;
param.times=1;
end


function [fun,param,options]=Henon_map(options)
a=1.4;b=0.3;
D=0;
fun=@(x)[awgn(x(2)+1-a.*x(1).*x(1),10*log10(1/D));
    awgn(b*x(1),10*log10(1/D))];
param.n=1000;
param.m=2;
param.x0=[0.2,0.3];
param.times=1;
options.view=[-15,60];
options.map=jet;
options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Henon_Koopman';
options.save.suffix='.png';
%view(-15,60)
%view(0,90)
end

function [fun,param,options]=Henon_map_3D(options)
A=-1.86;
C=0.03;
D=0;
fun=@(x)[awgn(  x(2)  ,10*log10(1/D));
    awgn(  x(3)  ,10*log10(1/D));
    awgn(  0.72*x(1)+C*x(2)+A*x(3)-1.45*x(3).^2+0.515.*x(2).*x(3)-x(2).^2  ,10*log10(1/D))];

param.n=1000;
param.m=2;
param.x0=[-1.596,-0.854,0.553];
param.times=1;
options.view=[-15,60];
options.map=jet;
options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Henon_Koopman';
options.save.suffix='.png';
%view(-15,60)
%view(0,90)
end

function [fun,param,options]=Henon_map_3D2(options)
A=-1.86;
C=0.03;
D=0;
fun=@(x)[awgn(  x(2)  ,10*log10(1/D));
    awgn(  x(3)  ,10*log10(1/D));
    awgn(  0.5*x(1)+A*x(3)+C*x(2)-2.25*x(3).^3-2*x(2).^3  ,10*log10(1/D))];


param.n=1000;
param.m=2;
param.x0=[1.985,-0.878,-0.287];
param.times=1;
options.view=[-15,60];
options.map=jet;
options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Henon_Koopman';
options.save.suffix='.png';
%view(-15,60)
%view(0,90)
end

function options=default_options
options.view=[-15,60];
options.map=jet;
options.save.enabled=false;
options.save.path='./temp';
options.save.pre='Henon_Koopman';
options.save.suffix='.png';
end