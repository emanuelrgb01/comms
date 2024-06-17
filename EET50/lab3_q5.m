% Parametros da modulaçao
gain = 2.0;     % ganho da modulaçao
T_s = 0.02;     % periodo de amostragem
t = -5:T_s:5;   % instantes em que ocorre a amostragem
f_c = -10;   % frequencia angular da carrier (<1/T_s/4)

% Mensagem
f_m = 5.0;
message = sinc(f_m*t).^2;

% modulaçao
signal = gain*real(hilbert(message,length(t)).*exp(1j*2*pi*f_c*t));

% recuperaçao
mult = 2*signal.*cos(2*pi*abs(f_c)*t);
recovered = lowpass(mult, abs(f_c) ,1/T_s,ImpulseResponse="iir",Steepness=0.7)/gain;

figure
plot(t,message)
hold on
plot(t,recovered)

figure
subplot(4,1,1)
plotFFT(message,1/T_s);
title("Sinal Original");
subplot(4,1,2)
plotFFT(signal,1/T_s);
title("Codificaçao AM-SSB-LSB")
subplot(4,1,3)
plotFFT(mult,1/T_s);
title("Demodulaçao coerente - etapa da multiplicaçao")
subplot(4,1,4)
plotFFT(recovered,1/T_s);
title("Sinal recuperado apos filtro passa-baixa")