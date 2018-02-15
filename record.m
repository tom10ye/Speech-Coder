clear;clc;close all;
recObj = audiorecorder;
disp('Start speaking for 4 seconds')
recordblocking(recObj, 4);
disp('End of Recording.');
x = getaudiodata(recObj);
plot(x);
save('record.mat');
Fs = 8000;
audiowrite('Original_speech.wav',x,Fs); 