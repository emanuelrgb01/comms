arquivo_audio = 'audio.wav';
[x, fs] = audioread(arquivo_audio);

sound(x, fs);

N = length(x); 
X = fft(x); 
X_mag = abs(X); 
f = (0:N-1)*(fs/N);

figure;
plot(f, X_mag);
title('Espectro de Frequências');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
