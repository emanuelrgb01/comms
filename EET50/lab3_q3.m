%% Gerar o Sinal
%clear all
Ac = 1;
T_s = 0.02;     % periodo de amostragem
t = -5:T_s:5;   % instantes em que ocorre a amostragem
f_c = -10;   % frequencia angular da carrier (<1/T_s/4)

% Mensagem
f_m = 5.0;
sinal_mensagem = sin(f_m*t) + sin(1.5*f_m*t) + sin(.75*f_m*t);

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

%% AM-DSB-SC - Modulacao

sinal_modulador = cos(2*pi*f_c*t);
s = Ac*sinal_mensagem.*sinal_modulador;

figure(f1)
subplot(4,1,2);
plot(t,s,'black');
title('Sinal Modulado');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
legend('Sinal Modulado');
grid on
%% AM-DSB-SC - Demodulacao

x = 2*s.*sinal_modulador;
y = lowpass(x, abs(f_c) ,1/T_s,ImpulseResponse="iir",Steepness=0.7);
m = y/Ac;

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

%% AM-DSB-SC - Avaliando no domínio da Frequência
f_s = 1/T_s;
N = length(sinal_mensagem); 
f = (-N/2:N/2-1)*(f_s/N);

X = fft(sinal_mensagem); 
X_mag = abs(fftshift(X))/N; 

figure(f2)
subplot(2,1,1)
plot(f, X_mag);
title('FFT do Sinal Mensagem');
xlabel('Frequência (s^{-1})')
ylabel('Magnitude')


Y = fft(m); 
Y_mag = abs(fftshift(Y))/N; 

figure(f2)
subplot(2,1,2)
plot(f, Y_mag);
title('FFT do Sinal Demodulado');
xlabel('Frequência (s^{-1})')
ylabel('Magnitude')