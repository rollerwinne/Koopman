function [F,D,x_function_length]=Lorenz_Koopman_U_poly(x_k,x_l,power)
K=Ploynomial_basis(x_k,power);
L=Ploynomial_basis(x_l,power);
x_function_length=length(K(1,:));
%% Eigenvalues and Eigenfuncitons of Koopman Operator
iK=pinv(K);     %��K�Ĺ����棺iK
U=L*iK;
[F,D]=eig(U);   %%��U������ֵD����������F
D=diag(D);
end