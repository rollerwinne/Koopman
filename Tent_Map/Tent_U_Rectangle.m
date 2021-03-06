function [F,D,U]= Tent_U_Rectangle(x,m,flag)
x_k=x(1,:);
x_l=x(end,:);
if nargin<3
    K=Tent_G_Rectangle(x_k,m);
    L=Tent_G_Rectangle(x_l,m);
else
    K=Tent_G_Rectangle_natural(x_k,m);
    L=Tent_G_Rectangle_natural(x_l,m);
end
U=L*pinv(K);
[F,D]=eig(U);
D=diag(D);
end

function G= Tent_G_Rectangle(x,m)
G=zeros(length(x),m);
x=x(:);
for i=1:m-1
    G(:,i)=(x>=(i-1)/m & x<i/m)*sqrt(m);
end
G(:,m)=(x>=(m-1)/m & x<=m/m)*sqrt(m);
end

function G=Tent_G_Rectangle_natural(x,m)
x_function=Logistic_x(4,m+1,1);
x_function(2,:);
for i=1:m-1
    G(:,i)=(x>=x_function(2,i) & x<x_function(2,i+1)) * sqrt(1/(x_function(2,i+1)-x_function(2,i)));
end
i=m;
G(:,i)=(x>=x_function(2,i) & x<x_function(2,i+1)) * sqrt(1/(x_function(2,i+1)-x_function(2,i)));
end