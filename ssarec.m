function [R] = ssarec(Y, L, N)
%SSACOM Returns reconstructed data series using N first components
%   Copyright (c) 2015 Anton Tkachev
%   Inputs:
%   Y - input data series column vector
%   L - number of reconstructed components input data series to be decomposed to
%       (note that L must be less than the length of input series Y)
%   N - number of components to use in reconstruction
%   Outputs:
%   R - reconstructed data series

T = length(Y);
K = T - L + 1;

X = zeros(L,K);
for i = 1:K
    X(:,i) = Y(i:i+L-1).';
end

[U,D] = eig(X*X.'); %#ok<NASGU>
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

R = sum(Q(:,1:N),2);
end 
