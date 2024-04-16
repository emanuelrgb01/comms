%% Leitura do arquivo de áudio
%clear all
arquivo_audio = 'audio.wav';
[signal, f_s] = audioread(arquivo_audio);
sinal_audio = transpose(signal(:,1));

frequencia_seno = 10*1000; %freq de corte
t = [0 : 1/f_s : (length(sinal_audio)-1)/f_s];

subplot(3,1,1);
plot(t,sinal_audio,'black');
title('Sinal Mensagem');
xlabel('Tempo (s)')
ylabel('Amplitude (V)')
legend('Sinal Mensagem');
grid on

%% Quantizando o sinal
num_bits = 8;
L = 2^num_bits;
max_sinal = max(sinal_audio);
min_sinal = min(sinal_audio);

delta = (max_sinal - min_sinal) / L;
mapa_q = [min_sinal : delta : max_sinal];
cod_q = [min_sinal-delta/2 : delta : max_sinal+delta/2];

[index, quants] = quantiz(sinal_audio,mapa_q,cod_q);


for i = 1:length(quants)
    if quants(i) < min_sinal
       quants(i) = quants(i) + delta;
       index(i) = index(i) + 1;
    end
    index(i) = index(i) - 1;

end

subplot(3,1,2);
plot(t,quants);
title('Sinal Quantizado');
xlabel('Amostras')
ylabel('Amplitude (V)')
legend('Sinal Quantizado');
grid on

%% Codificação
Rb = f_s * num_bits;
T_enc = 1/Rb;

y = de2bi(index);

y = reshape(y',1,[]);
t_enc = [0 : T_enc : length(sinal_audio)*T_enc*num_bits - T_enc];

subplot(3,1,3);
plot(t_enc,y,'red');
title('PCM Signal');
xlabel('Samples ---->');
ylabel('Amplitude(V) ---->')
legend('PCM Signal ---->');
grid on

ha = axes ('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text (0.5, 1,'\bf Pulse Code Modulation ','HorizontalAlignment','center','VerticalAlignment', 'top')


%% Demodulação
% parte do y para mq

mq = zeros(length(y)/num_bits,1)';
volta = bit2int(y',num_bits,false)'; % false porque o bit mais significante é o ultimo

for i = 1:length(volta)
    mq(i) = (min_sinal + delta/2) + volta(i)*delta;
end

% Passa baixas
filtrado = lowpass(mq,frequencia_seno,f_s,ImpulseResponse="iir",Steepness=0.7);
figure
plot(t, filtrado)
title("Sinal recuperado");