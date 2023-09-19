clc,clear,close all;

fclose(instrfind);

s = serial('COM6','BaudRate',115200);
fopen(s);

% while ~s.BytesAvailable
%     disp('Data not available');
%     clc;
%     pause(0.01);
% end
% 
% out = (fscanf(s,'%c'));
% out = out(1);
% 
% 
% while out~='O'
%     if s.BytesAvailable
%         out =(fscanf(s,'%c'));
%         out = out(1);
%     end
% end
% 
% disp('O Received');

fprintf(s,'%c\n','K');

disp('K sent');

x = [];

while ~s.BytesAvailable
    disp('Data not available');
%     pause(0.01);
end

i = 0;
data = 0;
disp('Receiving Started');
while data~=2047
    data = fscanf(s,'%u');
    x = [x; data];
    i = i+1;
end

x = x(1:end);
%% Processing


Fs = 5.33e6 ;

n = length(x);
Y = fft(x);
Yshift = abs(fftshift(Y));
faxis = (-n/2:n/2-1)'*Fs/n;

YshiftMax = max(Yshift);
YshiftN = Yshift/YshiftMax;
YshiftNdB = 20*log10(YshiftN);

figure(1);
subplot(211);plot(x);
subplot(212);plot(faxis,YshiftNdB);