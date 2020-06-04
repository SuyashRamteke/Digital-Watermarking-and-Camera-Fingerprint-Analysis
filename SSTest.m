%Test for robustness

function [count]=SSTest(img)
X=imread(img);
sigma=2;
%rkey=randi(1000,[1,1000]);
tota=1;
bits=zeros(1,1000);
%choice=randi(4);
choice=1;
count=0;
if choice==1
%Fibonacci series of ones and zeros just for fun so that the probability of
%ones and zeros is not equal!!!
    a=1;
    b=1;
    c=2;
    unit2=0;
    while c<1001
        c=a+b;
        if (mod(tota,2)~=0)&&(c<1000)
            for i=b:c-1
                bits(i)=bits(i)+1;
            end
        end
        if(c>1000)
            for i=b:1000
                bits(i)=bits(i);
            end
        end
        a=b;
        b=c;
        tota=tota+1;
    end
     for j=1:size(bits)
        if(bits(j)==1)
            unit2=unit2+1;
        end
     end
    
     pr1=unit2/1000;
     pr0=(1000-unit2)/1000;
end
if choice==2
    %random sequence of zeros and ones
    unit=0;
    bits=randi(2,1,1000)-1;
    for j=1:size(bits)
        if(bits(j)==1)
            unit=unit+1;
        end
    end
     pr1=unit/1000;
     pr0=(1000-unit)/1000;
end

if choice==3
    %all ones sequence
    bits=ones(1,1000);
     pr1=1;
     pr0=0;
end

if choice==4
    %all zeros sequence
    bits=zeros(1,1000);
     pr1=0;
     pr0=1;
end
rh0=[];
rh1=[];
var0=0;
var1=0;
corr=zeros(1,1000);
% neg=zeros(1,1000);
% pos=zeros(1,1000);

    rkey=randi(1000,1,1000);
for k=1:1000
   
    Y=SSEmb(X,bits(k),sigma,rkey(k));
    
    %jpeg compression
     %imwrite(Y,'watermarked.jpg','jpg','quality',5);
     %Y2=imread('watermarked.jpg');
    
    %histogram equalization
    %Y2=imadjust(Y);
    
    %gamma correction
    %Y2=imadjust(Y,[],[],0.1);
    
    %De-noising with a wiener filter
    %Y2=wiener2(Y);
    
    %median-filtering
    %Y2=medfilt2(Y,[3,3]);
    
    %resampling
    Y2=imresize(imresize(Y,0.5),2);
    
    %rotate
    %Y2=imrotate(Y,-7);
    
    %warp
    %tform=affine2d([1 0.3 0; 0.4 1 0; 0 0 1]);
    %Y2=imwarp(Y,tform);
    
    
    
    [bito,rho2]=SSExt(Y2,sigma,rkey(k));
     if bito==bits(k)
         count=count+1;
     end
     corr(k)=corr(k)+rho2;
     if corr(k)<0
         rh0=[rh0 corr(k)];
         
         
     else
         rh1=[rh1 corr(k)];
         
     end
end
 
 
     histogram(rh0,50,'FaceColor','b') 
     hold on
     histogram(rh1,50,'FaceColor','r')
         
     
%      histogram(neg,50,'FaceColor','b')
%      hold on
%      histogram(pos,50,'FaceColor','r')
%     
     neg_cor=(1/numel(rh0))*(sum(rh0));
    pos_cor=(1/numel(rh1))*(sum(rh1)); 
    disp("Sample mean when '0' is embedded "+neg_cor)
    disp("Sample mean when '1' is embedded "+pos_cor)
for m=1:1000
    if corr(m)<0
        var0=(1/numel(rh0))*((corr(m)-neg_cor).^2);
    else
        var1=(1/numel(rh1))*((corr(m)-pos_cor).^2);
    end
end

    disp("Sample variance when '0' is embedded "+var0)
    disp("Sample variance when '1' is embedded "+var1)
if pr0~=0
    prerr=pr0*(0.5*erfc((-neg_cor/sqrt(var0))/sqrt(2)))+pr1*(0.5*erfc((pos_cor/sqrt(var1))/sqrt(2)));
else 
prerr=pr1*(0.5*erfc((pos_cor/sqrt(var1))/sqrt(2)));
end 
disp("Probability of error: "+prerr)
end