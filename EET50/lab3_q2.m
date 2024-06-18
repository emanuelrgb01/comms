%% Sinal
%clear all
Ac = 1;
ka = 0.5;
f_c = -1e4;

% Mensagem
arquivo_audio = 'amen.mp3';
[sinal_mensagem, fs] = audioread(arquivo_audio);
sinal_mensagem = transpose(sinal_mensagem(:,1));
t = (0:(length(sinal_mensagem)-1) )/fs - length(sinal_mensagem)/2/fs;   % instantes em que ocorre a amostragem

f1 = figure;
f2 = figure;

figure(f1)
subplot(4,1,1);
plot(t,sinal_mensagem,'black');
title('Sinal Mensagem');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
legend('Sinal Mensagem');
grid on

%% AM-DSB - Modulacao

sinal_modulador = cos(2*pi*f_c*t);
s = Ac*(1+ka*sinal_mensagem).*sinal_modulador;

figure(f1)
subplot(4,1,2);
plot(t,s,'black');
title('Sinal Modulado');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
legend('Sinal Modulado');
grid on
%% AM-DSB - Demodulacao

x = 2*s.*sinal_modulador;
y = lowpass(x, abs(f_c) ,fs,ImpulseResponse="iir",Steepness=0.7);
z = y - Ac;
m = z/(Ac*ka);

figure(f1)
subplot(4,1,3);
plot(t,m,'black');
title('Sinal Demodulado');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
legend('Sinal Demodulado');
grid on

%%
subplot(4,1,4);
plot(t,sinal_mensagem,'blue'); hold on;
plot(t,m,'red'); hold off;
title('Sinal Mensagem vs Sinal Demodulado');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
%legend('Sinal Demodulado');
grid on

%% AM-DSB - Avaliando no domínio da Frequência
N = length(sinal_mensagem); 
f = (-N/2:N/2-1)*(fs/N);

X = fft(sinal_mensagem); 
X_mag = abs(fftshift(X))/N; 

figure(f2)
subplot(2,1,1)
plot(f, X_mag);
title('FFT do Sinal Mensagem');
xlabel('Frequência')
ylabel('Magnitude')


Y = fft(m); 
Y_mag = abs(fftshift(Y))/N; 

figure(f2)
subplot(2,1,2)
plot(f, Y_mag);
title('FFT do Sinal Demodulado');
xlabel('Frequência')
ylabel('Magnitude')