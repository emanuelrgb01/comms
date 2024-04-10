arquivo_audio = 'audio.wav';
[signal, fs] = audioread(arquivo_audio);
signal = transpose(signal);

f_fil = 5000;    % frequencia do filtro
delta = 0.1;%240*pi*f_fil/fs;    % valor do passo delta
t = (0:(length(signal)-1))/fs;

figure
subplot(2,1,1);
plotFFT(signal(1,:),fs)
title("FFT do sinal original");

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

subplot(2,1,2);
plotFFT(filtrado,fs)
title(strcat("FFT do sinal DM, Δ = ", num2str(delta)));

figure
subplot(2,1,1);
plot(t,signal(1,:))
title("Forma de onda do sinal original");
subplot(2,1,2);
plot(t,filtrado)
title(strcat("Forma de onda do sinal DM, Δ = ", num2str(delta)));

%% Tocar som
sound(filtrado,fs);
%clear sound