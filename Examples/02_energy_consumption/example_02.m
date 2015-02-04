[H, D, W, M] = read();

% make parent path visible

p = path;

path(p, '../..');


figure;
A = H(1:880);
F = ssafor(A,200,30,180);
plot(H(880+35:880+105),'DisplayName','A','LineWidth',2);hold all;plot(F(880+35:880+105),'DisplayName','R','LineWidth',2);hold off;

figure;
A = H(13800:14300);
F = ssafor(A,200,30,180);
plot(H(14301+16:14301+106),'DisplayName','A','LineWidth',2);hold all;plot(F(501+16:501+106),'DisplayName','R','LineWidth',2);hold off;

figure;
A = H(20450:20950);
F = ssafor(A,200,30,180);
plot(H(20951+50:20950+100),'DisplayName','A','LineWidth',2);hold all;plot(F(501+50:500+100),'DisplayName','R','LineWidth',2);hold off;

figure;
A = D(1:750);
F = ssafor(A,200,30,60);
plot(D(751:772),'DisplayName','A','LineWidth',2);hold all;plot(F(751:772),'DisplayName','R','LineWidth',2);hold off;

%restore the path variable

path(p); 
