arquivo_audio = 'audio.wav';
[signal, fs] = audioread(arquivo_audio);
signal = transpose(signal);

T_am = 1/fs;    % periodo de amostragem
delta = 0.1;    % valor do passo delta
f_fil = 1.0;    % frequencia do filtro
N = length(signal);
t = (1:N)/fs;

%% Calcular codificaçao
recebido = [[0;0] signal];
encoding = signal;
for i=1:length(signal)
    encVal = sign(signal(:,i)-recebido(:,i));
    encoding(:,i) = (encVal+1)/2;
    recebido(:,i+1) = recebido(:,i)+encVal*delta;
end

%% Filtragem
filtrado = [lowpass(recebido(1,2:end),f_fil,fs,ImpulseResponse="iir",Steepness=0.7)];
%            lowpass(recebido(2,2:end),f_fil,fs,ImpulseResponse="iir",Steepness=0.7)];

%% Gerar grafico
f = figure;
hold on
plotFFT(signal(1,:),fs)
plotFFT(filtrado,fs)
title(strcat("FFT do sinal DM, Δ = ", num2str(delta)));
legend("Sinal original","Sinal filtrado");
hold off

%% Tocar som
%sound((filtrado),fs);