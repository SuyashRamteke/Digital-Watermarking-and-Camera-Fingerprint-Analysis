function [Kz,mu] = zeromean88(K)

Kz = K;
mu = zeros(8,8);

for i = 1 : 8
    for j = 1 : 8
        aux = K(i:8:end,j:8:end);
        mu(i,j) = mean(aux(:));
        Kz(i:8:end,j:8:end) = Kz(i:8:end,j:8:end) - mu(i,j);
    end
end
