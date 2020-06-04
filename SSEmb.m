%embedding
function [Y]=SSEmb(X,bit,sigma,key)
X=double(X);
%disp(X);
[A,B]=size(X);
rng(key);
W=sigma*randn(A,B);

if bit==1
    Y=X+W;
end
if bit==0
    Y=X-W;
end
Y=uint8(Y);
end