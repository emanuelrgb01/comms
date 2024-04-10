%% Gerar o Seno
clear all
frequencia_seno = 10*1000;
t = [0:1/(100*frequencia_seno):10/frequencia_seno];
sinal_seno = sin(2*pi*frequencia_seno*t);

subplot(3,1,1);
plot(t,sinal_seno,'black');
title('Message Signal');
xlabel('Time(s) ---->')
ylabel('Amplitude(V) ---->')
legend('Message Signal ---->');
grid on

%% Amostrando o seno
f_s = 2*frequencia_seno;
T_s = 1/f_s;
%N = length(t);

%t_amostra = [0 : T_s : 10/frequencia_seno];
%f_digital = 2*pi*frequencia_seno/f_s;

%sinal_amostrado = sin(f_digital .* n);
%% Quantizando o sinal
num_bits = 2;
L = 2^num_bits;
max_sen = max(sinal_seno);
min_sen = min(sinal_seno);

delta = (max_sen - min_sen) / L;
mapa_q = [min_sen:delta:max_sen];
cod_q = [min_sen-delta/2:delta:max_sen+delta/2];

[index, quants] = quantiz(sinal_seno,mapa_q,cod_q);


for i = 1:length(quants)
    if quants(i) < min_sen
       quants(i) = quants(i) + delta;
       index(i) = index(i) + 1;
    end
    index(i) = index(i) - 1;

end

subplot(3,1,2);
plot(t,quants);
title('Quantized Signal');
xlabel('Samples ---->')
ylabel('Amplitude(V) ---->')
legend('Quantized Signal ---->');
grid on

%% Encode
Rb = frequencia_seno * num_bits;
T_enc = 1/Rb;
T_por_bit = T_enc/num_bits;

y = de2bi(index);

y = reshape(y',1,[]);
t_enc = [0:1/(100*frequencia_seno)/num_bits:10/frequencia_seno+1/(100*frequencia_seno)/num_bits];

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
