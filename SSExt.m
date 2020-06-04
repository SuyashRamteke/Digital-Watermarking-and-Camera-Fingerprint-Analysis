
%Extraction
function [exbit,rho]=SSExt(Y,sigma,key)
Y=double(Y);
[A,B]=size(Y);
C=wiener2(Y);
rng(key);
W2=sigma*randn(A,B);
rho=(1/(A*B))*(sum((Y-C).*W2));
rho=sum(rho);
%exbit=1;
%decision making

if (rho>=0)
    exbit=1;
else
    exbit=0;
end

end