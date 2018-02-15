clc;clear;close all;

load for_plot.mat;
threshold = 30
for frame=200:n
    if zcr(frame)<threshold
       voiced_x=x((frame-1)*len+1:frame*len);
       figure();
       plot(voiced_x);title('original voiced frame');
       voiced_recon=recon((frame-1)*len+1:frame*len);
       figure();
       plot(voiced_recon);title('reconstructed voiced frame');
       break;
    end
end
figure()
plot(u);title('Random Noise Generator')
figure()
plot(d);title('Impulse Train Generator')