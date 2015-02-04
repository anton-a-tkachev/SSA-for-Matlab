function [D] = ssaspe(Y, L)
%SSASPE Returns normalized SSA spectrum of the input series
%   Copyright (c) 2015 Anton Tkachev
%   Inputs:
%   Y - input data series column vector
%   L - number of reconstructed components input data series to be decomposed to
%       (note that L must be less than the length of the input series Y)
%   Outputs:
%   D - components' contributions to the input series in %

T = length(Y);
K = T - L + 1;

X = zeros(L,K);
for i = 1:K
    X(:,i) = Y(i:i+L-1).';
end

D = flipdim(eig(X*X.'),1);
D = D/sum(D);
end
