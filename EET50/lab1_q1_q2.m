%% Q1
arquivo_audio = 'audio.wav';
[x, fs] = audioread(arquivo_audio);

%sound(x, fs);

% o sinal é estereo, portanto temos duas colunas. Selecionando apenas uma
% delas para trabalhar

x = x(:, 1);

N = length(x); 
X = fft(x); 
X_mag = abs(fftshift(X))/N; 
f = (-N/2:N/2-1)*(fs/N);

figure;
plot(f, X_mag);
title('Espectro de Frequências');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

%% Q2

% SNR é potencia do sinal por potencia do ruido (variancia)

SNR = 0.1;
potencia_ruido = 10*log10(var(x)/SNR);

ruido = wgn(N,1,potencia_ruido);

x_com_ruido = x + ruido;
X_com_ruido = fft(x_com_ruido); 
X_com_ruido_mag = abs(fftshift(X_com_ruido))/N; 


figure;
plot(f, X_com_ruido_mag);
title('Espectro de Frequências do sinal com ruído');
xlabel('Frequência (Hz)');
ylabel('Magnitude');