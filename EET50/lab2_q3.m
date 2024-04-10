T_am = 0.01;     % periodo de amostragem
delta = 0.2;    % valor do passo delta
w_sin = 1.0;    % frequencia angular do sinal senoidal
t = 0:T_am:10;

%% Calcular codificaçao
signal = sin(w_sin*t);
recebido = [0];
encoding = [];
for i=signal
    encVal = sign(i-recebido(end));
    encoding = [encoding (encVal+1)/2];
    recebido = [recebido recebido(end)+encVal*delta];
end


filtrado = lowpass(recebido(2:end),w_sin/2/pi,1/T_am,ImpulseResponse="iir",Steepness=0.7);

%% Gerar grafico
f = figure;
hold on
plot(t,signal);
%stairs(t,recebido(2:end));
stairs(t,filtrado);
title(strcat("Codificaçao DM, Δ = ", num2str(delta), ", T_{am} = ", num2str(T_am)));
legend("Sinal original","Sinal filtrado");
hold off