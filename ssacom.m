function [Q, D] = ssacom(Y, L)
%SSACOM Returns reconstructed components Q of the input series Y and their contributions D in %
%   Copyright (c) 2015 Anton Tkachev
%   Inputs:
%   Y - input data series column vector
%   L - number of reconstructed components input data series to be decomposed to
%       (note that L must be less than the length of input series Y)
%   Outputs:
%   Q - reconstructed components matrix, each column being a separate component
%   D - vector of components' contributions to the input series (eigenvalues)

T = length(Y);
K = T - L + 1;

X = zeros(L,K);
for i = 1:K
    X(:,i) = Y(i:i+L-1).';
end

[U,D] = eig(X*X.');
D = flipdim(diag(D),1);
U = flipdim(U,2);

V = zeros(K,L);
for i = 1:L
    V(:,i) = X.'*U(:,i);
end

Z = cell(L,1);
Q = zeros(K,L);
for i = 1:L
    Z{i} = U(:,i)*V(:,i).';
    Z{i} = flipdim(Z{i},2);
    
    for j = (-L + 1):(K-1)
       Q(L+j,i) = sum(diag(Z{i},j))/length(diag(Z{i},j));
    end
end

Q = flipdim(Q,1);
end 
