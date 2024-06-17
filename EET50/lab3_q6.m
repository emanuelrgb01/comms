%% Mensagem
arquivo_audio = 'amen.mp3';
[message, fs] = audioread(arquivo_audio);
message = transpose(message(:,1));

%% Parametros da modulaçao
gain = 2.0;     % ganho da modulaçao
t = (0:(length(message)-1) )/fs - length(message)/2/fs;   % instantes em que ocorre a amostragem
f_c = -1e4;   % frequencia angular da carrier (<1/T_s/4)

%% modulaçao
signal = gain*real(hilbert(message,length(t)).*exp(1j*2*pi*f_c*t));

% recuperaçao
mult = 2*signal.*cos(2*pi*abs(f_c)*t);
recovered = lowpass(mult, abs(f_c) ,fs,ImpulseResponse="iir",Steepness=0.7)/gain;

figure
plot(t,message)
hold on
plot(t,recovered)

figure
subplot(4,1,1)
plotFFT(message,fs);
title("Sinal Original");
subplot(4,1,2)
plotFFT(signal,fs);
title("Codificaçao AM-SSB-LSB")
subplot(4,1,3)
plotFFT(mult,fs);
title("Demodulaçao coerente - etapa da multiplicaçao")
subplot(4,1,4)
plotFFT(recovered,fs);
title("Sinal recuperado apos filtro passa-baixa")