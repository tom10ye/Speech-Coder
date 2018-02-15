clc;clear;close all
load('record.mat')

figure()
plot(x)
title('Original Signal')

len=100; 
n=floor(numel(x)/len); %round 0, n is the number of frame

% Zero Crossing Rate
for i=1:n
    s=x((i-1)*len+1:i*len);  %divide into frame, s represent a frame
    zcr(i) = 0;  
    for j=2:len-1  
        zcr(i)=zcr(i)+abs(sign(s(j))-sign(s(j-1)))/2;  %sign function: <0 -1, =0 0, >0 1
    end  
end

figure(2)
plot(zcr);
title('Zero Crossing Rate') 

coefficient = zeros(n,11);
gain = zeros(n,1);

t=0.3;  % threshold
x_clip = zeros(numel(x),1);
for i=1:numel(x)
    if x(i)>t
        x_clip(i)=1;
    elseif x(i)<-t
            x_clip(i)=-1;
    else x_clip(i)= 0;
    
    end
end
% figure();
% plot(x_clip);

pitch_period = zeros(n,1);
for frame=1:n
    s=x((frame-1)*len+1:frame*len); 
    [coefficient(frame,:),gain(frame)] = lpc(s,10);
    for k=1:len
        Rm(k)=0;
        for i=(k+1):len
            Rm(k)=Rm(k)+x(i+(frame-1)*len)*x(i-k+(frame-1)*len);
        end
    end      
    [Rmax,pitch_period(frame)]=max(Rm(11:len));

end

pitch_period = pitch_period+10;
gain = sqrt(gain);


save('transmit_signal.mat');

