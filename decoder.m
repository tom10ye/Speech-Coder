clc;clear;close all;

load transmit_signal.mat;
threshold = 30;

recon=zeros(1,numel(x));
for frame=1:n
    if zcr(frame)>threshold
        wgn = randn(len,1);
        u = wgn/max(max(wgn),abs(min(wgn)));% normalize WGN signal between -1 to 1
        recon((frame-1)*len+1:frame*len)=filter(gain(frame),coefficient(frame,:),u);
    else
        d = zeros(len,1); % make the impluse period signal(T = pitch period)
        count = 1;
        while count<=len
            d(count) = 1;
            count = count + pitch_period(frame);
        end
        recon((frame-1)*len+1:frame*len)=filter(gain(frame)*pitch_period(frame),coefficient(frame,:),d);%*pitch_period(frame)
    end
end

recon = recon/max(max(recon),abs(min(recon))); % normalize reconstructed signal between -1 to 1

figure()
plot(x)
title('Original Signal')

figure()
plot(recon)
title('Reconstructed Signal')
Fs = 8000;
audiowrite('Decoded_speech.wav',recon,Fs); 

playObj=audioplayer(x,8000);
play(playObj);

pause(4);

playObj=audioplayer(recon,8000);
play(playObj);

%calculate MSE
tfnan = isnan(recon);
for i = 1:numel(recon)
    if(tfnan(i)==1) 
        recon(i)=0;
    end
end
MSE = immse(x,recon')

save('for_plot.mat')
