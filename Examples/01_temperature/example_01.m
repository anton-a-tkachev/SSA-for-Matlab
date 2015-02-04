% Copyright (c) 2015 Anton Tkachev
% make parent path visible
p = path;
path(p, '../..');

% prepare temperature data
A = importdata('novosibirsk.csv');
B = A.textdata(1:end,3);

for i = 1:length(B)-1
    T(i) = str2double(B{i+1}); %#ok<SAGROW>
end
T = T.';

% get ssa spectrum for 50 components
D = ssaspe(T,50);
figure;
semilogy(D);
% from the graph let us assume that first 5 components contain valuable signal

% now decompose the series into 50 components
Q = ssacom(T,50);

% sum first 3 reconstructed components and get reconstructed temperature
TR = sum(Q(:,1:5),2);
figure;
plot(T,'DisplayName','T');hold all;plot(TR,'DisplayName','TR','LineWidth',2);hold off;

%forecast 30 days using first 25 of 50 reconstructed components
F = ssafor(T,50,25,30);
figure;
plot(F);

%restore the path variable
path(p); 
