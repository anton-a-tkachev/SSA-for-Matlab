function [F] = ssafor(Y, L, N, M)
%SSAFOR Returns reconstructed data plus M forecasted points using N components of the input series
%   Copyright (c) 2015 Anton Tkachev
%   Inputs:
%   Y - input data series column vector
%   L - number of reconstructed components input data series to be decomposed to
%       (note that L must be less the length of the input series Y)
%   N - number of reconstructed components to be used for the forecast
%   M - number of points to be forecasted
%   Outputs:
%   F - sum of the first N reconstructed components plus M points forecasted via N first reconstructed components
%       (thus F has the dimension of (T + M), where T is the input series length)
%   
%   How to use:
%   First of all get the data series spectrum, i.e. eigenvalues using 'ssaspe' function. Plot the
%   eigenvalues on a log-scale graph to choose the number (N) of components
%   containing valuable signal. Then you can effectively forecast the
%   series with first N components.

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


A = zeros(L-1,1);
for i = 1:N
    A = A + U(L,i)*U(1:L-1,i);
end
v = norm(U(L,1:N));
A = A/(1-v^2);
A = flipdim(A,1);
G = sum(Q(:,1:N),2);
F = [G.', zeros(1,M)].';
for i = T+1:T+M
    for j = 1:L-1
        F(i) = F(i) + A(j)*F(i-j);
    end
end
F = F(T+1:T+M);
F = [G.', F.'].';
end 
