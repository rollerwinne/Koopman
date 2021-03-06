%                                               n,m,F,D,K,x_marker,h,setup,0,i,1
function [pks,locs,deep]=Tent_findpeaks_leftU(n,m,F,D,K,x_marker,h,setup,I)
A=real(K*F(:,h(I)));
%figure%(I)
subplot(2,2,I)
set(gcf,'outerposition',get(0,'screensize'));
x0=linspace(0,1,n);
hh=plot(x0,A);
[pks,locs] = findpeaks(-A);
deep=floor(log2(length(pks)+1));
%locs=locs/n;
hold on
%plot(locs,A(locs),'*')
binarray=[1,2,4,8,16,32,64,128,256];

A_peak=A(locs);
[pks_temp,index]=sort(A_peak);%,'descend');
locs_temp=locs(index);
locs_temp=locs_temp/n;
s=jet(deep);
% for i=1:deep
%     which=binarray(i):binarray(i+1)-1;
%     B{i}=pks_temp(which);
%     B_index{i}=locs_temp(which);
%     hh=plot(B_index{i},B{i},'--s',...%'LineWidth',2,...
%         'MarkerSize',10,...
%         'MarkerEdgeColor','b',...
%         'MarkerFaceColor',s(i,:));
%     for j=1:length(B{i})
%         text(B_index{i}(j),B{i}(j),['(',num2str(B_index{i}(j),'%5.4f'),',',num2str(B{i}(j),'%5.4f'),')'],'VerticalAlignment','bottom','rotation',45);
%     end
% end
load('tent_data0.mat');
hold on
choose=5;
plot(X{choose},min(A)+0.5*(max(A)-min(A)),'yo','MarkerSize',8,'MarkerFaceColor','y');
% for i=1:length(X{choose})
%     text(X{choose}(i),y_temp,[num2str(X{choose}(i),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
% end

load('tent_data0.66.mat');
hold on
choose=4;%y_temp=-0.001;
plot(X{choose},min(A)+1*(max(A)-min(A)),'go','MarkerSize',8,'MarkerFaceColor','g');
% for i=1:length(X{choose})
%     text(X{choose}(i),y_temp+0.1*(max(A)-min(A)),[num2str(X{choose}(i),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
% end

% load('tent_PP.mat');
% hold on
% choose=5;%y_temp=-0.001;
% plot(X{choose},y_temp+0.2*(max(A)-min(A)),'bo','MarkerSize',8,'MarkerFaceColor','b');
% for i=1:length(X{choose})
%     text(X{choose}(i),y_temp+0.2*(max(A)-min(A)),[num2str(X{choose}(i),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
% end
% 
% load('tent_P.mat');
% hold on
% T=4;%y_temp=-0.001;
% for j=1:length(P{T}(:,1))
%     plot(P{T}(j,:),y_temp+0.3*(max(A)-min(A)),'ro','MarkerSize',8,'MarkerFaceColor','r');
%     for i=1:T
%         text(P{T}(j,i),y_temp+0.3*(max(A)-min(A)),[num2str(P{T}(j,i),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
%     end
% end
% 
% hold on
% T=8;%y_temp=-0.001;
% for j=1:2%length(P{T}(:,1))
%     plot(P{T}(j,:),y_temp+0.4*(max(A)-min(A)),'mo','MarkerSize',8,'MarkerFaceColor','m');
%     for i=1:T
%         text(P{T}(j,i),y_temp+0.4*(max(A)-min(A)),[num2str(P{T}(j,i),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
%     end
% end

plot(x_marker,min(A)+0*(max(A)-min(A)),'c^','MarkerSize',8,'MarkerFaceColor','c');
% for i=1:length(x_marker)
%     text(x_marker(i),min(A)+0*(max(A)-min(A)),[num2str(abs(F(i,h(I))),'%5.4f')],'VerticalAlignment','bottom','rotation',90);
% end

d_abs=abs(D(h(I)));
d_angle=angle(D(h(I)))/pi*180;
str1=['n=',num2str(n),'; m=',num2str(m)];
str2=[num2str(d_abs) ' ��' num2str(d_angle) '��'];
title({str1;str2});
str=['.\temp2\Tent_findpeaks_leftU_noise_',setup.function,'_n',num2str(n),'m',num2str(m),'_figure',num2str(I)];
% saveas(hh,[str,'.fig'])
% saveas(hh,[str,'.png'])
end