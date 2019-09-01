function [F,D] = D2_U(x_k,x_l,y_k,y_l,m,md)

dj=4/md;    
[xj,yj]=meshgrid(linspace(-2,2,m));%�õ�����m*m�ľ���
mxy=length(x_k);
xj=xj(:);
yj=yj(:);

for i=1:mxy
    for j=1:m*m
        K(i,j)=exp(-(x_k(i)-xj(j))^2/(dj^2)-(y_k(i)-yj(j))^2/(dj^2));        
    end
end

for i=1:mxy
    for j=1:m*m
        L(i,j)=exp(-(x_l(i)-xj(j))^2/(dj^2)-(y_l(i)-yj(j))^2/(dj^2));        
    end
end

[F,D]=eig(L*pinv(K));   %%��U������ֵD����������F
D=diag(D);
end