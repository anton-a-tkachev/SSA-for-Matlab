function [H, D, W, M] = read()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    A = importdata('Hourly_Consumption.csv');
    n = 1;
    for i = 1:25:(1104 - 24)
        for k = 5:35
            if A.data(1,k) == 0;
                break;
            end
            for j = i:(i+23)
                H(n) = A.data(j,k); %#ok<*AGROW>
                n = n + 1;
            end
        end
    end
	
	n = 1;
    for i = 1:25:length(H) - 24
		D(n) = sum(H(i:i+24))/24;
		n = n+1;
    end
	
    n = 1;
	for i = 1:8:length(D) - 7
		W(n) = sum(D(i:i+7))/7;
		n = n+1;
	end
    
	n = 1;
	for i = 1:31:length(D) - 30
		M(n) = sum(D(i:i+30))/30;
		n = n+1;
	end
end
