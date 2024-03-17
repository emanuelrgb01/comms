close all
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

t = (-N/2:N/2-1)*(1/fs);

SIR = 0.0001;
sinc_t = (1000 * sinc(t*1000).*cos(2*pi*1000*t))';
x_com_interferencia = x + 1/SIR*sinc_t;

%sound(x_com_interferencia, fs);

Y=fft(x_com_interferencia);
Y_mag = abs(fftshift(Y))/N; 

figure;
plot(f, Y_mag);
title('Espectro de Frequências do sinal com interferência');
xlabel('Frequência (Hz)');
ylabel('Magnitude');